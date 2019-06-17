#!perl

# Create a list for the OEIS wiki from callcode.gen
# @(#) $Id$
# 2019-06-16, Georg Fischer
#
#:# Usage:
#:#   perl callcode_wiki.pl [-d debug] [-p parmno] callcode.gen > callcode.wiki
#:#       -p extract the nth parameter (default: first)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;
my $parmno = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $parmno    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) { # read inputfile
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    my ($aseqno, $cc, $offset, @parms) = split(/\s+/);
    print ", $parms[$parmno - 1] ($aseqno)";
} # while <>
print "\n";
#---------------------------------------
__DATA__
A003285	cfp	1	0				Period of continued fraction for square root of n (or 0 if n is a square).
A097853	cfp	1	1				Period of continued fraction for square root of n (or 1 if n is a square).
