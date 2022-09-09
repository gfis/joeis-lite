#!perl

# concprod.pl - grep parameters for CC=concprod
# @(#) $Id$
# 2022-09-05: revised
# 2019-07-25, Georg Fischer
#
#:# usage:
#:#     perl -n concprod.pl ../../../OEIS-mat/common/names
#----------------------------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $mode = "modpre";
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my ($aseqno, $superclass, $name, $keyword, $range, @rest);
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    next if ($line !~ m{\AA\d+});
    ($aseqno, $superclass, $name, $keyword, $range, @rest) = split(/\t/, $line);
    $name =~ s{juxtaposed}      {concatenated}g;
    $name =~ s{juxtapose}       {concatenate}g;
    $name =~ s{juxtaposing}     {concatenating}g;
    $name =~ s{juxtaposition}   {concatenation}ig;
    # print "# $name\n";
    if (0) {
    #--------
    # 'c' = the result is the concatenated base number, 'a' = addititive, 'm' = multiplicative
    } elsif ($name =~ m{Numbers \w such that the concatenation of \w with \w *([\+\-] *\d+) (is|gives) a square}) {
        &out(110, "ca", 0, $1, 0);
    } elsif ($name =~ m{Numbers \w such that \w concatenated with \w *([\+\-] *\d+) (is|gives) the product of two numbers which differ by (\d+)}) {
        &out(120, "ca", 0, $1, $3);
    } elsif ($name =~ m{Numbers \w such that \w concatenated with (itself) (is|gives) the product of two numbers which differ by (\d+)}) {
        &out(130, "ca", 0,  0, $3);
    } elsif ($name =~ m{Numbers \w such that the concatenation of \w with (\d+) *\* *\w (is|gives) a square}) {
        &out(145, "cm", 1, $1, 0);
    } elsif ($name =~ m{Numbers \w such that the concatenation of (\d+) *\* *\w with \w (is|gives) a square}) {
        &out(155, "cm", $1, 1, 0);
    #--------
    # 'p' = the result is the base of the product, a = addititive, m=multiplicative
    } elsif ($name =~ m{Numbers whose square (is|gives) the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out(210, "pa", 0, $2, 0);
    } elsif ($name =~ m{Numbers \w such that \w\^2 (is|gives) the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out(220, "pa", 0, $2, 0);
    } elsif ($name =~ m{Numbers \w such that the square of \w (is|gives) the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out(230, "pa", 0, $2, 0);
    } elsif ($name =~ m{Numbers \w such that the square of \w (is|gives) the concatenation of two numbers \w and (\d+) *\* *\w}) {
        &out(245, "pm", 1, $2, 0);
    } elsif ($name =~ m{Numbers \w such that \w\^2 (is|gives) the concatenation of two numbers \w and (\d+) *\* *\w}) {
        &out(255, "pm", 1, $2, 0);
    } elsif ($name =~ m{Numbers \w such that \w\^2 (is|gives) the concatenation of two numbers (\d+) *\* *\w and \w}) {
        &out(265, "pm", $2, 1, 0);
    } elsif ($name =~ m{Numbers (\w )?whose square (is|gives) the concatenation of two numbers (\d+) *\* *\w and \w}) {
        &out(275, "pm", $3, 1, 0);
    } elsif ($name =~ m{\w times \w *([\+\-] *\d+) (is|gives) the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out(280, "pa", 0, $3, $1);
    } elsif ($name =~ m{\w times \w *([\+\-] *\d+) (is|gives) the concatenation of a number \w with itself}) {
        &out(290, "pa", 0,  0, $1);
    #                                                      1           1   2        2                                                   3           3
    } elsif ($name =~ m{Numbers \w such that \w *\* *\(\w *([\+\-] *\d+)\) (is|gives) the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out(300, "pa", 0, $3, $1);
    } elsif ($name =~ m{Numbers \w such that \w *\* *\(\w *([\+\-] *\d+)\) (is|gives) the concatenation of a number \w with itself}) {
        &out(310, "pa", 0,  0, $1);
    #--------
    } else {
        print STDERR join("\t", $aseqno, "????", 1, $name, $range) . "\n";
    }
} # while <>
#----
sub out {
    my ($code, $mode, $conc1, $conc2, $pdiff) = @_;
    my $offset = ($range =~ m{\A(\-?\d+)\.}) ? $1 || 1 : 1;
    #                                              parm1  2       3       4       5      6  7   8   name
    print join("\t", $aseqno, "concprod", $offset, $mode, $conc1, $conc2, $pdiff, $code, 0, "", "", $name) ."\n";
} # out
__DATA__
A115535	super	Numbers k such that the concatenation of k with 4*k gives a square.	key	1..32	rest
A115536	super	Numbers k such that the square of k is the concatenation of two numbers m and 4*m.	key	1..27	rest
A115537	super	Numbers k such that the concatenation of 4*k with k gives a square.	key	1..9	rest
A115556	super	Numbers whose square is the concatenation of two numbers 9*m and m.	key	1..3	rest
A115426	super	Numbers k such that the concatenation of k with k+2 gives a square.	key	1..1	nyi	Resta
A115427	super	Numbers k such that k^2 is the concatenation of two numbers m and m+2.	base,nonn,changed,synth	1..15	nyi	_Giovanni Resta_, Jan 24 2006
A115439	super	Numbers m such that the square of m is the concatenation of two numbers k and k+5.	key	1..3733	rest
A115447	super	Numbers whose square is the concatenation of two numbers k and k-9.	key	1..19	rest
A116094	super	Numbers k such that k concatenated with k-9 gives the product of two numbers which differ by 1.	key	1..11	rest
A116154	super	Numbers k such that k concatenated with itself gives the product of two numbers which differ by 1.	key	1..23	rest
A116225	super	n times n+1 gives the concatenation of two numbers m and m-9.	nonn,base,synth	1..11	nyi	_Giovanni Resta_, Feb 06 2006
A116229	super	Numbers k such that k*(k+6) gives the concatenation of two numbers m and m-9.	nonn,base,changed,synth	1..20	nyi	_Giovanni Resta_, Feb 06 2006
A116289	super	Numbers k such that k*(k+5) gives the concatenation of a number m with itself.	nonn,base,changed,synth	1..28	nyi	_Giovanni Resta_, Feb 06 2006
A116290	super	n times n+6 gives the concatenation of a number m with itself.	nonn,base,synth	1..27	nyi	_Giovanni Resta_, Feb 06 2006

