#!perl

# turn a sequence into a DirectArray
# @(#) $Id$
# 2024-07-11, Georg Fischer: copied from gendir.pl
#
#:# Usage:
#:#   perl genarr.pl [-d debug] [-cp aseqno] [[A]seqno]
#:#   -cp  copy from joeis/src/irvine/eis/a*/aseqno.java
#:#   -d   debug mode: 0=none, 1=some, 2=more
#:# Writes ./manual/aseqno.java and starts uedit64 with it.
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
my $basedir   = "../../../OEIS-mat/common";
my $cseqno    = ""; # name of source sequence to copy, = target sequence if that is missing
my $debug     = 0;
my $aseqno    = "A000000";
my $joeisdir  = "../../../joeis/src/irvine/oeis";
my $namesfile = "$basedir/names";
my @pnames    = ();
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{\-d\Z}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{\-c}) { # or -cp
        $cseqno    = shift(@ARGV);
        $aseqno    = $cseqno;
    } else {
        die "invalid option $opt\n" 
    }
} # while $opt

if (scalar(@ARGV) >= 1) {
    $aseqno = shift(@ARGV);
}
$aseqno =~ s{\A\D*(\d+)}{$1};
$aseqno = sprintf("A%06d", $aseqno);
if (length($cseqno) > 0) {
    $cseqno =~ s{\A\D*(\d+)}{$1};
    $cseqno = sprintf("A%06d", $cseqno);
    &copyseq($cseqno, $aseqno);
} else {
    &output($aseqno);
}
#--------------------------------------------
sub copyseq {
    my ($cseqno, $aseqno) = @_;
    my $apack = lc(substr($aseqno, 0, 4));
    my $cpack = lc(substr($cseqno, 0, 4));
    my $tarfile = "manual/$aseqno.java";
    open(TAR, ">", $tarfile) || die "cannot write \"$tarfile\"\n";
    # get the target's name
    my $tarname = `grep -E \"^$aseqno\" $namesfile`;
    $tarname =~ s{\s+}{ }g; # replace (multiple) whitespace by 1 space
    $tarname =~ s{\s+\Z}{}; # chompr
    $tarname =~ s{\&}{\&amp;}g; # HTML encoding
    $tarname =~ s{\<}{\&lt;}g;
    $tarname =~ s{\>}{\&gt;}g;
    $tarname =~ s{\'}{\&apos;}g;
    $tarname =~ s{\"}{\&quot;}g;
    # substr($tarname, 8) =~ m{(A\d\d+)};
    my $imported = 0;
    my $srcfile = "$joeisdir/$cpack/$cseqno.java";
    open(SRC, "<", $srcfile) || die "cannot read \"$srcfile\"\n";
    my $state = 0;
    while (<SRC>) {
        my $line = $_;
        $line =~ s{\s+\Z}{}; # chompr
        if (0) {
        } elsif ($line =~ m{\Apackage}) {
            $line = "package irvine.oeis.$apack;";
        } elsif ($imported == 0 && ($line =~ m{import *irvine\.oeis\.})) {
            $imported = 1;
            $line .= "\nimport irvine.oeis.triangle.DirectArray;";
        } elsif ($line =~ m{ extends }) {
            $line =~ s{\{}  {implements DirectArray \{};
            $state = 1;
        } elsif ($state == 1 && ($line =~ m{\A( *\* )$cseqno })) {
            $line = "$1$tarname";
            $state ++;
        } elsif ($line =~ m{\A\}}) {
            print TAR <<"GFis";

  \@Override
  public Z a(final int n, final int k) {
    return Z.valueOf(n);
  }

GFis
        } 
        $line =~ s{$cseqno}{$aseqno}g;
        print TAR "$line\n";
    } # while SRC
    close(SRC);
    close(TAR);
    print `e $tarfile`;
} # copyseq
#--------
sub output {
    # preparations
    my ($aseqno) = @_;
    my ($pname, $sep);
    my $apack = lc(substr($aseqno, 0, 4));
    my $tarfile = "manual/$aseqno.java";
    open(TAR, ">", $tarfile) || die "cannot write \"$tarfile\"\n";
    # get the name
    my $tarname = `grep -E \"^$aseqno\" $namesfile`;
    $tarname =~ s{\s+}{ }g; # replace (multiple) whitespace by 1 space
    $tarname =~ s{\s+\Z}{}; # chompr
    $tarname =~ s{\&}{\&amp;}g; # HTML encoding
    $tarname =~ s{\<}{\&lt;}g;
    $tarname =~ s{\>}{\&gt;}g;
    $tarname =~ s{\'}{\&apos;}g;
    $tarname =~ s{\"}{\&quot;}g;
    substr($tarname, 8) =~ m{(A\d\d+)};
    my $rseqno = $1 || "A";

    print TAR <<"GFis"; # package and imports
package irvine.oeis.$apack;

import irvine.math.z.Z;
import irvine.oeis.AbstractSequence;
import irvine.oeis.triangle.DirectArray;

/**
 * $tarname
 * \@author Georg Fischer
 */
public class $aseqno extends AbstractSequence implements DirectArray {
  
  private int mN;

  /** Construct the sequence. */
  public $aseqno() {
    super(0);
    mN = -1;
  }

  \@Override
  public Z a(final Z n) {
    return n.isZero() ? Z.ONE : Z.ZERO;
    return a(n.intValueExact());
  }

  \@Override
  public Z a(final int n, final int k) {
    return Z.valueOf(n);
  }
}

GFis
    close(TAR);
    print `uedit64 $tarfile`;
} # output
__DATA__
