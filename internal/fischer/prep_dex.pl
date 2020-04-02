#!perl

# Prepare formulas for decimal expansion using CR functions
# @(#) $Id$
# 2020-04-01, Georg Fischer
#
#:# Usage:
#:#   perl prep_dex.pl [-d debug] dex3.tmp > outfile
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

my %hash = 
    ( "+", "add"
    , "-", "subtract"
    , "*", "multiply"
    , "/", "divide"
    , "^", "ComputableReals.SINGLETON.pow"
    );
my $line;
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($line =~ m{\AA\d+\t}) { # starts with aseqno
        my ($aseqno, $callcode, $offset, $postfix, $name) = split(/\t/, $line);
        my $sep = substr($postfix, 0, 1); # first character is separator
        $postfix = join(",", map {
            my $op = $_;
            if (($op =~ m{\A\d+\Z}) and length($op) >= 10) {
                $op .= "L";
            }
            $op
            } split(/$sep/, substr($postfix, 1)));
        # $callcode = "dex" might be changed to "dexcr" (if ComputableReals must be included)
        my @ops = map {
                my $op = $_; 
                if (0) {
                } elsif ($op =~ m{[\+\-\*\/]}) {
                    $op = ").$hash{$op}(";
                } elsif ($op =~ m{[\^]}) {
                    $callcode = "dexcr";
                    $op = "^?";
                } elsif ($op =~ m{\A(\d+L?)\Z}) { # number
                    $op = "CR.valueOf($op)";
                } elsif ($op =~ m{\A(e|pi)\Z}) { # constant
                    $op = "CR." . uc($1);
                } else {
                    $op = "?";
                }
                $op
            } split(/\,/, $postfix);
        my $result = "";
        if (0) {
        } elsif (scalar(@ops) == 3) {
            $result = "($ops[0]$ops[2]$ops[1])";
        # A176533   dex 2   15,4,sqrt(),15,funct,*,+,3,/    (15+4*sqrt(15))/3
        } elsif ($postfix =~ m{\A(\d+L?)\,(\d+L?)\,sqrt\(\),(\d+L?)\,funct\,\*\,\+\,(\d+L?)\,\/\Z}) {
            $result = "(CR.valueOf($1).add(CR.valueOf($2).multiply(CR.valueOf($3).sqrt()))).divide(CR.valueOf($4))";
        # A176534   dex 2   35,sqrt(),1295,funct,+,7,/  (35+sqrt(1295))/7
        } elsif ($postfix =~ m{\A(\d+L?)\,sqrt\(\),(\d+L?)\,funct\,\+\,(\d+L?)\,\/\Z}) {
            $result = "(CR.valueOf($1).add(CR.valueOf($2).sqrt())).divide(CR.valueOf($3))";
        } else {
            $result = "?";
        }
        if ($result !~ m{\?}) {
            print join("\t", $aseqno, $callcode, $offset, $result, $name) . "\n";
        }
    } # if aseqno
} # while <>

#--------------------------------
__DATA__
A176533 dex 2   15,4,sqrt(),15,funct,*,+,3,/    (15+4*sqrt(15))/3
A176534 dex 2   35,sqrt(),1295,funct,+,7,/  (35+sqrt(1295))/7
A176535 dex 2   10,sqrt(),105,funct,+,2,/   (10 + sqrt(105))/2
A030644 dex 1   10,pi,- 10 - pi
A034948 dex 0   1,9801,/    1/9801
A036663 dex 0   1,98019801,/    1/98019801
A036664 dex 0   1,980198019801,/    1/980198019801
A036665 dex 0   1,9801980198019801,/    1/9801980198019801
A037222 dex 2   pi,e,2,^,*  pi*e^2
A037996 dex 2   pi,exp(),2,pi,*,pi,2,^,2,/,-,funct,*    pi*exp(2*pi-pi^2/2)
A040009 dex 0   pi,exp(),0,pi,2,^,2,/,-,funct,* pi*exp(-pi^2/2)
A049471 dex 1   tan(),1,funct   tan(1)
#---------------------------------
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
  
import irvine.math.cr.ComputableReals;
 * A005480 Decimal expansion of cube root of 4.
  private static final CR N = ComputableReals.SINGLETON.pow(CR.FOUR, CR.THREE.inverse());  
  
 * A018938 Decimal expansion of <code>e^Pi - Pi</code>.
  private static final CR N = CR.PI.exp().subtract(CR.PI);
  
 * A019314 Decimal expansion of <code>e^Pi + Pi^e</code>.
  private static final CR N = CR.PI.exp().add(ComputableReals.SINGLETON.pow(CR.PI, CR.E));
  
 * A053511 Decimal expansion of <code>log_10 (Pi)</code>.
  private static final CR N = CR.PI.log().divide(CR.valueOf(10).log());
  
  