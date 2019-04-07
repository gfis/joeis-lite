#!perl

# Generate a series of Java sources for jOEIS
# @(#) $Id$
# 2019-04-05: -t targetdir (default "./temp")
# 2019-04-04, Georg Fischer
#
#:# Usage:
#:#   perl normalize_name.pl [-d debug] $(COMMON)/names > normalized_names
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
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
while (<>) { # read inputfile
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    my $name = $_;
    if ($debug >= 1) {
        print "$name\n";
    }
    $name =~ s/\s*\Z//; # remove trailing spaces
    $name =~ s/\.\Z//; # remove trailing dot
    $name =~ s/\s*\Z//; # remove trailing spaces
    # $name =~ s{\s*([\-\+\=\*\/]\^\(\)\[\]\{\}\.\:\;\,\<\>\'\")\s*}{\\$1}g;
    $name =~ s{\s+([\-\+\=\*\/\^])\s+}{$1}g; # remove space around operators
    $name =~ s{(\d+)}{\(\\d+\)}g;
		print "$name\n";
} # while <>
#---------------------------------------
__DATA__
# OEIS Sequence Names (http://oeis.org/names.gz)
# Last Modified: April  6 00:03 EDT 2019
# Use of this content is governed by the
# OEIS End-User License: http://oeis.org/LICENSE
A000001 Number of groups of order n.
A000002 Kolakoski sequence: a(n) is length of n-th run; a(1) = 1; sequence consists just of 1's and 2's.
A000003 Number of classes of primitive positive definite binary quadratic forms of discriminant D = -4n; or equivalently the class number of the quadratic order of discriminant D = -4n.
A000004 The zero sequence.
A000005 d(n) (also called tau(n) or sigma_0(n)), the number of divisors of n.
A000006 Integer part of square root of n-th prime.
A000007 The characteristic function of 0: a(n) = 0^n.
A000008 Number of ways of making change for n cents using coins of 1, 2, 5, 10 cents.
A000009 Expansion of Product_{m >= 1} (1 + x^m); number of partitions of n into distinct parts; number of partitions of n into odd parts (if n > 0).
A000010 Euler totient function phi(n): count numbers <= n and prime to n.
A000011 Number of n-bead necklaces (turning over is allowed) where complements are equivalent.
A000012 The simplest sequence of positive numbers: the all 1's sequence.
A000013 Definition (1): Number of n-bead binary necklaces with beads of 2 colors where the colors may be swapped but turning over is not allowed.
A000014 Number of series-reduced trees with n nodes.
A000015 Smallest prime power >= n.
A000016 a(n) = number of distinct (infinite) output sequences from binary n-stage shift register which feeds back the complement of the last stage. E.g., for n=6 there are 6 such sequences.
