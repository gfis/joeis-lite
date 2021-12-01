#!perl

# Improve postfix expressions for RING.ttab
# @(#) $Id$
# 2021-12-01, Georg Fischer: copied from cr_polish.plde_zeta.pl
#
#:# Usage:
#:#   perl ring_improve.pl seq4-input > output
#
# Postfix separator is ";".
#--------------------------------------------------------
use strict;
use integer;
use warnings;

# named Q constants
my %hnum = qw ( 
  ZERO  0
  ONE   1
  TWO   2
  THREE 3
  );
my $line;
my $nok;
while (<>) {
    $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s{\s+\Z}{}; # chompr
    if ($line =~ m{\AA\d+\t}) { # starts with aseqno
        my ($aseqno, $callcode, $offset, $parm1, @rest) = split(/\t/, $line);
        $nok = 0; # assume success
        # Caution: this order of the replacements matters!
        $parm1 .= ";"; # separator on both ends
        $parm1 =~ s{;exp(;1;exp);([0-9x]);\^;} {;exp(;$1;exp);}g;                 # exp(a)^b
    #   $parm1 =~ s{;1;2;\/;}                  {;half;}g;                         # 1/2
        $parm1 =~ s{;1;x;\+;}                  {;.RING.onePlusXToTheN(1);}g;      # 1+x
        $parm1 =~ s{;1;x;\-;}                  {;.RING.oneMinusXToTheN(1);}g;     # 1-x
        $parm1 =~ s{;1;x;(\d+);\^;\+;}         {;.RING.onePlusXToTheN($1);}g;     # 1+x^n
        $parm1 =~ s{;1;x;(\d+);\^;\-;}         {;.RING.oneMinusXToTheN($1);}g;    # 1-x^n
        $parm1 =~ s{;(\d+);x;\*;}              {;.RING.monomial(new Q($1),1);}g;  # n*x
        $parm1 =~ s{;(\d+);x;(\d+);\^;\*;}     {;.RING.monomial(new Q($1),$2);}g; # n*x^m
        $parm1 =~ s{;(\d+);\^;}                {;\.$1;\^n;}g;                     # ^n
        chop($parm1); # remove trailing separator
        if ($nok == 0) {
            print        join("\t", $aseqno, $callcode,  $offset, $parm1, @rest) . "\n";
        } else {
            print STDERR join("\t", $aseqno, "nok=$nok", $offset, $parm1, @rest) . "\n";
        }
    } # if starts with aseqno
} # while <>
__DATA__
A999991	egf	0	;1;2;/	0
A999992	egf	0	;exp(;x;exp);2;^	0
A999993	egf	0	;1;x;+	0
A999994	egf	0	;1;x;-	0
A999995	egf	0	;1;x;3;^;+	0
A999996	egf	0	;1;x;4;^;-	0
A999997	egf	0	;5;x;*	0
A999998	egf	0	;6;x;7;^;*	0
A999999	egf	0	;exp(;1;exp);x;^	0
