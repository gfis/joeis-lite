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
A045532	nthprime	1	new Z(String.valueOf(mN) + mNP.toString())				Concatenate n with n-th prime.	nonn,base,changed,	00104729	10000	Concatenate n with n-th prime.
# A046883	nthprimf	1	mNP.toString().endsWith(String.valueOf(mN))				Automorphic primes: primes p such that p is k-th prime and p ends in k.	base,nice,nonn,synth	76080181	12	Automorphic primes: primes p such that p is k-th prime and p ends in k.
A045532	nthprime	1	new Z(String.valueOf(mN) + mNP.toString())				Concatenate n with n-th prime.	nonn,base,changed,	00104729	10000	Concatenate n with n-th prime.
A051102	nthprime	1	CR.valueOf(mNP).exp().floor()	~~import irvine.~~math.cr.CR;			Floor of exp(n-th prime).	nonn,changed,	37573265	100	Floor of exp(n-th prime).
A051156	nthprime	1	Z.TWO.pow(mNP.pow(2)).subtract(Z.ONE).divide(Z.TWO.pow(mNP).subtract(Z.ONE))				a(n) = (2^p^2 - 1)/(2^p - 1) where p is the n-th prime.	nonn,easy,changed,synth	26218241	7	a(n) = (2^p^2 - 1)/(2^p - 1) where p is the n-th prime.
A051157	nthprime	1	(Z.TWO.pow(mNP.pow(3)).subtract(Z.ONE)).divide(Z.TWO.pow(mNP.pow(2)).subtract(Z.ONE))				a(n) = (2^p^3 - 1)/(2^p^2 - 1) where p = n-th prime.	nonn,easy,changed,synth	27220737	4	a(n) = (2^p^3 - 1)/(2^p^2 - 1) where p = n-th prime.
A053666	nthprime	1	ZUtils.digitProduct(mNP)	~~import irvine.~~math.z.ZUtils;			Product of digits of n-th prime.	nonn,base,easy,	567	1000	Product of digits of n-th prime.
A060019	nthprime	1	CR.TWO.multiply(CR.valueOf(mNP.subtract(Z.TWO)).sqrt()).floor()	~~import irvine.~~math.cr.CR;				a(n) = floor(2*sqrt(prime(n)-2)) where prime(n) = n-th prime.	nonn,synth	35	a(n) = floor(2*sqrt(prime(n)-2)) where prime(n) = n-th prime.
A060417	nthprime	1	Z.valueOf(count)	~~import irvine.~~math.z.ZUtils;		~~    ~~int count = 0; int[] dc = ZUtils.digitCounts(mNP,10);~~int k = 9;~~while (k >= 0) {~~  if (dc[k] > 0) {~~    ++count;~~  }~~--k;~~}	Number of different decimal digits in n-th prime.	base,easy,nonn,	6	10000	Number of different decimal digits in n-th prime.
A060418	nthprime	1	Z.valueOf(k)	~~import irvine.~~math.z.ZUtils;		~~    ~~int[] dc = ZUtils.digitCounts(mNP,10);~~int k = 9;~~while (dc[k] == 0 && k >= 0) {~~  --k;~~}	Largest decimal digit in n-th prime.	base,easy,nonn,	9	78498	Largest decimal digit in n-th prime.
A061028	nthprime	1	Z.valueOf(mN).pow(mNP).subtract(Z.valueOf(mN - 1).pow(mNP))				a(n) = n^p - (n-1)^p, where p is the n-th prime.	nonn,	43075871	95	a(n) = n^p - (n-1)^p, where p is the n-th prime.
A061227	nthprime	0	mNP.add(ZUtils.reverse(mNP))	~~import irvine.~~math.z.ZUtils;			a(n) = p + R{p} where R{p} is the digit reversal of n-th prime p.	nonn,base,look,changed,	15224	1000	a(n) = p + R{p} where R{p} is the digit reversal of n-th prime p.
A061591	nthprime	1	Z.TWO.pow(mNP.multiply(mNP.subtract(Z.ONE)).divide(Z.TWO))				a(n) = 2^x, where x = p*(p-1)/2 and p is the n-th prime.	nonn,	03172352	22	a(n) = 2^x, where x = p*(p-1)/2 and p is the n-th prime.
A063482	nthprime	1	mNP.multiply(mNP.mod(Z.TEN))				p(n) * last digit of p(n) where p(n) is n-th prime.	base,nonn,	71271	1000	p(n) * last digit of p(n) where p(n) is n-th prime.
A064799	nthprime	1	mNP.add(mCompos.next())	~~import irvine.oeis.~~Sequence;~~a002.A002808;	protected final Sequence mCompos = new A002808();		Sum of n-th prime number and n-th composite number.	nonn,easy,	9116	1000	Sum of n-th prime number and n-th composite number.
A065073	nthprime	1	mNP.add(Z.valueOf(ZUtils.digitSum(mNP)))	~~import irvine.~~math.z.ZUtils;			n-th prime + sum of digits of n-th prime.	nonn,base,easy,	7945	1000	n-th prime + sum of digits of n-th prime.
A065859	nthprime	1	mNP.remainder(mCompos.next())	~~import irvine.oeis.~~Sequence;~~a002.A002808;	protected final Sequence mCompos = new A002808();		Remainder when the n-th prime is divided by the n-th composite number.	nonn,	737	1000	Remainder when the n-th prime is divided by the n-th composite number.
A065870	nthprime	1	mNP.subtract(mSemis.next())	~~import irvine.oeis.~~Sequence;~~a001.A001358;	protected final Sequence mSemis = new A001358();		n-th prime - n-th semiprime.	easy,sign,	4324	1000	n-th prime - n-th semiprime.
A066936	nthprimf	1	mNP.subtract(Z.ONE).mod(mEulerPhi.next()).equals(Z.ZERO)	~~import irvine.oeis.~~Sequence;~~a000.A000010;	protected final Sequence mEulerPhi = new A000010();		Integers k such that prime(k)-1 == 0 (mod phi(k)) where prime(n)=A000040(n) is the n-th prime and phi(n)=A000010(n) is the Euler totient function.	nonn,changed,	9747619	94	Integers k such that prime(k)-1 == 0 (mod phi(k)) where prime(n)=A000040(n) is the n-th prime and phi(n)=A000010(n) is the Euler totient function.
A067087	nthprime	1	new Z(mNP.toString() + ZUtils.reverse(mNP).toString())	~~import irvine.~~math.z.ZUtils;			Concatenation of n-th prime and its reverse.	easy,nonn,base,	79199197	1000	Concatenation of n-th prime and its reverse.
A067563	nthprime	1	mNP.multiply(mCompos.next())	~~import irvine.oeis.~~Sequence;~~a002.A002808;	protected final Sequence mCompos = new A002808();		Product of n-th prime number and n-th composite number.	easy,nonn,changed,	91187646	10000	Product of n-th prime number and n-th composite number.
A067614	nthprime	1	CR.ONE.divide(sqNP.subtract(CR.valueOf(sqNP.floor()))).floor()	~~import irvine.~~math.cr.CR;		CR sqNP = CR.valueOf(mNP).sqrt();	floor(1/(sqrt(prime(n))-floor(sqrt(prime(n))))), where prime(n) is the n-th prime.	nonn,synth	1	99	floor(1/(sqrt(prime(n))-floor(sqrt(prime(n))))), where prime(n) is the n-th prime.
A067928	nthprimf	1	mNP.toString().startsWith(String.valueOf(mK))				Numbers n such that the digits of the n-th prime begin with n.	base,more,nonn,synth	6466	6	Numbers n such that the digits of the n-th prime begin with n.
A068395	nthprime	1	mNP.subtract(Z.valueOf(ZUtils.digitSum(mNP)))	~~import irvine.~~math.z.ZUtils;			a(n) = n-th prime minus its sum of digits.	nonn,nice,base,	104706	10000	a(n) = n-th prime minus its sum of digits.
A068396	nthprime	1	mNP.subtract(ZUtils.reverse(mNP))	~~import irvine.~~math.z.ZUtils;			n-th prime minus its reversal.	sign,base,nice,look,	-822672	10000	n-th prime minus its reversal.
A069547	nthprime	1	Z.valueOf(mN).pow(2).mod(mNP)				n^2 mod n-th prime.	nonn,	88534	10000	n^2 mod n-th prime.
A070750	nthprime	1	mN == 1 ? Z.ZERO : (mNP.mod(Z.FOUR).equals(Z.ONE) ? Z.ONE : Z.NEG_ONE)				0 if n-th prime is even, 1 if n-th prime is == 1 mod 4, and -1 if n-th prime is == 3 mod 4.	sign,nice,easy,changed,	1	10000	0 if n-th prime is even, 1 if n-th prime is == 1 mod 4, and -1 if n-th prime is == 3 mod 4.
A070883	nthprime	1	mNP.xor(Z.valueOf(mN))				Bitwise XOR of n and n-th prime.	nonn,look,	114185	10000	Bitwise XOR of n and n-th prime.
A071089	nthprime	1	mPrimSum.next().remainder(mNP)	~~import irvine.oeis.~~Sequence;~~a007.A007504;	~~  ~~protected final Sequence mPrimSum = new A007504();~~public A071089() {~~  mPrimSum.next();~~}		Remainder when sum of first n primes is divided by n-th prime.	easy,nonn,changed,	64138	10000	Remainder when sum of first n primes is divided by n-th prime.
A071168	nthprime	1	mNP.mod(mPhi.next())	~~import irvine.oeis.~~Sequence;~~a000.A000010;	protected final Sequence mPhi = new A000010();		n-th prime reduced modulo phi(n).	nonn,easy,look,	729	10000	n-th prime reduced modulo phi(n).
A071170	nthprime	1	mNP.mod(mSigma.next())	~~import irvine.oeis.~~Sequence;~~a000.A000203;	protected final Sequence mSigma = new A000203();		n-th prime reduced modulo sigma[n].	nonn,synth	7	75	n-th prime reduced modulo sigma[n].
A071259	nthprime	1	CR.valueOf(mNP).add(CR.valueOf(mCompos.next())).divide(CR.TWO).floor()	~~import irvine.~~math.cr.CR;~~oeis.a002.A002808;	protected final Sequence mCompos = new A002808();			Integer part of the arithmetic mean of the n-th prime p(n) and the n-th composite number C(n).	nonn,	12615	Integer part of the arithmetic mean of the n-th prime p(n) and the n-th composite number C(n).
A071260	nthprime	0	CR.valueOf(mNP).multiply(CR.valueOf(mCompos.next())).sqrt().floor()	~~import irvine.~~math.cr.CR;~~oeis.a002.A002808;	protected final Sequence mCompos = new A002808();			Integer part of the geometric mean of the n-th prime prime(n) and the n-th composite number C(n).	nonn,	3081	Integer part of the geometric mean of the n-th prime prime(n) and the n-th composite number C(n).
A072003	nthprime	1	Z.TEN.subtract(mNP.mod(Z.TEN))				10's complement of final digit of n-th prime.	nonn,base,synth	9	105	10's complement of final digit of n-th prime.
A072004	nthprime	1	mPsqSum.next().remainder(mNP)	~~import irvine.oeis.~~Sequence;~~a024.A024450;	~~  ~~protected final Sequence mPsqSum = new A024450();		Remainder when sum of squares of first n primes is divided by n-th prime.	easy,nonn,synth	287	65	Remainder when sum of squares of first n primes is divided by n-th prime.
A072577	nthprimf	1	ZUtils.digitCounts(Z.valueOf(mK), 2)[0] == ZUtils.digitCounts(mNP, 2)[0]	~~import irvine.~~math.z.ZUtils;			Numbers n such that n and the n-th prime have the same number of 0's in their binary representation.	nonn,synth	337	56	Numbers n such that n and the n-th prime have the same number of 0's in their binary representation.
A072578	nthprimf	1	ZUtils.digitCounts(Z.valueOf(mK), 2)[0] == ZUtils.digitCounts(mNP, 2)[1]	~~import irvine.~~math.z.ZUtils;			In binary representation: n has the same number of 0's as the n-th prime has 1's.	nonn,	12619	1000	In binary representation: n has the same number of 0's as the n-th prime has 1's.
A072579	nthprimf	1	ZUtils.digitCounts(Z.valueOf(mK), 2)[1] == ZUtils.digitCounts(mNP, 2)[0]	~~import irvine.~~math.z.ZUtils;			In binary representation: n has the same number of 1's as the n-th prime has 0's.	nonn,synth	292	56	In binary representation: n has the same number of 1's as the n-th prime has 0's.
A072583	nthprimf	1	p0 != k0 && p0 != k1 && p1 != k0 && p1 != k1	~~import irvine.~~math.z.ZUtils;		~~ ~~int p0 = ZUtils.digitCounts(mNP, 2)[0];~~int p1 = ZUtils.digitCounts(mNP, 2)[1];~~int k0 = ZUtils.digitCounts(Z.valueOf(mK), 2)[0];~~int k1 = ZUtils.digitCounts(Z.valueOf(mK), 2)[1];	Numbers n with property that there is no match when comparing the 0's and the 1's of n and the n-th prime in their binary representations.	nonn,synth	133	63	Numbers n with property that there is no match when comparing the 0's and the 1's of n and the n-th prime in their binary representations.
A072694	nthprime	1	mPrimor.next().pow(mNP)	~~import irvine.oeis.~~Sequence;~~a002.A002110;	protected final Sequence mPrimor = new A002110();		(p(n)#)^p(n), or n-th primorial raised to n-th prime power.	easy,nonn,synth	00000000	6	(p(n)#)^p(n), or n-th primorial raised to n-th prime power.
A073779	nthprime	1	Z.valueOf(ZUtils.digitCounts(mNP, 3)[0])	~~import irvine.~~math.z.ZUtils;			Number of 0's in base-3 representation of n-th prime.	base,easy,nonn,	1	10000	Number of 0's in base-3 representation of n-th prime.
A073780	nthprime	1	Z.valueOf(ZUtils.digitCounts(mNP, 3)[1])	~~import irvine.~~math.z.ZUtils;			Number of 1's in base 3 representation of n-th prime.	base,easy,nonn,	3	1000	Number of 1's in base 3 representation of n-th prime.
A073781	nthprime	1	Z.valueOf(ZUtils.digitCounts(mNP, 3)[2])	~~import irvine.~~math.z.ZUtils;			Number of 2's in base-3 representation of n-th prime.	base,easy,nonn,	4	1000	Number of 2's in base-3 representation of n-th prime.
A074350	nthprimf	1	same	~~import irvine.~~math.z.ZUtils;		~~    ~~int[] dck = ZUtils.digitCounts(Z.valueOf(mK));~~int[] dcp = ZUtils.digitCounts(mNP);~~boolean same = true;~~int ind = 0; ~~while (same && ind < 10) {~~  same = dck[ind] > 0 && dcp[ind] > 0 || dck[ind] == 0 && dcp[ind] == 0;~~  ++ind;~~}	Numbers n such that n and the n-th prime have the same digits.	base,nonn,	770196	1000	Numbers n such that n and the n-th prime have the same digits.
A075110	nthprime	1	new Z(mNP.toString() + String.valueOf(mN))	~~import irvine.~~math.z.ZUtils;			Concatenation of n-th prime and n in decimal notation.	nonn,base,	72910000	10000	Concatenation of n-th prime and n in decimal notation.
A075146	nthprime	1	mPerfPows.next().subtract(mNP)	~~import irvine.oeis.~~Sequence;~~a001.A001597;	~~  ~~protected final Sequence mPerfPows = new A001597();			n-th perfect power - n-th prime: pp(n) - prime(n).	easy,sign,synth	1592	n-th perfect power - n-th prime: pp(n) - prime(n).
A075702	nthprimf	1	mFibos.next().remainder(mNP).equals(Z.ZERO)	~~import irvine.oeis.~~Sequence;~~a000.A000045;	~~  ~~protected final Sequence mFibos = new A000045();~~public A075702() {~~  mFibos.next();~~}			n-th prime divides the n-th Fibonacci number.	nonn,synth	24530096	n-th prime divides the n-th Fibonacci number.
A076240	nthprime	1	mPPs.next().remainder(mNP)	~~import irvine.oeis.~~Sequence;~~a006.A006450;	~~  ~~protected final Sequence mPPs = new A006450();~~public A076240() {~~  }		Remainder when 2nd order prime pp(n) = A006450(n) is divided by n-th prime = A000040(n).	nonn,look,	5184	10000	Remainder when 2nd order prime pp(n) = A006450(n) is divided by n-th prime = A000040(n).
A077345	nthprimf	1	ok		protected long mN = mK;	~~  ~~boolean ok = mNP.toString().startsWith(String.valueOf(mN + 1));~~if (ok) {~~  ++mN;~~}	a(n) is the n-th prime whose decimal expansion begins with the decimal expansion of n.	base,easy,nonn,	00005383	1000	a(n) is the n-th prime whose decimal expansion begins with the decimal expansion of n.
A078931	nthprimf	1	mNP.add(Z.ONE).remainder(Z.valueOf(mK)).equals(Z.ZERO) || mNP.subtract(Z.ONE).remainder(Z.valueOf(mK)).equals(Z.ZERO)				Numbers n such that n divides p(n)+1 or p(n)-1 where p(n) is the n-th prime.	nonn,synth	10553569	40	Numbers n such that n divides p(n)+1 or p(n)-1 where p(n) is the n-th prime.
A081227	nthprime	1	Z.valueOf(common)	~~import irvine.~~math.z.ZUtils;		~~    ~~int[] dcn = ZUtils.digitCounts(Z.valueOf(mN));~~int[] dcp = ZUtils.digitCounts(mNP);~~int common = 0;~~int ind = 0; ~~while (ind < 10) {~~  if (dcn[ind] > 0 && dcp[ind] > 0) {~~    ++common;~~}~~  ++ind;~~}		a(n) is the number of digits in common between n and the n-th prime in base 10.	base,easy,nonn,synth	2	a(n) is the number of digits in common between n and the n-th prime in base 10.
A081229	nthprime	1	sum == 0 ? Z.NEG_ONE : Z.valueOf(sum).add(mNP)	~~import irvine.~~math.z.ZUtils;		~~    ~~int[] dcn = ZUtils.digitCounts(Z.valueOf(mN));~~int[] dcp = ZUtils.digitCounts(mNP);~~int sum = 0;~~int ind = 0; ~~while (ind < 10) {~~  if (dcn[ind] > 0 && dcp[ind] > 0) {~~    sum += ind;~~}~~  ++ind;~~}		a(n) is the sum of the common digits of n and the n-th prime in base 10, or -1 if there are no common digits.	base,sign,	1	a(n) is the sum of the common digits of n and the n-th prime in base 10, or -1 if there are no common digits.
A081652	nthprime	1	Z.valueOf(mN).gcd(Z.valueOf(ZUtils.digitSum(mNP)))	~~import irvine.~~math.z.ZUtils;			Greatest common divisor of n and sum of decimal digits of n-th prime.	nonn,base,synth	4	104	Greatest common divisor of n and sum of decimal digits of n-th prime.
A081653	nthprime	1	Z.valueOf(ZUtils.digitSum(Z.valueOf(mN))).gcd(Z.valueOf(ZUtils.digitSum(mNP)))	~~import irvine.~~math.z.ZUtils;			Greatest common divisor of sums of decimal digits of n and of n-th prime.	nonn,base,synth	1	105	Greatest common divisor of sums of decimal digits of n and of n-th prime.
A084369	nthprimf	1	! mNP.toString().matches(".*[02468].*")				Numbers n such that the n-th prime number doesn't contain any even digits.	base,easy,nonn,less,synth	196	62	Numbers n such that the n-th prime number doesn't contain any even digits.
A084921	nthprime	1	mNP.subtract(Z.ONE).lcm(mNP.add(Z.ONE))				a(n) = lcm(p-1, p+1) where p is the n-th prime.	nonn,	84081720	10000	a(n) = lcm(p-1, p+1) where p is the n-th prime.
A086650	nthprime	1	mCompos.next().pow(mNP)	~~import irvine.oeis.~~Sequence;~~a002.A002808;	protected final Sequence mCompos = new A002808();		n-th composite number raised to the n-th prime number.	easy,nonn,changed,synth	15994368	10	n-th composite number raised to the n-th prime number.
A087486	nthprimf	1	Z.valueOf(ZUtils.digitSum(mNP)).mod(Z.valueOf(ZUtils.digitSum(Z.valueOf(mK)))).equals(Z.ZERO)	~~import irvine.~~math.z.ZUtils;			Numbers n such that digital sum of n divides digital sum of n-th prime, p(n).	nonn,base,synth	611	54	Numbers n such that digital sum of n divides digital sum of n-th prime, p(n).
A088135	nthprime	1	(new Z(sNP.substring(0,1))).add((new Z(sNP.substring(sNP.length() - 1))))			~~    ~~String sNP = mNP.toString();	Sum of first and last digits of n-th prime.	easy,nonn,base,synth	13	87	Sum of first and last digits of n-th prime.
A088146	nthprime	1	new Z(sNP.substring(sNP.length() - 1) + sNP.substring(0, sNP.length() - 1), 2)			~~    ~~String sNP = mNP.toString(2);	n-th prime rotated one binary place to the right.	nonn,base,look,changed,	117900	10000	n-th prime rotated one binary place to the right.
A088147	nthprime	1	new Z(sNP.substring(1, sNP.length()) + sNP.substring(0, 1), 2)			~~    ~~String sNP = mNP.toString(2);	n-th prime rotated one binary place to the left.	nonn,base,synth	151	67	n-th prime rotated one binary place to the left.
A088162	nthprime	1	new Z(sNP.substring(sNP.length() - 1) + sNP.substring(0, sNP.length() - 1), 2).subtract(new Z(sNP.substring(1, sNP.length()) + sNP.substring(0, 1), 2))			~~    ~~String sNP = mNP.toString(2);	n-th prime rotated one binary place to the right less the n-th prime rotated one binary place to the left.	nonn,synth	291	66	n-th prime rotated one binary place to the right less the n-th prime rotated one binary place to the left.
A089620	nthprime	1	Z.valueOf(mN).pow(3).add(mNP)				n^3 + n-th prime.	easy,nonn,synth	64173	40	n^3 + n-th prime.
A089621	nthprime	1	Z.valueOf(mN).pow(4).add(mNP)				n^4 + n-th prime.	easy,nonn,synth	1186058	33	n^4 + n-th prime.
A089622	nthprime	1	Z.valueOf(mN).pow(Z.valueOf(mN)).add(mNP)				a(n) = n^n + n-th prime.	easy,nonn,synth	36764236	17	a(n) = n^n + n-th prime.
A090431	nthprime	1	Z.valueOf(ZUtils.digitSum(Z.valueOf(mN))).subtract(Z.valueOf(ZUtils.digitSum(mNP)))	~~import irvine.~~math.z.ZUtils;			Difference between sums of digits of n and n-th prime.	sign,base,	-22	10000	Difference between sums of digits of n and n-th prime.
A090455	nthprime	1	Z.valueOf(Z.valueOf(mN).bitCount() - mNP.bitCount())				Difference between numbers of binary 1's of n and binary 1's of n-th prime.	sign,base,synth	-3	74	Difference between numbers of binary 1's of n and binary 1's of n-th prime.
A090605	nthprimf	1	mNP.mod(Z.valueOf(60)).equals(Z.ONE)				Numbers n such that n-th prime is of the form 60*k+1.	nonn,synth	894	52	Numbers n such that n-th prime is of the form 60*k+1.
A091020	nthprimf	1	mNP.toString(2).contains(Z.valueOf(mK).toString(2))				Numbers n such that in binary representation n is a substring of the n-th prime.	nonn,base,	99122042	62	Numbers n such that in binary representation n is a substring of the n-th prime.
A091177	nthprimf	1	mNP.mod(Z.THREE).equals(Z.TWO)				Numbers n such that the n-th prime is of the form 3k-1.	easy,nonn,synth	126	66	Numbers n such that the n-th prime is of the form 3k-1.
A091178	nthprimf	1	mNP.mod(Z.SIX).equals(Z.ONE)				Numbers n such that n-th prime is of the form 6m+1.	nonn,	2017	1000	Numbers n such that n-th prime is of the form 6m+1.
A091931	nthprime	1	new Z(mNP.toString(2).substring(1), 2)				Change the first bit to 0 in binary notation for the n-th prime.	nonn,base,easy,	3823	1000	Change the first bit to 0 in binary notation for the n-th prime.
A092257	nthprime	1	Z.valueOf(sum)			~~    ~~long sum = 0L; ~~String sNP = mNP.toString();~~for (int i = sNP.length() -1; i >= 0; --i) {~~  sum += sNP.charAt(i) + i;~~}	Sum_i [i*(i-th digit)] for n-th prime.	easy,nonn,base,synth	44	75	Sum_i [i*(i-th digit)] for n-th prime.
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
