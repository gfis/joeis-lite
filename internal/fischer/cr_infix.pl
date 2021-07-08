#!perl

# Prepare formulas for decimal expansion using CR functions
# @(#) $Id$
# 2020-04-03, Georg Fischer: copied from infix_dex.pl
#
#:# Usage:
#:#   perl cr_infix.pl [-d debug] dex3.tmp > outfile
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

my $CRS = "REALS";
my %hash = 
    ( "arccos", "$CRS.acos"
    , "arcsin", "$CRS.asin"
    , "arctan", "$CRS.atan"
    , "arccot", "$CRS.acot"
    , "acos",   "$CRS.acos"
    , "asin",   "$CRS.asin"
    , "atan",   "$CRS.atan"
    , "acot",   "$CRS.acot"
    , "cosh",   "$CRS.cosh"
    , "sinh",   "$CRS.sinh"
    , "tan",    "$CRS.tan"
    , "tanh",   "$CRS.tanh"
    , "cot",    "$CRS.cot"
    , "coth",   "$CRS.coth"
    , "csc",    "$CRS.csc"
    , "sec",    "$CRS.sec"
    , "csch",   "$CRS.csch"

    , "omega",  "irvine.factor.factor.Cheetah.factor(mN).omega()" 
    , "phi",    "irvine.math.LongUtils.phi(mN)"
    , "sigma",  "irvine.factor.factor.Cheetah.factor(mN).sigma()"
    );
