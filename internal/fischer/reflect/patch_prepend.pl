#!perl

# Patch: Remove 1st int (skip) parameter of PrependSequence
# @(#) $Id$
# 2023-06-17, Georg Fischer: copied from ../patch_prep1.pl
#
#:# Usage:
#:#   perl patch_prepend.pl [-d debug] -m {new|ext} infile > outfile
#:#       infile has aseqno, rest
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
my $mode = "new";
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %tardirs;
my $srcroot = "../../../../joeis/src/irvine/oeis";
my $tarroot = "../../../src/irvine/oeis";
my $patch_count = 0;
my $aseqno;
my $otrans;
my ($offo, $offn);
my $superclass;
my $comment = "// modified by patch_abstract.pl at $timestamp\n";
my $line;
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    $line = $_;
    next if ($line !~ m{\AA\d+});
    ($aseqno, $offn) = split(/\t/, $line);
    &patch1();
} # while <>
print STDERR "# $patch_count files modified\n";
#----
sub patch1 {
    my $adir = lc(substr($aseqno, 0, 4));
    my $srcname = "$srcroot/$adir/$aseqno.java";
    my $tarpath = "$tarroot/$adir";
    if (! defined($tardirs{$tarpath}) or ! -d "$tarpath") { # tarpath not yet readable
        $tardirs{$tarpath} = 1;
        mkdir($tarpath);
    }
    open(SRC, "<", $srcname) || die "$0: cannot read $srcname\n";
    my $buffer;
    my $read_len = 100000000; # 100 MB
    read(SRC, $buffer, $read_len);
    close(SRC);
    $buffer =~ s{\n\n\n}{\n\n}mg;
    my $write_it = 0; # assume that the target should not be written
    #========
    if (0) {
    } elsif ($mode eq "new") {
        $write_it = (
            $buffer =~ s{new +PrependSequence\(0\, *}                  {new PrependSequence\(}mg
            ) + (
            $buffer =~ s{new +PrependSequence\((\w+)\, *(new A\d+\(\))}{new PrependSequence\($2.skip\($1\)}mg
            );
    } elsif ($mode eq "ext") {
        $write_it = (
            $buffer =~                s{super\((\w+)\, *(new A\d+\(\))}              {super\($2.skip\($1\)}mg
            );
        if ($debug >= 1 && $write_it > 0) {
            $buffer =~ m{\n(\s+super[^\r\n]+)\r?\n};
            print STDERR "# $tarpath/$aseqno.java: $1\n";
        }
    } else {
        die "$0: invalid mode $mode";
    }
    #========
    if ($debug >= 2) {
        print "#----------------\n$buffer";
    }
    if ($write_it > 0) {
        $patch_count ++;
        if ($patch_count % 32 == 0) {
            print STDERR "# +$patch_count: $line\n";
        }
        open(TAR, ">", "$tarpath/$aseqno.java") || die "$0: cannot write $tarpath/$aseqno.java\n";
        print TAR $buffer;
        close(TAR);
    }
} # patch1
__DATA__
src/irvine/oeis/a130/A130020.java:    super(new PrependSequence(1, new A059365(), 1));
src/irvine/oeis/a281/A281019.java:    super(1, new PrependSequence(1, new A051953(), 1));
src/irvine/oeis/a078/A078919.java:    super(1, new PrependSequence(0, new A079069(), 1));
src/irvine/oeis/a092/A092073.java:  private final BoustrophedonTransformSequence mSeq1 = new BoustrophedonTransformSequence(new PrependSequence(1, new A000045(), 1));
