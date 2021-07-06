#!perl

# Generate source in internal/fischer/manual
# @(#) $Id$
# 2021-06-26, Georg Fischer: copied from gen_linrec.pl
#
#:# Usage:
#:#   perl genman.pl [-d debug] [-n with] [-s subseq] seqno
#:#   -n generate ++mN
#:#   -s generate a subsequence of the integers
#:#   Writes fischer/manual/aseqno.javaoutfile and starts uedit64 with it.
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $max_term = 16;
my $max_size = 16;
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $basedir   = "../../../OEIS-mat/common";
my $namesfile = "$basedir/names";
my $withn     = 0; # whether to generate ++mN
my $subseq    = 0; # whether to generate a loop for a subsequence of the natural numbers
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        if ($opt  =~ m{n}) {
          $withn   = 1;
        } 
        if ($opt  =~ m{s}) {
          $subseq  = 1;
        }
    }
} # while $opt

my $line;
if (scalar(@ARGV) <= 0) {
    die "please specify a target sequence number";
}
my $aseqno = shift(@ARGV);
$aseqno =~ s{\D*(\d+)}{$1};
$aseqno = sprintf("A%06d", $aseqno);
&output($aseqno);
#--------------------------------------------
sub output {
    my ($aseqno) = @_;
    my $package = lc(substr($aseqno, 0, 4));
    my $filename = "manual/$aseqno.java";
    open(OUT, ">", $filename) || die "cannot write \"$filename\"\n";
    # get the name
    my $name = `grep -E \"^$aseqno\" $namesfile`;
    $name =~ s{\s+}{ }g;
    $name =~ s{\&}{\&amp;}g;
    $name =~ s{\<}{\&lt;}g;
    $name =~ s{\>}{\&gt;}g;
    $name =~ s{\'}{\&apos;}g;
    $name =~ s{\"}{\&quot;}g;

    print OUT <<"GFis";
package irvine.oeis.$package;
// manually $timestamp!

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * $name
 * \@author Georg Fischer
 */
public class $aseqno implements Sequence {

GFis
    print OUT "  protected int mN;\n" if $withn;
    print OUT <<"GFis";
  protected int mParm;

  /** Construct the sequence. */
  public $aseqno() {
    this(0);
  }

  /**
   * Generic constructor with parameter
   * \@param parm parameter
   */
  public $aseqno(final int parm) {
GFis
    if ($withn) {
        my $offset = 0;
        my $info = `grep -E \"\^$aseqno\" $basedir/asinfo.txt`;
        if ($info =~ m{^$aseqno\s+(\d+)}) {
            $offset = $1;
        }
        $offset--;
        print OUT "    mN = $offset;\n";
    }
    print OUT <<"GFis";
    mParm = parm;
  }

  \@Override
  public Z next() {
GFis
    if ($subseq) {
        print OUT <<"GFis";
    while (true) {
      ++mN;
      if (true) {
        return Z.valueOf(mN);
      }
    }
GFis
    } else {
        print OUT "    ++mN;\n" if $withn;
        print OUT <<"GFis";
    return mParm;
GFis
    }
    print OUT <<"GFis";
  }
}
GFis
    close(OUT);
    print `uedit64 $filename`;
} # output
__DATA__
