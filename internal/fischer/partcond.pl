#!perl

# Extract parameters for partitions with conditions
# @(#) $Id$
# 2022-07-06: revisited
# 2020-10-22: 0 < cn() ...
# 2020-09-05, Georg Fischer: copied from deris.pl
#
#:# Usage:
#:#     grep -E "Number of partitions " $(COMMON)/joeis_names.txt \
#:#     | perl partcond.pl [-cc callcode] [-d debug] > partcond.gen
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -cc one of the callcodes partcond
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
my $cc;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $cc         = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $offset = 0;
my %levels = qw(first 1 second 2 third 3 ternary 3 fourth 4 4th 4
                fifth 5 5th 5 sixth 6 6th 6 seventh 7 7th 7 8th 8 eighth 8
                9th 9 ninth 9 10th 10 tenth 10); # for diffseq
my $VOID = "VOID";

my $line;
my @parms; # records in joeis_names.txt
my ($p1, $p2, $p3);
my %rseqnos = ();
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    my $callcode = $cc;
    my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    my $iparm = 0;
    my $mult = 1;
    @parms = ();
    if ($line =~ m{apparent|empirical|conject}i) {
        # ignore the unproven
    #--------------------------------
    } elsif ($cc =~ m{\Apartcond}) {
        if (0) {

        # A035534   null    Number of partitions of n with equal number of parts congruent to each of 0 and 1 (mod 3).  nonn,   0..1000
        # A035537   null    Number of partitions of n with equal nonzero number of parts congruent to each of 0 and 1 (mod 3).  nonn,synth  0..54
        # A035572   null    Number of partitions of n with equal number of parts congruent to each of 0, 1 and 2 (mod 5)    nonn,synth  0..59
        } elsif ($name =~ m{\ANumber of partitions of n with equal (nonzero )?number of parts congruent to each of (.*)}) {
            my $nonzero = $1 || "";
            my $cond = $2;
            $cond =~ s{mod (\d+)}{}; # remove trailing "(mod m)"
            my $kmod = $1;
            my @modules = ($cond =~ m{(\d+)}g);
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A035536";
            $parms[$iparm ++] = $kmod;
            $parms[$iparm ++] = $mult;
            $parms[$iparm ++] = join(",", @modules);
            my $cbuf = "";
            for (my $ic = 0; $ic < scalar(@modules) - 1; $ic ++) {
                $cbuf .= "cn[$ic] == cn[" . ($ic + 1) . "] \&\& ";
            } # for $ic
            $parms[$iparm ++] = "($cbuf cn[0] >= " . ((length($nonzero) > 0) ? 1 : 0) . ") ? Z.ONE : Z.ZERO";
            $callcode = "partcond";

        # A035679 Number of partitions of n into parts 8k+1 and 8k+2 with at least one part of each type
        } elsif ($name =~ m{\ANumber of partitions of n into parts ([^w]+)with at least one part of each type}) {
            my $cond = "$1,"; # terminated with ","
            $cond =~ s{and}{\,}; # inner ","
            $cond =~ s{[ \*]}{}g; # remove spaces and "*"
            $cond =~ s{[a-z]\,}{k\+0\,}g; # 8k -> 8k+0
            $cond =~ m{(\d+)}; # first number
            my $kmod = $1;
            my @modules = ($cond =~ m{${kmod}k\+(\d+)}g);
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A035679";
            $parms[$iparm ++] = $kmod;
            $parms[$iparm ++] = $mult;
            $parms[$iparm ++] = join(",", @modules);
            my $cbuf = "Z.valueOf(cn[0])";
            for (my $ic = 1; $ic < scalar(@modules); $ic ++) {
                $cbuf .= ".multiply(Z.valueOf(cn[$ic]))";
            } # for $ic
            $parms[$iparm ++] = $cbuf;
            $callcode = "partcond";

       # A036801 Number of partitions satisfying (cn(0,5) <= cn(2,5) and cn(0,5) <= cn(3,5) and cn(0,5) <= cn(1,5) and cn(0,5) <= cn(4,5)). nonn,changed,synth  1..45
       # A036822 Number of partitions satisfying cn(1,5) = cn(4,5) = 0. nonn,changed,   1..1000
       # A036846 Number of partitions of n such that cn(0,5) = cn(2,5) <= cn(3,5) = cn(4,5) <= cn(1,5). nonn,synth  1..64
       # A036880 Number of partitions of 5n such that cn(0,5) <= cn(1,5) = cn(4,5) <= cn(2,5) = cn(3,5).    nonn,synth  1..33
       # A039896 Number of partitions satisfying 0 < cn(1,5) + cn(4,5) + cn(2,5) + cn(3,5).
       } elsif ($name =~ m{\ANumber of partitions (of \d*n )?(satisfying |such that )\(?(cn[^\.]+|0 *\< *cn[^\.]+)}) {
            my $mult = $1 || "of n ";
            my $cond = $3;
            $mult =~ s{ n}{1n};
            $mult =~ m{(\d+)};
            $mult =  $1; # 1 or 5
            $cond =~ s{\)\)\.?\Z}{\)};
            $cond =~ s{ 0\)\.?\Z}{ 0};
            #          1                2           3                4           5
            $cond =~ s{(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)}{$1$2$3 and $3$4$5}g; # insert "and"
            $cond =~ s{(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)}{$1$2$3 and $3$4$5}g; # insert "and"
            $cond =~ s{(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)([\<\=\> ]+)(cn\(\d+,\d+\)|0)}{$1$2$3 and $3$4$5}g; # insert "and"
            $cond =~ s{and}{\&\&}g;
            $cond =~ s{([^\<\>])\=([^\<\>])}{$1==$2}g; # "=" -> "=="
            $cond =~ m{cn\(\d+\,(\d+)}; # second parameter
            my $kmod = $1;
            $cond =~ s{cn\((\d+)\,$kmod\)}{cn\[$1\]}g;
            $parms[$iparm ++] = $offset;
            $parms[$iparm ++] = "A035536";
            $parms[$iparm ++] = $kmod;
            $parms[$iparm ++] = $mult;
            $parms[$iparm ++] = "";
            $parms[$iparm ++] = "($cond) ? Z.ONE : Z.ZERO";
            $callcode = "partcond";

       # A160974 Number of partitions of n where every part appears at least 4 times.
       # A161026 Number of partitions of n into Fibonacci numbers where every part appears at least 2 times.    nonn,changed,   0..10000
       # A161039 Number of partitions of n into odd numbers where every part appears at least 3 times.  nonn,   1..5000
       # A161051 Number of partitions of 2n into powers of two where every part appears at least twice. nonn,changed,   1..1000
       # A161064 Number of partitions of n into powers of two minus one where every part appears at least 2 times.  nonn,changed,   1..1000
       # A161077 Number of partitions of n into primes or 1 where every part appears at least 2 times.  nonn,changed,   1..1000
       # A161090 Number of partitions of n into squares where every part appears at least 2 times.  nonn,changed,   1..1000
       # A161103 Number of partitions of n into nonzero triangular numbers where every part appears at least 2 times    nonn,   1..1000
       #                                          1          2     3                                                                                                                      4 
       } elsif ($name =~ m{\ANumber of partitions (of \d?n )?(into (Somos\-4 sequence numbers A006720|numbers not divisible by [34]|Lucas numbers A000032|central polygonal numbers A000124|central binomial coefficients A001405|Catalan numbers A000108|Fibonacci numbers|odd numbers|powers of two minus one|powers of two|primes or 1|squares|nonzero triangular numbers) )?(in which no part occurs just once|where every part appears more than two times|where every part appears at least \d+ times|where every part appears at least twice)}) {
            my $subseq = $3 || "";
            my $appears = $4;
            if (0) {
            } elsif ($appears =~ m{just once}) {
                $appears = 2;
            } elsif ($appears =~ m{more than two}) {
                $appears = 3;
            } elsif ($appears =~ m{at least (\d+)}) {
                $appears = $1;
            } elsif ($appears =~ m{at least twice}) {
                $appears = 2;
            }
            $parms[$iparm ++] = $offset;
            if (0) {
            } elsif ($subseq eq "") { # empty
                $parms[$iparm ++] = "A160974";
            } elsif ($subseq =~ m{Fibonacci}) {
                $parms[$iparm ++] = "A161026";
            } elsif ($subseq =~ m{odd}) {
                $parms[$iparm ++] = "A161039";
            } elsif ($subseq =~ m{powers of two minus}) {
                $parms[$iparm ++] = "A161064";
            } elsif ($subseq =~ m{powers of two}) {
                $parms[$iparm ++] = "A161051";
            } elsif ($subseq =~ m{primes}) {
                $parms[$iparm ++] = "A161077";
            } elsif ($subseq =~ m{squares}) {
                $parms[$iparm ++] = "A161090";
            } elsif ($subseq =~ m{triangular}) {
                $parms[$iparm ++] = "A161103";
            } elsif ($subseq =~ m{A000108}) {
                $parms[$iparm ++] = "A161227";
            } elsif ($subseq =~ m{A001405}) {
                $parms[$iparm ++] = "A161240";
            } elsif ($subseq =~ m{A000124}) {
                $parms[$iparm ++] = "A161254";
            } elsif ($subseq =~ m{Lucas}) {
                $parms[$iparm ++] = "A161268";
            } elsif ($subseq =~ m{not divisible by 3}) { # A001651}) {
                $parms[$iparm ++] = "A161281";
            } elsif ($subseq =~ m{not divisible by 4}) { # A042968}) {
                $parms[$iparm ++] = "A161293";
            } elsif ($subseq =~ m{A006720}) {
                $parms[$iparm ++] = "A161306";
            } else {
                $parms[$iparm ++] = "A160974";
            }
            my $rseqno = $parms[$iparm - 1];
            if (! defined($rseqnos{$rseqno})) {
                $rseqnos{$rseqno} = $subseq;
                print join("\t", "# $rseqno", "partcapp", 0, , $appears, "$subseq") . "\n";
            }
            $parms[$iparm ++] = $appears;
            $parms[$iparm ++] = "";
            $parms[$iparm ++] = "";
            $parms[$iparm ++] = "";
            $callcode = "partcapp";

        } else {
            print STDERR "$line\n";
            $callcode = $VOID;
        }
    #--------------------------------
    } # switch variant
    if (0) { # no output
    } elsif ($callcode ne $VOID) {
        $parms[$iparm ++] = "";
        $parms[$iparm ++] = "";
        $parms[$iparm ++] = "";
        $parms[$iparm ++] = $name;
        print join("\t", $aseqno, $callcode, @parms) . "\n";
    } # conditional output
} # while <>
#----------------
#----------------
__DATA__
