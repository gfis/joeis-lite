#!perl

# Keep cat25.txt O-line only after non-O
# @(#) $Id$
# 2022-06-07, Georg Fischer
#
#:# Usage:
#:#   perl oshrik,pl input > output
#-------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug      = shift(@ARGV);
    }
} # while $opt

my $state = "O";
# while (<DATA>) {
while (<>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if (0) {
    } elsif ($state eq "N") {
        if ($line =~ m{\A.O}) {
            $state = "O";
        }
        print "$line\n";
    } elsif ($state eq "O") {
        if ($line !~ m{\A.O}) {
            $state = "N";
            print "$line\n";
        }
    }
} # while
#========
__DATA__
%O A058177 0,12
%O A058178 0,11
%O A058179 1,1
%N A058181 Quadratic recurrence a(n) = a(n-1)^2 - a(n-2) for n >= 2 with a(0) = 1 and a(1) = 0.
%F A058181 a(n)^2 = a(n+1) + a(n-1), a(-1-n) = a(n).
%O A058181 0,5
%F A058183 a(n) = (n+1)*floor(log_10(10*n)) - (10^floor(log_10(10*n))-1)/(10-1) = a(n-1) + floor(log_10(10*n)) = A055642(A007908(n)).
%O A058183 1,2
%O A058185 0,3
