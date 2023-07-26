#!perl

# Read a list of A-numbers and pack all sources into one file
# @(#) $Id$
# 2023-07-11, Georg Fischer
#
#:# Usage:
#:#   perl queue.pl [-d debug] -p listfile > outfile
#:#   perl queue.pl [-d debug] {-p|-u[f] infile} > outfile
#:#       -uf force update
#:#       listfile has tsv fields aseqno, p1, p2, p3 ...
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
my $mode = "p";
my $debug = 0;
my $separator = "#!queue";
my $force = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $mode      =   "p";
    } elsif ($opt  =~ m{u}) {
        $mode      =   "u";
        $force = ($opt =~ m{f}) ? 1 : 0;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %tardirs = ();
my $srcroot = "../../../../joeis/src/irvine/oeis";
my $tarroot = "../../../src/irvine/oeis";
my $pack_count = 0;
my $aseqno = "";
my $offset = 0;
my @rest;

if (0) {
} elsif ($mode =~ m{^p}) { # pack
    my $comment = "// generated by queue.pl at $timestamp\n";
    while (<>) { # read inputfile
        s{\s+\Z}{}; # chompr
        my $line = $_;
        next if ($line !~ m{\AA\d+});
        ($aseqno, @rest) = split(/\s+/, $line);
        &pack1();
    } # while <>
    print join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
    print STDERR "# $pack_count files packed\n";

} elsif ($mode =~ m{^u}) { # unpack
    my $change = "";
    while (<>) { # read inputfile
        s{\s+\Z}{}; # chompr
        my $line = $_;
        my ($sep, $nseqno);
        if ($line =~ m{\A$separator}) {
            ($sep, @rest) = split(/\s+/, $line);
            &unpack1($aseqno, $change);
            $aseqno = $rest[0];
            $offset = $rest[3];
            $change = "";
        } else {
            $line =~ s{\$\(ASEQNO\)}{$aseqno}g;
            $line =~ s{\$\(OFFSET\)}{$offset}g;
            $change .= "$line\n";
        }
    } # while <>
    print STDERR "# $pack_count files written\n";
}
#----
sub pack1 {
    my $adir = lc(substr($aseqno, 0, 4));
    my $srcname = "$srcroot/$adir/$aseqno.java";
    if (! open(SRC, "<", $srcname)) {
        print STDERR "#** cannot read $srcname\n";
        return; # skip nonexisting source file
    }
    my $buffer;
    my $read_len = 100000000; # 100 MB
    read(SRC, $buffer, $read_len);
    close(SRC);
    $pack_count ++;
    if ($pack_count % 256 == 0) {
        print STDERR "# +$pack_count: write $aseqno\n";
    }
    print join("\t", $separator, $aseqno, @rest, "--------------------------------") . "\n";
    print $buffer;
} # pack1
#----
sub unpack1 {
    my ($aseqno, $change) = @_;
    my $adir = lc(substr($aseqno, 0, 4));
    my $srcname = "$srcroot/$adir/$aseqno.java";
    if (! open(SRC, "<", $srcname)) {
        print STDERR "#** cannot read $srcname\n";
        return; # skip nonexisting source file
    }
    my $tarpath = "$tarroot/$adir";
    if (! defined($tardirs{$tarpath}) || ! -d "$tarpath") { # tarpath not yet readable
        $tardirs{$tarpath} = 1;
        mkdir($tarpath); # || die "cannot mkdir $tarpath";
    }
    my $buffer;
    my $read_len = 100000000; # 100 MB
    read(SRC, $buffer, $read_len);
    close(SRC);
    my $b1 = $buffer; $b1 =~ s{\s}{}mg;
    my $b2 = $change; $b2 =~ s{\s}{}mg;
    if ($force or ($b1 ne $b2)) {
        $change =~ s{\n\/\/ *DO NOT EDIT[^\n]*}{};
        $change =~ s{\n\n\n}{\n\n}mg;
        open(TAR, ">", "$tarpath/$aseqno.java") || die "cannot write $tarpath/$aseqno.java\n";
        print TAR $change;
        close(TAR);
        if ($debug >= 1) {
            print STDERR "# $aseqno written\n";
        }
        $pack_count ++;
    } else {
        if ($debug >= 2) {
            print STDERR "# $aseqno unchanged\n";
        }
    }
} # unpack1
__DATA__
# Starting report at 2022-08-16 15:32:35
A002162 1 -> 0  DecimalExpansionSequence
A002285 1 -> 0  DecimalExpansionSequence
A002389 1 -> 0  DecimalExpansionSequence
A002390 1 -> 0  DecimalExpansionSequence
A002580 0 -> 1  DecimalExpansionSequence
A002794 1 -> 0  A030125
A002795 1 -> 0  A002794
A003077 1 -> 0  DecimalExpansionSequence
A003676 1 -> -33    DecimalExpansionSequence

#!queue	A019067	2	->	3	A018940	--------------------------------
package irvine.oeis.a019;

import java.io.BufferedReader;
...