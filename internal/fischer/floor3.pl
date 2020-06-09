#!perl

# Extract sequences with "[ ] = floor" 
# @(#) $Id$
# 2020-06-09, Georg Fischer: 3rd attempt
#
#:# Usage:
#:#   perl floor3.pl [-d debug] $(COMMON)/joeis_names.txt > floors.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $ignore = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{i}) {
        $ignore    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my @known_words = 
my %known = ();
map { $known{$_} = 1; $_
    } qw(floor sqrt log exp sin cos
    arcsin arccos arctan sinh cosh tan tanh cot coth csc csch sech 
    e half one_third phi pi tau sqrt2 gamma eulergamma log_2 log_10 log);
my $callcode = "dex";
my $offset = 0;
my $formula;
my $condlist;
my ($aseqno, $superclass, $joeis_name, @rest);
my @vars;
my @values;

while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $superclass, $joeis_name, @rest) = split(/\t/, $line);
    my $name = $joeis_name;
    next if $name =~ m{\.\.| if |\[x\^\(?n|A\d{6}};
    if ($ignore == 1 or $superclass eq "null") {
        $name =~ s{\Aa\(n\) *\= *}{}; # remove "a(n) = "
        $name =~ s{floor\(}{\[}g;
        if ($name =~ m{\A(n *[\+\-] *)?\[}) { # starts with "floor"
            $name =~ s{\..*}{}; # remove "." and all behind
            $name =~ s{\[[ \.]*\] *\=? *floor}{};
            $name =~ s{(\;| and | where )}{\,}g; # " and " -> ","
            $name =~ s{\,( *\,)+}{\,}g; # keep single comma only
            $name =~ m{\A([^\,]+)(\, *(.*))?};
            $formula  = $1 || ""; 
            $condlist = $3 || "";
            $formula  =~ s{ }{}g;
            $condlist =~ s{ }{}g;
            if ($debug >= 1) {
                print "# $aseqno name=\"$name\", condlist=\"$condlist\", formula=\"$formula\"\n";
            }
            my $count = &eval_where($condlist);
            $count +=   &eval_expression($formula);
            if ($count == 0) {
                print STDERR "# " . join("\t", $aseqno, $superclass, $joeis_name, @rest) . "\n";
            }
        } # starts with "["
    } # ne null
} # while
#----
sub eval_where { # lists of variables and values behind ";" or ", where"
    my ($condlist) = @_;
    my $result = 0;
    $condlist =~ s{ }{}g;
    my $ind;
    @vars   = ();
    @values = ();
    if (0) {
    } elsif ($condlist =~m{\(([^\)]+)\)\=\((.+)\)\Z}) { # (r,s,t)=(expr1,expr2,expr3)
        my ($list1, $list2) = ($1,$2);
        @vars   = split(/\,/, $list1);
        @values = split(/\,/, $list2);
    } else { # r=expr1,s=expr2,t=expr3
        $ind = 0;
        @values = map { 
                my $pair = $_; 
                my ($var, $value) = split(/\=/, $pair);
                $vars[$ind ++] = $var || 7777;
                $value || "7777"
            } split(/\,/, $condlist);
    }
    @values = map { my $p = $_; $p =~ s{goldenratio}{\(\(1+sqrt\(5\)\)\/2\)}g; $p } @values;
    if ($debug >= 3) {
        print "  => [" . join(", ", @vars) . "] =[" . join(", ", @values) . "]\n";
    }
    $ind = 0;
    foreach my $var(@vars) { # insert "*" in products
        if ($ind < scalar(@values) and ($var  =~ m{\A[a-z]\Z})) {
            print join("\t", $aseqno, $callcode . $var, $offset, "postfix", "true", 10, $values[$ind] || 7777) . "\n";
            $ind ++;
            $result ++;
        }
    } # while
    return $result;
} # eval_where
#----
sub eval_expression { 
    my ($expr) = @_;
    my $result = 0;
    $expr =~ s{ }{}g;
    my $varno = scalar(@vars);
    push(@vars, "n");
    foreach my $var(@vars) { # insert "*" in products
        if ($var  =~ m{\A[a-z]\Z}) {
            $expr =~ s{$var}{$var\*}g;
        }
    }
    $expr =~ s{(\W)\*(\w)}{$1$2}g; # repair
    $expr =~ s{(\w)\*(\W)}{$1$2}g; # repair
    $expr =~ s{\*\Z}{}g; # repair
    $expr =~ s{(\w)([\[\(])}{$1\*$2}g; # digit * 
    $expr =~ m{([a-z][a-z]+)};
    my $ok = 1; # assume all lowercased words with length >= 2 are known
    map {   my $word = $_;
            if (($word =~ m{\A[A-Za-z]\w+}) and ! defined($known{lc($word)})) {
                $ok = 0;
            }
            $_
        } split(/\b/, $expr); # split on word boundaries
    if ($ok == 0) { # bad word occurred
        if ($debug >= 1) {
            print "#    $aseqno expr=\"$expr\"\n";
        }
    } else {
        $expr =~ s{\[}{floor\(}g; # normalize to "floor"s
        $expr =~ s{\]}{\)}g; # normalize to "floor"s
        print join("\t", $aseqno, $callcode . $varno, $offset, "postfix", "true", 10, $expr) . "\n";
        $result ++;
    }
    return $result;
} # eval_expression
#----------------
__DATA__
A188295	null	[nr]-[nr-r], where r=1/sqrt(2), [ ]=floor.	nonn,synth	1..123
A184813	null	n+[nr/s]+[nt/s], where r=sqrt(2), s=sqrt(3), t=sqrt(5), and []=floor.   nonn,   1..10000
A184814	null	n+[nr/t]+[ns/t], where r=sqrt(2), s=sqrt(3), t=sqrt(5), and []=floor.   nonn,   1..10000
A189363	null	a(n) = n + [n*r/t] + [n*s/t]; r=1, s=sqrt(2), t=sqrt(3).        nonn,   1..1000
A189365	null	a(n) = n + [n*r/s] + [n*t/s]; r=1, s=sqrt(2), t=(1+sqrt(5))/2.  nonn,   1..10000
A189366	null	a(n) = n + [n*r/t] + [n*s/t]; r=1, s=sqrt(2), t=(1+sqrt(5))/2.  nonn,   1..10000
A189368	null	a(n) = n + [n*r/s] + [n*t/s]; r=2, s=sqrt(2), t=sqrt(3).        nonn,changed,   1..10000
A189369	null	a(n) = n + [n*r/t] + [n*s/t]; r=2, s=sqrt(2), t=sqrt(3).        nonn,   1..10000
A189371	null	a(n) = n + [n*r/s] + [n*t/s]; r=1, s=sqrt(2), t=sqrt(5).        nonn,   1..10000
A189372	null	a(n) = n + [n*r/t] + [n*s/t]; r=1, s=sqrt(2), t=sqrt(5).        nonn,   1..10000
       	    	
A190365	null	n + [n*r/s] + [n*t/s] + [n*u/s]; r=sqrt(2), s=1/r, t=sqrt(3), u=1/t.    nonn,   1..10000
A190366	null	n + [n*r/t] + [n*s/t] + [n*u/t]; r=sqrt(2), s=1/r, t=sqrt(3), u=1/t.    nonn,   1..10000
A190367	null	n + [n*r/u] + [n*s/u] + [n*t/u]; r=sqrt(2), s=1/r, t=sqrt(3), u=1/t.    nonn,   1..10000
A190369	null	a(n) = n + [n*r/s] + [n*t/s] + [n*u/s];  r=sin(Pi/5), s=cos(Pi/5), t=sin(2*Pi/5), u=cos(2*Pi/5).
A190370	null	a(n) = n + [n*r/t] + [n*s/t] + [n*u/t];  r=sin(Pi/5), s=cos(Pi/5), t=sin(2*Pi/5), u=cos(2*Pi/5).
A190371	null	a(n) = n + [n*r/u] + [n*s/u] + [n*t/u];  r=sin(pi/5), s=cos(pi/5), t=sin(2*pi/5), u=cos(2*pi/5).
       	    	
A190375	null	a(n) = n + [n*r/u] + [n*s/u] + [n*t/u];  r=sin(Pi/5), s=1/r, t=sin(2*Pi/5), u=1/t.      nonn,   1..10000
A190427	null	a(n) = [(b*n+c)*r] - b*[n*r] - [c*r], where (r,b,c)=(golden ratio,2,1) and []=floor.    nonn,   1..10000
A190431	null	a(n) = [(b*n+c)*r] - b*[n*r] - [c*r], where (r,b,c)=(golden ratio,3,1) and []=floor.    nonn,   1..10000
A190436	null	a(n) = [(b*n+c)*r] - b*[n*r] - [c*r], where (r,b,c)=(golden ratio,3,2) and []=floor.    nonn,   1..10000
A190440	null	[(bn+c)r]-b[nr]-[cr], where (r,b,c)=(golden ratio,4,0) and []=floor.    nonn,synth      1..112
A190445	null	[(bn+c)r]-b[nr]-[cr], where (r,b,c)=(golden ratio,4,1) and []=floor.    nonn,synth      1..136
A190451	null	[(bn+c)r]-b[nr]-[cr], where (r,b,c)=(golden ratio,4,2) and []=floor.    nonn,synth      1..123
A190457	null	[(bn+c)r]-b[nr]-[cr], where (r,b,c)=(golden ratio,4,3) and []=floor.    nonn,synth      1..132
A190483	null	a(n) = [(bn+c)r]-b[nr]-[cr], where (r,b,c)=(sqrt(2),2,1) and []=floor.  nonn,   1..1000
A190487	null	a(n) = [(bn+c)r]-b[nr]-[cr], where (r,b,c)=(sqrt(2),3,0) and []=floor.  nonn,   1..1000
A190491	null	a(n) = [(bn+c)r]-b[nr]-[cr], where (r,b,c)=(sqrt(2),3,1) and []=floor.  nonn,   1..1000
A190496	null	a(n) = [(bn+c)r]-b[nr]-[cr], where (r,b,c)=(sqrt(2),3,2) and []=floor.  nonn,   1..1000
A190505	null	n+[nr/s]+[nt/s]+[nu/s];  r=golden ratio, s=r+1, t=r+2, u=r+3.   nonn,synth      1..71
A190511	null	n+[nr/u]+[ns/u]+[nt/u];  r=golden ratio, s=r^2, t=r^3, u=r^4.   nonn,changed,synth      1..78
A190514	null	n+[nr/s]+[nt/s]+[nu/s]+[nv/s]+[nw/s], where r=sin(x), s=cos(x), t=tan(x), u=csc(x), v=sec(x), w=cot(x), x=pi/5. nonn,synth 1..69
A190515	null	n+[nr/t]+[ns/t]+[nu/t]+[nv/t]+[nw/t], where r=sin(x), s=cos(x), t=tan(x), u=csc(x), v=sec(x), w=cot(x), x=pi/5. nonn,synth 1..69
A190516	null	n+[nr/u]+[ns/u]+[nt/u]+[nv/u]+[nw/u], where r=sin(x), s=cos(x), t=tan(x), u=csc(x), v=sec(x), w=cot(x), x=pi/5. nonn,synth 1..73
A190517	null	n+[nr/v]+[ns/v]+[nt/v]+[nu/v]+[nw/v], where r=sin(x), s=cos(x), t=tan(x), u=csc(x), v=sec(x), w=cot(x), x=pi/5. nonn,synth 1..71
A190518	null	n+[nr/w]+[ns/w]+[nt/w]+[nu/w]+[nv/w], where r=sin(x), s=cos(x), t=tan(x), u=csc(x), v=sec(x), w=cot(x), x=pi/5. nonn,synth
       	    	
A327174	null	a(n) = [(2*n+1)*r] - [(n+1)*r] - [n*r], where [ ] = floor and r = (1+sqrt(5))/2.        nonn,easy,changed,      0..35000
A327177	null	a(n) = [(2n+1)r] - [(n+1)r] - [nr], where [ ] = floor and r = sqrt(2).  nonn,easy,changed,      0..10000
A327180	null	a(n) = [(2n+1)r] - [(n+1)r] - [nr], where [ ] = floor and r = sqrt(3).  nonn,easy,changed,      0..10000

C:\Users\User\work\gits\OEIS-mat\common>grep -E '\[n\*?r\] *\- *\[k\*?r\] *\- *\[n\*?r *\- *k\*?r\]' joeis_names.txt
A188038	null	a(n) = [nr]-[kr]-[nr-kr], where r=sqrt(2), k=2, [ ]=floor.	nonn,	1..10000
A188041	null	a(n) = [n*r]-[k*r]-[n*r-k*r], where r=sqrt(2), k=3, [ ]=floor.	nonn,	1..10000
A188044	null	a(n) = [n*r] - [k*r] - [n*r-k*r], where r=sqrt(2), k=4, [ ]=floor.	nonn,	1..10000
A188068	null	[nr]-[kr]-[nr-kr], where r=sqrt(3), k=1, [ ]=floor.	nonn,	1..10000
A188071	null	[nr]-[kr]-[nr-kr], where r=sqrt(3), k=2, [ ]=floor.	nonn,synth	1..126
A188076	null	[nr]-[kr]-[nr-kr], where r=sqrt(3), k=5, [ ]=floor.	nonn,synth	1..123
A188079	null	[nr]-[kr]-[nr-kr], where r=sqrt(3), k=6, [ ]=floor.	nonn,synth	1..130
A188187	null	[nr]-[kr]-[nr-kr], where r=sqrt(5), k=1, [ ]=floor.	nonn,synth	1..149
A188189	null	[nr]-[kr]-[nr-kr], where r=sqrt(5), k=2, [ ]=floor.	nonn,synth	1..123
A188192	null	[nr]-[kr]-[nr-kr], where r=sqrt(5), k=3, [ ]=floor.	nonn,synth	1..134
A188294	null	Array T(k,n)=[nr]-[kr]-[nr-kr], r=(1+sqrt(5))/2, read by antidiagonals.	nonn,tabl,changed,synth	1..119
A188297	null	a(n) = [n*r] - [k*r] - [n*r-k*r], where r=1/sqrt(2), k=2, [ ]=floor.	nonn,	1..10000
A188300	null	a(n) = [n*r] - [k*r] - [n*r-k*r], where r=1/sqrt(2), k=3, [ ]=floor.	nonn,	1..10000
A188318	null	a(n) = [n*r] - [k*r] - [n*r-k*r], where r=1/sqrt(2), k=4, [ ]=floor.	nonn,	1..10000
A188321	null	a(n) = [n*r] - [k*r] - [n*r-k*r], where r=1/sqrt(2), k=5, [ ]=floor.	nonn,	1..10000
A188371	null	a(n) = [n*r] - [k*r] - [n*r-k*r], where r=1/sqrt(2), k=6, [ ]=floor.	nonn,	1..10000

A184909	null	n+floor(ns/r)+floor(nt/r), where r=2^(1/4), s=2^(1/2), t=2^(3/4).	nonn,synth	1..120
A184910	null	n+floor(nr/s)+floor(nr/t), where r=2^(1/4), s=2^(1/2), t=2^(3/4).	nonn,synth	1..120
A184911	null	n+floor(nr/t)+floor(ns/t), where r=2^(1/4), s=2^(1/2), t=2^(3/4).	nonn,synth	1..120
A184912	null	n+[ns/r]+[nt/r]+[nu/r], where []=floor and r=2^(1/5), s=r^2, t=r^3, u=r^4.	nonn,synth	1..120
A184913	null	n+[rn/s]+[tn/s]+[un/s], where []=floor and r=2^(1/5), s=r^2, t=r^3, u=r^4.	nonn,synth	1..120
A184927	null	n+[sr/u]+[sn/u]+[tn/u], where []=floor and r=1, s=sqrt(3), t=sqrt(5), u=sqrt(7).	nonn,synth	1..120
A184928	null	n+[sn/r]+[tn/r]+[un/r], where []=floor and r=sin(pi/2), s=sin(pi/3), t=sin(pi/4), u=sin(pi/5).	nonn,synth	1..120
A184929	null	n+[rn/s]+[tn/s]+[un/s], where []=floor and r=sin(pi/2), s=sin(pi/3), t=sin(pi/4), u=sin(pi/5).	nonn,synth	1..120

A187944	null	[nr+kr]-[nr]-[kr], where r=(1+sqrt(5))/2, k=3, [ ]=floor.	nonn,synth	1..124
A187945	null	Positions of 1 in A187944; complement of A101864.	nonn,synth	1..90
A187946	null	[nr+kr]-[nr]-[kr], where r=(1+sqrt(5))/2, k=5, [ ]=floor.	nonn,	1..10000

A188093	null	[nr+kr]-[nr]-[kr], where r=sqrt(3), k=6, [ ]=floor.	nonn,synth	1..143

#-------------------------
package irvine.oeis.$(PACK);
// Generated by $(GEN) $(CALLCODE) at $(DATE)
// DO NOT EDIT here!

import irvine.math.cr.CR;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * $(ASEQNO) $(NAME)
 * @author $(AUTHOR)
 */
public class $(ASEQNO) implements Sequence {
  private long mN = -1;
  private final CR r = CR.TWO.sqrt();

  @Override
  public Z next() {
    final CR n = CR.valueOf(++mN);
    return n.sqrt().multiply(CR.TWO).floor().testBit(0) ? Z.ONE : Z.ZERO;
  }
}

#-------------------------
