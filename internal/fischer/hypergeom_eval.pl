#!perl

# Evaluate holonomic recurrence matrices and look whether they are hypergeometric
# 2021-01-22, Georg Fischer
#
#:# Usage:
#:#   perl hypergeom_eval.pl input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{d}) {
        $debug    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line = "";
my ($aseqno, $callcode, $offset, $matrix, @rest);

# while (<DATA>) {
while (<>) {
    next if ! m{\AA\d+}; # no A-number
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, @rest) = split(/\t/, $line);
    $matrix = $rest[0];
    if ($matrix =~ s{\A\[\[}{}) {
        $matrix =~ s{\]\]\Z}{};
        $matrix =~ s{\s}{}g;
        my @rows = split(/\]\,\[/, $matrix);
        if (scalar(@rows) == 3 && $rows[0] eq "0" && ($rows[2] ne "1" && $rows[2] ne "-1")) {
            my @r1 = split(/\,/, $rows[1]);
            my @r2 = split(/\,/, $rows[2]);
            print join("\t", $aseqno, $matrix, splice(@rest, 0, 4), scalar(@r1), scalar(@r2), $rows[1], $rows[2]) . "\n";
        }
    } 
} # while <>
#--------
__DATA__
101095	holos	1	[0,1,-2,1]	[1,28,121,240,360]	0
A101106	holos	0	[[0],[-2,1],[9,-6],[-3,3],[3,-6],[0,1]]	[1,3,12,57,283]	0
A101109	holos	0	[[0],[-3],[0],[0],[3,1]]	[1,0,0,6,0]	3
A101229	holos	1	[0,-2,1]	[1,2,4,1,2,4,8,16,5,10,3]	0
A101269	holos	1	[[0],[500,-850,540,-152,16],[-29,30,-8],[1]]	[0,1]	0
A101432	holos	0	[[0],[1],[0],[-1]]	[1, 3, 4, 6]	0
A101478	holos	0	[[0],[0,384,2816,6144,4096],[-3360,-11792,-15808,-9472,-2048],[4680,10236,8364,2976,384],[-1440,-2328,-1372,-348,-32],[120,154,71,14,1]]	[0,1,4,21,124,782]	4
A101488	holos	0	[[0],[0,4,8],[72,82,30],[64,68,20],[-28,-19,-3],[-20,-9,-1]]	[1,1,1,2,4,10]	4
A101499	holos	0	[[0],[2,3,1],[-20,-18,-4],[-6,1,1],[80,20],[-50,-15,-1],[132,46,4],[-42,-13,-1]]	[1,1,1,3,9,25,73,223]	6
A101500	holos	0	[[0],[2,1],[-10,-4],[6,2],[-14,-4],[4,1]]	[1,2,5,16,53,178]	4
A101596	holos	0	[[0],[40,36,8],[-5,-6,-1]]	[1,8,56]	1
A101600	holos	0	[[0],[-6,-12],[2,1]]	[1,6,45]	0
A101601	holos	0	[[0],[36,42,12],[-4,-5,-1]]	[1,9,81]	1
A101602	holos	0	[[0],[60,54,12],[-5,-6,-1]]	[1,12,126]	1
A101686	holos	0	[[0],[-1,0,-1],[1]]	[1,2]	0
