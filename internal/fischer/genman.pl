#!perl

# Generate source in internal/fischer/manual
# @(#) $Id$
# 2021-10-28: -t, -e
# 2021-06-26, Georg Fischer: copied from gen_linrec.pl
#
#:# Usage:
#:#   perl genman.pl [-d debug] [-e] [-n] [-p v1,v2...] [-s] [-t] [-u] [A]seqno
#:#   -e generate "extends ..."
#:#   -n generate ++mN
#:#   -p v1,v2... names of parameters
#:#   -s generate while loop for a subsequence
#:#   -t generate a subclass of Triangle
#:#   -u generate a subclass of UpperLeftTriangle
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
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $basedir   = "../../../OEIS-mat/common";
my $namesfile = "$basedir/names";
my @pnames    = ();
my $extends   = 0; # whether to generate "extends ..."
my $withn     = 0; # whether to generate ++mN
my $subseq    = 0; # whether to generate a loop for a subsequence of the natural numbers
my $triangle  = 0; # whether to generate a subclass of Triangle
my $upperleft = 0; # whether to generate a subclass of UpperLeftTriangle
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug      = shift(@ARGV);
    } else {
        if ($opt   =~ m{n}) {
          $withn    = 1;
        } 
        if ($opt   =~ m{p}) {
            @pnames = split(/\W+/, shift(@ARGV));
        }
        if ($opt   =~ m{s}) {
          $subseq   = 1;
        }
        if (0) {
        } elsif ($opt   =~ m{e}) {
          $extends   = 1;
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
&output($aseqno);
#--------------------------------------------
sub output {
    # preparations
    my ($aseqno) = @_;
    my ($pname, $sep);
    my $package = lc(substr($aseqno, 0, 4));
    my $filename = "manual/$aseqno.java";
    open(OUT, ">", $filename) || die "cannot write \"$filename\"\n";
    # get the name
    my $name = `grep -E \"^$aseqno\" $namesfile`;
    $name =~ s{\s+\Z}{}; # chompr
    $name =~ s{\s+}{ }g; # replace (multiple) whitespace by 1 space
    $name =~ s{\&}{\&amp;}g; # HTML encoding
    $name =~ s{\<}{\&lt;}g;
    $name =~ s{\>}{\&gt;}g;
    $name =~ s{\'}{\&apos;}g;
    $name =~ s{\"}{\&quot;}g;
    substr($name, 8) =~ m{(A\d\d+)};
    my $rseqno = $1 || "A";
    #---------
    print OUT <<"GFis"; # package and imports
package irvine.oeis.$package;

import irvine.math.z.Z;
GFis
    print OUT "import irvine.oeis.";
    if (0) { # switch for superclass import
    } elsif ($extends == 1) {
        print OUT lc(substr($rseqno, 0, 4)) . ".$rseqno";
    } elsif ($triangle == 1) {
        print OUT "triangle.Triangle";
    } elsif ($upperleft== 1) {
        print OUT "triangle.UpperLeftTriangle";
    } else {
        print OUT "Sequence";
    } # end of superclass import
    print OUT ";\n";
    #--------
    print OUT <<"GFis"; # start of class

/**
 * $name
 * \@author Georg Fischer
 */
GFis
    print OUT "public class $aseqno ";
    if (0) {
    } elsif ($extends   == 1) {
        print OUT "extends $rseqno";
    } elsif ($triangle  == 1) {
        print OUT "extends Triangle";
    } elsif ($upperleft == 1) {
        print OUT "extends UpperLeftTriangle";
    } else {
        print OUT "implements Sequence";
    } 
    print OUT " {\n";
    foreach $pname (@pnames) { # member properties
        print OUT "  protected long m" . ucfirst($pname) . ";\n";
    } # foreach member property
    #--------
    print OUT <<"GFis"; # start of empty constructor

  /** Construct the sequence. */
  public $aseqno() {
GFis
    if ($upperleft) {
        print OUT "    super(1, 1, -1);\n";
    } elsif (scalar(@pnames) > 0) { # with generic constructor
        print OUT "    this";
        $sep = "(";
        foreach $pname (@pnames) {
            print OUT "${sep}0";
            $sep = ", ";
        }
        print OUT ");\n";
        print OUT <<"GFis";
  }

  /**
   * Generic constructor with parameters
GFis
        foreach $pname (@pnames) {
            print OUT "   * \@param $pname \n";
        }
        print OUT "   */\n";
        print OUT "  public $aseqno";
        $sep = "(";
        foreach $pname (@pnames) {
            print OUT "${sep}final long $pname";
            $sep = ", ";
        }
        print OUT ") {\n";
    } else { # without generic constructor
    }
    if ($withn) { # retrieve offset
        my $offset = 0;
        my $info = `grep -E \"\^$aseqno\" $basedir/asinfo.txt`;
        if ($info =~ m{^$aseqno\s+(\d+)}) {
            $offset = $1;
        }
        $offset--;
        print OUT "    mN = $offset;\n";
    }
    foreach $pname (@pnames) {
        print OUT "    m" . ucfirst($pname) . " = $pname;\n";
    }
    print OUT <<"GFis"; # end of generic constructor
  }

GFis
    #--------
    if (0) { # switch for methods
    } elsif ($triangle) {
        print OUT <<"GFis"; # Pascal's rule
  \@Override
  public Z compute(final int n, final int k) {
    return n == 0 ? Z.ONE : get(n - 1, k - 1).multiply(1).add(get(n - 1, k).multiply(1));
  }
GFis
    #----
    } elsif ($upperleft) {
        print OUT <<"GFis"; 
  \@Override
  public Z matrixElement(final int n, final int k) {
    return Z.valueOf(n == 1 ? k : n + k);
  }
GFis
    #----
    } else { # default method next()
        print OUT <<"GFis";
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
            print OUT "    return super.next().mod(Z.TWO);\n" if $extends;
        }
        print OUT <<"GFis"; # end of next()
  }
GFis
    } # switch for methods
    #--------
    print OUT <<"GFis"; # end of class
}
GFis
    close(OUT);
    print `uedit64 $filename`;
} # output
__DATA__
