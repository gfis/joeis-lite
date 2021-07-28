#!perl

# Polish CR expressions
# @(#) $Id$
# 2021-07-16, Georg Fischer: copied from de_zeta.pl
#
#:# Usage:
#:#   perl de_zeta.pl seq4-input > output
#
# - revert CR parameters of zeta() to int parameters
# - .gamma().log() -> .lnGamma()
# - .pow(CR.ONE.divide(CR.TWO)) -> .sqrt()
# - CR.TWO.sqrt() -> CR.SQRT2
# - append "r" to the callcode if "REALS" occurs
# - separate bad expressions with '<?'
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my %nums = qw (
  ZERO  0
  ONE   1
  TWO   2
  THREE 3
  FOUR  4
  FIVE  5
  SIX   6
  SEVEN 7
  EIGHT 8
  NINE  9
  TEN  10
  );
my $line;
while (<>) {
    $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    if ($line =~ m{\AA\d+\t}) { # starts with aseqno
        my ($aseqno, $callcode, $offset, $parm1, @rest) = split(/\t/, $line);
        my $nok = 0; # assume success
        # ---- zeta polishing ----
        while ($parm1 =~ m{zeta\(CR\.(ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN)\)}) {
            $parm1    =~ s{zeta\(CR\.(ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN)\)}{zzzz\($nums{$1}\)};
        }
        while ($parm1 =~ m{zeta\(CR\.valueOf\((\d+)\)\)}) {
            $parm1    =~ s{zeta\(CR\.valueOf\((\d+)\)\)}{zzzz\($1\)};
        }
        if ($parm1    =~ m{zeta\(}) {
            $nok = 1; # zeta with fraction, expression
        }
        if ($parm1    =~ m{\<\?}) {
            $nok = 2; # error in expression
        }
        $parm1 =~ s{zzzz\(}{zeta\(}g; # unshield
        # ---- general polishing ----
        $parm1 =~ s{\.gamma\(\)\.log\(\)}{\.lnGamma\(\)}g;
        $parm1 =~ s{CR\.ONE\.divide\(CR\.TWO\)}{CR\.HALF}g;
        $parm1 =~ s{\.pow\(CR\.HALF\)}{\.sqrt\(\)}g;
        $parm1 =~ s{CR\.TWO\.sqrt\(\)}{CR\.SQRT2}g;
        if ($parm1 =~ m{(REALS|ComputableReals)}) {
            $callcode .= "r";
        }
        #---- output ----
        if ($nok == 0) {
            print        join("\t", $aseqno, $callcode,  $offset, $parm1, @rest) . "\n";
        } else {
            print STDERR join("\t", $aseqno, "nok=$nok", $offset, $parm1, @rest) . "\n";
        }
    } # if starts with aseqno
} # while <>
