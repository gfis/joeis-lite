#!perl

# Keep the last record for any A-number
# 2021-01-25, Georg Fischer
#
#:# Usage:
#:#   perl keeplast.pl input > output
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my %hash;
while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\A(A\d+)}) {
        $hash{$1} = $line;
    }
} # while <>
foreach my $aseqno (sort(keys(%hash))) {
    print "$hash{$aseqno}\n";
} # foreach $aseqno