my @number_words = qw(ZERO ONE TWO THREE FOUR FIVE);  # SIX SEVEN EIGHT NINE TEN => undefined
my $line;
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($line =~ m{\AA\d+\t}) { # starts with aseqno
        my ($aseqno, $callcode, $offset, $postfix, $keep0, $base, $name) = split(/\t/, $line);
        my $callext = ""; # maybe "cr"
        my $s = substr($postfix, 0, 1); # first character is separator (";")
        # $postfix =~ s{\;2\;pi\;\*\;}{\;tau\;}g;
        # $postfix =~ s{\;sqrt\(\;2\;sqrt\)\;}{\;sqrt2\;}g;
        $postfix =~ s{\;1\;2\;\/\;}{\;half\;}g;
        $postfix =~ s{\;1\;3\;\/\;}{\;one_third\;}g;
        $postfix =~ s{\s+}{}g;
        $postfix = join($s, map {
            my $op = $_;
            if ($op =~ m{\A\d+\Z}) { # number
                if (length($op) >= 10) {
                    $op .= "L";
                }
            }
            $op
            } split(/$s/, $postfix));
        # $callcode = "dex_" might be changed to "dex_cr" (if ComputableReals must be included)
        my @ops = split(/${s}/, substr($postfix, 1));
        my @stack = ();
        my ($op1, $op2);
        my $iop = 0;
        my $error = 0;
        while ($iop < scalar(@ops) and $error == 0) { 
            my $op = $ops[$iop]; 
            if (0) {
            } elsif ($op =~ m{\A(\d+L?)\Z}) { # number
                $op = "CR.valueOf($op)";
                push(@stack, $op);
            } elsif ($op =~ m{\A(e|half|one_third|pi|sqrt2)\Z}i) { # named constant
                $op = "(CR." . uc($1) . ")";
                push(@stack, $op);
            } elsif ($op =~ m{\A[a-z][a-z0-9]*\Z}) { # several letters variable name
                push(@stack, $op);
            } elsif ($op =~ m{\A[a-z]\Z}) { # single letter variable name - cf. above
                push(@stack, $op);
            } elsif ($op eq "+") { # +
                $op2 = pop(@stack);
                $op1 = pop(@stack);
                push(@stack, "$op1.add($op2)");
            } elsif ($op eq "-.") { # unary -
                $op1 = pop(@stack);
                push(@stack, "$op1.negate()");
            } elsif ($op eq "-") { # -
                $op2 = pop(@stack);
                $op1 = pop(@stack);
                push(@stack, "$op1.subtract($op2)");
            } elsif ($op eq "*") { # *
                $op2 = pop(@stack);
                $op1 = pop(@stack);
                push(@stack, "$op1.multiply($op2)");
            } elsif ($op eq "/") { # /
                $op2 = pop(@stack);
                $op1 = pop(@stack);
                push(@stack, "$op1.divide($op2)");
            } elsif ($op eq "^") { # ^
                $op2 = pop(@stack);
                $op1 = pop(@stack);
                if (0) {
                } elsif ($op2 eq "CR.TWO") {
                    push(@stack, "$op1.multiply($op1)");
                } elsif ($op1 eq "CR.E") {
                    push(@stack, "$op2.exp()");
                } else {
                    # ComputableReals.SINGLETON.pow(CR.FOUR, CR.THREE.inverse());
                    $callext = "cr";
                    push(@stack, "$CRS.pow($op1,$op2)");
                }
            } elsif ($op =~ m{\(\Z}) { # start of function call
                # ignore
            } elsif ($op =~ m{\A(arcsin|arccos|arctan|sinh|cosh|tan|tanh|cot|coth|csc|sec|csch|sech)\)\Z}) { # end of function call
                $op = $1;
                $op1 = pop(@stack);
                $callext = "cr";
                push(@stack, "$hash{$op}($op1)");
            } elsif ($op =~ m{\A(sqrt|log|exp|sin|cos|abs|floor|ceil|round)\)\Z}) { # end of function call
                $op1 = pop(@stack);
                $op =~ s{\)}{\(\)};
                push(@stack, "$op1.$op");
            } elsif ($op =~ m{\A(zeta)\)\Z}) { # end of zeta call
                $op1 = pop(@stack);
                if ($op1 =~ m{\ACR.valueOf\((\d+)\)\Z}) { # int parameter; 2nd would be precision?
                    $op1 = $1;
                    $callext = "cr";
                    push(@stack, "Zeta.zeta($op1)");
                } else {
                    $op = "?4?";
                    $error = 1;
                }
            } elsif ($op =~ m{\A(gamma|eulergamma)\Z}) { # EulerGamma
                $callext = "cr";
                push(@stack, "(EulerGamma.SINGLETON)");
            } elsif ($op =~ m{\A(log_?(\d+))\)\Z}) { # log_10, log_2 ...
                my $base = $2;
                $op1 = pop(@stack);
                push(@stack, "$op1.log().divide(CR.valueOf($base).log())");
            } else {
                $op1 = pop(@stack) || "undef";
                if ($debug >= 1) {
                    print "# $aseqno ?1? op1=\"$op1\", op=\"$op\"\n";
                } 
                $op = "?1?";
                $iop = scalar(@ops); # break loop
                $error = 1;
            }
            $ops[$iop] = $op;
            $iop ++;
        } # while $iop
                
        my $result = "?5?";
        if ($base > 36) { # jOEIS DecimalExpansion restriction
            $result = "?2?";
        } elsif (scalar(@stack) == 1 and $error == 0) {
            $result = pop(@stack);
        } elsif (scalar(@ops) == 1) { 
            $result = "$ops[1]";
        } elsif (scalar(@ops) == 3) {
            $result = "($ops[0]$ops[2]$ops[1])";
        # A176534   dex 2   ;35;sqrt(;1295;sqrt);+;7;/  (35+sqrt(1295))/7
        } elsif ($postfix =~ m{\A\;(\d+L?)\;sqrt\(\;(\d+L?)\;sqrt\)\;\+\;(\d+L?)\;\/\Z}) {
            $result = "(CR.valueOf($1).add(CR.valueOf($2).sqrt())).divide(CR.valueOf($3))";
        # A176533   dex 2   ;15;4;sqrt(;15;sqrt);*;+;3;/    (15+4*sqrt(15))/3
        } elsif ($postfix =~ m{\A\;(\d+L?)\;(\d+L?)\;sqrt\(\;(\d+L?)\;sqrt\)\;\*\;\+\;(\d+L?)\;\/\Z}) {
            $result = "(CR.valueOf($1).add(CR.valueOf($2).multiply(CR.valueOf($3).sqrt()))).divide(CR.valueOf($4))";
        # A159811   dex 1   ;105507;65798;sqrt(;2;sqrt);*;+;223;2;^;/   (105507 + 65798*sqrt(2))/223^2
        } elsif ($postfix =~ m{\A\;(\d+L?);(\d+L?)\;sqrt\(\;(\d+L?)\;sqrt\)\;\*\;\+\;(\d+L?)\;2\;\^\;\/\Z}) {
            $result = "(CR.valueOf($1).add(CR.valueOf($2).multiply(CR.valueOf($3).sqrt()))).divide(CR.valueOf($4).multiply(CR.valueOf($4)))";
        } else {
            print "# $aseqno cr_infix: name=$name, ops=" . join(";", @ops) . ", stack=" . join(";", @stack) . "\n";
            $result = "?3?";
        }
        if ($result !~ m{\?}) {
            $result =~ s{CR\.valueOf\(2\)\.sqrt\(\)}{CR\.SQRT2}g; # simplify sqrt(2)
            $result =~ s{CR\.valueOf\(([0-5])\)}{\(CR\.$number_words[$1]\)}g; # known number constants
            print join("\t", $aseqno, "$callcode$callext", $offset, $result, $keep0, $base, $name) . "\n";
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
  
  