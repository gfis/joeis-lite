#!perl

# Keep the first n records of any callcode only
# 2021-01-27, Georg Fischer
#
#:# Usage:
#:#   perl keepfirst.pl [-n 4] input.tmp > output.gen
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $maxn = 4;
my $aseqno;
my $callcode;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{a}) {
        $aseqno    = shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $maxn      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %hash;
while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\A(A\d+)\t(\w+)\t}) { # line with A-number and callcode
        $callcode = $2;
        my $n = ($hash{$callcode} || 0) + 1;
        $hash{$callcode} = $n;
        if ($n <= $maxn) {
            print "$line\n";
        }
    } # line with A-number
} # while <>
__DATA__
# holref1.tmp
A000053 finit   1
A000054 finit   1
A000073 linea   0
A000078 linea   0
A000100 linea   0
A000102 linea   0
A000352 gener   4
A000431 gener   0
A000517 gener   7
A000597 gener   4
A000797 finit   1
A000926 finit   1
