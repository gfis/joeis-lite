#!perl

# Some test program
# @(#) $Id$
# 2022-12-03, Georg Fischer; SP=45
#
#:# Usage:
#:#   perl test.pl
#---------------------------------
use strict;
use integer;
use warnings;

for (my $i = 0; $i < 64; $i ++) { 
  print " ", ((2 * $i + 1) & 0xAAAAAA) + 1;
}
print "\n";
__DATA__
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