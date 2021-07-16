#!perl

# Revert CR parameters of zeta() to int parameters
# @(#) $Id$
# 2021-07-16, Georg Fischer: copied from post_infix.pl
#
#:# Usage:
#:#   perl de_zeta.pl seq4-input > output
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
        my ($aseqno, $callCode, $offset, $parm1, @rest) = split(/\t/, $line);
        my $nok = 0; # assume success
        while ($parm1 =~ m{zeta\(CR\.(ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN)\)}) {
            $parm1    =~ s{zeta\(CR\.(ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN)\)}{zzzz\($nums{$1}\)};
        }
        while ($parm1 =~ m{zeta\(CR\.valueOf\((\d+)\)\)}) {
            $parm1    =~ s{zeta\(CR\.valueOf\((\d+)\)\)}{zzzz\($1\)};
        }
        if ($parm1    =~ m{zeta\(}) {
            $nok = 1; # fraction, expression
        }
        $parm1        =~ s{zzzz\(}{zeta\(}g; # unshield
        if ($nok == 0) {
            print join("\t", $aseqno, $callCode, $offset, $parm1, @rest) . "\n";
        } else {
            print STDERR join("\t", "zeta $nok", $aseqno, $callCode, $offset, $parm1, @rest) . "\n";
        }
    } # if starts with aseqno
} # while <>
