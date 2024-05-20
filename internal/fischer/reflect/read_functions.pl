#!perl

# Read joeis/src/irvine/math/function/Funcions.java and extract the corresponding A-numbers
# @(#) $Id$
# 2024-05-17, Georg Fischer: copied from packex.pl
#
#:# Usage:
#:#   perl read_functions.pl [-d debug] infile.java > outfile.gen
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $mode = "u";
my $debug = 0;
my $callcode = "functions";
my $offset = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $aseqno;
my $parm;
my ($varph1, varph2) = ("_V1", "_V2"); # 1st and 2nd placeholder for parameters
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if ($line =~ m{\/\/ *\= *(A\d+.*)}) {
        my $list = $1;
        $list =~ s{ |\;.*}{}g;
        if ($line =~ m{Function(\d) +([A-Z0-9_]+)}) {
            my ($ifunc, $static) = ($1, $2);
            if ($ifunc == 1) {
                $aseqno = $list;
                print join("\t", $aseqno, "Functions.$static.z($varph1)", "Functions.$static.i($varph1)") . "\n";
            } else {
                foreach my $seq (split(/\=/, $list)) {
                    ($aseqno, $parm) = split(/\(/, $seq);
                    print join("\t", $aseqno, , "Functions.$static.z(${parm} $varph1)", "Functions.$static.i(${parm} $varph1)") . "\n";
                }
            }
        } else {
            print "2: $line\n" if $debug >= 1;
        }
    } else {
        print "1: $line\n" if $debug >= 1;
    }
} # while <>
exit(0);
my $dummy = <<'GFis';
  public static final Function1 PARTITIONS = new Partitions(); // =A000041
  /** Next power of two larger than the given number. */
  public static final Function1 NEXT_POWER_OF_2 = new NextPowerOf2(); // =A062383

  /** Reverse the digits of a number. */
  public static final Function2 REVERSE = new Reverse(); // =A004086(10, =A305989(2,
  /** Number of digits in a number. */
GFis
__DATA__
A003986	func2	_V1.or(_V2)
A003987	func2	_V1.xor(_V2)
A004198	func2	_V1.and(_V2)

