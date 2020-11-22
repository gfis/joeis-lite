#!perl

# Generate the infinite fraction for the Engel (or Pierce) expansion of a real number
# @(#) $Id$
# 2020-11-21, Georg Fischer
#
#:# Usage:
#:#   perl engel_fracts.pl [-p] csv_terms
#:#   -p Pierce expansion (with alternating signs; default: Engel expansion)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $pierce = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{p}) {
        $pierce = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------

my $termlist = shift(@ARGV);
my @terms = ($termlist =~ m{(\d+)}g);
print "" . ($pierce ? "Pierce" : "Engel") . " expansion of "  . join(",", @terms) . ":\n";
my $sign = "+";
my $expr = "";
for (my $it = 0; $it < scalar(@terms); $it ++) {
    if ($it == 0) {
        $expr .="1/";
    } else {
        $expr .=" $sign 1/(";
    }
    for (my $jt = 0; $jt <= $it; $jt ++) {
        $expr .="" . (($jt > 0) ? "*" : "") . $terms[$jt];
    } # for $jt
    if ($it == 0) {
    } else {
        $expr .=")";
    }
    if ($pierce) {
        $sign = ($sign eq "+") ? "-" : "+";
    }
} # for $it
print "$expr\n";
my $filename = "engel_fracts.gp.tmp";
open(OUT, ">", $filename) or die "cannot write to \"$filename\"\n";
print OUT "print($expr + 0.0\"...\");\nquit()\n";
close(OUT);
my $cmd = "gp -q --default realprecision=16 $filename";
print "= " . `$cmd`;
__DATA__

