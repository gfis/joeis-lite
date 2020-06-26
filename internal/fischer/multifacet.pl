#!perl

# Extract sequences from the OEIS wiki page:
# Charles R Greathouse IV, The multi-faceted reach of the OEIS.
# @(#) $Id$
# 2020-06-26, Georg Fischer
#
#:# Usage:
#:#     wget ...
#:#     perl multifacet.pl [-d debug] input > output
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
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

#----------------
my ($topic);
while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if (0) {
    } elsif ($line =~ m{\A\=\=+\s*([^\=]*)}) {
        $topic = lc($1);
        $topic =~ s{\W}{}g;
    } elsif ($line =~ m{(A\d{6})}) {
        foreach my $aseqno ($line =~ m{(A\d{6})}g) {
            print join("\t", $aseqno, "noncomp", 0, $topic) . "\n";
        } # foreach
    }
} # while <>
#--------------------------------------------
__DATA__
{{More}}
The OEIS covers more than just math: it has entries that go into various scientific fields and even the arts. To quote Brian Hayes on the OEIS:<ref>Brian Hayes, "A question of numbers", ''American Scientist'' '''84''':1 (1996), pp. 10–14.</ref>
:Number theory and combinatorics are naturally well represented, but there are also lots of examples from switching theory and circuit design (combinations of Boolean functions), chemistry (numbers of alkanes, ethers, esters, etc., with n carbon atoms) and a few from physics (Feynman diagrams with n vertices) and biology (secondary structures of RNA with n nucleotides).
This is an attempt to list some of those fields and the relevant material.

== Natural sciences ==

=== Life sciences ===

==== Biology ====

A008792, the amino acid numbers, is a mathematical representation of amino acids in theoretical biology.

===== Botany =====

====== Phyllotaxy ======

In botany, dynamical systems or their discretizations are often used in growth modeling, especially {{Wikipedia|phyllotaxis|}} (plant morphology), following the work of Irving Adler; see A093613, A002965, A036299, A122771, A122773, A138201, and A139344.

The [[Fibonacci numbers]] (A000045) appear in the phyllotaxis of sunflowers and pineapples, and also in the leaf arrangements of many plants.

Even combinatorial game theory is relevant to phyllotaxis, see A047708.

<!-- ===== Zoology ===== -->

===== Genetics =====

:A000311 Number of phylogenetic trees with n nodes.
:A074206 Lower bound on the worst-case number of solutions to the probed partial digest problem for n fragments of DNA.
:A088518 Symmetric secondary structures of RNA molecules with n nucleotides.
:A104155 The 64 codons of the genetic code, giving the value 1 to thymine (T), 3 to adenine (A), 2 to cytosine (C) and 4 to guanine (G).
:A164057 Complement to A164056, change A164056 bits (0->1; 1->0). Provides a coding template for Petoukhov matrices, relating to DNA codons.  
:A180850 Number of codons that code for an amino acid, listed in alphabetical order of their single-letter codes.
:A202478 Decimal expansion of constant arising in combinatorics of gamma-structures (RNA pseudoknot related).
:A000918 Time since a common genetic ancestor.<ref>R. B. Campbell, The effect of inbreeding constraints and offspring distribution on time to the most recent common ancestor, Journal of Theoretical Biology 382 (2015), pp. 74-80.</ref>
:A280234 Constant related to the ASTRAL algorithm in phylogenetic reconstruction.