A000001	knowna	13		/* A000001 */ Z.valueOf(GroupFactory.smallGroups(v.intValueExact()).size())	Number of groups of order n.
A000002	knowna	5		Kolakoski sequence: a(n) is length of n-th run; a(1) = 1; sequence consists just of 1''s and 2''s.
A000005	knowna	47	Jaguar.factor(v).sigma0()	d(n) (also called tau(n) or sigma_0(n)), the number of divisors of n.
A000009	knowna	11		Expansion of Product_{m >= 1} (1 + x^m); number of partitions of n into distinct parts; number of partitions of n into odd parts.
A000010	knowna	23	Euler.phi(v)	Euler totient function phi(n): count numbers <= n and prime to n.
A000030	knowna	19	Z.valueOf(v.toString().charAt(0) - '0')	Initial digit of n.
A000032	knowna	10	Fibonacci.lucas(v.intValueExact())	Lucas numbers beginning at 2: L(n) = L(n-1) + L(n-2), L(0) = 2, L(1) = 1.
A000035	knowna	13	v.testBit(0) ? Z.ONE : Z.ZERO	Period 2: repeat [0, 1]; a(n) = n mod 2; parity of n.
A000040	knowna	54	Puma.primeZ(v.intValueExact())	The prime numbers.
A000041	knowna	55	IntegerPartition.partitions(v.intValueExact())	a(n) is the number of partitions of n (the partition numbers).
A000045	knowna	14	Fibonacci.fibonacci(v.intValueExact())	Fibonacci numbers: F(n) = F(n-1) + F(n-2) with F(0) = 0 and F(1) = 1.
A000085	knowna	9	IntegerPartition.numStandardYoungTableaux(v.intValueExact())	Number of self-inverse permutations on n letters, also known as involutions; number of standard Young tableaux with n cells.
A000108	knowna	19	{ final int n = v.intValueExact(); return Binomial.binomial(2*n, n).divide(n + 1); }	Catalan numbers: C(n) = binomial(2n,n)/(n+1) = (2n)!/(n!(n+1)!).
A000110	knowna	32	Bell.bell(v.intValueExact())	Bell or exponential numbers: number of ways to partition a set of n labeled elements.
A000120	knowna	13	Z.valueOf(v.bitCount())	1''s-counting sequence: number of 1''s in binary expansion of n (or the binary weight of n).
A000142	knowna	21	MemoryFactorial.SINGLETON.factorial(v.intValueExact())	Factorial numbers: n! = 1*2*3*4*...*n (order of symmetric group S_n, number of permutations of n letters).
A000188	knownd	8		(1) Number of solutions to x^2 == 0 (mod n). (2) Also square root of largest square dividing n. (3) Also max_{ d divides n } gcd(d, n/d).
A000196	knowna	11	v.sqrt()	Integer part of square root of n. Or, number of positive squares <= n. Or, n appears 2n+1 times.
A000201	knowna	7		Lower Wythoff sequence (a Beatty sequence): a(n) = floor(n*phi), where phi = (1+sqrt(5))/2 = A001622.
A000203	knowna	24	Jaguar.factor(v).sigma()	a(n) = sigma(n), the sum of the divisors of n. Also called sigma_1(n).
A000217	knowna	29	v.multiply(v.add(1)).divide(2)	Triangular numbers: a(n) = binomial(n+1,2) = n*(n+1)/2 = 0 + 1 + 2 + ... + n.
A000225	knowna	5	Z.TWO.pow(v.intValueExact()).subtract(1)	a(n) = 2^n - 1. (Sometimes called Mersenne numbers, although that name is usually reserved for A001348.)
A000265	knowna	29	v.makeOdd()	Remove all factors of 2 from n; or largest odd divisor of n; or odd part of n.
A000290	knowna	7	v.square()		The squares: a(n) = n^2.
A000593	knownd	7		Sum of odd divisors of n.
A000688	knowna	7		Number of Abelian groups of order n; number of factorizations of n into prime powers.
A000720	knowna	78	Puma.primePiZ(v)		pi(n), the number of primes <= n. Sometimes called PrimePi(n) to distinguish it from the number 3.14159...
A000796	knowna	8		Decimal expansion of Pi (or digits of Pi).
A001045	knowna	0	new Q(Z.TWO.pow(v.intValueExact()), Z.THREE).round()
A001055	knowna	9		The multiplicative partition function: number of ways of factoring n with all factors greater than 1 (a(1) = 1 by convention).
A001065	knowna	11	Jaguar.factor(v).sigma().subtract(v)	Sum of proper divisors (or aliquot parts) of n: sum of divisors of n that are less than n.
A001157	knowna	4	Jaguar.factor(v).sigma(2)	
A001158	knowna	1	Jaguar.factor(v).sigma(3)	
A001177	knowna	5		Fibonacci entry points: a(n) = least k >= 1 such that n divides Fibonacci number F_k (=A000045(k)).
A001221	knowna	28	Z.valueOf(Jaguar.factor(v).omega())	Number of distinct primes dividing n (also called omega(n)).
A001222	knowna	25	Z.valueOf(Jaguar.factor(v).bigOmega())	Number of prime divisors of n counted with multiplicity (also called big omega of n, bigomega(n) or Omega(n)).
A001223	knowna	0	Puma.primeZ(v.add(1)).subtract(Puma.primeZ(v))	Prime gaps: differences between consecutive primes
A001227	knownd	25		Number of odd divisors of n 
A001358	knowna	10		Semiprimes (or biprimes): products of two primes.
A001359	knowna	5		Lesser of twin primes.
A001414	knownd	7	Jaguar.factor(v).sopfr()	Integer log of n: sum of primes dividing n (with repetition). Also called sopfr(n).
A001511	knowna	7	Z.valueOf(ZUtils.valuation(v.multiply2(), 2))		The ruler function: 2^a(n) divides 2n. Or, a(n) = 2-adic valuation of 2n.
A001615	knowna	0	A001615.dedekindPsi(v.intValueExact())	
A001951	knownd	7		A Beatty sequence: a(n) = floor(n*sqrt(2)).
A001952	knownd	7		A Beatty sequence: a(n) = floor(n*(2 + sqrt(2))).
A002110	knowna	17	ZUtils.primorial(v.longValueExact())	Primorial numbers (first definition): product of first n primes. Sometimes written prime(n)#.
A002182	knowna	6		Highly composite numbers, definition (1): numbers n where d(n), the number of divisors of n (A000005), increases to a record.
A002275	known	0	(10^n-1)/9
A002322	knownd	7	Carmichael.lambda(v)	Reduced totient function psi(n): least k such that x^k == 1 (mod n) for all x prime to n; also known as the Carmichael lambda function (exponent of unit group mod n); also called the universal exponent of n.
A002326	knowna	7	IntegersMod(v).ord(Z.TWO.mod(v))	Multiplicative order of 2 mod 2n+1.
A002487	knowna	19	{ final int n = v.intValueExact(); return Integers.SINGLETON.sum(0, n - 1, k -> Binomial.binomial(k, n - k - 1).testBit(0) ? Z.ONE : Z.ZERO); }	Stern''s diatomic series (or Stern-Brocot sequence): a(0) = 0, a(1) = 1; for n > 0: a(2*n) = a(n), a(2*n+1) = a(n) + a(n+1).
A002808	knowna	8		The composite numbers: numbers n of the form x*y for x > 1 and y > 1.
A003188	knowna	7	v.xor(v.divide2())	Decimal equivalent of Gray code for n.
A003285	knownd	6		Period of continued fraction for square root of n (or 0 if n is a square).
A003415	knownd	12		a(n) = n'' = arithmetic derivative of n: a(0) = a(1) = 0, a(prime) = 1, a(m*n) = m*a(n) + n*a(m).
A003418	knowna	5		Least common multiple (or LCM) of {1, 2, ..., n} for n >= 1, a(0) = 1.
A003557	knownd	6		n divided by largest squarefree divisor of n; if n = Product p(k)^e(k) then a(n) = Product p(k)^(e(k)-1), with a(1) = 1.
A003958	knowna	7		If n = Product p(k)^e(k) then a(n) = Product (p(k)-1)^e(k).
A003961	knownd	15		Completely multiplicative with a(prime(k)) = prime(k+1).
A003963	knowna	5		Fully multiplicative with a(p) = k if p is the k-th prime.
A003987	knowna	6		Table of n XOR m (or Nim-sum of n and m) read by antidiagonals with m>=0, n>=0.
A004001	knownm	12		Hofstadter-Conway $10000 sequence: a(n) = a(a(n-1)) + a(n-a(n-1)) with a(1) = a(2) = 1.
A004086	knowna	10	ZUtils.reverse(v)	Read n backwards (referred to as R(n) in many sequences).
A004186	known	0	Functions.DIGIT_SORT_DESCENDING.z
A004185	known	0	Functions.DIGIT_SORT_ASCENDING.z
A005117	knowna	7		Squarefree numbers: numbers that are not divisible by a square greater than 1.
A005179	knowna	5		Smallest number with exactly n divisors.
A005259	knowna	7	{ final int n = v.intValueExact(); return Integers.SINGLETON.sum(0, n, k -> Binomial.binomial(n, k).multiply(Binomial.binomial(n + k, k)).square()); }	Apery (Ap√©ry) numbers: Sum_{k=0..n} (binomial(n,k)*binomial(n+k,k))^2.
A005361	knownd	5		Product of exponents of prime factorization of n.
A005940	knownd	10		The Doudna sequence: write n-1 in binary; power of prime(k) in a(n) is # of 1''s that are followed by k-1 0''s.
A006068	knownd	6		a(n) is Gray-coded into n.
A006519	knowna	7	Z.valueOf(ZUtils.valuation(v, Z.TWO))	Highest power of 2 dividing n. Integer.lowestOneBit(n)
A006530	knowna	27	Jaguar.factor(v).largestPrimeFactor()	 greatest prime dividing n, for n >= 2; a(1)=1.
A006577	knowna	10		Number of halving and tripling steps to reach 1 in ''3x+1'' problem, or -1 if 1 is never reached.
A006882	knowna	5	MemoryFactorial.SINGLETON.doubleFactorial(v.intValueExact())	Double factorials n!!: a(n) = n*a(n-2) for n > 1, a(0) = a(1) = 1.
A007088	knowna	6	new Z(Z.toString(2))		The binary numbers (or binary words, or binary vectors, or binary expansion of n): numbers written in base 2.
A007504	knownd	16		Sum of the first n primes.
A007539	knowna	5		a(n) = first n-fold perfect (or n-multiperfect) number.
A007623	knownd	0		factorial base representation
A007814	knowna	44	Z.valueOf(ZUtils.valuation(v, Z.TWO))	Exponent of highest power of 2 dividing n, a.k.a. the binary carry sequence, the ruler sequence, or the 2-adic valuation of n.
A007895	knowna	6		Number of terms in the Zeckendorf representation of n (write n as a sum of non-consecutive distinct Fibonacci numbers).
A007913	knowna	5	Jaguar.factor(v).core()	Squarefree part of n: a(n) is the smallest positive number m such that n/m is a square.
A007918	knowna	15	v.isProbablePrime() ? v : Puma.primeZ(Puma.primePi(v) + 1)	Least prime >= n (version 1 of the "next prime" function).
A007947	knowna	13	Jaguar.factor(v).squareFreeKernel()	Largest squarefree number dividing n: the squarefree kernel of n, rad(n), radical of n.
A007949	knowna	14	Z.valueOf(ZUtils.valuation(v, Z.THREE))	Greatest k such that 3^k divides n. Or, 3-adic valuation of n.
A007953	knowna	10	Z.valueOf(ZUtils.digitSum(v))	Digital sum (i.e., sum of digits) of n; also called digsum(n).
A007954	knowna	7	ZUtils.digitProduct(v)	Product of decimal digits of n.
A007955	knowna	1	Jaguar.factor(v).pod()	Product of divisors
A008284	knowna	5		Triangle of partition numbers: T(n,k) = number of partitions of n in which the greatest part is k, 1 <= k <= n. Also number of partitions of n into k positive parts, 1 <= k <= n.
A008472	knowna	11	Jaguar.factor(v).sopf()	Sum of the distinct primes dividing n.
A008475	knownd	5		If n = Product (p_j^k_j) then a(n) = Sum (p_j^k_j) (a(1) = 0 by convention).
A008578	knowna	6	{ final int n = v.intValueExact(); return (n == 1) ? Z.ONE : Puma.primeZ(n + 1); }	Prime numbers at the beginning of the 20th century (today 1 is no longer regarded as a prime).
A008683	knowna	1	Z.valueOf(Jaguar.factor(v).mobius())	Moebius mu function
A00836	knownd	0		Liouville lambda
A008908	knowna	6		(1 + number of halving and tripling steps to reach 1 in the Collatz (3x+1) problem), or -1 if 1 is never reached.
A008966	knownd	0	Jaguar.factor(v).isSquareFree() ? Z.ONE : Z.ZERO
A010051	knowna	8	v.isProbablePrime() ? Z.ONE : Z.ZERO	Characteristic function of primes: 1 if n is prime, else 0.
A010060	knowna	5		Thue-Morse sequence: let A_k denote the first 2^k terms; then A_0 = 0 and for k >= 0, A_{k+1} = A_k B_k, where B_k is obtained from A_k by interchanging 0''s and 1''s.
A010786	knownd	0		Floor-factorial numbers: a(n) = Product_{k=1..n} floor(n/k).
A010873	knowna	6	v.mod(Z.FOUR)	a(n) = n mod 4.
A010888	knowna	13	{ final int ni = v.intValueExact(); return ni == 0 ? Z.ZERO : Z.valueOf(1 + (ni + 8) % 9); }	Digital root of n (repeatedly add the digits of n until a single digit is reached).
A013632	knownd	7	Puma.nextPrimeZ(v).subtract(v)	Difference between n and the next prime greater than n.
A013928	knownd	7	Integers.SINGLETON.sum(1, v.intValueExact() - 1, k -> Jaguar.factor(v).isSquareFree() ? Z.ONE : Z.ZERO)	Integers.SINGLETON.sum(1, n - 1, k -> LongUtils.isSquareFree(n) ? Z.ONE : Z.ZERO)	Number of (positive) squarefree numbers < n.
A019565	knownd	5		The squarefree numbers ordered lexicographically by their prime factorization (with factors written in decreasing order). a(n) = Product_{k in I} prime(k+1), where I is the set of indices of nonzero binary digits in n = Sum_{k in I} 2^k.
A020338	knowna	5	{ String s = v.toString(); return new Z(s + s); }	Doublets: base-10 representation is the juxtaposition of two identical strings.
A020639	knowna	19	Jaguar.factor(v).leastPrimeFactor()	Lpf(n): least prime dividing n (when n > 1); a(1) = 1. Or, smallest prime factor of n, or smallest prime divisor of n.
A032742	knowna	9	{ final Z[] divisors = Jaguar.factor(v).divisorsSorted(); return divisors[divisors.length - 2]; }	a(1) = 1; for n > 1, a(n) = largest proper divisor of n (that is, for n>1, maximum divisor d of n in range 1 <= d < n).
A033879	knownd	0		x
A033999	knownd	0	(((n & 1) == 1) ? Z.NEG_ONE : Z.ONE	(-1)^n
A034444	knowna	0	Jaguar.factor(v).unitarySigma0()	usigma(n) = sum of unitary divisors of n (divisors d such that gcd(d, n/d)=1); also called UnitarySigma(n).
A034448	knowna	7	Jaguar.factor(v).unitarySigma()	usigma(n) = sum of unitary divisors of n (divisors d such that gcd(d, n/d)=1); also called UnitarySigma(n).
A046523	knowna	0	FactorUtils.leastPrimeSignature(v)
A048385	knownd	5		In base-10 notation replace digits of n with their squared values (Version 1).
A048673	knowna	6		Permutation of natural numbers: a(n) = (A003961(n)+1) / 2 [where A003961(n) shifts the prime factorization of n one step towards larger primes].
A048675	knownd	12		If n = p_i^e_i * ... * p_k^e_k, p_i < ... < p_k primes (with p_i = prime(i)), then a(n) = (1/2) * (e_i * 2^i + ... + e_k * 2^k).
A049084	knowna	8	Z.valueOf(Puma.primePi(v)).isProbablePrime() ? Z.ONE : Z.ZERO	a(n) = pi(n) if n is prime, otherwise 0.
# A049345	knownd	9		n written in primorial base.
A049501	knownd	9		Major index of n, first definition.
A049502	knownd	9		Major index of n, 2nd definition.
A051903	knowna	9	Z.valueOf(Jaguar.factor(v).maxExponent())	Maximal exponent in prime factorization of n.
A053735	knowna	7	Z.valueOf(ZUtils.digitSum(v, 3))	Sum of digits of (n written in base 3).
A054429	knowna	6		Simple self-inverse permutation of natural numbers: List each block of 2^n numbers (from 2^n to 2^(n+1) - 1) in reverse order.
A055396	knowna	5		Smallest prime dividing n is a(n)-th prime (a(1)=0).
A055642	knowna	27	Z.valueOf(v.toString().length())	Number of digits in the decimal expansion of n.
A055881	knownd	6		a(n) = largest m such that m! divides n.
A056239	knownd	9		If n = Product_{k >= 1} (p_k)^(c_k) where p_k is k-th prime and c_k >= 0 then a(n) = Sum_{k >= 1} k*c_k.
A056737	knowna	7		Minimum nonnegative integer m such that n = k*(k+m) for some positive integer k.
A057427	knowna	0	(n == 0) ? Z.ZERO : Z.ONE
A060854	knowna	7		Array T(m,n) read by antidiagonals: T(m,n) (m >= 1, n >= 1) = number of ways to arrange the numbers 1,2,...,m*n in an m X n matrix so that each row and each column is increasing.
A061395	knowna	5	v.equals(Z.ONE) ? Z.ZERO : Puma.primePiZ(Jaguar.factor(v).largestPrimeFactor())	Let p be the largest prime factor of n; if p is the k-th prime then set a(n) = k; a(1) = 0 by convention.
A062731	knowna	0	Jaguar.factor(v.multiply2()).sigma()	sigma(2*n)
A064097	knowna	8		A quasi-logarithm defined inductively by a(1) = 0 and a(p) = 1 + a(p-1) if p is prime and a(n*m) = a(n) + a(m) if m,n > 1.
A064989	knowna	28		Multiplicative with a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p.
A065547	knowna	8		Triangle of Salie numbers.
A078008 knowna	0	Z.TWO.pow(n).add(Z.NEG_ONE.pow(n).multiply2()).divide(3)
A079216	knowna	5		Square array A(n>=0,k>=1) (listed antidiagonally: A(0,1)=1, A(1,1)=1, A(0,2)=1, A(2,1)=2, A(1,2)=1, A(0,3)=1, A(3,1)=3, ...) giving the number of n-edge general plane trees fixed by k-fold application of Catalan Automorphisms A057511/A057512 (Deep rotation of general parenthesizations/plane trees).
A091137	knowna	5		Largest number m such that number of times m divides k! is almost k/n for large k, i.e., largest m with A090624(m)=n.
A121548	knowna	10		Triangle read by rows: T(n,k) is the number of compositions of n into k Fibonacci numbers (1 <= k <= n; only one 1 is considered as a Fibonacci number).
A142458	knowna	6		Triangle T(n,k) read by rows: T(n,k) = 1 if k=1 or k=n, otherwise T(n,k) = (3*n-3*k+1)*T(n-1,k-1) + (3*k-2)*T(n-1,k).
A146075	knownd	7		Sum of even divisors of n.
A151799	knowna	8	Puma.primeZ(Puma.primePi(v) - 1)	Version 2 of the "previous prime" function: largest prime < n.
A151800	knowna	17	Puma.primeZ(Puma.primePi(v) + 1)	Least prime > n (version 2 of the "next prime" function).
A151899	knowna	0	Z.valueOf((new int[] {0,0,1,1,1,2})[v.mod(6)])
A181819	knownd	0		x
A183063	knownd	7		Number of even divisors of n.
A254049	knownd	0		x
A278219	knownd	0		x
A278222	knownd	9		The least number with the same prime signature as A005940(n+1).
A289813	knownd	0	new Z(v.toString(3).replace('2', '0'), 2)	
A289814	knownd	0	new Z(v.toString(3).replace('1', '0').replace('2', '1'), 2)	
A291770	knowna	0	new Z(v.toString(3).replace('0', '_').replaceAll("[12]", "0").replace('_', '1'), 2)
A319356	knownd	0		x
A319692	knownd	0		x
A338754	knownd	0	new Z(String.valueOf(n).replaceAll("(\\d)", "$1$1"))	duplicate all digits