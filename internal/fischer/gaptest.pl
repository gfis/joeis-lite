#!perl

# Read a file starting with A-numbers and determine the ranges
# @(#) $Id$
# 2019-07-06, Georg Fischer
#
#:# Usage:
#:#   perl gaptest.pl infile  > callcode.wiki
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;

while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $oseqno = 0;
my $nseqno = 0;
my $count  = 0;
while (<>) { # read inputfile
    next if ! m{\AA(\d+)\s}; # skip lines which do not start with an A-nubmer
    $nseqno = $1;
    if ($oseqno == 0) {
    	$oseqno = $nseqno;
    	print "$oseqno";
    	$count = 1;
    } elsif ($oseqno + 1 == $nseqno) { # ok, ignore
    	$count ++;
    } else { # gap detected
    	if ($count > 1) {
    		print "...$oseqno";
    	}
    	print "\n";
    	$oseqno = $nseqno;
    	print "$oseqno";
    }	
    $oseqno = $nseqno;
} # while <>
    	if ($count > 1) {
    		print "...$oseqno";
    	}
		print "\n";
#---------------------------------------
__DATA__
