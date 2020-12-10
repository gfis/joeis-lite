#!perl

# Polish names with "Expansion of Product (..."
# 2020-12-08, Georg Fischer
#
#:# Usage:
#:#   perl prod_polish.pl cat25.txt > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
while (<>) {
	s/\s+\Z//;  #chompr
    if (m{\A(\%\N) (A\d+) Expansion of Product (\(.*)}) {
    	my ($tcode, $aseqno, $form) = ($1, $2, $3);
    	$form =~ s{ in powers of x|[\;\,] [mk]\=1\.\.inf}{};
    	$form =~ s{\s}{}g;
    	$form =~ tr{jmqtz}{kkxxx};
    	$form =~ s{\^\-(\d+)}{\^\(\-$1\)};
    	$form = "\{k>=1\}$form";
    	print join(" ", $tcode, $aseqno, "Expansion of Product_$form") . "\n";
    } else {
    	print "$_\n";
    }
} # while <>
#--------
__DATA__
%N A000731 Expansion of Product (1 - x^k)^8 in powers of x.
%N A010818 Expansion of Product (1 - x^k)^10 in powers of x.
%N A010831 Expansion of Product (1-x^k )^26.
%N A010833 Expansion of Product (1-x^k )^28.
%N A010835 Expansion of Product (1-x^k)^30.
%N A010837 Expansion of Product (1-x^k )^32.
%N A010838 Expansion of Product (1-x^k )^44.
%N A010840 Expansion of Product (1-x^k )^40.
%N A022739 Expansion of Product (1-m*q^m)^-15; m=1..inf.
%N A022740 Expansion of Product (1-m*q^m)^-16; m=1..inf.
%N A022741 Expansion of Product (1-m*q^m)^-17; m=1..inf.
%N A022742 Expansion of Product (1-m*q^m)^-18; m=1..inf.
%N A022743 Expansion of Product (1-m*q^m)^-19; m=1..inf.
%N A022744 Expansion of Product (1-m*q^m)^-20; m=1..inf.
%N A022745 Expansion of Product (1-m*q^m)^-21; m=1..inf.
%N A022746 Expansion of Product (1-m*q^m)^-22; m=1..inf.
%N A022747 Expansion of Product (1-m*q^m)^-23; m=1..inf.
%N A022749 Expansion of Product (1-m*q^m)^-25; m=1..inf.
%N A022750 Expansion of Product (1-m*q^m)^-26; m=1..inf.
%N A022751 Expansion of Product (1-m*q^m)^-27; m=1..inf.
%N A022752 Expansion of Product (1-m*q^m)^-28; m=1..inf.
%N A022753 Expansion of Product (1-m*q^m)^-29; m=1..inf.
%N A022754 Expansion of Product (1-m*q^m)^-30; m=1..inf.
%N A022755 Expansion of Product (1-m*q^m)^-31; m=1..inf.
%N A022756 Expansion of Product (1-m*q^m)^-32; m=1..inf.
%N A034998 Expansion of Product (1+q^(2k-1))^(-8)*(1+q^(4k))^(-8), k=1..inf.

-->

%N A000731 Expansion of Product_{k>=1}(1-x^k)^8.
%N A010818 Expansion of Product_{k>=1}(1-x^k)^10.
%N A010831 Expansion of Product_{k>=1}(1-x^k)^26.
%N A010833 Expansion of Product_{k>=1}(1-x^k)^28.
%N A010835 Expansion of Product_{k>=1}(1-x^k)^30.
%N A010837 Expansion of Product_{k>=1}(1-x^k)^32.
%N A010838 Expansion of Product_{k>=1}(1-x^k)^44.
%N A010840 Expansion of Product_{k>=1}(1-x^k)^40.
%N A022739 Expansion of Product_{k>=1}(1-k*x^k)(-15).
%N A022740 Expansion of Product_{k>=1}(1-k*x^k)(-16).
%N A022741 Expansion of Product_{k>=1}(1-k*x^k)(-17).
%N A022742 Expansion of Product_{k>=1}(1-k*x^k)(-18).
%N A022743 Expansion of Product_{k>=1}(1-k*x^k)(-19).
%N A022744 Expansion of Product_{k>=1}(1-k*x^k)(-20).
%N A022745 Expansion of Product_{k>=1}(1-k*x^k)(-21).
%N A022746 Expansion of Product_{k>=1}(1-k*x^k)(-22).
%N A022747 Expansion of Product_{k>=1}(1-k*x^k)(-23).
%N A022749 Expansion of Product_{k>=1}(1-k*x^k)(-25).
%N A022750 Expansion of Product_{k>=1}(1-k*x^k)(-26).
%N A022751 Expansion of Product_{k>=1}(1-k*x^k)(-27).
%N A022752 Expansion of Product_{k>=1}(1-k*x^k)(-28).
%N A022753 Expansion of Product_{k>=1}(1-k*x^k)(-29).
%N A022754 Expansion of Product_{k>=1}(1-k*x^k)(-30).
%N A022755 Expansion of Product_{k>=1}(1-k*x^k)(-31).
%N A022756 Expansion of Product_{k>=1}(1-k*x^k)(-32).
%N A034998 Expansion of Product_{k>=1}(1+x^(2k-1))^(-8)*(1+x^(4k))^(-8).
