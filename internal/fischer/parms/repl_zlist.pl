#!perl

# Replace lists like 'new Z("123"),Z.ONE' '[123,1]'
# @(#) $Id$ 
# 2026-11-15, Georg Fischer: *EFF=5
#
#:# Usage:
#:#   perl repl_zlist.pl [-d debug] [-p parmno] infile.seq4 > outfile.seq4
#:#       -p parmno  parameter number in seq4-format: p=1 changes $(PARM1)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $debug      = 0; 
my $parmno     = 1;
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

my %znum = qw(
    Z.NEG_ONE -1
    Z.ZERO    0
    Z.ONE     1
    Z.TWO     2
    Z.THREE   3
    Z.FOUR    4
    Z.FIVE    5
    Z.SIX     6
    Z.SEVEN   7
    Z.EIGHT   8
    Z.NINE    9
    Z.TEN    10
    );
while (<>) { # read inputfile
# while (<DATA>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    next if ($line !~ m{\AA\d+});
    my ($aseqno, $cc, @parms) = split(/\t/, $line);
    my $parm = $parms[$parmno];
    $parm =~ s{L}{}g;
    #          1      12    2
    $parm =~ s{(Z\.\w+)([\,\)]|\Z)}{$znum{$1}$2}g;
    #                 (  1      1   )
    $parm =~ s{new *Z\(\"(\-?\d+)\"\)}{$1}g;
    #                     (1      1 )
    $parm =~ s{Z\.valueOf\((\-?\d+)\)}{$1}g; # Z.valueOf(112) 
    $parms[$parmno] = "[$parm]";
    print join("\t", $aseqno, $cc, @parms) ."\n";
} # while <>
__DATA__
A222978	brief	1	BRIEF	newZ("330003580"),newZ("3705771825"),newZ("5373457070")			bref
A225728	brief	1	BRIEF	Z.THREE,newZ("17"),newZ("967")			bref
A226954	brief	1	BRIEF	"[12671122464000,50684489856000,114040102176000,202737959424000,316778061600000,456160408704000,620885000736000,810951837696000,1026360919584000,1267112246400000,1533205818144000]"			2026-11-11.ack/briefseq
A228562	brief	1	BRIEF	newZ("27173"),newZ("2001341"),newZ("16024189487")			bref
A229831	brief	1	BRIEF	Z.SEVEN,newZ("13"),newZ("13"),newZ("17")			bref
