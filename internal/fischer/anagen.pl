#!perl

# Grep (holonomic) recurrences from jcat25.txt
# @(#) $Id$
# 2021-05-23, Georg Fischer
#
#:# Usage:
#:#   perl anagen.pl [-bs blockno] [-rs rseqno] > $@.gen
#:#   (grep -E "^blockno" anaprep.txt)
#---------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
my $timestamp = sprintf("%04d-%02d-%02d %02d:%02d:%02d"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

my $debug = 0;
my $bseqno = "118"; # of the block
my $rseqno = "";
my $prep_file = "anaprep.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{d}) {
        $debug    = shift(@ARGV);
    } elsif ($opt =~ m{bs}) {
        $bseqno   = shift(@ARGV);
    } elsif ($opt =~ m{rs}) {
        $rseqno   = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
if ($rseqno eq "") {
    $rseqno = $bseqno;
}

my $cmd = "grep -E \"^$bseqno\" $prep_file";
my $buffer = `$cmd`;
# print STDERR "cmd: $cmd, length=" . length($buffer) . "\n";
foreach my $line (split(/\r?\n/, $buffer)) {
    $line =~ s{\s+\Z}{}; # chompr
    # print STDERR "read: $line\n";
    my ($bs, $aseqno, $offset, $class, $parmlist, $name, @rest) = split(/\t/, $line);
    my@parms = split(/\, */, $parmlist);
    my $callcode = "parm" . (scalar(@parms) + 1);
    print join("\t", $aseqno, $callcode, $offset, $rseqno, @parms, $name) . "\n";
} # while <>
__DATA__
#---- joeis:  1 nyi:    61
A118078	A118078	-2	BriefSequenc	8,1	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050201	-2	zzzz        	2,0	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050202	-2	zzzz        	3,0	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050208	-2	zzzz        	2,1	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050209	-2	zzzz        	3,1	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050215	-2	zzzz        	2,2	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050222	-2	zzzz        	2,3	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050230	-2	zzzz        	2,4	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050238	-2	zzzz        	2,5	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050245	-2	zzzz        	2,6	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050254	-2	zzzz        	2,7	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050263	-2	zzzz        	2,8	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A050272	-2	zzzz        	2,9	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A083598	-2	zzzz        	4,0	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A083599	-2	zzzz        	5,0	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i
A118078	A083600	-2	zzzz        	6,0	Starting positions of strings of (\d+)(\d+)s in the decimal expansion of Pi	m	i