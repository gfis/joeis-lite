#!perl

# Polish sequences to be guessed by an EulerInvTransform
# 2020-08-21: remove all zeroes and an optional leading one
# 2020-08-18, Georg Fischer
#
#:# Usage:
#:#   perl euguess_polish.pl input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset, $keyword, $terms, $period);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $keyword, $terms) = split(/\t/, $line);
    my $keep = 1;
    $terms =~ s{\,\-?\d+\Z}{}; # remove last - maybe incomplete - term
    $terms =~ s{\A(([0]\,)*(1\,)?)}{$1\t}; # split into prefix and part behind first 1
    $terms =~ s{\,\t}{\t}; # remove trailing comma from prefix
    if (0) {
    } elsif (length($terms) < 32) {
        $keep = 0;
    }
    if ($keep >= 1) {
        print join("\t", $aseqno, $callcode, $offset, "nonn", $terms, "term") . "\n";
    }
} # while <>
#================================
__DATA__

