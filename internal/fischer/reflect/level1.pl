#!perl

# Determine 1st level in caller hierarchy
# @(#) $Id$
# 2023-06-20, Georg Fischer: copied from ../patch_prepend.pl
#
#:# Usage:
#:#   perl level1.pl [-d debug] [-c column] infile > outfile
#:#       -c number of column for descendants
#:#       infile has aseqno, column2, column3 ...
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
my $colno = 3;
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{c}) {
        $colno     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $aseqno;
my $desc;
my %ahash = ();
my %dhash = ();
my $line;
my $count = 0;
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    $line = $_;
    next if ($line !~ m{\AA\d+});
    my @cols = split(/\t/, $line);
    ($aseqno, $desc) = $cols[0], $cols[$colno - 1]);
    next if ($desc !~ m{\AA\d+\Z});
    $count ++;
    $ahash{$aseqno} = $line;
    $dhash{$desc} = 1;
} # while <>
print STDERR "# $count records read\n";

__DATA__
# Starting report at 2023-06-20 07:28:16 
A000017	0 -> 1	DeadSequence
A000020	0 -> 1	PrependSequence
A000053	0 -> 1	FiniteSequence
A000054	0 -> 1	FiniteSequence
A000094	0 -> 1	A000041
A000181	3 -> 4	A000159
A000184	0 -> 2	A029887
A000185	3 -> 5	A000159
A000187	1 -> 0	A000233
