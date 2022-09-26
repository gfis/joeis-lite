#!perl

# conctest.pl - test concpord algorithm
# @(#) $Id$
# 2022-09-07, Georg Fischer
#
#:# usage:
#:#     perl -n conctest.pl < input.seq4
#----------------------------------------------------
use strict;
use integer;
use warnings;
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

while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    next if ($line !~ m{\AA\d+});
    my ($aseqno, $callcode, $offset, $mode, $conc1, $conc2, $pdiff, $code, $parm6, $parm7, $parm8, $name) = split(/\t/, $line);
} # while <>
#----
__DATA__
A115434	concprod	1	ca	0	-7	0	110	8			Numbers k such that the concatenation of k with k-7 gives a square.
A115435	concprod	1	ca	0	-8	0	110	2137			Numbers k such that the concatenation of k with k-8 gives a square.
A115436	concprod	1	ca	0	-9	0	110	50			Numbers k such that the concatenation of k with k-9 gives a square.
A115437	concprod	1	ca	0	+4	0	110	96			Numbers m such that the concatenation of m with m+4 gives a square.
A115438	concprod	1	pa	0	+4	0	210	2			Numbers whose square is the concatenation of two numbers k and k+4.
