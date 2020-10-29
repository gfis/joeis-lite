#!perl

# Generate a Gram matrix of dimension dim
# 2020-10-29, Georg Fischer
#
#:# Usage:
#:#   perl gengram.pl dim > output
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my $matrix = 
my $dim = shift(@ARGV);
my @rows = ();
for (my $i = 0; $i < $dim; $i ++) {
    my @cols = ();
    for (my $j = 0; $j < $dim; $j ++) {
        push(@cols, ($i == $j) ? $i + 1 : 0);
    } # for $j
    push(@rows, "{" . join(",", @cols) . "}");
} # for $i
print "{" . join(",", @rows) . "}\n";
