#!perl

# Get blocks of implemented and unimplemented sequences
# @(#) $Id$
# 2021-05-13: with numbers
# 2019-08-29, Georg Fischer: copied from get_stretchables.pl
#
#:# Usage:
#:#   perl stretchable.pl [-d debug] [-m min] anasort.tmp > anastret.tmp
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
    } elsif ($opt   =~ m{\-d}) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-m}) {
        $min_stretch = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options

while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
} # while $opt

my ($old_aseqno, $old_code, $old_name, $old_num) = ("", "", "", "");
my ($new_aseqno, $new_code, $new_name, $new_num) = ("", "", "", "");
my $block  = "";
my $blk_aseqno = "A000000"; # first aseqno in block
my $jcount = 0;
my $ocount = 0;
my $jsum   = 0;
my $osum   = 0;
my $offset = "-2";
while (<>) { # read inputfile
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    s{\s+\Z}{}; # chompr
    my $line = $_;
    ($new_aseqno, $offset, $new_code, $new_name, $new_num) = split(/\t/, $line);
    $new_name = "" if ! defined($new_name);
    $new_num  = "" if ! defined($new_num );
    if ($old_name ne $new_name) {
        $blk_aseqno = $new_aseqno;
        &output_block();
    }
    #                                                        parm1      parm2     parm3      
    $block .= join("\t", ($blk_aseqno, $new_aseqno, $offset, $new_code, $new_num, $new_name, "m", "i")) . "\n";
    if ($new_code =~ m{\Anyi}) { # not in joeis
        $ocount ++;
    } else { # in joeis
        $jcount ++;
    } # 
    ($old_aseqno, $old_code, $old_name, $old_num) = 
    ($new_aseqno, $new_code, $new_name, $new_num);
} # while <>
&output_block();
print "jsum:    $jsum   osum:   $osum\n";
#---------------
sub output_block {
    if ($jcount > 0 and $ocount >= $min_stretch) {
        print "#---- joeis:  $jcount nyi:    $ocount\n"; # does not work because of cellular automaton splitting?
        print "$block";
        $jsum += $jcount;
        $osum += $ocount;
    }
    $block  = "";
    $jcount = 0;
    $ocount = 0;
} # output_block
#---------------------------------------
__DATA__
A093560	-2	GeneratingFu	((\d+),(\d+)) Pascal triangle	3,1
A093644	-2	GeneratingFu	((\d+),(\d+)) Pascal triangle	9,1
A172185	-2	GeneratingFu	((\d+),(\d+)) Pascal triangle	9,11
A093561	-2	zzzz        	((\d+),(\d+)) Pascal triangle	4,1
A093562	-2	zzzz        	((\d+),(\d+)) Pascal triangle	5,1
A093564	-2	zzzz        	((\d+),(\d+)) Pascal triangle	7,1
A093565	-2	zzzz        	((\d+),(\d+)) Pascal triangle	8,1
A093645	-2	zzzz        	((\d+),(\d+)) Pascal triangle	10,1
A048951	-2	zzzz        	((\d+),(\d+)) Ulam sequence	2,4
A090592	-2	HolonomicRec	((\d+),(\d+)) entry of powers of the orthogonal design shown below	1,1
A087621	-2	LinearRecurr	((\d+),(\d+)) entry of powers of the orthogonal design shown below	1,1
A090590	-2	LinearRecurr	((\d+),(\d+)) entry of powers of the orthogonal design shown below	1,1
A089181	-2	LinearRecurr	((\d+),(\d+)) entry of powers of the orthogonal design shown in Annnnnn	1,3,090592
A241979	-2	LinearRecurr	((\d+),(\d+)) sequence such that lengths of (\d+) consecutive runs are always distinct	0,1,3
A127254	-2	zzzz        	((\d+),(\d+)) sequence whose (\d+) positions are indexed by twice the odious numbers given by Annnnnn	0,1,0,091855
A093563	-2	zzzz        	((\d+),(\d+))-Pascal triangle	6,1
A343159	-2	zzzz        	((\d+),(\d+))-array describing two-dimensional paper-folding construction of Annnnnn, read by upward antidiagonals	0,1,342759
A122788	-2	LinearRecurr	((\d+),(\d+))-entry of the (\d+) X (\d+) matrix M^n, where M ={{(\d+),-(\d+),(\d+)},{(\d+),(\d+),(\d+)},{(\d+),(\d+),(\d+)}}	1,3,3,3,0,1,1,1,1,0,0,1,1
A005273	-2	zzzz        	((\d+),(\d+))-graphs	5,4
A005274	-2	zzzz        	((\d+),(\d+))-graphs	6,5
A005275	-2	zzzz        	((\d+),(\d+))-graphs	7,6
