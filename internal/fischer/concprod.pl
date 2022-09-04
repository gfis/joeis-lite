# concprod.pl
# @(#) $Id$
# 2019-07-25, Georg Fischer
#
#:# usage:
#:#     perl -n concprod.pl ../../../OEIS-mat/common/names
#
# A116224       0   0   +9  9
# A116225       0   1   -9  1
#                rs   i   j
#   rs=0:  Numbers k such that k // (k+i) = m * (m+j)
#   rs=1:  Numbers k such that m // (m+i) = k * (k+j)
#
# A030465 Numbers n such that n concatenated with n+1 is a square.
# A030466 Squares that are concatenations of two consecutive nonzero numbers.
# A030467 Numbers n such that n^2 is a concatenation of two successive numbers.
# A116353	null	Numbers n such that n times n+7 gives the concatenation of two numbers m and m+9.	nonn,base,synth	1..5
# A116354	null	n times n+8 gives the concatenation of two numbers m and m+9.	nonn,base,synth	1..23
# A115437	null	Numbers n such that the concatenation of n with n+4 gives a square.	base,nonn,synth	1..24
# A115438	null	Numbers n such that the square of n is the concatenation of two numbers k and k+4.	base,nonn,synth	1..25
# A115527	null	Numbers n such that the concatenation of n with 2*n gives a square.	nonn,base,synth	1..5
# A115528	null	Numbers n such that the square of n is the concatenation of two numbers m and 2*m.	nonn,base,synth	1..5
# A116094 Numbers n such that n concatenated with n-9 gives the product of two numbers which differ by 1.
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
    if (0) {
    #--------
    # 'c' = the result is the concatenated base number, 'a' = addititive, 'm' = multiplicative
    } elsif ($name =~ m{Numbers \w such that the concatenation of \w with \w *([\+\-] *\d+) (is|gives) a square}) {
        &out("ca", 0, $1, 0);
    } elsif ($name =~ m{Numbers \w such that \w concatenated with \w *([\+\-] *\d+) gives the product of two numbers which differ by (\d+)}) {
        &out("ca", 0, $1, $2);
    } elsif ($name =~ m{Numbers \w such that \w concatenated with (itself) gives the product of two numbers which differ by (\d+)}) {
        &out("ca", 0, 0, $2);
    } elsif ($name =~ m{Numbers \w such that the concatenation of \w with (\d+) *\* *\w (is|gives) a square}) {
        &out("cm", 1, $1, 0);
    } elsif ($name =~ m{Numbers \w such that the concatenation of (\d+) *\* *\w with \w (is|gives) a square}) {
        &out("cm", $1, 1, 0);
    } elsif ($name =~ m{Numbers \w such that the square of \w is the concatenation of two numbers \w and (\d+) *\* *\w}) {
        &out("cm", 1, $1, 0);
    #--------
    # 'p' = the result is the base of the product, a = addititive, m=multiplicative
    } elsif ($name =~ m{Numbers whose square is the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out("pa", 0, $1, 0);
    } elsif ($name =~ m{Numbers \w such that \w\^2 is the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out("pa", 0, $1, 0);
    } elsif ($name =~ m{Numbers \w such that the square of \w is the concatenation of two numbers \w and \w *([\+\-] *\d+)}) {
        &out("pa", 0, $1, 0);
    } elsif ($name =~ m{Numbers \w such that \w\^2 is the concatenation of two numbers \w and (\d+) *\* *\w}) {
        &out("pm", 1, $1, 0);
    } elsif ($name =~ m{Numbers \w such that \w\^2 is the concatenation of two numbers (\d+) *\* *\w and \w}) {
        &out("pm", 1, $1, 0);
    } elsif ($name =~ m{Numbers (\w )?whose square is the concatenation of two numbers (\d+) *\* *\w and \w}) {
        &out("pm", $2, 1, 0);
    #--------
    } else {
        print STDERR join("\t", $aseqno, $name, $range) . "\n";
    }
} # while <>
#----
sub out {
    my ($mode, $conc1, $conc2, $pdiff) = @_;
    my $offset = ($range =~ m{\A(\-?\d+)\.}) ? $1 : 1;
    print join("\t", $aseqno, "concprod", $offset, $mode, $conc1, $conc2, $pdiff, $name) ."\n";
} # out
__DATA__
A115426	Numbers k such that the concatenation of k with k+2 gives a square.
A115427	Numbers k such that k^2 is the concatenation of two numbers m and m+2.	base,nonn,changed,synth	1..15	nyi	_Giovanni Resta_, Jan 24 2006
A115439	Numbers m such that the square of m is the concatenation of two numbers k and k+5.	1..3733
A115447	Numbers whose square is the concatenation of two numbers k and k-9.	1..19
A116094	Numbers k such that k concatenated with k-9 gives the product of two numbers which differ by 1.	1..11

A115535	Numbers k such that the concatenation of k with 4*k gives a square.	1..32
A115536	Numbers k such that the square of k is the concatenation of two numbers m and 4*m.	1..27
A115537	Numbers k such that the concatenation of 4*k with k gives a square.	1..9
A115556	Numbers whose square is the concatenation of two numbers 9*m and m.	1..3
A115536 Numbers k such that the square of k is the concatenation of two numbers m and 4*m.      1..27
A116154	Numbers k such that k concatenated with itself gives the product of two numbers which differ by 1.	1..23
