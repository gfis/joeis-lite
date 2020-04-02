#!perl

# Extract formulas for decimal expansion sequences
# @(#) $Id$
# 2019-06-15: renamed from extract_decexp.pl
# 2019-05-28, Georg Fischer
#
#:# Usage:
#:#   perl extract_dex.pl [-d debug] $(COMMON)/joeis_names.txt > outfile
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
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line;
my $code;
my $comt     = "";
my $content;
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    my ($aseqno, $class, $offset1, $name) = split(/\t/, $line);
    if ($name =~ m{Decimal\s+expansion\s+of\s+(the\s+)?(constant\s+)?(.*)}) {
        $name = $3;
        $name =~ s{\s*\.\s*\Z}{};
        $name =~ s{[\,\:\;\=].*}{}; # remove right side
        # $name =~ s{\s}{}g;
        $name = lc($name);
        $name =~ s{\) and of arc.*}{};
        my @words = grep 
            {! m{\A(e|pi|log|log_|exp|tau|phi|psi|ln|abs|eulergamma|gamma|zeta|sqrt|((a|arc)?(sin|cos|tan|cot|csc|sec|cosecans|secans|)h?))\Z}} 
            ($name =~ m{[a-z\_]+}g);
        if ($name =~ m{[Aa]\d{6}|!|\.\.|\'|\^\D}) { # no A-number, factorial, ellipsis, derivative, non-integer exponent
        } elsif (scalar(@words) == 0) {
            $name =~ tr{\{\}\[\]}
                       {\(\)\(\)};
            print join("\t", $aseqno, $class, $offset1, "", $name) . "\n";
        } else {
            print "# ";
            print join("\t", $aseqno, $class, $offset1, "", $name) . "\n";
        }
    } # if $name =~ m
} # while <>
#----
#--------------------------------------------
__DATA__
# OEIS as of February 28 14:44 EST 2019
A037222 Decimal expansion of Pi*e^2.    nonn,cons,synth
A037996 Decimal expansion of Pi*exp(2*Pi-Pi^2/2).   cons,nonn,synth

package irvine.oeis.a086;

import irvine.math.cr.CR;
import irvine.oeis.DecimalExpansionSequence;

/**
 * A086201 Decimal expansion of <code>1/(2*Pi)</code>.
 * @author Sean A. Irvine
 */
public class A086201 extends DecimalExpansionSequence {

  private static final CR N = CR.TWO.multiply(CR.PI).inverse();

  @Override
  protected CR getCR() {
    return N;
  }
}

 * A019800      Decimal expansion of sqrt(2*e)/5.
 private static final CR N = CR.E.multiply(CR.TWO).sqrt().divide(CR.FIVE);

 * A222071 Decimal expansion of <code>(1/105)*Pi^3</code>.
  private static final CR N = CR.PI.multiply(CR.PI).multiply(CR.PI).divide(CR.valueOf(105));


 * A140240 Decimal expansion of <code>arccos(7/8)</code>.
public class A140240 extends DecimalExpansionSequence {
  private static final ComputableReals REALS = ComputableReals.SINGLETON;
  private static final CR N = REALS.acos(CR.valueOf(7).divide(CR.valueOf(8)));

 * A020759 Decimal expansion of <code>(-1)*GammaDerivated(1/2)/Gamma(1/2)</code> where <code>Gamma(x)</code> denotes the Gamma function.
public class A020759 extends DecimalExpansionSequence {
  private static final CR N = EulerGamma.SINGLETON.add(CR.TWO.log().multiply(CR.TWO));

 * A091724 Decimal expansion of <code>e^(2*EulerGamma)</code>.
public class A091724 extends DecimalExpansionSequence {
  private static final CR N = EulerGamma.SINGLETON.multiply(CR.TWO).exp();

   * A053511 Decimal expansion of <code>log_10</code> (Pi).
public class A053511 extends DecimalExpansionSequence {
  private static final CR N = CR.PI.log().divide(CR.valueOf(10).log());

 * A060295 Decimal expansion of <code>exp(Pi*sqrt(163))</code>.
public class A060295 extends DecimalExpansionSequence {
  private static final CR N = CR.PI.multiply(CR.valueOf(163).sqrt()).exp();

 * A068436 Expansion of <code>Pi</code> in base 11.
 * @author Sean A. Irvine
 */
public class A068436 extends DecimalExpansionSequence {
  /** Construct the sequence. */
  public A068436() {
    super(false, 11);
  }
  @Override
  protected CR getCR() {
    return CR.PI;
  }

 * A019810 Decimal expansion of sine of 1 degree.
public class A019810 extends DecimalExpansionSequence {
  private final CR mN = CR.PI.multiply(CR.valueOf(getAngle())).divide(CR.valueOf(180)).sin();