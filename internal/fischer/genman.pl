#!perl

# Generate source in internal/fischer/manual
# @(#) $Id$
# 2024-04-20: -dir
# 2023-09-23: "private int mN;" again
# 2023-08-30: AbstractSequence, no getOffset
# 2023-06-01: -t constructor; UP=54
# 2022-12-30: private long mN;
# 2022-11-24: Sequence0
# 2022-07-15: SequenceWithOffset
# 2022-06-01: package recur
# 2022-02-22, private; -p implies -n
# 2021-10-28: -t, -e
# 2021-06-26, Georg Fischer: copied from gen_linrec.pl
#
#:# Usage:
#:#   perl genman.pl [-d debug] [-dir] [-e] [-n] [-p v1,v2...] [-cp aseqno] [-s] [-t] [-u] [A]seqno
#:#   -cp copy from - to
#:#   -dir implements DirectSequence
#:#   -e   generate "extends ..."
#:#   -h   generate a subclass of HolonomicRecurrence
#:#   -m   generate a subclass of MemorySequence
#:#   -n   generate ++mN
#:#   -p   v1,v2... names of parameters
#:#   -s   generate while loop for a subsequence
#:#   -t   generate a subclass of Triangle
#:#   -u   generate a subclass of UpperLeftTriangle
#:#   Writes ./manual/aseqno.java and starts uedit64 with it.
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $max_term = 16;
my $max_size = 16;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $basedir   = "../../../OEIS-mat/common";
my $copy      = "";
my $debug     = 0;
my $direct    = 0; # whether "implements DirectSequence"
my $joeisdir  = "../../../joeis/src/irvine/oeis";
my $namesfile = "$basedir/names";
my @pnames    = ();
my $extends   = 0; # whether to generate "extends ..."
my $holonomic = 0; # whether to generate "extends HolonomicRecurrence;"
my $memory    = 0; # whether to generate "extends MemorySequence;"
my $withn     = 0; # whether to generate ++mN
my $subseq    = 0; # whether to generate a loop for a subsequence of the natural numbers
my $triangle  = 0; # whether to generate a subclass of Triangle
my $upperleft = 0; # whether to generate a subclass of UpperLeftTriangle
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{\-d\Z}) {
        $debug      = shift(@ARGV);
    } elsif ($opt  =~ m{\-dir}) {
        $direct     = shift(@ARGV);
    } elsif ($opt  =~ m{\-cp}) {
        $copy       = shift(@ARGV);
    } else {
        if ($opt   =~ m{n}) {
            $withn    = 1;
        }
        if ($opt   =~ m{p}) {
            @pnames = split(/\W+/, shift(@ARGV));
            $withn     = 1;
        }
        if ($opt   =~ m{s}) {
            $subseq   = 1;
        }
        if (0) {
        } elsif ($opt   =~ m{e}) {
            $extends   = 1;
        } elsif ($opt   =~ m{h}) {
            $holonomic = 1;
        } elsif ($opt   =~ m{m}) {
            $memory    = 1;
            $withn     = 1;
        } elsif ($opt   =~ m{t}) {
            $triangle  = 1;
        } elsif ($opt   =~ m{u}) {
            $upperleft = 1;
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
if (length($copy) > 0) {
    &copyseq($copy, $aseqno);
} else {
    &output($aseqno);
}
#--------------------------------------------
sub copyseq {
    # preparations
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
    substr($tarname, 8) =~ m{(A\d\d+)};
    my $srcfile = "$joeisdir/$cpack/$cseqno.java";
    open(SRC, "<", $srcfile) || die "cannot read \"$srcfile\"\n";
    my $state = 0;
    while (<SRC>) {
        my $line = $_;
        $line =~ s{\s+\Z}{}; # chompr
        if ($line =~ m{\Apackage}) {
            $line = "package irvine.oeis.$apack;";
        }
        if ($state == 0 && ($line =~ m{\A( *\* )$cseqno })) {
            $line = "$1$tarname";
            $state ++;
        }
        $line =~ s{$cseqno}{$aseqno}g;
        print TAR "$line\n";
    } # while SRC
    close(SRC);
    close(TAR);
    print `uedit64 $tarfile`;
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
    #---------
    print TAR <<"GFis"; # package and imports
package irvine.oeis.$apack;

import irvine.math.z.Z;
GFis
    if (0) { # switch for superclass import
    } elsif ($extends   == 1) {
        print TAR "import irvine.oeis." . lc(substr($rseqno, 0, 4)) . ".$rseqno";
    } elsif ($holonomic == 1) {
        print TAR "import irvine.oeis.recur.HolonomicRecurrence";
    } elsif ($memory    == 1) {
        print TAR "import irvine.oeis.MemorySequence";
    } elsif ($triangle  == 1) {
        print TAR "import irvine.oeis.triangle.BaseTriangle";
    } elsif ($upperleft == 1) {
        print TAR "import irvine.oeis.triangle.UpperLeftTriangle";
    } else {
        print TAR "import irvine.oeis.AbstractSequence"
    } # end of superclass import
    print TAR ";\n";
    if ($direct) {
        print TAR "import irvine.oeis.DirectSequence;\n"
    }
    #--------
    print TAR <<"GFis"; # start of class

/**
 * $tarname
 * \@author Georg Fischer
 */
GFis
    print TAR "public class $aseqno ";
    if (0) {
    } elsif ($extends    == 1) {
        print TAR "extends $rseqno";
    } elsif ($holonomic  == 1) {
        print TAR "extends HolonomicRecurrence";
    } elsif ($memory     == 1) {
        print TAR "extends MemorySequence";
    } elsif ($triangle   == 1) {
        print TAR "extends BaseTriangle";
    } elsif ($upperleft  == 1) {
        print TAR "extends UpperLeftTriangle";
    } else {
        print TAR "extends AbstractSequence";
        if ($direct) {
            print TAR " implements DirectSequence";
        }
    }
    print TAR " {\n";
    if ($withn) {
        print TAR "\n  private int mN;\n";
    }
    foreach $pname (@pnames) { # member properties
        if ($pname ne "offset") {
            print TAR "  private int m" . ucfirst($pname) . ";\n";
        }
    } # foreach member property
    #--------
    print TAR <<"GFis"; # start of empty constructor

  /** Construct the sequence. */
  public $aseqno() {
GFis
    if (0) {
    } elsif ($holonomic) {
        my $rec = `grep $aseqno holref.txt`;
        $rec =~ s{\s+\Z}{};
        # A000352 holos   4       [0,6,-17,17,-7,1]       [5,29,118,418,1383]     0       0       gener
        if ($rec !~ m{\A\s*\Z}) {
            my ($dummy, $cc, $off, $matrix, $init, $dist, $gftype, $remark) = split(/\t/, $rec);
            print TAR "    super($off, \"$matrix\", \"$init\", $dist);\n";
            open(RUN, ">", "run.cmd") || die "cannot write run.cmd";
            print RUN "make runholo MATRIX=\"$matrix\" INIT=\"$init\" DIST=$dist OFF=$off\n";
            close(RUN);
        } else {
            print TAR "    super(0, \"[[0],[1],[1],[1],[1],[1],[1],[-1]]\", \"1\", 0);\n"; # Fibonacci
        }
    } elsif ($triangle) {
        print TAR "    super(1, 1, 1);\n";
        print TAR "    hasRAM(true);\n";
    } elsif ($upperleft) {
        print TAR "    super(1, 1, -1);\n";
        print TAR "    hasRAM(true);\n";
    } elsif (scalar(@pnames) > 0) { # with generic constructor
        print TAR "    this";
        $sep = "(";
        foreach $pname (@pnames) {
            print TAR "${sep}0";
            $sep = ", ";
        }
        print TAR ");\n";
        print TAR <<"GFis";
    }
  }

  /**
   * Generic constructor with parameters
GFis
        # print TAR "    super($off);\n";
        foreach $pname (@pnames) {
            print TAR "   * \@param $pname \n";
        }
        print TAR "   */\n";
        print TAR "  public $aseqno";
        $sep = "(";
        foreach $pname (@pnames) {
            print TAR "${sep}final int $pname";
            $sep = ", ";
        }
        print TAR ") {\n    super(offset);\n";
    } else { # without generic constructor
    }
    if ($withn) { # retrieve offset
        my $offset = 0;
        my $info = `grep -E \"\^$aseqno\" $basedir/asinfo.txt`;
        if ($info =~ m{^$aseqno\s+(\d+)}) {
            $offset = $1;
        }
        $offset--;
        print TAR "    mN = $offset;\n";
    }
    foreach $pname (@pnames) {
        if ($pname ne "offset") {
            print TAR "    m" . ucfirst($pname) . " = $pname;\n";
        }
    }
    print TAR <<"GFis"; # end of generic constructor
  }
GFis
    #--------
    if (0) { # switch for methods
    } elsif ($holonomic) {
    } elsif ($memory) {
        print TAR <<"GFis";
  \@Override
  protected Z computeNext() {
    final int n = size();
    if ((n \& 1) == 0) {
      return Z.valueOf(n);
    } else {
      return Z.valueOf(n);
    }
  }
GFis
    } elsif ($triangle) {
        print TAR <<"GFis"; # Pascal's rule

  \@Override
  public Z triangleElement(final int n, final int k) {
    return (k == n) ? Z.ONE : ((k == n - 1) ? Z.valueOf(k) : Z.ZERO);
  }
GFis
    #----
    } elsif ($upperleft) {
        print TAR <<"GFis";

  \@Override
  public Z matrixElement(final int n, final int k) {
    return Z.valueOf(n == 1 ? k : n + k);
  }
GFis
    #----
    } else { # default method next()
        print TAR <<"GFis";

  \@Override
  public Z next() {
GFis
        if (0) {
        } elsif ($subseq) {
            print TAR <<"GFis";
    while (true) {
      ++mN;
      if (true) {
        return Z.valueOf(mN);
      }
    }
GFis
        } elsif ($direct) {
            print TAR "    return a(++mN);\n";
        } else {
            print TAR "    ++mN;\n" if $withn;
            print TAR "    return super.next().mod(Z.TWO);\n" if $extends;
        }
        print TAR <<"GFis"; # end of next()
  }
GFis
        if ($direct) {
            print TAR <<"GFis";

  \@Override
  public Z a(final Z n) {
    return n.isZero() ? Z.ONE : Z.ZERO;
  }

  \@Override
  public Z a(final int n) {
    return a(Z.valueOf(n));
  }
GFis
        }
    } # switch for methods
    #--------
    print TAR <<"GFis"; # end of class
}
GFis
    close(TAR);
    print `uedit64 $tarfile`;
} # output
__DATA__
