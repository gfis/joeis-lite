#!perl

# Extract CC=holos parameters from "make runholo" commands
# @(#) $Id$
# 2022-07-19, Georg Fischer
#
#:# Usage:
#:#     perl parmholo.pl input.cmd > output.seq4
#--------------------------------------------------------
use strict;
use integer;
use warnings;

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

while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{^make +runholo +OFF\=(\-?\d+) +A\=(\w+) +MATRIX=\"([^\"]*)\" +INIT=\"([^\"]*)\"}) {
        my ($offset, $aseqno, $matrix, $init) = ($1, $2, $3, $4);
        print join("\t", $aseqno, "holos", $offset, $matrix, $init, 0) . "\n";
    }
} # while <>
#--------------------------------------------
__DATA__
make runholo OFF=1 A=A251538 MATRIX="[[0],[216,-339,71,-4],[-504,407,-75,4]]" INIT="2,6,10,14,18,22,26,30,33"
# A252078 664, 0; -75, 664; -1, -75; 0, -1; -656, 0; 74, -656; 1, 74; 0, 1 1,22,33,41,56,57,58,91,92
vector[1]=[0,664,-75,-1,0,-656,74,1] vector[0]=[664,-75,-1,0,-656,74,1,0] 
make runholo OFF=1 A=A252078 MATRIX="[[0],[664,-75,-1],[-656,74,1]]" INIT="1,22,33,41,56,57,58,91,92"
# A253277 -210; -181; 28; -1; 0; 210; -29; 1 3,6,9,12,18,21,24,27,30
vector[0]=[-210,-181,28,-1,0,210,-29,1] 
make runholo OFF=1 A=A253277 MATRIX="[[0],[-210,-181,28,-1],[0,210,-29,1]]" INIT="3,6,9,12,18,21,24,27,30"
# A253445 0; 0; 10; -1; -10; 21; -12; 1 11,44,99,1616,2525,3636,4949,6464,8181
vector[0]=[0,0,10,-1,-10,21,-12,1] 
make runholo OFF=1 A=A253445 MATRIX="[[0],[0,0,10,-1],[-10,21,-12,1]]" INIT="11,44,99,1616,2525,3636,4949,6464,8181"
