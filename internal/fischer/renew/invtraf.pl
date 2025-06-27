#!perl

# Convert callcodes invtra* to poly*
# @(#) $Id$
# 2025-06-27, Georg Fischer
#
#:# Usage:
#:#     perl invtraf.pl [-d mode] gregen.seq4 > invtraf.seq4
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my ($aseqno, $callcode, $offset, @parms, $polys, $postfix, $seqs, $name);
while (<>) {
#while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    ($aseqno, $callcode, @parms) = split(/\t/, $line); # 
    $offset = $parms[0];
    if (0) {
    } elsif ($callcode =~ m{\A(invtra([cfs]))\Z}) { 
    	my $cc    = $1;
      $callcode = "polya"; 
      $polys    = ($offset == 0) ? "[1]" : "[0,1]";
      $name     = $parms[9];
      $postfix  = "1,1,x,B,-,/";
      if (0) {
      } elsif ($cc =~ m{[fs]\Z}) {
          $seqs     = $parms[1];
      } elsif ($cc =~ m{[c]\Z}) {
          $seqs     = "new CharacteristicFunction(0, " . $parms[1] . ")";
      }
      &output();
    } else {
      print "$line\n";
    }

} # while <>
sub output {
    print join("\t", $aseqno, $callcode, $offset, "\"$polys\"", "\"$postfix\"", $seqs, $name) . "\n";
} # output
#----
__DATA__
A280605	invtrac	0	new A246547()	0	Expansion of 1/(1 - Sum_{p prime, k>=2} x^(p^k)).						Expansion of 1/(1 - Sum_{p prime, k>=2} x^(p^k)).
A281422	invtrac	0	new A006450()	0	Expansion of 1/(1 - Sum_{k>=1} x^prime(prime(k))).						Expansion of 1/(1 - Sum_{k>=1} x^prime(prime(k))).
A282906	invtrac	0	new A007504()	0	Expansion of 1/(1 - Sum_{j>=1} x^(Sum_{i=1..j} prime(i))).						Expansion of 1/(1 - Sum_{j>=1} x^(Sum_{i=1..j} prime(i))).
A129921	invtraf	0	new A000005()	INVERT transform of tau (A000005). - _Alois P. Heinz_, Feb 11 2021							Number of generalized compositions of n: words b_1^{i_1}b_2^{i_2}...b_k^{i_k} such that b_j''s and j_i''s are positive integers and sum b_j*i_j = n.
A180305	invtraf	0	new A000203()	INVERT transform of sigma (A000203). - _Alois P. Heinz_, Feb 11 2021							G.f.: 1/(1 + x*d/dx log(eta(x))), where eta(x) is Dedekind''s eta(q) function without the q^(1/24) factor.
A305532	invtraf	0	new A000182()	Invert transform of tangent numbers (A000182).							Expansion of 1/(1 - x/(1 - 1*2*x/(1 - 2*3*x/(1 - 3*4*x/(1 - 4*5*x/(1 - ...)))))), a continued fraction.
A305533	invtraf	0	new A002105()	Invert transform of reduced tangent numbers (A002105).							Expansion of 1/(1 - x/(1 - 1*x/(1 - 3*x/(1 - 6*x/(1 - 10*x/(1 - ... - (k*(k + 1)/2)*x/(1 - ...))))))), a continued fraction.
A144028	invtras	0	new A055615()	0	, n*mu(n).						INVERT transform of A055615, n*mu(n).
A159929	invtras	0	new A000010()	0	.						INVERT transform of phi(n), A000010.
A300662	invtras	0	new A008578()	0	.						Expansion of 1/(1 - x - Sum_{k>=2} prime(k-1)*x^k).
