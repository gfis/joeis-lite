#!perl

# Copy the A-numbers in the input from joeis to joeis-alt
# @(#) $Id$
# 2021-12-17, Georg Fischer; EM=76

use strict;
use integer;

my $srcroot = "../../../joeis/src/irvine/oeis";
my $tarroot = "../../../joeis-alt/src/irvine/oeis";
while (<>) {
  if (m{\A(A\d+)}) {
    my $aseqno  = $1;
    my $tarpath = "$tarroot/" . lc(substr($aseqno, 0, 4));
    my $srcpath = "$srcroot/" . lc(substr($aseqno, 0, 4));
    if (! -d "$tarpath") { # tarpath not yet readable
        mkdir($tarpath);
        print "mkdir $tarpath\n";
    }
    my $tarname = "$tarpath/$aseqno.java";
    my $srcname = "$srcpath/$aseqno.java";
    open(SRC, "<", $srcname) || die "cannot read  $srcname\n";
    open(TAR, ">", $tarname) || die "cannot write $tarname\n";
    while (<SRC>) {
       print TAR $_;
    }
    close(SRC);
    close(TAR);
    print "copied $srcname -> $tarname\n";
  }
} # while <>
__DATA__
