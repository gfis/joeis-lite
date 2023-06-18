#!perl

# Patch Sequence -> AbstractSequence in Java source files
# @(#) $Id$
# 2023-06-17, Georg Fischer: copied from ../patch_offset.pl
#
#:# Usage:
#:#   perl patch_abstract.pl [-d debug] infile > outfile
#:#       infile has tsv fields aseqno, offset1
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
my $mode = "modpre";
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
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    next if ($line !~ m{\AA\d+});
    $patch_count ++;
    if ($patch_count % 128 == 0) {
        print STDERR "# +$patch_count: $line\n";
    }
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
    open(SRC, "<", $srcname) || die "cannot read $srcname\n";
    my $buffer;
    my $read_len = 100000000; # 100 MB
    read(SRC, $buffer, $read_len);
    close(SRC);
    $buffer =~ s{\n\n\n}{\n\n}mg;
    #========
    $buffer =~ m{class +(A\d+) +implements +Sequence\b};
    my $aseqno = $1;
    if (0) { 
    } elsif ($buffer =~ m{(public|protected) +$aseqno *\(}) { # has a (generic) constructor
        $buffer =~ s[((public|protected) +$aseqno *\([^\{]+\{\r?\n +this)]]this$1]mg; # shield constructors with "this()"
        $buffer =~ s[(\b(public|protected) +$aseqno *\([^\{]+\{\r?\n +)][$1 . "super\($offn\)\;\n    "]emg; # insert the super call
        $buffer =~ s{this(public|protected)}{$1}mg; # unshield constructors with "this()"
        $buffer =~ s{class +$aseqno +implements +Sequence([^\{]*)*\{}
            {class $aseqno extends AbstractSequence \{};
    } else { # has no constructor
        $buffer =~ s{class +$aseqno +implements +Sequence *\{}
            {class $aseqno extends AbstractSequence \{\n\n  \/\*\* Construct the sequence. \*\/\n  public $aseqno() \{\n    super\($offn\)\;\n  \}}mg;
    }
    $buffer =~ s{\bimport irvine.oeis.Sequence\b}{import irvine.oeis.AbstractSequence}mg;
    if ($buffer =~ m{\bSequence\b}m) {
        $buffer =~ s{\bimport irvine.oeis.AbstractSequence\b}{import irvine.oeis.AbstractSequence\;\nimport irvine.oeis.Sequence}mg;
    }
    #========
    if ($debug >= 2) {
        print "#----------------\n$buffer";
    }
    open(TAR, ">", "$tarpath/$aseqno.java") || die "cannot write $tarpath/$aseqno.java\n";
    print TAR $buffer;
    close(TAR);
} # patch1
__DATA__
# Starting report at 2022-08-16 15:32:35
A002162	1 -> 0	DecimalExpansionSequence
A002285	1 -> 0	DecimalExpansionSequence
A002389	1 -> 0	DecimalExpansionSequence
A002390	1 -> 0	DecimalExpansionSequence
A002580	0 -> 1	DecimalExpansionSequence
A002794	1 -> 0	A030125
A002795	1 -> 0	A002794
A003077	1 -> 0	DecimalExpansionSequence
A003676	1 -> -33	DecimalExpansionSequence