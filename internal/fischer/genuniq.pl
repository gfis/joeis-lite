#!perl

# Take first occurence of all A-numbers only, and split the following into a separate file
# 2020-05-20, Georg Fischer
#
#:# Usage:
#:#   perl genuniq.pl callcode.tmp > callcode.gen 2> callcode.dup
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my %hash = ();
while (<>) {
    # no! s{\s+\Z}{}; # chompr
    my $line = $_;
    my ($aseqno, @rest) = split(/\t/, $line);
    if (! defined($hash{$aseqno})) {
    	$hash{$aseqno} = 1;
    	print $line;
    } else {
    	print STDERR $line;
    }
} # while <>
