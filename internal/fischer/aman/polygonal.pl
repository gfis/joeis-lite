#!perl

# Generate polygonal sequences for shapes >= 11
# @(#) $Id$
# 2024-03-28, Georg Fischer; *WK=77

use strict;
use integer;

my $lo = 1;
my $hi = 16;
my $gen = shift(@ARGV);
$hi = shift(@ARGV);
if (0) {
} elsif ($gen eq "poly") {
    # 30-gonal numbers: a(n) = n*(14*n-13).
    # 47-gonal:               (n*(45*n-43))/2.
    for (my $shape = 3; $shape <= 1024; $shape ++) {
        my $div = 2; # 1 + ($shape & 1);
        my $buffer = "";
        for (my $n = $lo; $n <= $hi; $n ++) {
            $buffer .= "," . ($n * ($n * ($shape - 2) - ($shape - 4))/$div);
        }
        print substr($buffer, 1) . "\n";
    } # 3..100
} elsif ($gen eq "pyra") {
    # A237616 Cf. sequences with formula n*(n+1)*(k*n-k+3)/6
    for (my $shape = 3; $shape <= 1024; $shape ++) {
    	my $k = $shape - 2;
        my $div = 6; # 1 + ($shape & 1);
        my $buffer = "";
        for (my $n = $lo; $n <= $hi; $n ++) {
            $buffer .= "," . ($n * ($n + 1) * ($k*$n - $k + 3)/$div);
        }
        print substr($buffer, 1) . "\n";
    } # 3..100
} elsif ($gen =~ m{\Anew}) {
    while(<DATA>) {
       s/\s+\Z//; # chompr
       my $line = $_;
       next if $line !~ m{\AA\d+};
       my ($aseqno, $callcode, $offset, $shape, @rest) = split(/\t/, $line);
       my @parms;
       if (0) {
       } elsif ($callcode =~ m{\Apoly}) {
           @parms  = ($shape, ($shape - 2), ($shape - 4), @rest);
       } elsif ($callcode =~ m{\Apyra}) {
           @parms  = (($shape + 1), ($shape - 2), ($shape - 5), @rest);
       }
       print join("\t", $aseqno, $callcode, $offset, join("\t", @parms)) . "\n";
    }
} else {
    while(<DATA>) {
        if (m{\A(A\d+)\s+(\d+)}) {
            my ($aseqno, $shape) = ($1, $2);
            if ($shape % 2 == 1) {
                print join("\t", $aseqno, "polygonod", 0, $shape, ($shape - 2)/1, ($shape - 4)/1) . "\n";
            } else {
                print join("\t", $aseqno, "polygonev", 0, $shape, ($shape - 2)/2, ($shape - 4)/2) . "\n";
            }
        }
    }
} # no "gen" 
# Caution, do not expand tabs below!
__DATA__
A051682	polygonal	0	11
A051624	polygonal	0	12
A051865	polygonal	0	13
A051866	polygonal	0	14
A051867	polygonal	0	15
A051868	polygonal	0	16
A051869	polygonal	0	17
A051870	polygonal	0	18
A051871	polygonal	0	19
A051872	polygonal	0	20
A051873	polygonal	0	21
A051874	polygonal	0	22
A051875	polygonal	0	23
A051876	polygonal	0	24
A255184	polygonal	0	25
A255185	polygonal	0	26
A255186	polygonal	0	27
A161935	polygonal	0	28
A255187	polygonal	0	29
A254474	polygonal	0	30
A098923	polygonal	0	33
A282854	polygonal	0	34
A282851	polygonal	0	35
A282853	polygonal	0	36
A282852	polygonal	0	37
A282850	polygonal	0	38
A261191	polygonal	0	40
A098924	polygonal	0	45	~~    ~~next();
A095311	polygonal	0	47	~~    ~~next();
A261343	polygonal	0	50
A249911	polygonal	0	60
A098140	polygonal	0	63
A098230	polygonal	0	75
A261276	polygonal	0	100
A195163	polygonal	0	1000

# A000292	pyramidal	0	1
# A000330	pyramidal	0	2
# A002411	pyramidal	0	3
# A002412	pyramidal	0	4
# A002413	pyramidal	0	5
# A002414	pyramidal	0	6
# A007584	pyramidal	0	7
# A007585	pyramidal	0	8
# A007586	pyramidal	0	9
# A007587	pyramidal	0	10
A050441	pyramidal	0	13
A172073	pyramidal	0	14
A177890	pyramidal	0	15
A172076	pyramidal	0	16
A237616	pyramidal	0	17
A172078	pyramidal	0	18
A237617	pyramidal	0	19
A172082	pyramidal	0	20
A237618	pyramidal	0	21
A172117	pyramidal	0	22
A256718	pyramidal	0	23
A256716	pyramidal	0	24
A256645	pyramidal	0	25
A256646	pyramidal	0	26
A256647	pyramidal	0	27
A256648	pyramidal	0	28
A256649	pyramidal	0	29
A256650	pyramidal	0	30
# A130566	pyramidal	0	47	~~    ~~next();	Difference a(1) ...

