#!perl

# Polish sequences to be guessed by an EulerInvTransform
# 2020-08-25: split field n into two fields after n zeroes and an optional leading one
# 2020-08-18, Georg Fischer
#
#:# Usage:
#:#   perl euguess_polish.pl input > output
#:#     -n field number (counted from 0, default 5) 
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset, $keyword, $terms, $period);

my $debug = 0;
my $nparm = 5; # counted from 0
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $nparm     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $keyword, $terms) = split(/\t/, $line);
    my $keep = 1;
    $terms =~ s{\,\-?\d+\Z}{}; # remove last - maybe incomplete - term
    $terms =~ s{\A(([0]\,)*(1\,)?)}{$1\t}; # split into prepend and part behind first 1
    $terms =~ s{\,\t}{\t}; # remove trailing comma from prepend
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

