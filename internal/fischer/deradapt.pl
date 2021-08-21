#!perl

# Adapt offsets for derived sequences
# @(#) $Id$
# 2021-08-21, Georg Fischer: copied from dersimple.pl
#
#:# Usage:
#:#     perl deradapt.pl [-d mode] [-parmi] input.seq4 > output.seq4
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -parmi replace parameter i (default -parm3)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $parmi = 3;
my $callcode;
my $line;
my $aseqno;
my @parms; # records in joeis_names.txt
my $aofs; # offset for $aseqno
my $rofs; # offset for $rseqno

while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-parm(\d)}  ) {
        $parmi      = $1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $callcode, @parms) = split(/\t/, $line);
    $aofs = $parms[0];
    $rofs = $parms[$parmi];
    my $shift = $aofs - $rofs;
    my $stmt = "";
    if ($shift > 0) { # must shift
        $callcode = "dersimpln";
        $stmt = "~~    ";
        while ($shift > 0) {
            $stmt .= "~~super.next();";
            $shift --;
        } # while
    } # must shift
    $parms[$parmi] = $stmt;
    print join("\t", $aseqno, $callcode, @parms) . "\n";
} # while <>
#----------------
__DATA__
