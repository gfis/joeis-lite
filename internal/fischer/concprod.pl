# concprod.pl
# @(#) $Id$
# 2019-07-25, Georg Fischer
#
#:# usage:
#:#     perl -n concprod.pl ../../../OEIS-mat/common/names
#
# A116224       0   0   +9  9
# A116225       0   1   -9  1
#                rs   i   j
#   rs=0:  Numbers k such that k // (k+i) = m * (m+j)
#   rs=1:  Numbers k such that m // (m+i) = k * (k+j)
#----------------------------------------------------
use strict;
use integer;
use warnings;

s{Numbers \w such that }{};
if (m{^(A\d+)\s+(the concatenation of \w with [\w\+\-\*\d]{3}|\w concatenated with [\w\+\-\*\d]{3}|the square of \w|\w times [\w\+\-\*\d]{3}) (gives|is) (the concatenation of two numbers \w and [\w\+\-\*\d]{3}|the product of two numbers which differ by \d+|a square)}) {
    my ($aseqno, @both) = ($1, $2, $4);
    my ($left, $right) = map { s{times}{\*};
        s{concatenated with}{\/\/};
        s{the concatenation of (\w) with ([\w\+\-\*\d]{3})}{$1 \/\/ $2};
        s{(\w) concatenated with ([\w\+\-\*\d]{3})}{$1 \/\/ $2};
        s{the concatenation of two numbers (\w) and ([\w\+\-\*\d]{3})}{$1 \/\/ $2};
        s{the product of two numbers which differ by (\d+)}{m \* m\+$1};
        s{the square of (\w)}{$1 * $1\+0};
        s{a square}{n * n+0};
        $_} @both;
    $left  =~ s{[a-z]}{k}g;
    $right =~ s{[a-z]}{m}g;
    my $resindex = 0;
    if ($right =~ m{\/\/}) {
        my $temp = $left;
        $left = $right;
        $right = $temp;
        $resindex = 1;
    }
    $left =~ s{([0-9])\*([a-z])}{$2\*$1};
    $left =~ s{\w \/\/ \w}{};
    $right =~ s{\w \* \w\+}{};
    print join("\t", $aseqno, "$@", 0, $resindex, $left, $right) . "\n";
} # if match
