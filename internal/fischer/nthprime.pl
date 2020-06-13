#!perl

# Generate Jasinski's sequences expr(n-th prime)
# @(#) $Id$
# 2020-06-12, Georg Fischer
#
#:# Usage:
#:#   perl nthprime.pl [-d debug] > nth_prime.gen
#-------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) < 0) {
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

print <<'GFis';
A032600	nthprime	1	mLuckies.next().subtract(mNP)	~~import irvine.oeis.~~Sequence;~~a000.A000959;	  final Sequence mLuckies = new A000959();		Difference between n-th lucky number and n-th prime number.	sign,	10862	10000
A032601	nthprime	1	mLuckies.next().multiply(mNP)	~~import irvine.oeis.~~Sequence;~~a000.A000959;	  final Sequence mLuckies = new A000959();		Difference between n-th lucky number and n-th prime number.	sign,	10862	10000
A032602	nthprime	1	mLuckies.next().add(mNP)	~~import irvine.oeis.~~Sequence;~~a000.A000959;	  final Sequence mLuckies = new A000959();		Difference between n-th lucky number and n-th prime number.	sign,	10862	10000
A032603	nthprime	1	new Z(mNP.toString() + mLuckies.next().toString())	~~import irvine.~~math.z.ZUtils;~~oeis.Sequence;~~oeis.a000.A000959;	  final Sequence mLuckies = new A000959();			Concatenation of n-th prime number and n-th lucky number.	nonn,base,less,changed,synth	157189	37
A032604	nthprime	1	new Z(mLuckies.next().toString() + mNP.toString())	~~import irvine.~~math.z.ZUtils;~~oeis.Sequence;~~oeis.a000.A000959;	  final Sequence mLuckies = new A000959();			Decimal concatenation of n-th lucky number and n-th prime number.	nonn,base,changed,synth	189157	37
A033549	nthprimf	1	ZUtils.digitSum(mNP) == ZUtils.digitSum(mK)	~~import irvine.~~math.z.ZUtils;			Numbers n such that sum of digits of n-th prime equals sum of digits of n.	nonn,base,nice,	24706	1000
# A033947	nthprime	1	ZUtils.leastPrimitiveRoot(mNP)	~~import irvine.~~math.z.ZUtils;			Smallest primitive root (in absolute value) of n-th prime.	sign,synth	-2	90
A034785	nthprime	1	Z.TWO.pow(mNP)				a(n) = 2^(n-th prime).	easy,nonn,	68804608	200
A035100	nthprime	1	Z.valueOf(mNP.bitLength())				Number of bits in binary expansion of n-th prime.	nonn,easy,	13	1000
A035103	nthprime	1	Z.valueOf(mNP.bitLength() - mNP.bitCount())				Number of 0s in binary representation of n-th prime.	nonn,base,easy,	9	10000
A038194	nthprime	1	mNP.mod(Z.NINE)				Iterated sum-of-digits of n-th prime; or digital root of n-th prime; or n-th prime modulo 9.	nonn,base,easy,	5	10000
A038529	nthprime	1	mNP.subtract(mCompos.next())	~~import irvine.oeis.~~Sequence;~~a002.A002808;	  final Sequence mCompos = new A002808();			n-th prime - n-th composite.	sign,easy,changed,	93355	10000
A038530	nthprime	1	new Z(mNP.toString() + mCompos.next().toString())	~~import irvine.oeis.~~Sequence;~~a002.A002808;	  final Sequence mCompos = new A002808();			Concatenate n-th prime and n-th composite.	nonn,base,synth	16756	39
# A038833	nthprime	1	Z.THREE.pow(mNP)				3^n-th prime.	nonn,hard,	07982563	36
A039701	nthprime	1	mNP.mod(Z.THREE)				a(n) = n-th prime modulo 3.	nonn,easy,	2	10000
A039702	nthprime	1	mNP.mod(Z.FOUR)				a(n) = n-th prime modulo 4.	nonn,easy,	1	10000
A039703	nthprime	1	mNP.mod(Z.FIVE)				a(n) = n-th prime modulo 5.	nonn,easy,	4	1000
A039704	nthprime	1	mNP.mod(Z.SIX)				a(n) = n-th prime modulo 6.	nonn,easy,	5	10000
A039705	nthprime	1	mNP.mod(Z.SEVEN)				a(n) = n-th prime modulo 7.	nonn,easy,changed,	2	1000
A039706	nthprime	1	mNP.mod(Z.EIGHT)				a(n) = n-th prime modulo 8.	nonn,easy,changed,	1	10000
A039709	nthprime	1	mNP.mod(Z.valueOf(11))				a(n) = n-th prime modulo 11.	nonn,easy,	10	1000
A039710	nthprime	1	mNP.mod(Z.valueOf(12))				a(n) = n-th prime modulo 12.	nonn,easy,	5	10000
A039711	nthprime	1	mNP.mod(Z.valueOf(13))				Primes modulo 13.	nonn,easy,	5	10000
A039712	nthprime	1	mNP.mod(Z.valueOf(14))				a(n) = n-th prime modulo 14.	nonn,easy,	9	10000
A039713	nthprime	1	mNP.mod(Z.valueOf(15))				a(n) = n-th prime modulo 15.	nonn,easy,	14	10000
A039714	nthprime	1	mNP.mod(Z.valueOf(16))				a(n) = n-th prime modulo 16.	nonn,easy,	9	10000
A039715	nthprime	1	mNP.mod(Z.valueOf(17))				Primes modulo 17.	nonn,easy,	9	10000
A180217	nthprime	1	mNP.mod(Z.THREE).add(mNP.mod(Z.FOUR))				(n-th prime modulo 3) + (n-th prime modulo 4).
A051156	nthprime	1	Z.TWO.pow(mNP.pow(2)).subtract(Z.ONE).divide((Z.TWO.pow(mNP).subtract(Z.ONE)))				a(n) = (2^p^2 - 1)/(2^p - 1) where p is the n-th prime.	nonn,easy,changed,synth	26218241	7
A051157	nthprime	1	Z.TWO.pow(mNP.pow(3)).subtract(Z.ONE).divide((Z.TWO.pow(mNP.pow(Z.TWO).subtract(Z.ONE))))				a(n) = (2^p^3 - 1)/(2^p^2 - 1) where p = n-th prime.	nonn,easy,changed,synth	27220737	4
A060019	nthprime	1	CR.TWO.multiply(CR.valueOf(mNP.subtract(Z.TWO)).sqrt().subtract(CR.TWO)).floor()	~~import irvine.~~math.cr.CR;				a(n) = floor(2*sqrt(prime(n)-2)) where prime(n) = n-th prime.	nonn,synth	35	66
GFis
exit();

