#!perl

# Extract parameter for MultiplicativeSequence from legacy jOEIS programs
# @(#) $Id$
# 2022-07-19, Georg Fischer
#
#:# Usage:
#:#     perl multext.pl mult2.gen > mult3.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $path = "../../../joeis/src/irvine/oeis";
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) {
    s/\s+\Z//; # chompr
    next if ! m{\AA\d+};
    my ($aseqno, $callcode, $offset) = split(/\t/);
    my $apkg = lc(substr($aseqno, 0, 4));
    my $srcname = "$path/$apkg/$aseqno.java";
    if (defined(open(SRC, "<", $srcname))) {
        while (<SRC>) {
            s/\s+\Z//; # chompr
            my $code = $_;
            if ($code =~ m{prod *\= *prod\.multiply\(([^\;]+)}) {
            	my $expr = $1;
            	$expr =~ s{\) *\Z}{};
            	$expr =~ s{fs\.getExponent\(p\)}{e}g;
                print join("\t", $aseqno, $callcode, $offset, $expr) . "\n"
            }
        }
        close(SRC);
    } else {
        # print "# $srcname nyi\n";
    }
} # while <>
#--------------------------------------------
__DATA__
package irvine.oeis.a008;

import irvine.factor.factor.Jaguar;
import irvine.factor.util.FactorSequence;
import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * A008473 If n = Product (p_j^k_j) then a(n) = Product (p_j + k_j).
 * @author Sean A. Irvine
 */
public class A008473 implements Sequence {

  private long mN = 0;

  @Override
  public Z next() {
    Z prod = Z.ONE;
    if (++mN > 1) {
      final FactorSequence fs = Jaguar.factor(mN);
      for (final Z p : fs.toZArray()) {
        prod = prod.multiply(p.add(fs.getExponent(p)));
      }
    }
    return prod;
  }
}