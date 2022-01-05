#!perl

# binquad_show.pl - show the numbers represented by a binary quadratic form
# 2022-01-05, Georg Fischer
#
#:# Usage:
#:#     perl binquad_show.pl [-n max] [-s] a b c
#:#         -n number of rows/columns (default: 16)
#:#         -s ("signed"): whether to run x = -max .. +max (default: 0..max)
#-----------------------------------------------
use strict;
use integer;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime (time);
my $utc_stamp = sprintf ("%04d-%02d-%02dT%02d:%02d:%02d\z"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

my $nrows = 16;
my $start = 0;
my $debug = 0;
my ($a, $b, $c) = (2, -1, 3);
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $nrows     = shift(@ARGV);
    } elsif ($opt  =~ m{s}) {
        $start    = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

$start = - $start * $nrows;
$a = shift(@ARGV);
$b = shift(@ARGV);
$c = shift(@ARGV);

print "# $a * x^2 " . ($b > 0 ? "+ " : "- ") . abs($b) . " * x*y + $c * y^2\n";
print "      ";
for (my $iy = 0; $iy <= $nrows; $iy ++) {
    print sprintf("%4d ", $iy);
} # for $iy
print "\n";
print "------";
for (my $iy = 0; $iy <= $nrows; $iy ++) {
    print "-----";
} # for $iy
print "\n";
for (my $ix = $start; $ix <= $nrows; $ix ++) {
	print sprintf("%4d| ", $ix);
    for (my $iy = 0; $iy <= $nrows; $iy ++) {
        print sprintf("%4d ", $a*$ix*$ix + $b*$ix*$iy + $c*$iy*$iy);
    } # for $iy
    print "\n";
} # for $ix
