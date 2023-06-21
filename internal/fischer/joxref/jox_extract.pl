#!perl

# grep all A-numbers from the jOEIS class files below a path
# @(#) $Id$
# 2023-06-21, Georg Fischer
#
#:# Usage:
#:#   perl jox_extract [-d debug] [-nk max_a_number] path > outfile.tsv
#:#       -nk ignore those with an A_number <= the one specified, default 0
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
my $debug = 0;
my $no_known = 0;
my $path = "../../../../joeis/build.tmp/classes/irvine/oeis/a363";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{nk}) {
        $no_known  = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $path      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $aseqno;
my $rseqno;
my %hash = ();
my $line;
my $count = 0;
foreach my $file (glob("$path/*.class")) {
    if ($debug >= 1) {
        print "read $file\n";
    }
    $file =~ m{/(A\d{6})};
    $aseqno = $1;
    %hash = ();
    open(BIN, "<", $file) || die "cannot read $file\n";
    binmode(BIN);
    while (<BIN>) { # read inputfile
        my $buffer = $_;
        my @anos = ($buffer =~ m{irvine\/oeis\/([A-Za-z0-9\_\$\/]+)}g);
        foreach $rseqno (@anos) {
            if ($debug >= 2) {
                print "\"$aseqno\" uses \"$rseqno\"\n";
            }
            $hash{$rseqno} = 1;
        }
    } # while <>
    close(BIN);
    foreach $rseqno (sort(keys(%hash))) {
        $rseqno =~ s{\Aa\d\d\d\/}{};
        if ($aseqno ne $rseqno) {
            print join("\t", $aseqno, $rseqno) . "\n";
        }
    }
}
#========
__DATA__
C:\Users\User\work\gits\joeis\build.tmp\classes\irvine\oeis\a000>hexdump -C A000045.class
00000000  ca fe ba be 00 00 00 37  00 21 0a 00 08 00 12 09  |.......7.!......|
00000010  00 13 00 14 09 00 07 00  15 09 00 13 00 16 09 00  |................|
00000020  07 00 17 0a 00 13 00 18  07 00 19 07 00 1a 07 00  |................|
00000030  1b 01 00 02 6d 41 01 00  11 4c 69 72 76 69 6e 65  |....mA...Lirvine|
00000040  2f 6d 61 74 68 2f 7a 2f  5a 3b 01 00 02 6d 42 01  |/math/z/Z;...mB.|
00000050  00 06 3c 69 6e 69 74 3e  01 00 03 28 29 56 01 00  |..<init>...()V..|
00000060  04 43 6f 64 65 01 00 04  6e 65 78 74 01 00 13 28  |.Code...next...(|
00000070  29 4c 69 72 76 69 6e 65  2f 6d 61 74 68 2f 7a 2f  |)Lirvine/math/z/|
00000080  5a 3b 0c 00 0d 00 0e 07  00 1c 0c 00 1d 00 0b 0c  |Z;..............|
00000090  00 0a 00 0b 0c 00 1e 00  0b 0c 00 0c 00 0b 0c 00  |................|
000000a0  1f 00 20 01 00 18 69 72  76 69 6e 65 2f 6f 65 69  |.. ...irvine/oei|
000000b0  73 2f 61 30 30 30 2f 41  30 30 30 30 34 35 01 00  |s/a000/A000045..|
000000c0  15 69 72 76 69 6e 65 2f  6f 65 69 73 2f 53 65 71  |.irvine/oeis/Seq|
000000d0  75 65 6e 63 65 30 01 00  14 6a 61 76 61 2f 69 6f  |uence0...java/io|
000000e0  2f 53 65 72 69 61 6c 69  7a 61 62 6c 65 01 00 0f  |/Serializable...|
000000f0  69 72 76 69 6e 65 2f 6d  61 74 68 2f 7a 2f 5a 01  |irvine/math/z/Z.|
00000100  00 07 4e 45 47 5f 4f 4e  45 01 00 03 4f 4e 45 01  |..NEG_ONE...ONE.|
00000110  00 03 61 64 64 01 00 24  28 4c 69 72 76 69 6e 65  |..add..$(Lirvine|
00000120  2f 6d 61 74 68 2f 7a 2f  5a 3b 29 4c 69 72 76 69  |/math/z/Z;)Lirvi|
00000130  6e 65 2f 6d 61 74 68 2f  7a 2f 5a 3b 00 21 00 07  |ne/math/z/Z;.!..|
00000140  00 08 00 01 00 09 00 02  00 02 00 0a 00 0b 00 00  |................|
00000150  00 02 00 0c 00 0b 00 00  00 02 00 01 00 0d 00 0e  |................|
00000160  00 01 00 0f 00 00 00 1f  00 02 00 01 00 00 00 13  |................|
00000170  2a b7 00 01 2a b2 00 02  b5 00 03 2a b2 00 04 b5  |*...*......*....|
00000180  00 05 b1 00 00 00 00 00  01 00 10 00 11 00 01 00  |................|
00000190  0f 00 00 00 27 00 02 00  02 00 00 00 1b 2a b4 00  |....'........*..|
000001a0  03 2a b4 00 05 b6 00 06  4c 2a 2a b4 00 05 b5 00  |.*......L**.....|
000001b0  03 2a 2b b5 00 05 2b b0  00 00 00 00 00 00        |.*+...+.......|
000001be