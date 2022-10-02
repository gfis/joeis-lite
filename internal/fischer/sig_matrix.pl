#!perl

# Turn lrindex signatures into matrices for HolonomicRecurrence
# @(#) $Id$
# 2022-09-29, Georg Fischer
#
#:# Usage:
#:#   grep -E "^A[0-9] $(COMMON)/../lrindex/lrindx_nyi_check.txt \
#:#   | perl sig_matrix > output.tmp 2> holsig.holo.run
#---------------------------------
use strict;
use integer;
use warnings;

while(<>) {
    s{\s+\Z}{}; # chompr
    my $line = $_;
    my ($aseqno, $callcode, $offset1, $signature, $inits, $sigorder, @rest) = split(/\t/, $line);
    $signature =~ s{ }{}g;
    my $matrix = "[0," . join(",", reverse(split(/\,/, $signature))) . ",-1]";
    print join("\t", $aseqno, "holos", $offset1, $matrix, $inits, 0, 0, "Lin.rec. signature: ($signature)") . "\n"; 
    print STDERR "make runholo ASEQNO=$aseqno OFF=$offset1 MATRIX=\"$matrix\" INIT=\"$inits\"\n";
} # while <>
__DATA__
A060602 0       holsig  6,-13,12,-4     8,24,62,148     4       1       0       27      Number of tilings of the d-dimensional zonotope