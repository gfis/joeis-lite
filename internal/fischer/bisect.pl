#!perl

# Determine polarity for bisections
# @(#) $Id$
# 2021-05-28, Georg Fischer
#
#:# Usage:
#:#   perl bisect.pl seq4-format > seq4-format
#---------------------------------
use strict;
use integer;
use warnings;

my $line;
my ($aseqno, $callcode, $offset, $rseqno, $polar, $lista, $listr, $name);
my $cc = "bisect";

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $rseqno, $polar, $lista, $listr, $name) = split(/\t/, $line);
    #                             parm1    parm2   parm3   parm4   parm5
    my  @termas = split(/\,/, $lista); 
    pop(@termas); # maybe incomplete
    my  @termrs = split(/\,/, $listr); 
    pop(@termrs); 
    if (0) {
    } elsif ($termas[0] eq $termrs[0] && $termas[1] eq $termrs[2]) {
        $polar = 0;
    } elsif ($termas[0] eq $termrs[1] && $termas[1] eq $termrs[3]) {
        $polar = 1;
    } else {
        $polar = 0; # did not find it, but assume first
    }
    if ($polar >= 0) {
        print join("\t", $aseqno, $cc, -2, $rseqno, $polar, $lista, $listr, $name) . "\n";
    } else { # no more:
        print STDERR "# " . join("\t", $aseqno, $cc, $polar, $rseqno, $polar, $lista, $listr, $name) . "\n";
    }
} # while <>
#--------
__DATA__
head -n4 bisect.tmp
A002286 bisect  -2      A002470 -2      1,-8,10,80,-231,-248,1466,-80,-4766,1944,9600,-2704,-15525,-3984        0,1,4,-8,-48,10,224,80,-448,-231,40,-248,1408,1466,2240,-80,1280,-4766,-924,1944,-480,9600,6944,-2704,-8704,-15525,5864,-3984,-    A002470 Bisection of A002470.   sign,synth      1..36   unkn