#!perl

# try "triangle" indexing
use strict;
use integer;
my $max = 16;
my $on = -1;
for (my $ix = 0; $ix < $max; $ix ++) {
for (my $iy = 0; $iy <= $ix;  $iy ++) {
	my $nn = ($ix * ($ix + 1) / 2 + $iy);
	if ($nn != $on + 1) {
		print "error: $nn $on\n";
	} 
	$on = $nn;
	print "[$ix,$iy] -> $nn\n";
}}
