#!perl

# Cut as many initial terms as the offset says
# @(#) $Id$
# 2021-08-16, Georg Fischer
#
#:# Usage:
#:#   perl cutinit.pl [-d debug] infile.seq4 > outfile.seq4
#:#       infile has the format: ASEQNO CALLPATTERN OFFSET PARM1 PARM2 ...
#:#       modifies PARM2
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
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

my $aseqno;
my $callcode;
my $offset;
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    next if ! m{\AA\d}; # not starting with aseqno
    my $line = $_;
    my @parms = ("", "", "", "", ""); # offset and $(PARM1-4)
    ($aseqno, $callcode, @parms) = split(/\t/, $line);
    $offset     = $parms[0];  # align it with $(PARM1) ...
    my $initlist = $parms[2];
    
    $parms[2] = "[" . join("\,", @inits) . "]";
    print join("\t", $aseqno, $callcode, @parms) . "\n";
} # while <>
#--------------------------------------------
__DATA__
A056237	holos	0	[[0],[-24,12],[48,-33],[-32,26],[0,-5]]	[6,21,40,63,90]	0	0	radtorec((12*x^2-21*x+5)/(x-1)^3)
# make runholo A=A056237 OFF=0 MATRIX="[[0],[-24,12],[48,-33],[-32,26],[0,-5]]" INIT="[6,21,40,63,90]" DIST=0
A060460	holos	0	[[0],[-30,10],[91,-57],[-92,71],[15,-27],[0,3]]	[12,53,254,1255,6256,31257]	0	0	radtorec((-2*x^2+9*x-3)/(x-1)^2/(5*x-1))
# make runholo A=A060460 OFF=0 MATRIX="[[0],[-30,10],[91,-57],[-92,71],[15,-27],[0,3]]" INIT="[12,53,254,1255,6256,31257]" DIST=0
