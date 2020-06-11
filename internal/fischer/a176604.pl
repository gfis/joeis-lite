#!perl

# Generate polynomials for HolonomicRecurrence.java
# @(#) $Id$
# 2020-01-21, Georg Fischer
#
#:# Usage:
#:#   perl a176604.pl choulet.gen > holos.gen
#---------------------------------
use strict;
use integer;
use warnings;

my $aseqno;
my $line;

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    next if $line =~ m{^\s*\#};
    my ($aseqno, $callcode, $offset, $a0, $m, $k, $l, @rest) = split(/\t/, $line);
    print join("\t", ($aseqno, "holos", $offset, "[[0,0"
			. "],[" . (+ (+20+20*$k+20*$l-20*$m)) . "," . (+ (- 4- 4*$k-4*$l+ 4*$m)) # *n)*a[n-5]
			. "],[" . (- (+62+48*$k+34*$l-48*$m)) . "," . (- (-16-12*$k-8*$l+12*$m)) # *n)*a[n-4]
			. "],[" . (+ (+68+28*$k+14*$l-36*$m)) . "," . (+ (-25- 8*$k-4*$l+12*$m)) # *n)*a[n-3]
			. "],[" . (- (+29            - 8*$m)) . "," . (- (-19           + 4*$m)) # *n)*a[n-2]
			. "],[" . (- ( -2                  )) . "," . (- (  7                 )) # *n)*a[n-1]
			. "],[" . (+ ( +1                  )) . "," . (+ (  1                 )) # *n)*a[n  ]
            . "]]", "[$a0,$m]", 0, "choulet $m, $k, $l")) . "\n";
} # while
__DATA__
(* A176605: m=1, k=0 and l=1.	1, 1, 3, 8, 23, 72, 239 *)
m:=1; k:=0; l:=1; RecurrenceTable[{a[0]==1, a[1]==m, 
a[2]==3, a[3]==8, a[4]==23,
+ (+20+20*k+20*l-20*m+(- 4- 4*k-4*l+ 4*m)*n)*a[n-5]
- (+62+48*k+34*l-48*m+(-16-12*k-8*l+12*m)*n)*a[n-4]
+ (+68+28*k+14*l-36*m+(-25- 8*k-4*l+12*m)*n)*a[n-3]
- (+29          - 8*m+(-19         + 4*m)*n)*a[n-2]
- ( -2               +(  7              )*n)*a[n-1]
+ ( +1               +(  1              )*n)*a[n  ]
== 0},a,{n,0,16}]

#                   a0  a1  k   l
A176604	choulet	0	1	0	0	1
A176605	choulet	0	1	1	0	1
A176606	choulet	0	1	3	0	1
A176607	choulet	0	1	4	0	1

