#!perl

# Extract parameter for MultiplicativeSequence from legacy jOEIS programs
# @(#) $Id$
# 2022-07-19, Georg Fischer
#
#:# Usage:
#:#     perl multext.pl mult2.gen > mult3.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $path = "../../../joeis/src/irvine/oeis";
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my ($aseqno, $callcode, $offset, $name);
$callcode = "xult";
$offset = 0;
while (<>) {
    s/\s+\Z//; # chompr
    next if ! m{\AA\d+};
    next if m{\.\.\.};
    s/ /\t/; # not global!
    ($aseqno, $name) = split(/\t/);
    if ($name =~ s{Multiplicative with ([^\.]+)\.}{M.w. $1\.}i) {
        my $expr = $1;
        if ($expr =~ m{a\(p\^k\)}) {
            $expr =~ s{k}{e}g;
        }
        $expr =~ s{a\(p\^e\) *\= ([^p])p*}{Z.valueOf($1}g;
        $expr =~ s{a\(p\^e\) *\= *}{}g;
        $expr =~ s{a\(2\^e\) *\= *}{p\.equals\(Z\.TWO\) ? Z\.valueOf\(}g;
        $expr =~ s{p\^\(}{p\.pow\(}g;
        $expr =~~s {\A([^p])}{Z\.valueOf\($1};
        $expr =~ s{\(\-1\)\^e}{\(\(\(e \& 1\) == 0) ? 1 : \-1\)}g;
        $expr =~ s{ *for.*}{};
        $expr =~ s{otherwise}{};
        $expr =~ s{ and }{ \: }g;
        $expr =~ s{2\^\(}{Z.ONE.shiftLeft\(}g;
        $expr =~ s{\)\^2}{\)\.square\(\)}g;
        $expr =~ s{\)\*\(}{\)\.multiply\(}g;
        $expr =~ s{Z\.valueOf\(1}{Z\.ONE}g;
        print join("\t", $aseqno, $callcode, $offset, $expr, "", $name) . "\n"
    }
} # while <>
#--------------------------------------------
__DATA__
A327937 Multiplicative with p^(p-1) if e >= p, otherwise a(p^e) = p^e.
A133482 Multiplicative with p^(pe). If n = Product p(k)^e(k) then a(n) = Product p(k)^(p(k)*e(k)). - _Jaroslav Krizek_, Oct 17 2009
A321322 Multiplicative with p^2 - 2 if e = 1 and (p^2 - 1)^2 * p^(2*e - 4) otherwise. - _Amiram Eldar_, Oct 26 2020
A078615 Multiplicative with p^2. - _Mitch Harris_, May 17 2005
A270436 Multiplicative with p^A065621(e).
A307037 Multiplicative with p^e + (-1)^e.
A306408 Multiplicative with p^e - (p^e - 1)/(p-1).
A326575 Multiplicative with p^e if p < 5, (p^(e+1)-(-1)^(e+1))/(p+1) if p == 5 (mod 6), and (p^(e+1)-1)/(p-1) if p == 1 (mod 6). - _Amiram Eldar_, Dec 02 2020
A328618 Multiplicative with p^e if p = 2 or e is a multiple of p, otherwise a(p^e) = p^((p*floor(e/p)) + (2e mod p)).
A111938 Multiplicative with p^e if p = 2; (e+1)p^e if p == 1 (mod 4); (1+(-1)^e)/2 p^e if p == 3 (mod 4).
A155918 Multiplicative with p^e if p == 1 (mod 4); ceiling(p^(e+1)/(p+1)) if p == 3 (mod 4); 2^(e-1) + 1 if p = 2. - _Jianing Song_, Apr 20 2019
A085731 Multiplicative with p^e if p divides e; a(p^e) = p^(e-1) otherwise. - _Eric M. Schmidt_, Oct 22 2013
