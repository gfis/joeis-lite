#!perl

# Convert callcodes ser* to poly*
# @(#) $Id$
# 2025-06-24, Georg Fischer
#
#:# Usage:
#:#     perl revtraf.pl [-d mode] gregen.seq4 > revtraf.seq4
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

my %restix = ("poly", 1, "polyx", 3, "polyz", 5); # index in @rest of new parameter for seqs
my ($aseqno, $callcode, $offset, @parms, $polys, $name, $postfix);
while (<>) {
#while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    ($aseqno, $callcode, $offset, @parms) = split(/\t/, $line); #
    if (0) {
    } elsif ($callcode =~ m{\A(serrev)\Z}) {
    	$callcode = "poly";
      $polys = (1 || $offset == 0) ? "[1]" : "[0,1]";
      $polys .= ",$parms[1],$parms[2]";  
      $name = $parms[3];
      $postfix = "p1,p2,/,rev";
      if ($offset == 0) {
        $postfix .= ",x,/";
        $callcode .= "x";
        $name = "1\t0\t$name";
      }
      print join("\t", $aseqno, $callcode, $offset, "\"$polys\"", "\"$postfix\"", $name) . "\n";
    }
} # while <>
#----
__DATA__
A371429	serrev	0	1	[0,1]	[1,3,3,1,-1]	(1/x) * Series_Reversion( x / ((1+x)^3 - x^4) ).					Expansion of (1/x) * Series_Reversion( x / ((1+x)^3 - x^4) ).
A371430	serrev	0	1	[0,1]	[1,4,5,4,1]	(1/x) * Series_Reversion( x / ((1+x)^4 - x^2) ).					Expansion of (1/x) * Series_Reversion( x / ((1+x)^4 - x^2) ).
A263843	serreva0	0	J162395			Reversion of g.f. for J162395 (squares with signs).	nonn,easy,changed,synth	0..23	nyi		Reversion of g.f. for J162395 (squares with signs).
A050385	serrevas	1	F008683			Reversion of Moebius function F008683.	nonn,nice,changed,	1..1000	nyi		Reversion of Moebius function F008683.
A050387	serrevas	1	F008836			Reversion of Liouville''s lambda function F008836.	nonn,	1..1000	nyi		Reversion of Liouville''s lambda function F008836.
