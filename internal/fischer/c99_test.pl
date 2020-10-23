#!perl
# c99_test.pl - find solutions to (b+1)^2 = c^2 - 99
# 2020-10-20, Georg Fischer

use strict;
use integer;
use warnings;

my %roots = ();
foreach my $c (0..65535) {
    $roots{$c * $c} = $c;
}


foreach my $c (10...10000) {
	my $val = $c * $c - 99;
	if (defined($roots{$val})) {
		print "c = $c -> $roots{$val}\n";
	}
}
