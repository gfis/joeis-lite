#!perl

# Recombine expressions splitted over several seq4 records by ck_guiddes.pl -a M
# @(#) $Id$
# 2021-09-03, Georg Fischer
#
#:# Usage:
#:#   perl uvpoly_join.pl [-d debug] input.seq4 > output.seq4
#
# The records must be sorted by aseqno and callcode, 
# and there is a fixed order of the vectors for a2, c0, n1, n2
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $offset = 0;
my $buffer;
while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    my ($aseqno, $callcode, $offset, $expr, @rest) = split(/\t/, $line);
    if ($callcode =~ m{uvpol(\w)_(\w+)}) {
        my $d_with_n = $1;
        my $var = $2;
        $d_with_n = ($d_with_n eq "n") ? "true" : "false";
        $expr =~ s{[\[\]]}{}g; # remove brackets
        if (0) {
        } elsif ($var eq "a2") {
            $buffer = $expr;
        } elsif ($var eq "c0") {
            $buffer .= "\t$expr";
        } elsif ($var eq "n1") {
            $buffer .= "\t$expr";
        } elsif ($var eq "n2") {
            $buffer .= "\t$expr";
            print join("\t", $aseqno, "uvpoly", $offset, $buffer, $d_with_n) . "\n";
        }
    }
} # while
__DATA__
A208509	uvpoln_a2	0	[3]	1+1+(1)	0
A208509	uvpoln_c0	0	[0]	(0)*(1)-(1)*(1)+(1)	0
A208509	uvpoln_n1	0	[2]	1+1	0
A208509	uvpoln_n2	0	[-1,1]	(x)*(1)-(1)*(1)	0
A208510	uvpoln_a2	0	[1,1]	1+x+(0)	0
A208510	uvpoln_c0	0	[0,1]	(x)*(1)-(0)*(x)+(0)	0
A208510	uvpoln_n1	0	[1,1]	1+x	0
A208510	uvpoln_n2	0	[0]	(x)*(1)-(1)*(x)	0
