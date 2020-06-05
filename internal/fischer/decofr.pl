#!perl

# Extract cofr sequences depending on decexp 
# @(#) $Id$
# 2020-06-05, Georg Fischer
#
#:# Usage:
#:#   perl decofr.pl [-d debug] $(COMMON)/joeis_names.txt > decofr.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $ignore = 1;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{i}) {
        $ignore    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $state = "decexp";
my $constant;
my $rseqno = "";
my $offset = 0;
while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    if (0) {
    } elsif ($state eq "decexp"  and ($name =~ m{\ADecimal expansion of ([^\.]+)\.}) and $superclass ne "null") {
        $constant = $1;
        $rseqno = $aseqno;
        $state =       "decofr";
    } elsif ($state eq "decofr"  and ($name =~ m{\AContinued fraction ([^\.]+)\.})) {
        my $postfix = $1;
        if (($ignore == 1 or $superclass eq "null") and ($ignore == 1 or index($postfix, $constant) >= 0)) {
        #   print "# $rseqno: $constant\n";
            print join("\t", $aseqno, $state, $offset, &aseq($rseqno), $name) . "\n";
        }
        $state =       "decofrn";
    } elsif ($state eq "decofrn" and ($name =~ m{\ANumerators ([^\.]+)\.})) {
        my $postfix = $1;
        if (($ignore == 1 or $superclass eq "null") and ($ignore == 1 or index($postfix, $constant) >= 0)) {
            print join("\t", $aseqno, $state, $offset, &aseq($rseqno), $name) . "\n";
        }
        $state =       "decofrd";
    } elsif ($state eq "decofrd" and ($name =~ m{\ADenominators ([^\.]+)\.})) {
        my $postfix = $1;
        if (($ignore == 1 or $superclass eq "null") and ($ignore == 1 or index($postfix, $constant) >= 0)) {
            print join("\t", $aseqno, $state, $offset, &aseq($rseqno), $name) . "\n";
        }
        $state =       "decexp";
    } else {
        $state =       "decexp";
    }
} # while
#----
sub aseq { # returns jOEIS package, tab, aseqno
	my ($rseqno) = @_;
	return lc(substr($rseqno, 0, 4)) . "\t$rseqno";
} # aseq

__DATA__
A005482	DecimalExpansion	Decimal expansion of cube root of 7.	nonn,cons,easy,	1..20000
A005483	null	Continued fraction for cube root of 7.	nonn,cofr,	1..20000
A005484	null	Numerators of convergents to cube root of 7.	nonn,frac,	1..1000
A005485	null	Denominators of convergents to cube root of 7.	nonn,frac,	1..1000

C:\Users\User\work\gits\joeis-lite\internal\fischer>cat C:/Users/User/work/gits/joeis/src/irvine/oeis/a005/A005482.java
#-------------------------
package irvine.oeis.a005;

import irvine.math.cr.CR;
import irvine.math.cr.ComputableReals;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A005482 Decimal expansion of cube root of 7.
 * @author Sean A. Irvine
 */
public class A005482 extends DecimalExpansionSequence {

  private static final CR N = ComputableReals.SINGLETON.pow(CR.valueOf(7), CR.THREE.inverse());

  @Override
  protected CR getCR() {
    return N;
  }
}
#-------------------------
package irvine.oeis.a005;

import irvine.oeis.ContinuedFractionSequence;

/**
 * A005483 Continued fraction for cube root of 7.
 * @author Sean A. Irvine
 */
public class A005483 extends ContinuedFractionSequence {

  /** Construct the sequence. */
  public A005483() {
    super(new A005482());
  }
}
#-------------------------
package irvine.oeis.a005;

import irvine.oeis.ContinuedFractionNumeratorSequence;

/**
 * A005484 Numerators of convergents to cube root of 7.
 * @author Sean A. Irvine
 */
public class A005484 extends ContinuedFractionNumeratorSequence {

  /** Construct the sequence. */
  public A005484() {
    super(new A005482());
  }
}
#-------------------------
package irvine.oeis.a005;

import irvine.oeis.ContinuedFractionDenominatorSequence;

/**
 * A005485 Denominators of convergents to cube root of 7.
 * @author Sean A. Irvine
 */
public class A005485 extends ContinuedFractionDenominatorSequence {

  /** Construct the sequence. */
  public A005485() {
    super(new A005482());
  }
}
#-------------------------
