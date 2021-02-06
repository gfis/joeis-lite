#!perl

# Generate holonomic recurrences for "NUmerator of Hermite(n, k/m)
# @(#) $Id$
# 2021-02-03, Georg Fischer; SBW
#
#:# Usage:
#:#   grep -E "Numerator of Hermite" $(COMMON)/joeis_names.txt \
#:#   | perl gen_hermite.pl > output
#
#---------------------------------
use strict;
use integer;
use warnings;

while (<>) {
    s{\s+\Z}{};
    my $line = $_;
    my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    $name =~ m{(\d+)\/(\d+)}; 
    my ($num, $den) = ($1, $2);
    if (($den & 1) == 0) { # even
        $den = 2 * ($den >> 1)**2;
    } else { # odd
        $den = 2 * ($den     )**2;
        $num <<= 1;
    }
    print join("\t", $aseqno, "holos", 0, "[[0],[$den,-$den],[$num],[-1]]", ""
        , 0, 0, lc(substr($superclass, 0, 5)), $name) . "\n"; 
} # while <>    
__DATA__
A158967	HolonomicRecurrence	Numerator of Hermite(n, 4/5).	sign,frac,	0..450	holose
A158968	HolonomicRecurrence	Numerator of Hermite(n, 1/6).	sign,frac,	0..450	holose
A158969	HolonomicRecurrence	Numerator of Hermite(n, 5/6).	sign,frac,	0..450	holose
	make runholo MATRIX="[[0],[18,-18],[5],[-1]]" INIT="" NT=16
