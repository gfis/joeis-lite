#!perl

# Get blocks of implemented and unimplemented sequences
# @(#) $Id$
# 2019-08-29, Georg Fischer: copied from get_stretchables.pl
#
#:# Usage:
#:#   perl stretchables.pl [-d debug] [-m min] analogs.tmp > stretch_blocks
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;
my $min_stretch = 2;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $min_stretch = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my ($old_aseqno, $old_code, $old_name) = ("", "", "");
my ($new_aseqno, $new_code, $new_name) = ("", "", "");
my $block  = "";
my $jcount = 0;
my $ocount = 0;
my $jsum   = 0;
my $osum   = 0;
while (<>) { # read inputfile
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    s{\s+\Z}{}; # chompr
    my $line = $_;
    ($new_aseqno, $new_code, $new_name) = split(/\t/, $line);
    $new_name = "" if ! defined($new_name);
    if ($old_name ne $new_name) {
        &output_block();
    }
    $block .= "$line\n";
    if ($new_code =~ m{\AZZ}) { # not in joeis
        $ocount ++;
    } else { # in joeis
        $jcount ++;
    } # 
    ($old_aseqno, $old_code, $old_name) = 
    ($new_aseqno, $new_code, $new_name);
} # while <>
&output_block();
print "jsum:	$jsum	osum:	$osum\n";
#---------------
sub output_block {
    if ($jcount > 0 and $ocount >= $min_stretch) {
        print "---- joeis:  $jcount nyi:    $ocount\n";
        print $block;
        $jsum += $jcount;
        $osum += $ocount;
    }
    $block  = "";
    $jcount = 0;
    $ocount = 0;
} # output_block
#---------------------------------------
__DATA__
A063833 +j+ !n-(\d+) is prime
A063833 -o- !n-(\d+) is prime
A092860 -o- "(\d+) times the prime sequence"
A158302 -o- "(\d+)" followed by repeats of (\d+)^k deleting all (\d+)^k, k>(\d+)
A121205 -o- "(\d+)" in bases (\d+) and higher rewritten in base (\d+)
A060858 +j+ "(\d+)", a popular song by Rafaela Carra
A060858 -o- "(\d+)", a popular song by Rafaela Carra
A064373 +j+ "(\d+)-(\d+)-(\d+)", a popular song by the B(\d+)'s
A064373 -o- "(\d+)-(\d+)-(\d+)", a popular song by the B(\d+)'s
A277402 -o- "(\d+)-Portolan numbers": number of regions formed by n-secting the angles of an equilateral triangle
A089604 -o- "(\d+)-lazy binary" representation of n: to increment, add one to the last digit, then "carry" the rightmost (\d+) (replace (\d+)->(\d+), (\d+)->(\d+), or (\d+)->(\d+))
A208362 -o- "(\d+)-ply" palindromic primes
A208363 -o- "(\d+)-ply" palindromic primes