my ($aseqno, $superclass, $name, @rest);
while (<DATA>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    $name =~ s{\Aa\(n\) *\= *}{};
    $name =~ s{\..*}{};
    if ($name =~ s{ *\,? *where +p *=.*}{}) {
        $name =~ s{p}{prime\(n\)}g;
    }
    $name =~ s{\(n\-th prime\)}{prime\(n\)}g;
    $name =~ s{\(n\-th prime\^(\d)\)}{prime\(n\)\^$1}g;
    $name =~ s{\(prime\(n\)\)\^(\d)}{prime\(n\)\^$1}g;
    $name =~ s{ }{}g;
    # now patch 2 types of errors:
    # $name =~ s{n\-th prime\^}{n\-th prime\)\^}g;
    # $name =~ s{\)\)\/}{\)\/}g;
    my $result = $name;
    if (0) {
    } elsif ($name =~ m{\Aprime\(n\)\^(\d+)\*\(prime\(n\)\-1\)}) {
            $result = "mNP.pow($1).multiply(mNP.subtract(Z.ONE))";
        
    } elsif ($name =~ m{\Aprime\(n\)\^(\d+)\-prime\(n\)(\^(\d+))?}) {
        my $exp2 = $3 || 1;
        if ($exp2 == 1) {
            $result = "mNP.pow($1).subtract(mNP)";
        } else {
            $result = "mNP.pow($1).subtract(mNP.pow($exp2))";
        }
        
    } elsif ($name =~ m{\A\(prime\(n\)\^(\d+)\-prime\(n\)(\^(\d+))?\)\)?(\/(\d+))?}) {
        my $exp2 = $3 || 1;
        my $div  = $5 || 1;
        if ($exp2 == 1) {
            $result = "mNP.pow($1).subtract(mNP)";
        } else {
            $result = "mNP.pow($1).subtract(mNP.pow($exp2))";
        }
        if ($div != 1) {
            $result .= ".divide(Z.valueOf($div))";
        }
    } else {
    }
    
    print join("\t", $aseqno, "nthprime", 0, $result, $name, $rest[1]) . "\n";
} # while 
__DATA__
A138401	null	a(n) = prime(n)^4 - prime(n).	nonn,easy,	1..200
A138402	null	a(n) = (n-th prime)^4-(n-th prime)^2.	nonn,easy,	1..200
A138403	null	a(n) = p^3*(p-1), where p = prime(n).	nonn,easy,	1..200
A138404	null	a(n) = prime(n)^5 - prime(n).	nonn,easy,	1..200
A138405	null	a(n) = prime(n)^5 - prime(n)^2.	nonn,easy,	1..200
A138406	null	a(n) = prime(n)^5 - prime(n)^3.	nonn,easy,	1..200
A138407	null	a(n) = p^4*(p-1), where p = prime(n).	nonn,easy,	1..200
A138408	null	a(n) = prime(n)^6 - prime(n).	nonn,easy,	1..200
A138409	null	a(n) = prime(n)^6 - prime(n)^2.	nonn,easy,	1..200
A138410	null	a(n) = prime(n)^6 - prime(n)^3.	nonn,easy,	1..200
A138411	null	a(n) = prime(n)^6 - prime(n)^4.	nonn,easy,	1..168
A138412	null	a(n) = p^5*(p-1) where p =prime(n).	nonn,easy,	1..167
A138416	null	a(n) = (p^3 - p^2)/2, where p = prime(n).	nonn,easy,	1..168
A138417	null	a(n) = (prime(n)^4 - prime(n))/2.	nonn,easy,	1..200
A138418	null	a(n) = ((n-th prime)^4-(n-th prime)^2)/2.	nonn,easy,	1..200
A138419	null	a(n) = (prime(n)^4 - prime(n)^2)/3.	nonn,easy,	1..200
A138420	null	a(n) = ((prime(n))^4-(prime(n))^2)/4.	nonn,easy,	1..200
A138421	null	a(n) = (prime(n)^4 - prime(n)^2)/6.	nonn,easy,	1..200
A138422	null	a(n) = (prime(n)^4 - prime(n)^2)/12.	nonn,easy,	1..200
A138423	null	a(n) = (prime(n)^4 - prime(n)^3)/2.	nonn,easy,	1..200
A138424	null	a(n) = (prime(n)^5 - prime(n))/2.	nonn,easy,	1..200
A138425	null	a(n) = (prime(n)^5 - prime(n))/3.	nonn,easy,	1..200
A138426	null	a(n) = ((prime(n))^5-prime(n))/5.	nonn,easy,	1..200
A138427	null	a(n) = (prime(n)^5 - prime(n))/6.	nonn,easy,	1..200
A138428	null	a(n) = (prime(n)^5 - prime(n))/10.	nonn,easy,	1..200
A138429	null	a(n) = (prime(n)^5 - prime(n))/15.	nonn,easy,	1..200
A138430	null	(prime(n)^5 - prime(n))/30.	nonn,easy,	1..200
A138431	null	a(n) = ((n-th prime)^5-(n-th prime)^2)/2.	nonn,easy,synth	1..24
A138432	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/2.	nonn,easy,synth	1..24
A138433	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/3.	nonn,easy,changed,synth	1..24
A138434	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/4.	nonn,easy,	1..1000
A138435	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/6.	nonn,easy,changed,	1..1000
A138436	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/8.	nonn,easy,synth	1..25
A138437	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/12.	nonn,easy,synth	1..26
A138438	null	a(n) = ((n-th prime)^5-(n-th prime)^3)/24.	nonn,easy,	1..1000
A138439	null	a(n) = ((n-th prime)^5-(n-th prime)^4)/2.	nonn,easy,synth	1..24
A138440	null	a(n) = ((n-th prime)^6-(n-th prime))/2.	nonn,easy,synth	1..21
A138441	null	a(n) = ((n-th prime)^6-(n-th prime^2))/2.	nonn,easy,synth	1..23
A138442	null	a(n) = ((n-th prime)^6-(n-th prime^2))/3.	nonn,easy,synth	1..21
A138443	null	a(n) = ((n-th prime)^6-(n-th prime^2))/4.	nonn,easy,synth	1..21
A138444	null	a(n) = ((n-th prime)^6-(n-th prime^2))/5.	nonn,easy,synth	1..22
A138445	null	a(n) = ((n-th prime)^6-(n-th prime^2))/6.	nonn,easy,synth	1..22
A138446	null	a(n) = ((n-th prime)^6-(n-th prime^2))/10.	nonn,easy,	1..1000
A138447	null	a(n) = ((n-th prime)^6-(n-th prime^2))/12.	nonn,easy,synth	1..23
A138448	null	a(n) = (prime(n)^6-prime(n)^2)/15.	nonn,easy,synth	1..23
A138450	null	a(n) = ((n-th prime)^6-(n-th prime^2))/30.	nonn,easy,changed,synth	1..24
A138451	null	a(n) = (prime(n)^6-prime(n)^2)/60.	nonn,easy,less,	1..1000
A138452	null	a(n) = ((n-th prime)^6-(n-th prime)^3))/2.	nonn,easy,	1..1000
A138453	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/2.	nonn,easy,synth	1..21
A138454	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/3.	nonn,easy,changed,	1..1000
A138455	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/4.	nonn,easy,synth	1..21
A138456	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/6.	nonn,easy,synth	1..22
A138457	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/8.	nonn,easy,synth	1..22
A138458	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/24.	nonn,easy,synth	1..23
A138459	null	a(n) = ((n-th prime)^6-(n-th prime)^4))/12.	nonn,easy,synth	1..23
A138460	null	a(n) = ((n-th prime)^6-(n-th prime)^5))/2.	nonn,easy,synth	1..21
