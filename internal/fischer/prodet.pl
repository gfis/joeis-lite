#!perl

# Extract parameters for product formulas 1/(1 - x^k)^(abc)
# 2020-10-10, Georg Fischer
#
#:# Usage:
#:#   perl prodeti.pl prod1_xk.tmp > prodet.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my $negate = 0; # whether "not modulo ..."
my $VOID = "A000000";
my ($aseqno, $callcode, $offset, $var, $name, @rest);
my $rseqno;

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $var, $name, @rest) = split(/\t/, $line);
    $name =~ s{\>\=1\}}{\>0\}};
    $name =~ s{\^\((A\d+\([i-n]\))\)}{\^$1}g;
    $rseqno = $VOID;
    if (0) {

    } elsif ($name =~ m{Prod(uct)?_\{([i-n])\>0\}\s*1\/\(1\s*\-\s*[xq]\^\2\)\^(A\d+)\(\2\)}) {
        # Product_{k>0} 1/(1 - x^k)^A056924(k)
        $rseqno = $3;
        $callcode = "prodet";
        &output();

    } elsif ($name =~ m{Prod(uct)?_\{([i-n])>0\}\s*\(1\s*\-\s*][xq]\^\2\)\^(A\d+)\(\2\)}) {
		# Product_{k>0} (1 - x^k)^A038548(k)
        $rseqno = $3;
        $callcode = "prodetn";
        &output();

    #--------
    # %N A116377 Number of partitions of n into parts with digital root = 7.
    # %N A147787 Number of partitions of n into parts divisible by 4,6 or 9.
    # etc.
    } else {
        # print STDERR "$aseqno\t$name\n";
    }
} # while <>
#================================
sub output { # global $line, @periods, $reason
    print join("\t", $aseqno, $callcode, $offset, $rseqno, 1, '', '', $name) . "\n";
} # output
#--------
__DATA__
A319669 prod1_xk.pl 0   k   Product_{k>=1} (1 - x^k)^(2*k-1)

A321285 prod1_xk.pl 0   k   Product_{k>0} 1/(1 - x^k)^A056924(k)
A321286 prod1_xk.pl 0   k   Product_{k>0} (1 + x^k)^A056924(k)
A321299 prod1_xk.pl 0   k   Product_{k>0} (1 - x^k)^A038548(k)
A321300 prod1_xk.pl 0   k   Product_{k>0} (1 - x^k)^A056924(k)
A321302 prod1_xk.pl 0   k   Product_{k>=1} ((1 - x^k)/(1 + x^k))^A007426(k)
A321317 prod1_xk.pl 0   k   Product_{k>=1} (1 - x^k)^A074206(k) where A074206(n) is the number of ordered factorizations of n
A321325 prod1_xk.pl 0   k   Product_{k>0} (1 + x^k)^A067856(k)
A321326 prod1_xk.pl 0   k   Product_{k>0} (1 - x^k)^A067856(k)
A321327 prod1_xk.pl 0   k   Product_{k>=0} (1 - x^(2^k))^(2^k)
A321336 prod1_xk.pl 0   k   Product_{k>=0} (1 - x^(2^k))^(2^(k+1))
A321354 prod1_xk.pl 0   k   Product_{k>=0} (1 + x^(3^k))^(3^(k+1))
A321355 prod1_xk.pl 0   k   Product_{k>=0} (1 + x^(4^k))^(4^(k+1))
A321357 prod1_xk.pl 0   k   Product_{k>=0} (1 + x^(5^k))^(5^(k+1))
A321359 prod1_xk.pl 0   k   Product_{k>0} (1 + x^k)^A034836(k)
