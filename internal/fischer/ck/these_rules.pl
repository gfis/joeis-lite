#!perl
# A190803 Increasing sequence generated by these rules: a(1)=1, and if x is in a then 2x-1 and 3x-1 are in a.
# @(#) $Id$
# 2021-09-02, Georg Fischer

use strict;
my @anum = qw (
  ZERO 
  ONE  
  TWO  
  THREE
  FOUR 
  FIVE 
  SIX  
  SEVEN
  EIGHT
  NINE 
  TEN  
  );
  
my $rseqno = "A190803";
while (<>) {
# while (<DATA>) {
    my $line = $_;
    if ($line =~ m{\A(A\d+)}) { # starts with 
        my $aseqno = $1;
        if ($line =~ m{in +\w +then +([\dx\+\-\[\]\*\/\^flor\(\)]+) +and +([\dx\+\-\[\]\*\/\^flor\(\)]+) +are +in +\w}) { # extract parameters
            my ($expr1, $expr2) = ($1, $2);
            my ($oxpr1, $oxpr2) = ($1, $2);
            ($expr1, $expr2) = map {
                s{[ \[\]]}{}g; # remove spaces and [ ]
                s{(\d+|\))x}{x\*$1}g;
                s{x\(}{x\*\(}g;
                s{x\^2}{x\*x}g;
                s{x\^3}{x\*x\*x}g;
                if (s{floor\(}{}) { s{\)\Z}{}; } # remove "floor(...)"
                s{\A(\d+)\+(.+)}{$2\+$1}g;
                # now Z-ify the expression
                s{\*(\d+|x)}{\.multiply\($1\)}g;
                s{\/(\d+)}  {\.divide\($1\)}g;
                s{\+(\d+)\Z}{"\.add\(Z\.$anum[$1]\)"}eg;
                s{\-(\d+)\Z}{"\.subtract\(Z\.$anum[$1]\)"}eg;
                s{(multiply|divide)\(2\)}{${1}2\(\)}g;
                $_ # return result of mapping
                } ($expr1, $expr2); 
            print join("\t", $aseqno, "a190803", 0, $rseqno, $expr1, $expr2, $oxpr1, $oxpr2) ."\n";
        } # if parameters
    } # if aseqno
} # while
#----
__DATA__
A191286	null	Increasing sequence generated by these rules:  a(1)=1, and if x is in a then 3x and 1+x^2 are in a.     nonn,   1..10000        nyi
A191287	null	Increasing sequence generated by these rules:  a(1)=1, and if x is in a then floor(3x/2) and 3x are in a.       nonn,   1..10000        nyi
A191288	null	Increasing sequence generated by these rules: 1 is in a, and if x is in a then 2x and floor((x^2)/3) are in a.  nonn,   1..10000        nyi