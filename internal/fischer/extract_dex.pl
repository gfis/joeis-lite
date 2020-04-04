#!perl

# Extract formulas for decimal expansion sequences
# @(#) $Id$
# 2020-04-04: other bases
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

my %bases = qw(binary 2 digital 2 ternary 3 duodecimal 12 hexadecimal 16 sexagesimal 60);
my $line;
my $base  = 10;
my $keep0 = "true"; # whether to keep leading zeroes
my ($aseqno, $class, $offset1, $name);
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $class, $offset1, $name) = split(/\t/, $line);
    $name =~ s{Base\-60 \(Babylonian or sexagesimal\)}{Sexagesimal};
    $base = 10;
    if ($name =~ m{\.\.\.}) { 
    	# ignore if ellipsis
    	
    } elsif ($name =~ m{(The |\A)Decimal\s+(expansion|representation)\s+of\s+(the\s+)?(constant\s+)?(.*)}i) {
        #               1                 2                                 3        4             5
        # order of elsif matters!
        $name = $5;
        $base = 10;
        &evaluate();    

    } elsif ($name =~ m{(The\s+)?(Binary|DigitalTernary|Duodecimal|Hexadecimal|Sexagesimal|Base[\- ](\d+)|)\s*(Expansion|Representation)\s+of\s+(the\s+)?(constant\s+)?([^\.\;\,\<\>\=]+)}i) {
        #               1        2                                                                  3          4                                5        6             7          
        my $basew = $2 || "";
        my $baseb = $3 || "";
        $name = $7     || "";
        if ($name =~ m{\s+in base[\- ](\d+)}   ) {
            $base = $1;
            $name =~ s{in base[\- ](\d+)}{};
        } elsif (length($basew) > 0) {
            if ($basew =~ m{base}i) {
                $base = $baseb;
            } else {
                $basew = $bases{lc($basew)} || "";
                if (length($basew) > 0) {
                    $base = $basew;
                }
            }
        }
        &evaluate();
        
    } # if $name =~ m
} # while <>
#----
sub evaluate {
    $keep0 = ($offset1 < 0 or ($aseqno =~ m{A0197[29]|A22206[67]})) ? "false" : "true";
    return if $name =~ m{\A\[| the }; # "[Phi, Phi" or "[5,5,...]"
    $name =~ s{\s*\.\s*\Z}{};
    $name =~ s{[\,\:\;].*}{}; # remove all behind formula
    $name =~ s{\s*([\+\-\*\/])\s*}{$1}g;
    $name =  lc($name);
    $name =~ s{\) and of arc.*}{};
    $name =~ s{(\W\d+) ([A-Za-z])}{$1\*$2}g; # A177067, 
    $name =~ s{\A(\S+)\s+(\S+)\Z}{$1\($2\)}; # e.g. "log 1/3"
    $name =~ s{\s}{}g;
    my @words = grep 
        {! m{\A(e|pi|log|log_\d+|exp|tau|phi|psi|ln|abs|eulergamma|gamma|zeta|sqrt|((a|arc)?(sin|cos|tan|cot|csc|sec|cosecans|secans|)h?))\Z}} 
        ($name =~ m{([a-z][a-z0-9\_]+)}g);
    if ($name =~ m{[Aa]\d{6}|!|\.|\=|\'}) { # no A-number, factorial, ellipsis, derivative
    } elsif (scalar(@words) == 0) {
        $name =~ tr{\{\}\[\]}
                   {\(\)\(\)};
        print join("\t", $aseqno, $class, $offset1, "postfix", $keep0, $base, $name, "A", "B") . "\n";
    } else {
        print "# ";
        print join("\t", $aseqno, $class, $offset1, "postfix", $keep0, $base, $name, "a", "a") . "\n";
    }
} # evaluate
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

/**
 * A004593 Expansion of e in base 2.
 * @author Sean A. Irvine
 */
public class A004593 extends DecimalExpansionSequence {

  /** Construct the sequence. */
  public A004593() {
    super(false, 2);
  }

  @Override
  protected CR getCR() {
    return CR.E;
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