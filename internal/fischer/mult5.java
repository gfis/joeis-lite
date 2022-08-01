A059479	mult	1
#--------> p.pow(3*e - (e & 1))
# M.w. a(p^e) = p^(3e - (e % 2)). - _Mitch Harris_, Jun 09 2005

A060839	mult	1
#----> is3(p) ? Z.valueOf(e == 1 ? 1 : 3) : (isMod(3, p, 2) ? Z.ONE : Z.THREE)
# M.w. a(3) = 1, a(3^e) = 3, e >= 2, a((3k+1)^e) = 3, a((3k+2)^e) = 1. _David W. Wilson_, May 22 2005

A061142	mult	1
#--------> Z.ONE.shiftLeft(e)
# Totally M.w. a(p) = 2. - _Franklin T. Adams-Watters_, Oct 04 2006Replace each prime factor of n with 2: a(n) = 2^bigomega(n), where bigomega = A001222, number of prime factors counted with multiplicity.

A061389	mult	1
#---->Z.valueOf(LongUtils.phi(e) + 1)
# M.w. a(p^e) = A000010(e)+1.Number of (1+phi)-divisors of n.

A062370	mult	1
#----> Integers.SINGLETON.sum(1, e, k -> Jaguar.factor(p.pow(k)).sigma().multiply(2*k + 1)).add(1)
# M.w. a(p^e) = 1 + Sum_{k=1..e} (2k+1) sigma(p^k). - _Mitch Harris_, May 24 2005a(n) = Sum_{i|n,j|n} sigma(i)*sigma(j)/sigma(gcd(i,j)), where sigma(n) = sum of divisors of n.

A062379	mult	1
#----> p.pow(e - 3 > 0 ? e - 3 : 0)
# M.w. a(p^e) = p^max(e-3, 0). - _Amiram Eldar_, Sep 07 2020n divided by largest 4th-power-free factor of n.

A062380	mult	1
#-----> (p.pow(e+1).multiply(2*e+1).subtract(p.pow(e).multiply(2*e + 3)).add(2)).divide(p.subtract(1))
# Integers.SINGLETON.sum(1, e, k -> p.pow(k).subtract(p.pow(k-1))).add(1)
# M.w. a(p^e) = 1 + sum_{k=1..e} (2k+1)(p^k-p^{k-1}) = ((2e+1)p^(e+1) - (2e+3)p^e+2)/(p-1). - _Mitch Harris_, May 24 2005a(n) = Sum_{i|n,j|n} phi(i)*phi(j)/phi(gcd(i,j)), where phi is Euler totient function.

A064950	mult	1
#--------> (p.pow(e+2).subtract(p.pow(e+1).multiply(3)).add(p).add(1).add(p.pow(e+2).multiply(2*e)).subtract(p.pow(e+1).multiply(2*e))).divide(p.subtract(1).square())
# a(n) = Sum_{d|n} d*tau(d^2). M.w. a(p^e) = (p^(e+2) - 3*p^(e+1) + p + 1 + 2*p^(e+2)*e - 2*p^(e+1)*e)/(p-1)^2.a(n) = Sum_{i|n, j|n} lcm(i,j).

A064971	mult	1
#--------> p.pow(e).multiply(p.pow(e).add(1))
# M.w. a(p^e) = p^e*(p^e+1). - _Vladeta Jovovic_, Nov 01 2001a(n) = n*usigma(n), where usigma(n) is the sum of unitary divisors of n (A034448).

A064988	mul	1
# prime(p)^e
# M.w. a(p^e) = prime(p)^e.Multiplicative with a(p^e) = prime(p)^e.

A064989	mul	1
# is2(p) ? Z.ONE : prevprime(p)^e
# M.w. a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p.Multiplicative with a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p.

A065769	mul	1
# a(p(m)^k) = p(m-1) * p(m)^(k-1)
# Prime cascade: M.w. a(p(m)^k) = p(m-1) * p(m)^(k-1).Prime cascade: multiplicative with a(p(m)^k) = p(m-1) * p(m)^(k-1).

A065770	mul	1
# a(p(m)^k) = p(m-1) * p(m)^(k-1)
# Number of prime cascades to reach 1, where a prime cascade (A065769) is M.w. a(p(m)^k) = p(m-1) * p(m)^(k-1).Number of prime cascades to reach 1, where a prime cascade (A065769) is multiplicative with a(p(m)^k) = p(m-1) * p(m)^(k-1).

A066060	mul	1
# a(p^m) equal to the number of groups of order p^m
# M.w. a(p^m) equal to the number of groups of order p^m.Number of nilpotent groups of order n.

A066260	mul	1
# a(p) = A002808(A049084(p)), p prime
# Completely M.w. a(p) = A002808(A049084(p)), p prime.In the prime factorization of n replace the k-th prime with the k-th composite number, k > 0.

A067029	mul	1
# Z.valueOf(f(e), as recurrences of the
# Together with A028234 is useful for defining sequences that are M.w. a(p^e) = f(e), as recurrences of the form: a(1) = 1 and for n > 1, a(n) = f(A067029(n)) * a(A028234(n)). - _Antti Karttunen_, May 29 2017Exponent of least prime factor in prime factorization of n, a(1)=0.

A067856	mult	1
#--------> is2(p) ? Z.ONE.shiftLeft(e - 1) : (e == 1 ? Z.NEG_ONE : Z.ZERO)
# M.w. a(2^e) = 2^(e - 1), a(p) = -1 for p > 2, a(p^e) = 0 for p > 2 and e > 1. - _Vladeta Jovovic_, Jan 02 2003

A068074	mul	1
# b(2^e) = abs(2*e-3) : b(p^e) = 2*e+1
# a(n) = -tau(n^2) for odd n and 2*tau(n^2/4) - tau(n^2) for even n. b(n) = abs(a(n)) is M.w. b(2^e) = abs(2*e-3) and b(p^e) = 2*e+1 for an odd prime p. - _Vladeta Jovovic_, Apr 25 2002a(n) = Sum_{d|n} (-1)^d*2^omega(n/d) where omega(x) is the number of distinct prime factors in the factorization of x.

A068984	mult	1
#--> p.pow(e+3).subtract(p.pow(e+2).multiply(3)).add(p.pow(e+1).multiply(4)).subtract(p).subtract(1).add(p.pow(e+3).multiply(2*e)).subtract(p.pow(e+2).multiply(6*e)).add(p.pow(e+1).multiply(4*e)).add(p.pow(e+3).multiply(e*e)).subtract(p.pow(e+2).multiply(2*e*e)).add(p.pow(e+1).multiply(e*e)).divide(p.subtract(1).pow(3))
# M.w. a(p^e) = (p^(e+3)-3*p^(e+2)+4*p^(e+1)-p-1+2*p^(e+3)*e-6*p^(e+2)*e+4*p^(e+1)*e+p^(e+3)*e^2-2*p^(e+2)*e^2+p^(e+1)*e^2).divide(p-1)^3.a(n) = Sum_{d|n} d*tau(d)^2.

A069194	mult	1
#--------> p.pow(e).multiply(p.pow(e).subtract(p.pow(e-1))).add(p.pow(2*e).subtract(1).divide(p.square().subtract(1)))
# M.w. a(p^e) = p^e*(p^e - p^(e-1)) + (p^(2*e) - 1)/(p^2 - 1). - _Amiram Eldar_, Sep 15 2019a(n) = Sum_{d|n} (n/d)*phi(n)/phi(d).

A069256	mult	1
#----> is2(p) ? Z.ONE.shiftLeft(4*e-3) : Z.ONE.shiftLeft(ZUtils.valuation(p.subtract(1).multiply(p.square().subtract(1)), Z.TWO))
# M.w. a(2^e) = 2^(4*e-3) and a(p^e) = power of 2 in prime factorization of (p-1)*(p^2-1) for an odd prime p. - _Vladeta Jovovic_, Apr 17 2002Size of the Sylow 2-subgroup of the group GL_2(Z_n): maximal power of 2 that divides A000252(n).

A069739	mult	1
#--------> Binomial.binomial(2*e, e).divide(e+1)
# M.w. a(p^m) = Catalan(m) (A000108). Coincides with A066060 up to n=63 except for n=32.Size of the key space for isomorphism verification of circulant graphs of order n.

A069915	mult	1
#----> Z.ONE.add(Integers.SINGLETON.sum(1, e, k -> (IntegerUtils.gcd(k, e) == 1 ? p.pow(k) : Z.ZERO)))
# M.w. a(p^e) = 1+Sum_{k=1..e, gcd(k, e)=1} p^k.Sum of (1+phi)-divisors of n (cf. A061389).

A069934	mul	1
# Z.valueOf(Product_{k=2
# M.w. a(p^e) = Product_{k=2..e+1} Phi_k(p), where Phi_k(x) is k-th cyclotomic polynomial.a(n) = lcm_{d|n} sigma(d).

A071785	mult	1
#----> Z.valueOf(ZUtils.digitSum(p, 10)).pow(e)
# M.w. a(p) = A007953(p), p prime.In prime factorization of n replace each prime with the sum of its decimal digits.

A072026	mult	1
#----> (p.compareTo(Z.THREE) <= 0 ? p : (p.add(2).isPrime() ? p.add(2) : (p.subtract(2).isPrime() ? p.subtract(2) : p))).pow(e)
# M.w. a(p) = (if p<=3 then p else (if p+2 is prime then p+2 else (if p-2 is prime then p-2 else p))), p prime.Swap twin prime pairs >(3,5) in prime factorization of n.

A072027	mult	1
#----> (p.compareTo(Z.THREE) <= 0 ? Z.FIVE.subtract(p) : (p.add(2).isPrime() ? p.add(2) : (p.subtract(2).isPrime() ? p.subtract(2) : p))).pow(e)
# M.w. a(p) = (if p<=3 then 5-p else (if p+2 is prime then p+2 else (if p-2 is prime then p-2 else p))), p prime.Swap (2,3) and all twin prime pairs >(3,5) in prime factorization of n.

A072028	mult	1
#----> (isMod(4, p, 1) && p.add(2).isPrime() ? p.add(2) : (isMod(4, p, 3) && p.subtract(2).isPrime() ? p.subtract(2) : p)).pow(e)
# M.w. a(p) = (if p mod 4 = 1 and p+2 is prime then p+2 else (if p mod 4 = 3 and p-2 is prime then p-2 else p)), p prime.Swap twin prime pairs of form (4*k+1,4*k+3) in prime factorization of n.

A072029	mult	1
#----> (isMod(4, p, 3) && p.add(2).isPrime() ? p.add(2) : (isMod(4, p, 1) && p.subtract(2).isPrime() ? p.subtract(2) : p)).pow(e)
# M.w. a(p) = (if p mod 4 = 3 and p+2 is prime then p+2 else (if p mod 4 = 1 and p-2 is prime then p-2 else p)), p prime.Swap twin prime pairs of form (4*k+3,4*(k+1)+1) in prime factorization of n.

A072087	mul	1
# a(p) = A061712(p)
# Completely M.w. a(p) = A061712(p). - _David W. Wilson_, Aug 03 2005Least k such that A072084(k) = n.

A072963	mult	1
#----> p.add(2).isPrime() || p.subtract(2).isPrime() ? p.pow(e) : Z.ONE
# M.w. a(p) = (if p+2 or p-2 is prime then p else 1), p prime.In prime factorization of n replace all single (i.e., non-twin) primes with 1.

A073103	mult	1
#--------> is2(p) ? p.pow(e-1 < 3 ? e-1 : 3) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.FOUR : Z.TWO)
# M.w. a(p^e) = p^min(e-1, 3) if p = 2, 4 if p == 1 (mod 4), 2 if p == 3 (mod 4). - _David W. Wilson_, Jun 09 2005Number of solutions to x^4 == 1 (mod n).

A077456	mult	1
#---> p.pow(20*e+4).add(p.pow(15*e+3)).add(p.pow(10*e+2)).add(p.pow(5*e+1)).add(1).divide(p.pow(4).add(p.pow(3)).add(p.square()).add(p).add(1))
# M.w. a(p^e) = (p^(20*e+4) + p^(15*e+3) + p^(10*e+2) + p^(5*e+1) + 1)/(p^4 + p^3 + p^2 + p + 1). - _Amiram Eldar_, Sep 09 2020a(n) = sigma_5(n^5)/sigma(n^5).

A079579	mult	1
#--------> p.subtract(1).multiply(p).pow(e)
# Totally M.w. p -> (p-1)*p, p prime.Totally multiplicative with p -> (p-1)*p, p prime.

A079707	mul	1
# 2->2 : prime(k)->prime(k-1), k>1
# M.w. 2->2 and prime(k)->prime(k-1), k>1.In prime factorization of n replace odd primes with their prime predecessor.

A081210	mul	1
# p^e -> A070321(p^e), p prime
# M.w. p^e -> A070321(p^e), p prime.In prime factorization of n replace each prime power p^e with the greatest squarefree number <= p^e.

A082388	mul	1
# is2(p) ? Z.valueOf(A006012(e), Z.ONE
# M.w. a(2^e) = A006012(e), a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 31 2018a(1) = 1, a(2) = 2; further terms are defined by rules that for k >= 2, a(2^k-i) = a(2^k+i) for 1 <= i <= 2^k-1 and a(2^k) = a(2^(k-1)) + Sum_{i < 2^k} a(i).

A084091	multb	0
#----> mN == -1 ? super.next().subtract(1) : super.next()	Z.valueOf(is2(p) ? oneOr0(e): (is3(p) ? 0 : (isMod(6, p, 1) ? 1 : (neg1(e)))))
# a(n) is M.w. a(2^e) = (1 + (-1)^e)/2, a(3^e) = 0^e, a(p^e) = 1 if p == 1 (mod 6), a(p^e) = (-1)^e if p == 5 (mod 6). - _Michael Somos_, Jul 18 2004Expansion of sum(k>=0, x^2^k/(1+x^2^k+x^2^(k+1))).

A085731	mult	1
#--------> Z.valueOf(e).remainder(p).isZero() ? p.pow(e) : p.pow(e-1)
# M.w. a(p^e) = p^e if p divides e; a(p^e) = p^(e-1) otherwise. - _Eric M. Schmidt_, Oct 22 2013Greatest common divisor of n and its arithmetic derivative.

A087694	mult	1
#----> is3(p) ? Z.THREE.pow(e) : (isMod(3, p, 1) ? p.subtract(1).multiply(e).add(p).multiply(p.pow(e - 1)) : p.pow((e/2)*2))
# M.w. a(3^e) = 3^e, a(p^e) = ((p-1)*e+p)*p^(e-1) if p mod 3 = 1, a(p^e) = p^(2*floor(e/2)) if p mod 3 = 2. - _Vladeta Jovovic_, Sep 27 2003Number of solutions to x^2 + xy + y^2 == 0 (mod n).

A087780	mult	1
#--------> is2(p) ? (e == 1 ? Z.ONE : Z.ZERO) : (is3(p) ? Z.ZERO : (p.mod(Z.EIGHT).bitCount() == 2 ? Z.ZERO : Z.TWO))
# M.w. a(p^m) = 2 for p == 1, 7 (mod 8); a(p^m) = 0 for p == 3, 5 (mod 8); a(2^1) = 1; a(2^m) = 0 for m > 1. - _Eric M. Schmidt_, Apr 20 2013Number of non-congruent solutions to x^2 == 2 mod n.

A087786	mult	1
#----> p.pow((2*e/3) * 2).add(Integers.SINGLETON.sum(0, (e - 1)/3, i -> (p.subtract(1).multiply(p.pow(e + i -1)).multiply(is3(p) && 3*i + 1 == e || isMod(3, p, 1) ? 3 : 1))))
# M.w. a(p^e) = p^(2*floor(2*e/3)) + Sum_{i=0..floor((e-1)/3)} k*(p-1)*p^(e+i-1) where k = 3 if (p = 3 and 3*i+1 = e) or (p mod 3 = 1) otherwise k = 1. - _Andrew Howroyd_, Jul 17 2018a(n) = number of solutions to x^3 - y^3 == 0 (mod n).

A089242	mul	1
# is2(p) ? Z.ONE + a(e), Z.ONE
# M.w. a(2^e) = 1 + a(e), a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 27 2018Sequence is S(infinity), where S(1) = 1, S(m+1) = concatenation S(m), a(m)+1, S(m) and a(m) is the m-th term of S(m). a(m) is also the m-th term of the sequence.

A090884	mul	1
# a(2) = 1, a(prime(i+1)) = prime(i)^i
# Completely M.w. a(2) = 1, a(prime(i+1)) = prime(i)^i for i > 0. - _Andrew Howroyd_, Jul 31 2018There exists an isomorphism from the positive rationals under multiplication to Z[x] under addition, defined by f(q) = e1 + (e2)x + (e3)(x^2) +...+ (ek)(x^(k-1)) + ... (where e_i is the exponent of the i-th prime in q.s prime factorization) The a(n) above

A091306	mul	1
# b(p,k)=p^k+1 : b(p^e,k)=1
# If b(n,k) = sum of k-th powers of unitary, squarefree divisors of n, including 1, then b(n,k) is M.w. b(p,k)=p^k+1 and b(p^e,k)=1 for e>1.Sum of squares of unitary, squarefree divisors of n, including 1.

A092342	mul	0
# b(3^e) = 0^e, b(p^e) = (p.pow(3*e+3).subtract(1).divide(p^3 - 1)
# If b(3*n) = 0, b(3*n+1) = a(n), b(3*n+2) = A092343(n), then b(n) is M.w. b(3^e) = 0^e, b(p^e) = (p^(3*e+3) - 1) / (p^3 - 1) otherwise. - _Michael Somos_, Aug 22 2007a(n) = sigma_3(3n+1).

A092673	mult	1
#--------> is2(p) ? Z.valueOf(e == 1 ? -2 : (e == 2 ? 1 : 0)) : (e == 1 ? Z.NEG_ONE : Z.ZERO)
# a(n) is M.w. a(2)= -2, a(4)= 1, a(2^e)= 0 if e>2. a(p)= -1, a(p^e)= 0 if e>1, p>2. - _Michael Somos_, Mar 26 2007a(n) = moebius(n) - moebius(n/2) where moebius(n) is zero if n is not an integer.

A095683	mul	1
# Z.valueOf(A000720(e)
# M.w. a(p^e) = A000720(e). - _Vladeta Jovovic_, Jul 06 2004Number of prime power divisors of n. If n = product p_i^r_i then d = product {p_i^s_i, 2 <= s_i <= r_i, s_i is prime} is a prime power divisor of n.

A095691	mul	1
# Z.valueOf(A000720(e)+1
# M.w. a(p^e) = A000720(e)+1.Multiplicative with a(p^e) = A000720(e)+1.

A097246	mul	1
# p^e -> NextPrime(p)^floor(e/2) * p.pow(e mod 2), where p prime : NextPrime(p)=A000040(A049084(p)+1)
# M.w. p^e -> NextPrime(p)^floor(e/2) * p^(e mod 2), where p prime and NextPrime(p)=A000040(A049084(p)+1).Replace factors of n that are squares of a prime with the prime succeeding this prime.

A099991	multb	1
#-->super.next().negate()	is2(p) ? Z.ZERO : (e == 1 ? Z.NEG_ONE : Z.ZERO)
# b(n) = -a(n) is M.w. b(2^e) = 0, b(p) = -1 if p >= 3, 0 otherwise. - _David W. Wilson_, Jun 12 2005a(n) = Moebius(2n).

A102440	mul	1
# prime(i) -> (if i<=2 then prime(i) else A102415(i))
# M.w. prime(i) -> (if i<=2 then prime(i) else A102415(i)).Replace each prime factor of n that is greater than 3 with the greatest semiprime less than it.

A102574	mul	1
# Z.valueOf(sigma(p.pow(2e)) = (p.pow(2e+1).subtract(1).divide(p.subtract(1)) if p = 2 or isMod(4, p, 1); sigma_2(p^e) = (p.pow(2e+2).subtract(1).divide(p.square().subtract(1)) if p == 3 (mod 4)
# M.w. a(p^e) = sigma(p^(2e)) = (p^(2e+1) - 1)/(p - 1) if p = 2 or p == 1 (mod 4); sigma_2(p^e) = (p^(2e+2) - 1)/(p^2 - 1) if p == 3 (mod 4). - _Jianing Song_, Aug 03 2018a(n) is the sum of the distinct norms of the divisors of n over the Gaussian integers.

A102631	mult	1
#--------> p.pow(2*e-1)
# M.w. a(p^e) = p^{2e-1}. - _Franklin T. Adams-Watters_, Nov 17 2006a(n) = n^2 / (squarefree kernel of n).

A103440	mul	1
# a(3^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - z * a(p.pow(e-2)) where z = Kronecker(-3, p) * p^2 : a(p) = z + 1
# a(n) is M.w. a(3^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - z * a(p^(e-2)) where z = Kronecker(-3, p) * p^2 and a(p) = z + 1.a(n) = Sum[d|n, d==1 (mod 3), d^2] - Sum[d|n, d==2 (mod 3), d^2].

A108548	mul	1
# p -> A108546(A049084(p)), p prime
# M.w. p -> A108546(A049084(p)), p prime.Fully multiplicative with a(prime(j)) = A108546(j), where A108546 is the lexicographically earliest permutation of primes such that after 2 the forms 4*k+1 and 4*k+3 alternate, and prime(j) is the j-th prime in A000040.

A109386	mult	1
#----> is2(p) ? Z.ONE.shiftLeft(e+1).subtract(1) : p.pow(e + 2).multiply(e+1).subtract(p.pow(e+1).multiply(e + 2)).add(1).divide(p.subtract(1).square())
# M.w. a(2^e) = 2^(e+1)-1 and a(p^e) = (p^(e+2)*(e+1)-p^(e+1)*(e+2)+1)/(p-1)^2 for p>2.

A110399	mult	1
#--------> is2(p) ? Z.valueOf(e-1).abs() : (is7(p) ? Z.ONE : (p.mod(Z.SEVEN).bitCount() == 1 ? Z.valueOf(e+1) : Z.valueOf((1+(neg1(e)))/2)))
# a(n) is M.w. a(2^e) = |e-1|, a(7^e)= 1, a(p^e) = e+1 if p == 1, 2, 4 (mod 7), a(p^e) = (1+(-1)^e)/2 if p == 3, 5, 6 (mod 7).Expansion of (theta_3(q)*theta_3(q^7) - 1)/2 in powers of q.

A111938	mult	1
#----> is2(p) ? p.pow(e) : p.pow(e).multiply(isMod(4, p, 1) ? e + 1 : oneOr0(e))
# M.w. a(p^e) = p^e if p = 2; (e+1)p^e if p == 1 (mod 4); (1+(-1)^e)/2 p^e if p == 3 (mod 4).

A113063	mult	1
#----> is3(p) ? Z.TWO : (isMod(6, p, 1) ? Z.valueOf(e+1) : (isMod(6, p, 2, 5) ? Z.valueOf((1 + neg1(e)) / 2) : p.pow(e)))
# a(n) is M.w. a(p^e) = 2 if p = 3 and e>0, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e) / 2 if p == 2, 5 (mod 6).

A113175	mult	1
#--------> Fibonacci.fibonacci(p.intValue()).pow(e)
# Totally M.w. a(p) = F(p). - _Franklin T. Adams-Watters_, Jun 05 2006

A113186	mult	1
#----> is2(p) ? Z.NEG_ONE : (is5(p) ? Z.ONE : (isMod(10, p, 1, 9) ? sigmaP(p, e) : sigmaP(p.negate(), e)))
# a(n) is M.w. a(2^e) = -1 if e>0, a(5^e) = 1, a(p^e) = (p^(e+1)-1)/(p-1) if p == 1, 9 (mod 10), a(p^e) = ((-p)^(e+1)-1)/(-p-1) if p == 3, 7 (mod 10).

A113260	mult	1
#--> is2(p) ? Z.valueOf(-2).pow(e+2).subtract(1).divide(3) : (is5(p) ? Z.ONE : (isMod(5, p, 1, 4) ? sigmaP(p, e) : sigmaP(p.negate(), e)))
# a(n) is M.w. a(2^e) = ((-2)^(e+2)-1)/3, a(5^e) = 1, a(p^e) = (p^(e+1)-1)/(p-1) if p == 1, 4 (mod 5), a(p^e) = ((-p)^(e+1)-1)/(-p-1) if p == 2, 3 (mod 5).Expansion of (-1 + psi(q)^5/psi(q^5) - 25q^2 psi(q)*psi(q^5)^3)/5 in powers of q where psi(q) is a Ramanujan theta function.

A113262	mult	1
#--------> is2(p) ? Z.ONE.shiftLeft(e+1).subtract(3) : (is3(p) ? Z.ONE : sigmaP(p, e))
# a(n) is M.w. a(3^e) = 1, a(2^e) = 2^(e+1) - 3, a(p^e) = (p^(e+1) - 1) / (p - 1) if p > 3.

A113652	mult	1
#----> is2(p) ? Z.NEG_ONE : (isMod(4, p, 1) ? Z.valueOf(e+1) : Z.valueOf((1 + (neg1(e)))/2))
# a(n) is M.w. a(2^e) = -1 if e>0, a(p^e) = e+1 if p == 1 (mod 4), (1 + (-1)^e)/2 if p == 3 (mod 4).

A114643	mult	1
#--------> is2(p) ? (e == 1 ? Z.ZERO : (e == 2 ? Z.ONE : (e == 3 ? Z.TWO : Z.ZERO))) : (e == 1 ? Z.ONE : Z.ZERO)
# This sequence is M.w. a(2) = 0, a(4) = 1, a(8) = 2, a(2^r) = 0 for r > 3, a(p) = 1 for prime p > 2 and a(p^r) = 0 for r > 1. - _Steven Finch_, Mar 08 2006 (With correction by _Jianing Song_, Jun 28 2018)Number of real primitive Dirichlet characters modulo n.

A114810	mult	1
#----> Z.valueOf(e == 1 ? LongUtils.phi(p.longValue()) : LongUtils.phi(p.pow(e).longValue()) - LongUtils.phi(p.pow(e-1).longValue()))
# a(n) is M.w. a(p)=phi(p), a(p^k)=phi(p^k)-phi(p^(k-1)) and phi(n)=A000010(n).

A114811	mult	1
#--------> is2(p) ? (e <= 2 ? Z.ONE : (e == 3 ? Z.TWO : Z.ZERO)) : (e == 1 ? Z.TWO : Z.ZERO)
# This sequence is M.w. a(2)=1, a(4)=1, a(8)=2, a(2^r)=0 for r>2, a(p)=2 for prime p>2 and a(p^r)=0 for r>1. - _Steven Finch_, Mar 08 2006Number of real, weakly primitive Dirichlet characters modulo n.

A115155	mul	1
# is3(p) ? Z.THREE.negate().pow(e) : (is5(p) ? (((e & 1) == 0) ? p.pow(e) : Z.ZERO) : (isMod(15, p, 7, 11, 13, 14) ? (....??? ))
# a(3^e) = (-3)^e, a(5^e) = 5^e, p^e if e even else 0 if p == 7, 11, 13, 14 (mod 15), Z.valueOf(a(p) * a(p.pow(e-1)) - p^2 * a(p.pow(e-2)) if p == 1, 2, 4, 8 (mod 15). a(n) is M.w. a(3^e) = (-3)^e, a(5^e) = 5^e, a(p^e) = p^e if e even else 0 if p == 7, 11, 13, 14 (mod 15), a(p^e) = a(p) * a(p^(e-1)) - p^2 * a(p^(e-2)) if p == 1, 2, 4, 8 (mod 15).Expansion of (eta(q^3) * eta(q^5))^3 + (eta(q) * eta(q^15))^3 in powers of q.

A115364	mult	1
#----> Z.valueOf(is2(p) ? (e+1) * (e+2) / 2 : 1)
# M.w. a(2^k) = A000217(k+1), a(p^k) = 1 for odd primes p. - _Antti Karttunen_, Nov 02 2018a(n) = A000217(A001511(n)), where A001511 is one more than the 2-adic valuation of n, and A000217(n) is the n-th triangular number, binomial(n+1, 2).

A115672	mul	1
# a(5^e) = (neg1(e)), a(7^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2))
# a(n) is M.w. a(5^e) = (-1)^e, a(7^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) otherwise.

A116073	mult	1
#--------> is5(p) ? Z.ONE : sigmaP(p, e)
# a(n) is M.w. a(5^e) = 1, a(p^e) = (p^(e+1)-1)/(p-1) otherwise.

A116607	mult	1
#--------> is3(p) ? Z.FOUR : sigmaP(p, e)
# a(n) is M.w. a(3^e) = 4 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) otherwise.Sum of the divisors of n which are not divisible by 9.

A117000	mult	1
#----> is2(p) ? Z.ONE : (isMod(8, p, 1, 7) ? sigmaP(p, e) : sigmaP(p.negate(), e))
# a(n) is M.w. a(2^e) = 1, a(p^e) = (p^(e+1).subtract(1) / (p - 1) if p == 1, 7 (mod 8), ((-p)^(e+1) - 1) / (-p - 1) if p == 3, 5 (mod 8). - _Michael Somos_, Aug 08 2007a(n) = Sum_{d|n} Jacobi(2,d)*d.

A117656	mult	1
#--------> p.pow(e/2).add(p.subtract(1).multiply(p.pow(e-1)))
# M.w. a(p^e) = p^floor(e/2) + (p-1)*p^(e-1) for prime p. - _Andrew Howroyd_, Jul 17 2018Number of solutions to x^(k+2)=x^2 mod n for some k>=1.

A117657	mult	1
#--------> p.pow(2*e/3).add(p.subtract(1).multiply(p.pow(e-1)))
# M.w. a(p^e) = p^floor(2*e/3) + (p-1)*p^(e-1) for prime p. - _Andrew Howroyd_, Jul 17 2018Number of solutions to x^(k+3)=x^3 mod n for some k>=1.

A118541	mult	0
#----> ZUtils.digitProduct(p).pow(e)
# Completely M.w. a(p) = A007954(p) for prime p. ZUtils.digitProduct(mN);Product of digits of prime factors of n, with multiplicity.

A120119	mul	1
# a(Prime(k)) = A055025(k)
# Totally M.w. a(Prime(k)) = A055025(k).Multiplicative function from integers to sums of two squares.

A122261	mul	1
# a(p) = A065333(p-1),
# M.w. a(p) = A065333(p-1), for p prime.Characteristic function of numbers having only factors that are Pierpont primes.

A122266	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = oneOr0(e)* p.pow(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p.pow(e-1)) - p^4 * b(p.pow(e-2)) if p == 1 or 5 (mod 12)
# a(n) = b(12*n + 1) where b() is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e) / 2 * p^(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p^(e-1)) - p^4 * b(p^(e-2)) if p == 1 or 5 (mod 12). - _Michael Somos_, Jun 24 2013

A123331	mult	1
#----> is2(p) ? Z.valueOf((3-(neg1(e)))/2) : (is3(p) ? Z.ONE : (isMod(6, p, 1) ? Z.valueOf(e+1) : Z.valueOf((1+(neg1(e)))/2)))
# a(n) is M.w. a(2^e) = (3-(-1)^e)/2, a(3^e) = 1, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1+(-1)^e)/2 if p == 5 (mod 6).

A123667	mult	1
#--------> p.shiftLeft(1).pow(e)
# Totally M.w. a(p) = 2p.	a(n) = n * 2^bigomega(n).

A124508	mult	1
#--------> Z.ONE.shiftLeft(e).multiply(3)
# M.w. p^e -> 3*2^e, p prime and e>0.2^BigO(n) * 3^omega(n), where BigO=A001222 and omega=A001221, the numbers of prime factors of n with and without repetitions.

A124859	mul	1
# p^e -> primorial(e), p prime : e > 0
# M.w. p^e -> primorial(e), p prime and e > 0.Multiplicative with p^e -> primorial(e), p prime and e > 0.

A125096	mult	1
#--------> is2(p) ? Z.valueOf(e == 1 ? 0 : 2) : (Z.valueOf(isMod(8, p, 1, 3) ? e+1 : (1 + (neg1(e)))/2))
# a(n) is M.w. a(2) = 0, a(2^e) = 2 if e>1, a(p^e) = e+1 if p == 1, 3 (mod 8), a(p^e) = (1+(-1)^e)/2 if p == 5, 7 (mod 8).Expansion of -1 + (phi(q) * phi(q^2) + phi(-q^2) * phi(q^4)) / 2 in powers of q.

A125139	mult	1
#--------> p.multiply(p.pow(e).subtract(1)).divide(p.subtract(1)).subtract(neg1(e))
# SENSigma: M.w. a(p^e) = p*(p^e-1)/(p-1) - (-1)^e.SENSigma: Multiplicative with a(p^e) = p*(p^e-1)/(p-1) - (-1)^e.

A125510	multb	0
#--> mN == -1 ? super.next() : super.next().multiply(6)	is2(p) ? Z.ONE : (is3(p) ? p.pow(e + 1).subtract(2) : sigmaP(p, e))
# a(n) = 6*b(n) where b() is M.w. b(2^e) = 1, b(3^e) = 3^(e+1) - 2, b(p^e) = (p^(e+1) - 1) / (p-1) if p>3. - _Michael Somos_, Feb 17 2017Theta series of 4-dimensional lattice QQF.4.g.

A126246	mult	1
#----> is2(p) && e == 1 ? Z.TWO : p.multiply(p.subtract(1).pow(e - 1))
# M.w. a(p^e) = phi(p^e) = p*(p-1)^(e-1), except when p=2, then a(2)=2, because F(1)=F(2)=1 and a(2^e) = 3*(2^(e-2)), (e > 1, all smaller Fibonacci numbers are coprime, except ones that are multiples of 3, i.e., every 4th one). - _Jud McCranie_, Nov 11 2017a(n) is the number of Fibonacci numbers among (F(1),F(2),F(3),...,F(n)) which are coprime to F(n), where F(n) is the n-th Fibonacci number.

A127863	mul	0
# b(3^e) = 0^e, b(p^e) = oneOr0(e)* (-p)^(e/2) if p == 2 (mod 3), b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p == 1 (mod 3) where b(p) = -Sum_{x=0
# a(n) = b(3*n + 1) where b(n) is M.w. b(3^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 * (-p)^(e/2) if p == 2 (mod 3), b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p == 1 (mod 3) where b(p) = -Sum_{x=0..p-1} Kronecker(4*x^3 + 9, p).Coefficients of modular form for elliptic curve "243b1": y^2 + y = x^3 + 2 divided by q in powers of q^3.

A128263	mul	1
# a(17^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p minus number of points of elliptic curve modulo p
# a(n) is M.w. a(17^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p minus number of points of elliptic curve modulo p.Coefficients of L-series for elliptic curve "17a4": y^2 + x*y + y = x^3 - x^2 - x or y^2 + x*y - y = x^3 - x^2.

A129522	mul	1
# p.equals(Z.valueOf(11)) ? Z.valueOf(11),negate().pow(e) : (isMod(11, p, 2, 6, 7, 8, 10) ? Z.valueOf((1+(neg1(e)))/2).multiply(p.pow(e)) : Z.valueOf(a(p)*a(p.pow(e-1)) - p^2*a(p.pow(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^2 - 2*p : 4*p = y^2 + 11*x^2
# a(n) is M.w. a(11^e) = (-11)^e, a(p^e) = (1+(-1)^e)/2*p^e if p == 2, 6, 7, 8, 10 (mod 11), a(p^e) = a(p)*a(p^(e-1)) - p^2*a(p^(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^2 - 2*p and 4*p = y^2 + 11*x^2.Expansion of unique weight 3 level 11 multiplicative cusp form in powers of q.

A129666	mul	1
# a(7^e) = (-7)^e, Z.valueOf(a(p) * a(p.pow(e-1)) - p^3 * a(p.pow(e-2))
# a(n) is M.w. a(7^e) = (-7)^e, a(p^e) = a(p) * a(p^(e-1)) - p^3 * a(p^(e-2)).Expansion of unique cusp form of weight 4 level 7 in powers of q.

A130107	mult	1
#--------> e == 1 ? p.subtract(1) : (e == 2 ? p.subtract(1).multiply(p).subtract(1) : p.pow(e - 3).multiply(p.add(1)).multiply(p.subtract(1).square()))
# M.w. a(p^e) = p-1 if e=1,  a(p^e) = p^2-p-1 if e=2, a(p^e) = p^(e-3)*(p+1)*(p-1)^2. - _Enrique P√©rez Herrero_, Apr 03 2014	M√∂bius transform of A063659.

A131944	mult	1
#--------> is2(p) ? Z.ONE : (is3(p) ? Z.FOUR.subtract(Z.THREE.pow(e+1)) : sigmaP(p, e))
# a(n) is M.w. a(2^e) = 1, a(3^e) = 4- 3^(e+1), a(p^e) = (p^(e+1) - 1) / (p-1) if p>3.Expansion of (1 - b(q)*b(q^2)) / 3 where b() is a cubic AGM function. Expansion of (1 - eta(q)^3 * eta(q^2)^3 / (eta(q^3) * eta(q^6))) / 3 in powers of q.

A131947	mult	1
#--------> is2(p) ? Z.ONE.shiftLeft(e+1).negate().add(3) : (is3(p) ? Z.ONE : sigmaP(p, e))
# a(n) is M.w. a(2^e) = 3 - 2^(e+1), a(3^e) = 1, a(p^e) = (p^(e+1) - 1) / (p-1) if p>3.Expansion of (1 - (phi(-q) * phi(-q^3))^2)/4 in powers of q where phi() is a Ramanujan theta function.

A132001	mult	1
#---->~~    ~~{ if (is2(p)) {~~  return Z.TWO.add(Z.valueOf(-4).pow(e+1).subtract(1).divide(5));~~} else if (is3(p)) {~~  return Z.ONE;~~} else {~~  final Z q = p.square().multiply(LongUtils.kronecker(3, p.longValue()));~~  return q.pow(e+1).subtract(1).divide(q.subtract(1));~~}}
# a(n) is M.w. a(2^e) = 2 + ((-4)^(e+1) - 1)/5, a(3^e) = 1, a(p^e) = (q^(e+1) - 1) / (q - 1) where q = p^2 * Kronecker(-3, p) if p > 3.

A132004	mult	1
#----> is2(p) ? Z.NEG_ONE : (is3(p) ? Z.ONE : (isMod(4, p, 1) ? Z.valueOf(e+1) : Z.valueOf((1 + (neg1(e))) / 2)))
# a(n) is M.w. a(2^e) = 2*0^e - 1, a(3^e) = 1, a(p^e) = e+1 if p == 1 (mod 4), a(p^e) = (1 + (-1)^e) / 2 if p == 3 (mod 4).

A132705	mul	0
# (p) = p + 2
# If a(1) were 1 rather than 3, the sequence would be completely M.w. a(p) = p + 2. - _Charles R Greathouse IV_, Sep 02 2009For an integer n with prime factorization (p_1)*(p_2)*(p_3)* ... *(p_k), a(n) = (p_1+2)*(p_2+2)*(p_3+2)* ... *(p_k+2).

A133079	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = oneOr0(e)* p.pow(e/2) if p == 1, 3 (mod 8), b(p^e) = oneOr0(e)* (-p)^(e/2) if p == 5, 7 (mod 8)
# a(n) = b(24*n + 1) where b(n) is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 * p^(e/2) if p == 1, 3 (mod 8), b(p^e) = (1 + (-1)^e)/2 * (-p)^(e/2) if p == 5, 7 (mod 8).Expansion of f(x)^3 - 3 * x * f(x^9)^3 in powers of x^3 where f() is a Ramanujan theta function.

A133639	mult	1
#--------> p.compareTo(Z.THREE) <= 0 ? Z.valueOf(e == 1 ? -1 : 0) : Z.valueOf(neg1(e))
# a(n) is M.w. a(2^e) = a(3^e) = -1 if e=1, 0 if e>1, a(p^e) = (-1)^e if p > 3.Mobius transform of b(n) where b(8n + 1) = A080995(n).

A133691	mult	1
#--------> is2(p) ? Z.valueOf(e == 1 ? -2 : -6) : sigmaP(p, e)
# a(n) is M.w. a(2) = -2, a(2^e) = -6 if e>1, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>2.Expansion of (1 - (phi(-q) * phi(q^2))^2) / 4 in powers of q where phi() is a Ramanujan theta function.

A133693	mult	1
#----> is2(p) ? Z.NEG_ONE : (isMod(8, p, 5, 7) ? Z.valueOf((1 + (neg1(e))) / 2) : Z.valueOf(e+1))
# a(n) is M.w. a(2^e) = -1 if e>0, a(p^e) = (1 + (-1)^e) / 2 if p == 5, 7 (mod 8), a(p^e) = e+1 if p == 1, 3 (mod 8).

A133827	mul	0
# b(2^e) = 0^e, b(7^e) = 1, b(p^e) = oneOr0(e)if p == 3, 5, 6 (mod 7), b(p^e) = e+1 if p == 1, 2, 4 (mod 7)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(7^e) = 1, b(p^e) = (1 + (-1)^e) / 2 if p == 3, 5, 6 (mod 7), b(p^e) = e+1 if p == 1, 2, 4 (mod 7).Number of solutions to x + 7 * y = 2 * n in triangular numbers.

A134015	mult	1
#--------> is2(p) ? Z.valueOf(e == 1 ? 0 : -2) : (Z.valueOf(isMod(4, p, 1) ? e+1 : (1+(neg1(e)))/2))
# a(n) is M.w. a(2) = 0, a(2^e) = -2 if e>1, a(p^e) = e+1 if p == 1 (mod 4), a(p^e) = (1+(-1)^e)/2 if p == 3 (mod 4).Expansion of (1 - phi(-q) * phi(q^4)) / 2 in powers of q where phi() is a Ramanujan theta function.

A134080	mul	0
# b(2^e) = 0^e, b(5^e) = 5^e, b(p^e) = (sigmaP(p, e) if p == 1, 9 (mod 10), b(p^e) = (p.pow(e+1)  + (neg1(e))).divide(p + 1) if p == 3, 7 (mod 10)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(5^e) = 5^e, b(p^e) = (p^(e+1) - 1) / (p - 1) if p == 1, 9 (mod 10), b(p^e) = (p^(e+1)  + (-1)^e) / (p + 1) if p == 3, 7 (mod 10).Expansion of (f(-q^5)^5 / f(-q) + f(q^5)^5 / f(q)) / 2 in powers of q^2 where f() is a Ramanujan theta function.

A136549	mul	1
# a(3^e) = 3^e, a(5^e) = (-5)^e, p^e * oneOr0(e)if p == 7, 11, 13, 14 (mod 15), Z.valueOf(a(p) * a(p.pow(e-1)) - p^2 * a(p.pow(e-2)) if p == 1, 2, 4, 8 (mod 15)
# a(n) is M.w. a(3^e) = 3^e, a(5^e) = (-5)^e, a(p^e) = p^e * (1 + (-1)^e) / 2 if p == 7, 11, 13, 14 (mod 15), a(p^e) = a(p) * a(p^(e-1)) - p^2 * a(p^(e-2)) if p == 1, 2, 4, 8 (mod 15).Expansion of (eta(q^3) * eta(q^5))^3 - (eta(q) * eta(q^15))^3 in powers of q.

A136747	mul	1
# a(3^e) = (-27)^e, Z.valueOf(a(p) * a(p.pow(e-1)) - p^7 * a(p.pow(e-2)) unless p = 3
# a(n) is M.w. a(3^e) = (-27)^e, a(p^e) = a(p) * a(p^(e-1)) - p^7 * a(p^(e-2)) unless p = 3.Expansion of a(q)^2 * (b(q) * c(q) / 3)^3 in powers of q where a(), b(), c() are cubic AGM theta functions.

A137608	mult	1
#--> is2(p) ? Z.NEG_ONE : (is3(p) ? Z.ONE : (isMod(6, p, 1) ? Z.valueOf(e+1) : Z.valueOf(oneOr0(e))))
# a(n) is M.w. a(2^e) = -1 unless e=0, a(3^e) = 1, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A138661	mul	1
# a(11^e) = (-1331)^e, p.pow(3*e) * oneOr0(e)if p == 2, 6, 7, 8, 10 (mod 11), Z.valueOf(a(p) * a(p.pow(e-1)) - p^6 * a(p.pow(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^6 - 6*p*y^4 + 9*p^2*y^2 - 2*p^3 : 4 * p = y^2 + 11 * x^2
# a(n) is M.w. a(11^e) = (-1331)^e, a(p^e) = p^(3*e) * (1 + (-1)^e) / 2 if p == 2, 6, 7, 8, 10 (mod 11), a(p^e) = a(p) * a(p^(e-1)) - p^6 * a(p^(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^6 - 6*p*y^4 + 9*p^2*y^2 - 2*p^3 and 4 * p = y^2 + 11 * x^2.Expansion of a level 11 weight 7 multiplicative modular form in powers of q.

A138746	mult	1
#--> is2(p) ? Z.NEG_ONE : (is3(p) ? Z.valueOf(2 - neg1(e)) : (isMod(12, p, 1, 5) ? Z.valueOf(e+1) : Z.valueOf(oneOr0(e))))
# a(n) is M.w. a(2^e) = -1 if e>0, a(3^e) = 2 - (-1)^e, a(p^e) = e+1 if p == 1, 5 (mod 12), a(p^e) = (1 + (-1)^e) / 2 if p == 7, 11 (mod 12).

A138805	multb	0
#--> mN == -1 ? super.next() : super.next().multiply2()	is3(p) ? (e == 1 ? Z.ZERO : Z.THREE) : Z.valueOf(isMod(6, p, 1) ? e+1 : oneOr0(e))
# a(n) = 2*b(n) where b() is M.w. b(3^e) = 3 if e>1, b(p^e) = e+1 if p == 1 (mod 6), b(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A138811	multb	0
#--> mN == -1 ? super.next() : super.next().multiply2()	p.equals(Z.valueOf(43)) ? Z.ONE : Z.valueOf(LongUtils.kronecker(-43, p.longValue()) == 1 ? e + 1 : oneOr0(e))
# a(n) = 2*b(n) where b() is M.w. b(43^e) = 1, b(p^e) = e+1 if Kronecker(-43, p) = 1, b(p^e) = (1 + (-1)^e) / 2 otherwise.Theta series of quadratic form x^2 + x*y + 11*y^2.

A138950	mult	1
#--> is2(p) ? Z.ONE : (is3(p) ? Z.valueOf(-1 + 2 * neg1(e)) : (isMod(12, p, 1, 5) ? Z.valueOf(e+1) : Z.valueOf(oneOr0(e))))
# a(n) is M.w. a(2^e) = 1, a(3^e) = -1 + 2 * (-1)^e, a(p^e) = e+1 if p == 1, 5 (mod 12), a(p^e) = (1 + (-1)^e) / 2 if p == 7, 11 (mod 12).

A138952	mult	1
#--> is2(p) ? Z.NEG_ONE : (is3(p) ? Z.valueOf(-1 + 2 * neg1(e)) : (isMod(12, p, 1, 5) ? Z.valueOf(e+1) : Z.valueOf(oneOr0(e))))
# a(n) is M.w. a(2^e) = -1 if e>0, a(3^e) = -1 + 2 * (-1)^e, a(p^e) = e+1 if p == 1, 5 (mod 12), a(p^e) = (1 + (-1)^e) / 2 if p == 7, 11 (mod 12).Expansion of (eta(q^2)^7 * eta(q^3)^2 * eta(q^12) / (eta(q)^2 * eta(q^4)^3 * eta(q^6)^3) - 1) / 2 in powers of q.

A140782	mult	1
#----> sigmaP(p, e).multiply(Z.valueOf(LongUtils.kronecker(13, p.longValue())).pow(e))
# a(n) is M.w. a(p^e) = (p^(e+1) - 1) / (p - 1) * Kronecker(13, p)^e.a(n) = sigma(n) * Kronecker(13, n).

A143062	mul	0
# b(p.pow(2*e)) = (neg1(e)) if p = 5 (mod 6), b(p.pow(2*e)) = +1 if p = 1 (mod 6) : b(p.pow(2*e-1)) = b(2^e) = b(3^e) = 0 if e>0
# a(n) = b(24*n + 1) where b() is M.w. b(p^(2*e)) = (-1)^e if p = 5 (mod 6), b(p^(2*e)) = +1 if p = 1 (mod 6) and b(p^(2*e-1)) = b(2^e) = b(3^e) = 0 if e>0.Expansion of false theta series variation of Euler:s pentagonal number series in powers of x.

A143064	mul	0
# b(p.pow(2*e)) = -(neg1(e)) if p = 2, b(p.pow(2*e)) = (neg1(e)) if p = 5 (mod 6), b(p.pow(2*e)) = 1 if p = 1 (mod 6), : b(p.pow(2*e-1)) = b(3^e) = 0 if e>0
# a(n) = b(3*n + 1) where b() is M.w. b(p^(2*e)) = -(-1)^e if p = 2, b(p^(2*e)) = (-1)^e if p = 5 (mod 6), b(p^(2*e)) = 1 if p = 1 (mod 6), and b(p^(2*e-1)) = b(3^e) = 0 if e>0. - _Michael Somos_, Jul 19 2013Expansion of a Ramanujan false theta series variation of A089801 in powers of x.

A143348	mult	1
#--------> is2(p) ? Z.ONE.subtract(Z.ONE.shiftLeft(e+1)) : sigmaP(p, e)
# a(n) is M.w. a(2^e) = 1 - 2^(e+1) if e > 0, a(p^e) = (p^(e+1) - 1) / (p - 1) if p > 2.a(n) = -(-1)^n times sum of divisors of n.

A143520	mult	1
#--------> is2(p) ? Z.valueOf(e-1).multiply(Z.ONE.shiftLeft(e)) : p.pow(e).multiply(e+1)
# a(n) is M.w. a(2^e) = (e-1) * 2^e if e>0, a(p^e) = (e+1) * p^e if p>2.a(n) is n times number of divisors of n if n is odd, zero if n is twice odd, n times number of divisors of n/4 if n is divisible by 4.

A143521	mult	1
#--------> is2(p) ? Z.valueOf(3-e).multiply(Z.ONE.shiftLeft(e)) : p.pow(e).multiply(e+1)
# a(n) is M.w. a(2^e) = (3-e) * 2^e if e>0, a(p^e) = (e+1) * p^e if p>2.G.f.: Sum_{k>0} k * x^k / (1 + (-x)^k)^2.

A152243	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = p^e * oneOr0(e)if p == 5 (mod 6), b(p^e) = b(p) * b(p.pow(e-1)) - p^2 * b(p.pow(e-2)) if p == 1 (mod 6)
# a(n) = b(6*n + 1) where b(n) is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = p^e * (1 + (-1)^e) / 2 if p == 5 (mod 6), b(p^e) = b(p) * b(p^(e-1)) - p^2 * b(p^(e-2)) if p == 1 (mod 6).Expansion of a(q) * f(-q)^4 where f() is a Ramanujan theta function and a() is a cubic AGM function.

A152244	mul	0
# b(2^e) = 0^e, b(3^e) = -2 * (-3)^e if e>0, b(p^e) = p^e * oneOr0(e)if p == 5 (mod 6), b(p^e) = b(p) * b(p.pow(e-1)) - p^2 * b(p.pow(e-2)) if p == 1 (mod 6)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = -2 * (-3)^e if e>0, b(p^e) = p^e * (1 + (-1)^e) / 2 if p == 5 (mod 6), b(p^e) = b(p) * b(p^(e-1)) - p^2 * b(p^(e-2)) if p == 1 (mod 6).Expansion of a(x) * f(-x^3)^4 in powers of x where f() is a Ramanujan theta function and a() is a cubic AGM function.

A153728	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = oneOr0(e)* (-1)^(e/2) * p.pow(3*e/2) if p == 5 (mod 6), b(p^e) = b(p) * b(p.pow(e-1)) - b(p.pow(e-2)) * p^3 if p == 1 (mod 6) where b(p) = (x^2 - 3*p)*x, 4*p = x^2 + 3*y^2, |x| < |y| : x == 2 (mod 3)
# a(n) = b(6*n + 1) where b(n) is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e) / 2 * (-1)^(e/2) * p^(3*e/2) if p == 5 (mod 6), b(p^e) = b(p) * b(p^(e-1)) - b(p^(e-2)) * p^3 if p == 1 (mod 6) where b(p) = (x^2 - 3*p)*x, 4*p = x^2 + 3*y^2, |x| < |y| and x == 2 (mod 3).Expansion of q^(-1/3) * (eta(q)^8 + 8 * eta(q^4)^8) in powers of q^2.

A155918	mult	1
#--> is2(p) ? Z.ONE.shiftLeft(e-1).add(1) : (isMod(4, p, 1) ? p.pow(e) : new Q(p.pow(e+1), p.add(1)).ceiling())
# M.w. a(p^e) = p^e if p == 1 (mod 4); ceiling(p^(e+1)/(p+1)) if p == 3 (mod 4); 2^(e-1) + 1 if p = 2. - _Jianing Song_, Apr 20 2019

A156061	mul	1
# a(prime(k)^e) = k
# M.w. a(prime(k)^e) = k. Note that in contrast to A003963, this is not fully multiplicative. a(1) = 1 as an empty product. - _Antti Karttunen_, Aug 13 2017a(n) = product of indices of distinct prime factors of n, where index(prime(k)) = k.

A159253	mult	1
#--------> e % 3 == 0 ? p.pow(e) : (e % 3 == 1 ? p.pow(e+1) : p.pow(e - 1))
# M.w. a(p^{3n}) = p^{3n}, a(p^{3n+1}) = p^{3n+2), and a(p^{3n+2)) = p^{3n+1).a(n) is the smallest positive integer not yet in the sequence such that n * a(n) is a cube.

A160499	mult	1
#--> is2(p) ? ((e == 1 || e >= 5) ? Z.ZERO : p.pow(e - 2)) : (e >= 2 ? Z.ZERO : (isMod(4, p, 1) ? Z.THREE : Z.ONE))
# M.w. a(4) = 1, a(8) = 2, a(16) = 4, a(2^e) = 0 for e = 1 or e >= 5; for odd primes p, a(p) = 3 if p == 1 (mod 4) and 1 if p == 3 (mod 4), a(p^e) = 0 for e >= 2.

A161946	mul	1
# Z.valueOf(oddpart(p^e+1), where oddpart(n) = A000265(n) is the largest odd divisor of n
# M.w. a(p^e) = oddpart(p^e+1), where oddpart(n) = A000265(n) is the largest odd divisor of n.Odd part of sum of unitary divisors of n.

A163659	mult	1
#--------> is2(p) ? Z.ONE.shiftLeft(e+1).subtract(1) : Z.valueOf(is3(p) ? -2 : 1)
# a(n) is M.w. a(2^e) = 2^(e+1) - 1, a(3^e) = -2 if e>0, a(p^e) = 1 if p>3. - _Michael Somos_, Feb 14 2011

A163746	mult	1
#--> is2(p) ? Z.ONE : (is3(p) ? Z.valueOf(2 - neg1(e)) : (isMod(4, p, 1) ? Z.valueOf(e+1) : Z.valueOf((1 - neg1(e))/2)))
# a(n) is M.w. a(2^e) = 1, a(3^e) = 2-(-1)^e, a(p^e) = e+1 if p == 1 (mod 4), a(p^e) == (1-(-1)^e)/2 if p == 3 (mod 4).

A163819	mult	1
#--> Z.valueOf(is2(p) || is5(p) ? neg1(e) : (isMod(40, p, 3, 17, 21, 27, 29, 31, 33, 39) ? oneOr0(e) : (isMod(40, p, 1, 9, 11, 19) ? e + 1 : neg1(e) * (e + 1))))
# a(n) is M.w. a(2^e) = a(5^e) = (-1)^e, a(p^e) = (1 + (-1)^e)/2 if p == 3, 17, 21, 27, 29, 31, 33, 39 (mod 40), a(p^e) = e+1 if p == 1, 9, 11, 19 (mod 40), a(p^e) = (-1)^e * (e+1) if p == 7, 13, 23, 37 (mod 40).

A166586	mul	1
# b(p) = 2 - p, b(p^e) = 0,
# Dirichlet g.f.: 1 / Product_{p prime} (1 - p^(1 - s) + 2p^s). The Dirichlet inverse is M.w. b(p) = 2 - p, b(p^e) = 0, for e > 1. - _√Ālvar Ibeas_, Nov 24 2017Totally multiplicative sequence with a(p) = p - 2 for prime p.

A166698	mul	1
# Z.valueOf((a(p-1)-1)^e
# M.w. a(p^e) = (a(p-1)-1)^e.Totally multiplicative sequence with a(p) = a(p-1) - 1 for prime p.

A170819	mul	1
# p*A011765(p+1), e > 0
# M.w. a(p^e) = p*A011765(p+1), e > 0. - R. J. Mathar, Jun 07 2011a(n) = product of distinct primes of the form 4k-1 that divide n.

A173763	mul	1
# is2(p) ? Z.valoeOf(16).pow(e) : ??? Z.valueOf(a(p) * a(p.pow(e-1)) - p^9 * a(p.pow(e-2)) if p>2
# a(n) is M.w. a(2^e) = 16^e, a(p^e) = a(p) * a(p^(e-1)) - p^9 * a(p^(e-2)) if p>2.Expansion of (eta(q^2)^7 / eta(q^4)^2)^4 + 16 * q * (eta(q)^2 * eta(q^2) * eta(q^4)^2)^4 in powers of q.

A178737	mul	0
# b(p^e) = 0 if e odd, b(2^e) = 0^e, b(p^e) = p.pow(3 * e/2) if isMod(4, p, 1), b(p^e) = (-p)^(3 * e/2) if p == 3 (mod 4)
# a(n) = b(8*n + 1) where b() is M.w. b(p^e) = 0 if e odd, b(2^e) = 0^e, b(p^e) = p^(3 * e/2) if p == 1 (mod 4), b(p^e) = (-p)^(3 * e/2) if p == 3 (mod 4).Coefficients in expansion of Jacobi theta_1:::(0).

A179851	mul	0
# b(2^e) = b(5^e) = 0^e, b(p^e) = oneOr0(e)if p == 3 (mod 4), b(p^e) = (e+1) * s^e where s = Kronecker(10, p)
# a(n) = b(4*n + 1) where b(n) is M.w. b(2^e) = b(5^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 if p == 3 (mod 4), b(p^e) = (e+1) * s^e where s = Kronecker(10, p) for other primes p.Expansion of q^(-1/4) * (eta(q^4) * eta(q^25) + eta(q) * eta(q^100))^2 / (eta(q^2) * eta(q^50)) in powers of q.

A181905	mul	1
# a(3^e) = 0, Z.valueOf(((p^2)^(e+1).subtract(1).divide(p.square().subtract(1))
# Conjecture: M.w. a(3^e) = 0, a(p^e) = ((p^2)^(e+1)-1)/(p^2-1) for p == 1 (mod 3), a(p^e) = (1-(-p^2)^(e+1))/(p^2+1) for p == 2 (mod 3). - _Andrew Howroyd_, Aug 05 2018Expansion of (b(q^3)^3 - b(q)^3) / 9 in powers of q where b() is a cubic AGM theta function.

A182004	mul	0
# b(2^e) = b(5^e) = 0^e, b(p^e) = oneOr0(e)if p == 3 (mod 4), b(p^e) = (e+1) * s^e where s = Kronecker(10, p)
# a(n) = b(4*n + 1) where b(n) is M.w. b(2^e) = b(5^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 if p == 3 (mod 4), b(p^e) = (e+1) * s^e where s = Kronecker(10, p) for other primes p.Expansion of q^(-1/4) * (eta(q^4) * eta(q^25) + eta(q) * eta(q^100))^2 / (eta(q^2) * eta(q^50)) in powers of q.

A182139	mul	1
# a_q(p^e) = (q^(e+1).subtract(1).divide(q-1)
# More generally: Let a_q(n) be M.w. a_q(p^e) = (q^(e+1)-1)/ (q-1) for prime p, e >= 0 and some fixed integer q. Then a_q(n) is the inverse Moebius transform of the completely multiplicative sequence b_q(n) = q^bigomega(n) with b_q(p) = q and b_q(1) = 1. For q = 1 see a_q(n) = A000005(n) and b_q(n) = A000012(n), for q = 0 see a_q(n) = A000012(n) and b_q(n) = A000007(n) with offset 1, and for q = -1 see a_q(n) = A010052(n) with offset 1 and b_q(n) = A008836(n). - _Werner Schulte_, Feb 20 2019Inverse Moebius transform of A061142.

A183091	mult	1
#--------> p.pow(e*(e+1)/2)
# M.w. a(p^k) = p^(k*(k+1)/2).a(n) is the product of the divisors p^k of n where p is prime and k >= 1.

A184160	mul	1
# a(prime(t)) = 1 + a(t)
# Completely M.w. a(prime(t)) = 1 + a(t). - _Andrew Howroyd_, Aug 01 2018Number of root subtrees in the rooted tree with Matula-Goebel number n.

A186099	mult	1
#--------> p.compareTo(Z.THREE) <= 0 ? Z.ONE : sigmaP(p, e)
# a(n) is M.w. a(2^e) = a(3^e) = 1, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.Sum of divisors of n congruent to 1 or 5 mod 6.

A187096	mul	1
# a(19^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(19^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.Coefficients of L-series for elliptic curve "19a3": y^2 + y = x^3 + x^2 + x.

A187097	mul	0
# b(2^e) = 0^e, b(19^e) = 1, b(p^e) = oneOr0(e)if -1 = Kronecker(-19, p), b(p^e) = e+1 if p = x^2 + 19 * y^2, b(p^e) = Kronecker(-3, e+1) if p = 4*x^2 + 2*x*y + 5*y^2
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(19^e) = 1, b(p^e) = (1 + (-1)^e) / 2 if -1 = Kronecker(-19, p), b(p^e) = e+1 if p = x^2 + 19 * y^2, b(p^e) = Kronecker(-3, e+1) if p = 4*x^2 + 2*x*y + 5*y^2.Expansion of psi(x^4) * phi(x^38) - x^2 * psi(x) * psi(x^19) + x^9 * phi(x^2) * psi(x^76) in powers of x where phi(), psi() are Ramanujan theta functions.

A187846	mul	1
# a(3^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(3^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.Coefficients of L-series for elliptic curve "21a4": y^2 + x * y = x^3 + x.

A188581	mul	1
# Z.valueOf(A000070(e)
# M.w. a(p^e) = A000070(e). - _Amiram Eldar_, Sep 09 2020Inverse Moebius transform of A000688, the number of factorizations of n into prime powers greater than 1.

A192577	mul	1
# Z.valueOf((1+p^e)/2
# [Note that A034448(n) and A034444(n) are multiplicative, so the arithmetic mean A034448(n)/A034444(n) is M.w. a(p^e) = (1+p^e)/2.]Numbers n such that the arithmetic mean of the unitary divisors of n is a prime number.

A194959	mul	1
# B(n,p^e) = A(n,e+1)
# Let B(n,k) be M.w. B(n,p^e) = A(n,e+1) for e >= 0 and some fixed n > 0. That yields the Dirichlet g.f.: Sum_{k>0} B(n,k)/k^s = (zeta(s))^3/(zeta(2*s)*zeta(n*s)).Fractalization of (1 + floor(n/2)).

A197774	mult	1
#--> Z.valueOf(e).isSquare() ? (Z.valueOf(e).sqrt().isEven() ? Z.ONE : Z.NEG_ONE) : Z.ZERO
# M.w. a(p^e) = (-1)^sqrt(e) if e is a square, 0 otherwise. - _Franklin T. Adams-Watters_, Oct 18 2011Suppose n has prime factorization n = p1^a1 * p2^a2 * ... * pk^ak. Then a(n) = (-1)^(n1 + n2 + ... + nk) if all the ai are ni^2 and a(n) = 0 otherwise.

A197863	mult	1
#--------> p.pow(e > 2 ? e : 2)
# M.w. a(p^e) = p^max(e,2).Smallest powerful number that is a multiple of n.

A198328	mul	1
# a(2) = 1, a(prime(t)) = prime(a(t))
# Completely M.w. a(2) = 1, a(prime(t)) = prime(a(t)) for t > 1. - _Andrew Howroyd_, Aug 01 2018The Matula-Goebel number of the rooted tree obtained from the rooted tree with Matula-Goebel number n after removing the leaves, together with their incident edges.

A198956	mul	0
# a(3^e) = 3^e, Z.valueOf(sigma_3(p^e)
# Conjecture: M.w. a(3^e) = 3^e, a(p^e) = sigma_3(p^e) for prime p <> 3. - _Andrew Howroyd_, Aug 08 2018q-expansion of modular form psi_0^4/t_{3B}.

A199918	mul	0
# b(p.pow(2*e)) = (neg1(e)) if p == 13, 17, 29, 23 (mod 24), b(p.pow(2*e)) = +1 if p = 1, 5, 7, 11 (mod 24) : b(p.pow(2*e - 1)) = b(2^e) = b(3^e) = 0 if e > 0
# a(n) = b(24*n + 1) where b(n) is M.w. b(p^(2*e)) = (-1)^e if p == 13, 17, 29, 23 (mod 24), b(p^(2*e)) = +1 if p = 1, 5, 7, 11 (mod 24) and b(p^(2*e - 1)) = b(2^e) = b(3^e) = 0 if e > 0.Expansion of false theta series variation of Euler:s pentagonal number series in powers of x.

A204342	mul	0
# b(2^e) = 0^e, b(p^e) = ((p^4)^(e+1) + 1).divide(p^4 + 1) if p == 3 (mod 4), b(p^e) = ((p^4)^(e+1).subtract(1).divide(p^4 - 1) if isMod(4, p, 1)
# a(n) = b(2*n + 1) where b(n) is M.w. b(2^e) = 0^e, b(p^e) = ((p^4)^(e+1) + 1) / (p^4 + 1) if p == 3 (mod 4), b(p^e) = ((p^4)^(e+1) - 1) / (p^4 - 1) if p == 1 (mod 4).a(n) = (-1)^n * Sum_{2*m + 1 | 2*n + 1} (-1)^m (2*m + 1)^4.

A204386	mult	1
#--------> is2(p) ? Z.EIGHT.pow(e).divide2().multiply(3) : (p.pow(3).pow(e+1).subtract(1).divide(p.pow(3).subtract(1)))
# a(n) is M.w. a(2^e) = 3/2 * 8^e if e>0, a(p^e) = ((p^3) ^ (e+1) - 1) / (p^3 - 1).Expansion of (theta_2(q)^8 + 4 * theta_2(q^2)^8) / 256 in powers of q^2.

A204617	mul	1
# p.pow(e-1)*H(p)
# M.w. a(p^e) = p^(e-1)*H(p). H(2)=1, H(p) = p-1 if p=1 (mod 4) and H(p) = p+1 if p=3 (mod 4).Multiplicative with a(p^e) = p^(e-1)*H(p). H(2)=1, H(p) = p-1 if p=1 (mod 4) and H(p) = p+1 if p=3 (mod 4).

A204850	mul	0
# b(2^e) = 0^e, b(3^e) = - (1 + (neg1(e))) * 3^(e/2), b(p^e) = oneOr0(e)* p.pow(e/2) if p == 1, 3 (mod 8), b(p^e) = oneOr0(e)* (-p)^(e/2) if p == 5, 7 (mod 8)
# a(n) = b(8*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = - (1 + (-1)^e) * 3^(e/2), b(p^e) = (1 + (-1)^e)/2 * p^(e/2) if p == 1, 3 (mod 8), b(p^e) = (1 + (-1)^e)/2 * (-p)^(e/2) if p == 5, 7 (mod 8). - _Michael Somos_, Jun 19 2015Expansion of f(x)^3 - 9 * x * f(x^9)^3 in powers of x where f() is a Ramanujan theta function.

A209198	mult	1
#--------> is2(p) ? (e > 1 ? Z.ONE : Z.TWO) : (is3(p) ? (e == 1 ? Z.ONE : p.pow(e)) : (is7(p) ? Z.ZERO : Z.ONE))
# a(n) is M.w. a(2^e) = 1 if e!=1, a(3^e) = 1 if e<2, a(7^e) = 0^e, a(p^e) = 1 otherwise.	a(n) = 1 if n not == 2 (mod 4) and relatively prime to 63 otherwise 0.

A217220	mul	0
# rational b ??? mN == -1 ? super.next() : super.next().multiply(4)	is2(p) ? Z.valueOf((1 + neg1(e))*3/4) : (is3(p) ? Z.ONE : Z.valueOf(isMod(6, p, 5) ? oneOr0(e) : e + 1))
# a(n) = 4 * b(n) where b() is M.w. b(2^e) = (1+(-1)^e)*3/4, b(3^e) = 1, b(p^e) = (1+(-1)^e)/2 if p == 5 (mod 6), b(p^e) = e+1 if p == 1 (mod 6). - _Michael Somos_, Feb 01 2017Theta series of Kagome net with respect to an atom.

A226010	mul	1
# a(2^n) = (-64)^n, Z.valueOf(a(p) * a(p.pow(e-1)) - p^13 * a(p.pow(e-2)) if p>2
# a(n) is M.w. a(2^n) = (-64)^n, a(p^e) = a(p) * a(p^(e-1)) - p^13 * a(p^(e-2)) if p>2.Expansion of u1 * (u1 + u4) * (u1^2 - 2 * u1 * u4 - u4^2) / eta(q^2)^4 in powers of q where u1 = eta(q)^8 and u4 = 32 * eta(q^4)^8.

A226075	mul	1
# a(11^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) if p != 11
# a(n) is M.w. a(11^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) if p != 11.Expansion of (eta(q) * eta(q^11))^2 + 2 * (eta(q^2) * eta(q^22))^2 in powers of q.

A226086	mul	1
# a(2^n) = 64^n, Z.valueOf(a(p) * a(p.pow(e-1)) - p^13 * a(p.pow(e-2)) if p>2
# a(n) is M.w. a(2^n) = 64^n, a(p^e) = a(p) * a(p^(e-1)) - p^13 * a(p^(e-2)) if p>2.Expansion of (2 * eta(q^2)^24 - eta(q)^16 * eta(q^4)^8)^3 / (eta(q)^4 * eta(q^2) * eta(q^4)^6)^4 in powers of q.

A226162	mult	0
#--> is2(p) && e == 1 ? Z.NEG_ONE : (is5(p) && e == 1 ? Z.ZERO : (isMod(20, p, 1, 3, 7, 9) ? Z.ONE : Z.NEG_ONE))
# Completely M.w. a(2) = -1, a(5) = 0, a(p) = 1 if p == 1, 3, 7, 9 (mod 20), a(p) = -1 if p == 11, 13, 17, 19 (mod 20)

A226333	mult	1
#--> is5(p) ? p.pow(3*e) : p.pow(3*(e+1)).subtract(1).divide(p.pow(3).subtract(1))
# a(n) is M.w. a(p^e) = p^(3*e) if p=5, else a(p^e) = (p^(3*(e+1)) - 1) / (p^3 - 1).

A226347	mul	1
# is5(p) ? p.pow(2*e) : ??? a(p) * a(p.pow(e-1)) - p^6 * a(p.pow(e-2))
# a(n) is M.w. a(p^e) = p^(2*e) if p=5, else a(p^e) = a(p) * a(p^(e-1)) - p^6 * a(p^(e-2)).Expansion of the unique normalized cusp form of Gamma_0(5) of weight 6 in powers of q.

A226602	mul	0
# b(1) = 1, and
# Dirichlet inverse b(n), n>0, is M.w. b(1) = 1, and for p prime and e>0: b(p^e)=0 if e mod 3 = 0 otherwise b(p^e)=3*(-1)^(e mod 3).Number of ordered triples (i,j,k) with i*j*k = n, i,j,k >= 0 and gcd(i,j,k) <= 1.

A227128	mult	1
#--> is3(p) ? p.pow(e) : p.pow(e - 1).multiply(p.add(isMod(3, p, 1) ? -1 : 1))
# M.w. a(3^e)=3^e, a(p^e) = p^(e-1)*(p-1) if p== 1 (mod 3) and a(p^e) = p^(e-1)*(p+1) if p = 2 (mod 3). - _R. J. Mathar_, Jul 10 2013The twisted Euler phi-function for the non-principal Dirichlet character mod 3.

A227131	mult	0
#--------> is5(p) ? Z.SIX : sigmaP(p, e)
# a(n) is M.w. a(0) = 1, a(5^e) = 6 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) otherwise.Sum of divisors of n that are not divisible by 25. a(0) = 1.

A227239	mul	1
# is2(p) ? Z.valueOf(e == 1 ? 8 : 0) : ??
# a(2) = 8, is2(p) ? Z.valueOf(0 if e > 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p^5 * a(p.pow(e-2)) if p > 2a(n) is M.w. a(2) = 8, a(2^e) = 0 if e > 1, a(p^e) = a(p) * a(p^(e-1)) - p^5 * a(p^(e-2)) if p > 2.Expansion of q * f(-q^2)^12 + 8 * q^2 * f(-q^4)^12 in powers of q where f() is a Ramanujan theta function.

A227354	mul	0
#rational b ??? mN == -1 ? super.next() : super.next().multiply(12)	is2(p) ? Z.valueOf((1 + 3*neg1(e)) / 4) : (is3(p) ? Z.ONE : Z.valueOf(isMod(6, p, 1) ? e + 1 : oneOr0(e)))
# a(n) = 12 * b(n) where b(n) is M.w. b(2^e) = (1 + 3*(-1)^e) / 4, b(3^e) = 1, b(p^e) = e+1 if p == 1 (mod 6), b(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).Expansion of 2 * a(q) - a(q^2) in powers of q where a() is a cubic AGM theta function.

A228072	mul	0
# b(2^e) = 0^e, b(p^e) = b(p) * b(p.pow(e-1)) - p^3 * b(p.pow(e-2)) if p>2
# a(n) = b(2*n + 1) where b(n) is M.w. b(2^e) = 0^e, b(p^e) = b(p) * b(p^(e-1)) - p^3 * b(p^(e-2)) if p>2.Expansion of psi(x^2)^2 * phi(-x^2)^6 + 8 * x * psi(x^2)^6 * phi(-x^2)^2 in powers of x where phi(), psi() are Ramanujan theta functions.

A228443	mul	0
# b(2^e) = 0^e, b(p^e) = (sigmaP(p, e) if isMod(4, p, 1), b(p^e) = (p.pow(e+1) + (neg1(e))).divide(p + 1) if p == 3 (mod 4), with a(0) = 1
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(p^e) = (p^(e+1) - 1) / (p - 1) if p == 1 (mod 4), b(p^e) = (p^(e+1) + (-1)^e) / (p + 1) if p == 3 (mod 4), with a(0) = 1.G.f.: Sum_{k>=0} (2*k + 1) * x^k / (1 + x^(2*k + 1)).

A228731	mul	1
# a(prime(t)) = A228732(t)
# Completely M.w. a(prime(t)) = A228732(t). - _Andrew Howroyd_, Aug 01 2018Number of independent subsets in the rooted tree with Matula-Goebel number n that contain the root.

A228732	mul	1
# a(prime(t)) = A228731(t) + A228732(t)
# Completely M.w. a(prime(t)) = A228731(t) + A228732(t). - _Andrew Howroyd_, Aug 01 2018Number of independent subsets in the rooted tree with Matula-Goebel number n that do not contain the root.

A228745	mul	0
# mN == -1 ? super.next() : super.next().multiply(-6)	is2(p) ? (e == 1 ? Z.TWO : Z.valueOf(-4)) : b(p^e) = ???  b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)), if p>2
# a(n) = -6 * b(n) where b() is M.w. a(0) = 1, b(2^e) = -4 if e>1, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)), if p>2.Expansion of (phi(q)^4 + 7 * phi(-q)^4) / 8 in powers of q where phi() is a Ramanujan theta function.

A229143	mult	1
#--------> is3(p) ? Z.valueOf(e == 1 ? -3 : 0) : (p.mod(Z.THREE).equals(Z.ONE) ? Z.valueOf(e+1) : Z.valueOf((1+(neg1(e)))/2))
# a(n) is M.w. a(3) = -3, a(3^e) = 0 if e>1, a(p^e) = e+1 if p == 1 (mod 3), a(p^e) = (1 + (-1)^e) / 2 if p == 2 (mod 3).Expansion of (b(q^3) - b(q)) / 3 in powers of q where b() is a cubic AGM theta function.

A229297	mult	1
#--> is2(p) && ((e & 1) == 1) ? Z.ZERO : p.pow(e/2)
# M.w. a(2^e) = 1 + (-1)^e, a(p^e) = p^floor(e/2) for odd prime p. is2(p) ? Z.ONE.add(neg1(e)) : p.pow(e/2)

A230277	mul	1
# is2(p) ? Z.valueOf(-(-2)^e if e>0,  a(3^e) = 0^e, p^e * oneOr0(e)if p == 3, 7 (mod 8), Z.valueOf(a(p)*a(p.pow(e-1)) - p^2*a(p.pow(e-2)) : a(p) = t * (-1)^(t mod 3) if p == 1, 5 (mod 8) where t = 2 * if( p == 5 (mod 6) then 4*x*y else p - 8*y^2 ) : p = x^2 + 4*y^2
# a(n) is M.w. a(2^e) = -(-2)^e if e>0,  a(3^e) = 0^e, a(p^e) = p^e * (1 + (-1)^e)/2 if p == 3, 7 (mod 8), a(p^e) = a(p)*a(p^(e-1)) - p^2*a(p^(e-2)) and a(p) = t * (-1)^(t mod 3) if p == 1, 5 (mod 8) where t = 2 * if( p == 5 (mod 6) then 4*x*y else p - 8*y^2 ) and p = x^2 + 4*y^2.Expansion of f(-q^6)^6 * ( q * chi(-q^3)^4 + 2*q^2 / chi(-q^3)^4 ) in powers of q where chi(), f() are Ramanujan theta functions.

A234565	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = oneOr0(e)* p.pow(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p.pow(e-1)) - p^4 * b(p.pow(e-2)) if p == 1 or 5 (mod 12)
# a(n) = b(4*n + 1) where b() is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e) / 2 * p^(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p^(e-1)) - p^4 * b(p^(e-2)) if p == 1 or 5 (mod 12).Expansion of f(-q^3)^2 * Q(q^3) + 48 * q * f(-q^3)^10 in powers of q.

A234744	mul	0
# a(p_i) = p_{A235048(i)}
# M.w. a(p_i) = p_{A235048(i)} for primes with index i, except for cases i=3 and i=4, use p_18 and p_8 (61 and 19) instead of 19 and 61. For the composites, the value is determined as: a(u*v) = a(u) * a(v).Multiplicative permutation of integers: a(n) = A234840(A235199(n)).

A234747	mul	0
# p_i = p_{A234751(i)} (where p_i stands
# Completely M.w. p_i = p_{A234751(i)} (where p_i stands for the i-th prime, A000040(i)), and a(x*y) = a(x)*a(y) for x, y > 0.Self-inverse and multiplicative permutation of natural numbers, A091202-conjugate of Blue code: a(n) = A091203(A193231(A091202(n))).

A235027	mul	0
# a(0)=0, a(1)=1, a(p) = A056539(p)
# Completely M.w. a(0)=0, a(1)=1, a(p) = A056539(p) for primes p (which maps 2 to 2, and reverses the binary representation of odd primes), and a(u*v) = a(u) * a(v) for composites.Reverse the bits of prime divisors of n (with 2 -> 2), and multiply together: a(0)=0, a(1)=1, a(2)=2, a(p) = revbits(p) for odd primes p, a(u*v) = a(u) * a(v) for composites.

A235201	mul	0
# a(3^k) = Z.ONE.shiftLeft(2k), a(Z.ONE.shiftLeft(2k)) = 3^k, a(Z.ONE.shiftLeft(2k+1)) = 2*3^k, a(p_i) = p_{a(i)}
# M.w. a(3^k) = 2^(2k), a(2^(2k)) = 3^k, a(2^(2k+1)) = 2*3^k, a(p_i) = p_{a(i)} for primes with index i > 2, and for composites > 4, a(u * v) = a(u) * a(v) for u, v > 0.Self-inverse and multiplicative permutation of integers: a(0)=0, a(1)=1, a(2)=2, a(3)=4 and a(4)=3, a(p_i) = p_{a(i)} for primes with index i > 2, and for composites > 4, a(u * v) = a(u) * a(v) for u, v > 0.

A235487	mul	0
# a(p_i) = p_{a(i)}
# M.w. a(p_i) = p_{a(i)} for primes with index i <> 4, a(7) = 8, a(2^(3k)) = 7^k, a(2^(3k+1)) = 2*7^k, a(2^(3k+2)) = 4*7^k, and for other composites, a(u * v) = a(u) * a(v).Self-inverse and multiplicative permutation of integers: For n < 7, a(n)=n, a(7)=8 and a(8)=7, a(p_i) = p_{a(i)} for primes with index i <> 4, and for composites > 8, a(u*v) = a(u) * a(v).

A235489	mul	0
# a(3^(2k)) = 2^3k = 8^k, a(3^(2k+1)) = 3*2^3k, a(Z.ONE.shiftLeft(3k)) = 3^2k = 9^k, a(Z.ONE.shiftLeft(3k+1)) = 2*9^k, a(Z.ONE.shiftLeft(3k+2)) = 4*9^k, a(p_i) = p_{a(i)}
# M.w. a(3^(2k)) = 2^3k = 8^k, a(3^(2k+1)) = 3*2^3k, a(2^(3k)) = 3^2k = 9^k, a(2^(3k+1)) = 2*9^k, a(2^(3k+2)) = 4*9^k, a(p_i) = p_{a(i)} for primes with index i, and a(u*v) = a(u) * a(v) for composites other than 8 or 9.Self-inverse and multiplicative permutation of integers: For n < 8, a(n) = n, a(8)=9 and a(9)=8, a(p_i) = p_{a(i)} for primes with index i, and for composites > 9, a(u*v) = a(u) * a(v).

A236852	mul	0
# a(p) = A234742(p) although neither A234741 or A234742 are even multiplicative
# This sequence appears to be completely M.w. a(p) = A234742(p) although neither A234741 or A234742 are even multiplicative. Terms tested up to n = 10^7. - _Andrew Howroyd_, Aug 01 2018Remultiply n first "downward", from N to GF(2)[X], and then remultiply that result back "upward", from GF(2)[X] to N: a(n) = A234742(A234741(n)).

A241405	mult	1
#-->Integers.SINGLETON.sumdiv(e + 1, d -> p.pow(d - 1))
# M.w. a(p^a) = sum p^b such that b+1 divides a+1.Sum of modified exponential divisors: if n = product p_i^r_i then me-sigma(x) = product (sum p_i^s_i such that s_i+1 divides r_i+1).

A245485	mult	1
#--------> is7(p) ? Z.valueOf(neg1(e)) : Z.valueOf((1 + (neg1(e))) / 2)
# a(n) is M.w. a(p^e) = (-1)^e if p = 7, a(p^e) = (1 + (-1)^e) / 2 otherwise.a(n) = 1 if n is a square, -1 if n is seven times a square, 0 otherwise.

A245572	multb	0
#-->mN == -1 ? super.next().add(2) : super.next().multiply2()	is2(p) ? (e == 1 ? Z.NEG_ONE : Z.THREE) : Z.valueOf(isMod(8, p, 1, 3) ? e + 1 : oneOr0(e))
# a(n) = 2 * b(n) where b(n) is M.w. b(2) = -1, b(2^e) = 3 if e>1, b(p^e) = e+1 if p == 1, 3 (mod 8), b(p^e) = (1 + (-1)^e)/2 if p == 5, 7 (mod 8).Expansion of phi(q) * phi(q^2) + 2 * phi(-q^2) * phi(q^4) in powers of q where phi() is a Ramanujan theta function.

A247067	mul	1
# is2(p) ? Z.valueOf((-64)^e, p.pow(6*e) * oneOr0(e)if p == 3 (mod 4), Z.valueOf(a(p) * a(p.pow(e-1)) - p^12 * a(p.pow(e-2)) if isMod(4, p, 1) where a(p) = 2 * Re( (x + i*y)^12 ) : p = x^2 + y^2 with even x
# a(n) is M.w. a(2^e) = (-64)^e, a(p^e) = p^(6*e) * (1 + (-1)^e)/2 if p == 3 (mod 4), a(p^e) = a(p) * a(p^(e-1)) - p^12 * a(p^(e-2)) if p == 1 (mod 4) where a(p) = 2 * Re( (x + i*y)^12 ) and p = x^2 + y^2 with even x. - _Michael Somos_, Nov 18 2014

A247198	mul	1
# is2(p) ? Z.valueOf((neg1(e)), a(13^e) = 1, else Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(2^e) = (-1)^e, a(13^e) = 1, else a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.Coefficients of L-series for elliptic curve "26a3": y^2 + x * y - y = x^3 + x or y^2 + x*y + y = x^3.

A247257	mult	1
#--------> is2(p) ? p.pow(e-1 < 4 ? e-1 : 4) : p.subtract(1).gcd(Z.EIGHT)
# M.w. a(p^e) = p^min(e-1, 4) if p = 2, gcd(8, p-1) if p > 2. - _Jianing Song_, Nov 10 2019The number of octic characters modulo n.

A247503	mul	1
# a(prime(n)) = prime(n)^(n mod 2)
# Completely M.w. a(prime(n)) = prime(n)^(n mod 2).Completely multiplicative with a(prime(n)) = prime(n)^(n mod 2).

A248003	mult	1
#--------> p.subtract(1).multiply(p.pow(2*e-1)).divide2()
# a(n) is M.w. a(p^e) = (p-1)*p^(2e-1)/2.a(n) = (sum of totatives of n ) / (2^(omega(n)-1)); a(n) = A023896(n) / A007875(n).

A248101	mul	1
# a(prime(n)) = prime(n)^((n+1) mod 2)
# Completely M.w. a(prime(n)) = prime(n)^((n+1) mod 2).Completely multiplicative with a(prime(n)) = prime(n)^((n+1) mod 2).

A248692	mul	1
# a(prime(i)) = 2^i
# Fully M.w. a(prime(i)) = 2^i.Fully multiplicative with a(prime(i)) = 2^i; If n = product_{k >= 1} (p_k)^(c_k) where p_k is k-th prime A000040(k) and c_k >= 0 then a(n) = product_{k >= 1} 2^(k*c_k).

A249010	mul	0
# b(2^e) = 2 - 2^e, b(5^e) = 1, : b(p^e) = (sigmaP(p, e)
# If n>0 then a(n) = -3 * b(n) where b is M.w. b(2^e) = 2 - 2^e, b(5^e) = 1, and b(p^e) = (p^(e+1) - 1) / (p - 1) otherwise.Expansion of (P(q) - 3*P(q^2) - 5*P(q^5) + 15*P(q^10)) / 8 in powers of q where P() is a Ramanujan Eisenstein series.

A251913	mul	1
# is2(p) ? Z.ONE , a(13^e) = (neg1(e)), else Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(2^e) = 1, a(13^e) = (-1)^e, else a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.Coefficients of L-series for elliptic curve "26b1": y^2 + x * y - 2*y = x^3 + 2*x^2.

A252731	mul	0
# b(p^e) = (neg1(e)) if p = 11, b(p^e) = b(p)*b(p.pow(e-1)) - p*b(p.pow(e-2)) if p != 11
# a(n) = b(2*n + 1) where b() is M.w. b(p^e) = (-1)^e if p = 11, b(p^e) = b(p)*b(p^(e-1)) - p*b(p^(e-2)) if p != 11.Fourier expansion of the unique newform on Gamma_0(44).

A253193	mul	1
# b(23^e) = 1,  b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2))
# If b(n) = a(n) - (1 + sqrt(5))/2 * A232506(n) then b() is M.w. b(23^e) = 1, otherwise b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)).Expansion of a weight 2 Gamma0(23) cusp form in powers of q with a(1) = 1, a(2) = 0.

A254503	mult	1
#----> e == 1  ? p : Z.valueOf(LongUtils.phi(p.pow(e).longValue()))
# M.w. a(p) = p; a(p^e) = phi(p^e), for e > 1.M√∂bius transform of A034448.

A255647	multp1	0
#----> is2(p) || p.equals(Z.valueOf(11)) ? Z.valueOf(LongUtils.kronecker(-22, p.intValue()) == +1 ? e+1 : (1 + (neg1(e)))/2)
# a(n) is M.w. a(p^e) = 1 if p = 2 or 11, a(p^e) = e+1 if Kronecker(-22, p) = +1, a(p^e) = (1 + (-1)^e)/2 if Kronecker(-22, p) = -1, and with a(0) = 1.

A255648	mult	1
#----> is2(p) ? Z.ONE : (is3(p) ? Z.valueOf(e == 0 ? 1 : 2) : Z.valueOf(isMod(6, p, 1) ? e+1 : (1 + (neg1(e)))/2))
# a(n) is M.w. a(2^e) = 1, a(3^e) = 2 if e>1, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A256678	mul	1
# a(p)???  is2(p) ? Z.ONE : (p.equals(Z.valueOf(17)) ? Z.valueOf((neg1(e))) : p.pow(e))
# a(n) is M.w. a(2^e) = 1, a(17^e) = (-1)^e. For p prime, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) and a(p) = p minus number of points of elliptic curve modulo p.Coefficients of L-series for elliptic curve "34a1": y^2 + x*y = x^3 - 3*x + 1.

A257403	mult	1
#----> is2(p) ? Z.valueOf(e == 1 ? 1 : 0) : (is3(p) ? Z.ZERO : Z.valueOf(isMod(8, p, 1, 3) ? e+1 : (1 + (neg1(e))) / 2))
# M.w. a(2) = 1, a(2^e) = 0 if e>1, a(3^e) = 0^e, a(p^e) = e+1 if p == 1, 3 (mod 8), a(p^e) = (1 + (-1)^e) / 2 if p == 5, 7 (mod 8).

A257477	mult	1
#----> is2(p) ? Z.valueOf(e == 1 ? 0 : (e == 2 ? -1 : 0)) : (is3(p) ? Z.valueOf(e == 1 ? -1 : 0) : Z.valueOf((isMod(8, p, 1, 3) ? 1 : (neg1(e)))))
# M.w. a(2) = 0, a(4) = -1, a(2^e) = 0 if e>2, a(3) = -1, a(3^e) = 0^e if e>1, a(p^e) = 1 if p == 1, 3 (mod 8), a(p^e) = (1 + (-1)^e) / 2 if p == 5, 7 (mod 8).

A257538	mul	1
# a(prime(n)) = prime(prime(a(n)))
# Fully M.w. a(prime(n)) = prime(prime(a(n))). - _Antti Karttunen_, Mar 09 2017

A257900	mult	1
#---->is2(p) ? Z.NEG_ONE : (is3(p) ? Z.valueOf(1 + (neg1(e))) : (isMod(4, p, 3, 4) ? Z.valueOf((1 + (neg1(e)))/2) : Z.valueOf(e+1)))
# a(n) is M.w. a(2^e) = -1 if e>0, a(3^e) = 1 + (-1)^e if e>0, a(p^e) = (1 + (-1)^e) / 2 if p == 3 (mod 4), a(p^e) = e+1 if p == 1 (mod 4).

A258739	mul	0
# b(2^e) = 0^e, b(p^e) = oneOr0(e)* p.pow(5*e/2) if p == 3 (mod 4), b(p^e) = b(p) * b(p.pow(e-1)) - p^4 * b(p.pow(e-2)) if isMod(4, p, 1)
# a(n) = b(4*n + 1) where b(n) is M.w. b(2^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 * p^(5*e/2) if p == 3 (mod 4), b(p^e) = b(p) * b(p^(e-1)) - p^4 * b(p^(e-2)) if p == 1 (mod 4).Expansion of (f(-x)^3 / f(-x^2))^6 - 64 * x * (f(-x^2)^3 / f(-x))^6 in powers of x where f() is a Ramanujan theta function.

A138507	mult	1
#--------> is2(p) ? Z.TWO.negate().pow(e+1).subtract(1).divide(3) : (is5(p) ? Z.ONE : (isMod(10, p, 3, 7) ? p.negate().pow(e+1).subtract(1).divide(p.add(1).negate()) : sigmaP(p, e)))
# a(n) is M.w. a(2^e) = ((-2)^(e+1) - 1) / 3, a(p^e) = ((-p)^(e+1) - 1) / (-p - 1) if p == 3, 7 (mod 10), a(p^e) = (p^(e+1) - 1) / (p - 1) if p == 1, 9 (mod 10).

A258260	multp1	0
#--------> is2(p) ? (e == 1 ? Z.ONE : Z.ZERO) : (is3(p) ? Z.valueOf(e == 1 ? -1 : 4*(neg1(e))) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.ONE : Z.valueOf(neg1(e))))
# a(n) is M.w. a(2) = 1, a(2^e) = 0 if e>1, a(3) = -1, a(3^e) = 4 * (-1)^e if e>1, a(p^e) = 1 if p == 1 (mod 4), a(p^e) = (-1)^e if p == 3 (mod 4).

A258998	multp1	0
#--------> is2(p) ? (((e & 1) == 0) ? Z.valueOf(((e & 2) == 0) ? 1 : -1) : Z.ZERO) : (((e & 1) == 0) ? Z.ONE : Z.ZERO)
# is2(p) ? Z.valueOf((-1)^(e/2) if e even, Z.ONE if p>2 : e even,  0
# a(n) is M.w. a(2^e) = (-1)^(e/2) if e even, a(p^e) = 1 if p>2 and e even, otherwise 0. a(n) = -(-1)^n if n = k^2 for positive integer k, otherwise 0.

A138505	mult	1
#----> is2(p) ? Z.NEG_ONE : (isMod(4, p, 1) ? p.square().pow(e+1).subtract(1).divide(p.square().subtract(1)) : p.square().negate().pow(e+1).subtract(1).divide(p.square().negate().subtract(1)))
# a(n) is M.w. a(2^e) = -1 if e>0, a(p^e) = ((p^2)^(e+1) - 1) / (p^2 - 1) if p == 1 (mod 4), a(p^e) = ((-p^2)^(e+1) - 1) / ( -p^2 - 1) if p == 3 (mod 4).

A259024	mult	1
#--> is2(p) ? Z.valueOf(oneOr0(e)) : (is3(p) ? Z.valueOf(e == 1 ? -1 : 0) : (isMod(6, p, 1) ? Z.ONE : Z.valueOf(neg1(e))))
# a(n) is M.w. a(2^e) = (1 + (-1)^e) / 2, a(3) = -1, a(3^e) = 0 if e>1, a(p^e) = 1 if p == 1 (mod 6), a(p^e) = (-1)^e if p == 5 (mod 6).

A259030	mult	1
#----> is2(p) ? Z.valueOf(-(1 - (neg1(e))) / 2) : Z.valueOf(LongUtils.kronecker(5, p.intValue())).pow(e)
# a(n) is M.w. a(2^e) = -(1 - (-1)^e) / 2 if e > 0, a(p^e) = Kronecker(5, p)^e if p > 2.

A259445	mult	1
#----> is2(p) ? Z.TWO : p.pow(e)
# M.w. a(n) = n if n is odd and a(2^s)=2.

A259761	multb	0
#-->mN == -1 ? super.next() : super.next().multiply2()	is2(p) ? Z.ONE : Z.valueOf(is3(p) ? 1 + neg1(e) : (isMod(12, p, 1, 5) ? e + 1 : oneOr0(e)))
# a(n) = 2 * b(n) with a(0) = 1 and b() is M.w. b(2^e) = 1, b(3^e) = 1 + (-1)^e if e>0, b(p^e) = e+1 if p == 1, 5 (mod 12), (p^e) = (1 + (-1)^e)/2 if p == 7, 11 (mod 12).Expansion of (phi(x)^2 + phi(x^9)^2) / 2 in powers of x where phi() is a Ramanujan theta function.

A260649	mult	1
#--> is2(p) ? Z.valueOf(e-1) : (is3(p) || is5(p) ? Z.ONE : Z.valueOf(isMod(15, p, 1, 2, 4, 8) ? e+1 : oneOr0(e)))
# a(n) is M.w. a(2^e) = |e-1|, a(3^e) = a(5^e) = 1, a(p^e) = e+1 if p == 1, 2, 4, 8 (mod 15), a(p^e) = (1 + (-1)^e)/2 if p == 7, 11, 13, 14 (mod 15).Expansion of (phi(q^3) * phi(q^5) + phi(q) * phi(q^15)) / 2 - 1 in powers of q where phi(q) is a Ramanujan theta function.

A261277	mul	0
# b(2^e) = 0^e, b(3^e) = -2 * (neg1(e)) if e>0, b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p>3
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = -2 * (-1)^e if e>0, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p>3.Expansion of q^(-1/2) * (eta(q^3)^8 + 4 * eta(q^6)^8)^(1/2) in powers of q.

A261278	mul	1
# a(Z.ONE.shiftLeft(2*k)) = (-8)^k, a(Z.ONE.shiftLeft(2*k+1)) = 4 * (-8)^k, a(3^e) = 0^e, a(p.pow(2*k)) = (-p)^(3^k) : a(p.pow(2*k+1)) = 0 if p == 5 (mod 6), Z.valueOf(a(p) * a(p.pow(e-1)) - p^3 * a(p.pow(e-2)) if p == 1 (mod 6)
# a(n) is M.w. a(2^(2*k)) = (-8)^k, a(2^(2*k+1)) = 4 * (-8)^k, a(3^e) = 0^e, a(p^(2*k)) = (-p)^(3^k) and a(p^(2*k+1)) = 0 if p == 5 (mod 6), a(p^e) = a(p) * a(p^(e-1)) - p^3 * a(p^(e-2)) if p == 1 (mod 6).Expansion of eta(q^3)^8 + 4 * eta(q^6)^8 in powers of q.

A261884	mult	1
#--> is2(p) ? Z.valueOf(neg1(e)) : (is3(p) ? Z.NEG_ONE : Z.valueOf(isMod(6, p, 1) ? e+1 : oneOr0(e)))
# a(n) is M.w. a(2^e) = (-1)^e, a(3^e) = -1 if e>0, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e)/2 if p == 5 (mod 6).

A262209	mul	1
# Z.ONE if p=2; Z.valueOf(0 if e odd : p in A002145; Z.ONE if e even : p in A002145; Z.valueOf(e+1 if p in A002144
# Conjecture: M.w. a(p^e) = 1 if p=2; a(p^e) = 0 if e odd and p in A002145; a(p^e) = 1 if e even and p in A002145; a(p^e) = e+1 if p in A002144.Inverse Mobius Transform of A002654.

A262401	mul	1
# p -> A054055(p), p prime
# M.w. p -> A054055(p), p prime.In prime factorization of n: replace each factor with its largest decimal digit.

A262780	mul	0
# b(2^e) = 0^e, b(3^e) = 1, b(p^e) = e+1 if p == 1, 19 (mod 24), b(p^e) = (neg1(e)) * (e+1) if p == 7, 13 (mod 24), b(p^e) = oneOr0(e)if p == 5 (mod 6)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = 1, b(p^e) = e+1 if p == 1, 19 (mod 24), b(p^e) = (-1)^e * (e+1) if p == 7, 13 (mod 24), b(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).Expansion of phi(-x^6) * psi(x^4) + x * phi(-x^2) * psi(x^12) in powers of x where phi(), psi() are Ramanujan theta functions.

A263571	mul	0
# b(2^e) = b(3^e) = (neg1(e)), b(p^e) = e+1 if p == 1, 7 (mod 24), b(p^e) = (e+1) * (neg1(e)) if p == 5, 11 (mod 24), b(p^e) = oneOr0(e)if p == 13, 17, 19, 23 (mod 24)
# a(n) = b(3*n + 1) where b() is M.w. b(2^e) = b(3^e) = (-1)^e, b(p^e) = e+1 if p == 1, 7 (mod 24), b(p^e) = (e+1) * (-1)^e if p == 5, 11 (mod 24), b(p^e) = (1 + (-1)^e) / 2 if p == 13, 17, 19, 23 (mod 24).Expansion of f(x^2, x^2) * f(x, x^5) in powers of x where f(, ) is Ramanujan:s general theta function.

A263649	mult	1
#--> Z.valueOf(is2(p) ? neg1(e) : (is3(p) ? neg1(e)*(-2) : (isMod(24, p, 1, 7) ? e+1 : (isMod(24, p, 5, 11) ? (e+1)*neg1(e) : oneOr0(e)))))
# a(n) is M.w. a(2^e) = (-1)^e, a(3^e) = -2*(-1)^e if e>0, a(p^e) = e+1 if p == 1, 7 (mod 24), a(p^e) = (e+1) * (-1)^e if p == 5, 11 (mod 24), a(p^e) = (1 + (-1)^e) / 2 if p == 13, 17, 19, 23 (mod 24).

A264740	mult	1
#--> is2(p) ? Z.valueOf(e+1) : sigmaP(p, e)
# M.w. a(2^k) = k + 1, a(p^k) = sigma(p^k) = (p^(k+1)-1) / (p-1) for p > 2.Sum of odd parts of divisors of n.

A265398	mul	1
# a(2) = 2, a(3) = 3, a(prime(k)) = prime(k-1) * prime(k-2)
# Completely M.w. a(2) = 2, a(3) = 3, a(prime(k)) = prime(k-1) * prime(k-2) for k > 2. - _Andrew Howroyd_ & _Antti Karttunen_, Aug 04 2018Perform one x^2 -> x+1 reduction for the polynomial with nonnegative integer coefficients that is encoded in the prime factorization of n.

A265399	mul	1
# a(2) = 2, a(3) = 3, a(p) = a(A265398(p))
# Completely M.w. a(2) = 2, a(3) = 3, a(p) = a(A265398(p)) for p > 3. - _Andrew Howroyd_ & _Antti Karttunen_, Aug 04 2018Repeatedly perform x^2 -> x+1 reduction for polynomial (with nonnegative integer coefficients) encoded in prime factorization of n, until the polynomial is at most degree 1.

A266288	mult	1
#--------> { final int m = p.mod(Z.THREE).intValue(); final int s = (m == 0 ? 0 : (m == 1 ? 1 : -1)); return p.pow(4).pow(e+1).subtract(Z.valueOf(s).pow(e+1)).divide(p.pow(4).subtract(Z.valueOf(s))); }
# a(n) is M.w. a(p^e) = ((p^4)^(e+1) - s^(e+1)) / (p^4 - s) where s = 0 if p = 3, s = 1 if p == 1 (mod 3), s = -1 if p == 2 (mod 3).Expansion of a(q)^2 * (c(q)/3)^3 in powers of q where a(), c() are cubic AGM theta functions.

A267099	mul	1
# a(p_n) = p_{A267100(n)} = A267101(n)
# Fully M.w. a(p_n) = p_{A267100(n)} = A267101(n).Fully multiplicative involution swapping the positions of 4k+1 and 4k+3 primes: a(1) = 1; a(prime(k)) = A267101(k), a(x*y) = a(x)*a(y) for x, y > 1.

A267326	mul	1
# a factor of 8: a(k*m) = 8*a(k)*a(m)
# For all pair of relatively prime numbers k, m this sequence is M.w. a factor of 8: a(k*m) = 8*a(k)*a(m). - _Christopher Heiling_, Apr 02 2017Number of ways writing n^2 as a sum of four squares: a(n) = A000118(n^2).

A268385	mul	1
# p^e -> p^A193231(e), p prime : e > 0
# M.w. p^e -> p^A193231(e), p prime and e > 0.a(1) = 1, for n > 1, a(n) = A020639(n)^A193231(A067029(n)) * a(A028234(n)).

A270418	mul	1
# p^A065620(e)
# M.w. a(p^e) = p^A065620(e) for odious e, a(p^e)=1 for evil e, or equally, a(p^e) = p^(A010060(e)*A065620(e)).Numerator of the rational number obtained when exponents in prime factorization of n are reinterpreted as alternating binary sums (A065620).

A270419	mul	1
# p.pow(-A065620(e))
# M.w. a(p^e) = p^(-A065620(e)) for evil e, a(p^e)=1 for odious e, or equally, a(p^e) = p^(A010059(e) * -A065620(e)).Denominator of the rational number obtained when the exponents in prime factorization of n are reinterpreted as alternating binary sums (A065620).

A270436	mul	1
# p^A065621(e)
# M.w. a(p^e) = p^A065621(e).a(1) = 1, for n > 1, a(n) = A020639(n)^A065621(A067029(n)) * a(A028234(n)).

A270437	mult	1
#--------> p.pow(e ^ (2*e))
# M.w. a(p^e) = p^A048724(e), where A048724(e) = (e XOR 2e).a(1) = 1, for n > 1, a(n) = A020639(n)^A048724(A067029(n)) * a(A028234(n)).

A275966	mul	1
# a(p^n) = Re(I^(p^n+1) - I^(p.pow(n-1)+1))
# This function is M.w. a(p^n) = Re(I^(p^n+1) - I^(p^(n-1)+1)).a(n) is the real part of -I*Sum_{d|n}(mobius(d)*I^(n/d)), I=sqrt(-1), mobius(n) is A008683.

A277076	mul	0
# b(p^e) = 0^e if p=3 : b(p^e) = b(p)*b(p.pow(e-1))  - p^7*b(p.pow(e-2))
# a(n) = b(3*n+1) where b() is M.w. b(p^e) = 0^e if p=3 and b(p^e) = b(p)*b(p^(e-1))  - p^7*b(p^(e-2)) otherwise.Expansion of f(-x)^8 * Q(x) in powers of x where f() is a Ramanujan theta function and Q() is a Ramanujan Lambert series.

A277847	mul	1
# Z.valueOf(2 if p = 2; oddpart(p-1)*p.pow(e-1) + 1 if p > 2
# M.w. a(p^e) = 2 if p = 2; oddpart(p-1)*p^(e-1) + 1 if p > 2.Size of the largest subset of Z/nZ fixed by x -> x^2.

A278086	mul	1
# a(2) = 1, is2(p) ? Z.valueOf(0
# Conjecture: a(n) is M.w. a(2) = 1, a(2^k) = 0 for k >= 2, and for k >= 1 and p an odd prime, a(p^k) = p^(k-1)*a(p) with a(p) = p + 1 for p == (2, 3, 8, 10, 12, 13, 14, 15, 18) (mod 19), a(p) = p - 1 for p == (1, 4, 5, 6, 7, 9, 11, 16, 17) (mod 19), and p(19) = 19.  It would be nice to have a proof of this.1/12 of the number of integer quadruples with sum = 3*n and sum of squares = 7*n^2.

A278908	mul	1
# Z.valueOf(2^omega(e), where omega = A001221
# M.w. a(p^e) = 2^omega(e), where omega = A001221.Multiplicative with a(p^e) = 2^omega(e), where omega = A001221.

A279371	mul	1
# a(11^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2))
# a(n) is M.w. a(11^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) for p != 11.Expansion of F(q) + 4*F(q^2) + 8*F(q^4) in powers of q where F(q) = q * (f(-q) * f(-q^11))^2.

A279510	mul	1
# a(p(i)^j) = p(i+1)^a(j)
# M.w. a(p(i)^j) = p(i+1)^a(j) for i-th prime p(i) and j>0.Multiplicative with a(p(i)^j) = p(i+1)^a(j) for i-th prime p(i) and j>0.

A279513	mul	1
# p*a(e)
# M.w. a(p^k) = p*a(k) for any prime p and k>0.Multiplicative with a(p^k) = p*a(k) for any prime p and k>0.

A279912	mult	0
#--------> p.pow(e-1).multiply(p.subtract(1).multiply(p.pow(e)).add(1))
# M.w. a(p^k) = p^(k-1) * ((p-1) * p^k + 1). - _Daniel Suteu_, Oct 24 2018a(n) = Sum_{i=1..n} denominator(i^n/n).

A279929	mult	1
#--------> is2(p) ? Z.ONE : (is3(p) ? Z.ZERO : sigmaP(p, e))
# a(n) is M.w. a(2^e) = 1, a(3^e) = 0^e, a(p^e) = (p^(e+1) - 1) / (p-1) if p>3.Expansion of c(q)*c(q^2)/9 - c(q^3)*c(q^6)/3 in powers of q where c() is a cubic AGM theta function.

A281785	mult	1
#--------> is2(p) ? Z.ONE : (is3(p) ? Z.valueOf(-8) : sigmaP(p, e))
# a(n) is M.w. a(2^e) = 1, a(3^e) = -8 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.a(n) is multiplicative with a(2^e) = 1, a(3^e) = -8 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.

A281786	multb	0
#-->mN == -1 ? super.next().add(1) : super.next().multiply(3)	is2(p) ? Z.ONE : (is3(p) ? Z.valueOf(-8) : sigmaP(p, e))
# a(n) = 3*b(n) if n>0 where b() is M.w. b(2^e) = 1, b(3^e) = -8 if e>0, b(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.Expansion of a(q) * b(q^2) + a(q^2) * b(q) in powers of q where a(), b() are cubic AGM functions.

A282254	mult	0
#--------> p.pow(e).multiply(p.pow(9*(e+1)).subtract(1)).divide(p.pow(9).subtract(1))
# M.w. a(p^e) = p^e*(p^(9*(e+1))-1)/(p^9-1). - _Jianing Song_, Aug 12 2020Coefficients in q-expansion of (3*E_4^3 + 2*E_6^2 - 5*E_2*E_4*E_6)/1584, where E_2, E_4, E_6 are the Eisenstein series shown in A006352, A004009, A013973, respectively.

A287926	mult	1
#--> is7(p) ? Z.EIGHT : sigmaP(p, e)
# M.w. a(7^e) = 8 and a(p^e) = (p^(e+1)-1)/(p-1) otherwise. - _Amiram Eldar_, Sep 17 2020Sum of the divisors of n that are not divisible by 49.

A288417	mult	1
#--> is2(p) ? Z.valueOf(e+1) : Integers.SINGLETON.sum(0, e, i -> p.pow(e - i).multiply(i + 1))
# M.w. a(2^e) = e+1 and a(p^e) = Sum_{i=0..e} (i+1)*p^(e-i) for e >= 0 and prime p > 2. - _Werner Schulte_, Jan 05 2021a(n) = Sum_{d|n} A000593(n/d).

A290099	mul	1
# is2(p) ? Z.valueOf((neg1(e)) : prevprime(p)^e
# M.w. a(2^e) = (-1)^e and a(p^e) = prevprime(p)^e for odd primes p.Multiplicative with a(2^e) = (-1)^e and a(p^e) = prevprime(p)^e for odd primes p.

A290106	mul	1
# a(prime(k)^e) = k^(e-1)
# M.w. a(prime(k)^e) = k^(e-1).a(1) = 1; for n > 1, if n = Product prime(k)^e(k), then a(n) = Product (k)^(e(k)-1).

A290641	mul	1
# prime(p.subtract(1))^e
# M.w. a(p^e) = prime(p-1)^e.Multiplicative with a(p^e) = prime(p-1)^e.

A293303	mul	1
# Z.valueOf(Sum_{d|e} A008683(e/d)*p^d
# M.w. a(p^e) = Sum_{d|e} A008683(e/d)*p^d.Exponential convolution of the exponential Mobius function and the natural numbers.

A293442	mul	1
# Z.valueOf(A019565(e)
# M.w. a(p^e) = A019565(e).Multiplicative with a(p^e) = A019565(e).

A293443	mul	1
# Z.valueOf(A019565(A193231(e))
# M.w. a(p^e) = A019565(A193231(e)).Multiplicative with a(p^e) = A019565(A193231(e)).

A293444	mul	1
# Z.valueOf(A019565(e)
# a(n) = A293442(A293442(n)), where A293442 is M.w. a(p^e) = A019565(e).a(n) = A293442(A293442(n)), where A293442 is multiplicative with a(p^e) = A019565(e).

A294931	mul	1
# Z.valueOf(A019565(A289813(e))
# M.w. a(p^e) = A019565(A289813(e)).Multiplicative with a(p^e) = A019565(A289813(e)).

A294932	mul	1
# Z.valueOf(A019565(A289814(e))
# M.w. a(p^e) = A019565(A289814(e)).Multiplicative with a(p^e) = A019565(A289814(e)).

A295316	mul	1
# Z.valueOf(A000035(e)
# M.w. a(p^e) = A000035(e).a(n) = 1 if there are no even exponents in the prime factorization of n, 0 otherwise.

A295665	mul	1
# a(prime(m)) = prime(k) when m = prime(k), : a(prime(m)) = 1 when m is not a prime
# Fully M.w. a(prime(m)) = prime(k) when m = prime(k), and a(prime(m)) = 1 when m is not a prime.Fully multiplicative with a(prime(m)) = prime(k) when m = prime(k), and a(prime(m)) = 1 when m is not a prime.

A295878	mul	1
# a(p.pow(2e)) = 1, a(p.pow(2e-1)) = prime(e)
# M.w. a(p^(2e)) = 1, a(p^(2e-1)) = prime(e).Multiplicative with a(p^(2e)) = 1, a(p^(2e-1)) = prime(e).

A295879	mul	1
# a(p) = 1, prime(e-1) if e > 1
# M.w. a(p) = 1, a(p^e) = prime(e-1) if e > 1.Multiplicative with a(p) = 1, a(p^e) = prime(e-1) if e > 1.

A297002	mul	1
# a(prime(k)) = prime(2 * k) (where prime(k) denotes the k-th prime)
# Completely M.w. a(prime(k)) = prime(2 * k) (where prime(k) denotes the k-th prime).Completely multiplicative with a(prime(k)) = prime(2 * k) (where prime(k) denotes the k-th prime).

A299200	mul	1
# a(prime(n)) = A000041(n)
# M.w. a(prime(n)) = A000041(n).Number of twice-partitions whose domain is the integer partition with Heinz number n.

A299406	mul	1
# b(p^e) = (neg1(e)) if e < 3,  0, p prime : e >= 0
# Dirichlet inverse b(n) is M.w. b(p^e) = (-1)^e if e < 3, otherwise 0, p prime and e >= 0.G.f.: Sum_{n>0} a(n)/n^s = ((zeta(s)*zeta(6*s))/((zeta(2*s)*zeta(3*s)).

A300955	mul	1
# Z.valueOf(A064614(p)^a(e)
# M.w. a(p^k) = A064614(p)^a(k).In the prime tower factorization of n, replace 2:s with 3:s and 3:s with 2:s.

A301315	mul	1
# prime(p) ^ a(e) (where prime(k) denotes the k-th prime number)
# M.w. a(p^e) = prime(p) ^ a(e) (where prime(k) denotes the k-th prime number).Multiplicative with a(p^e) = prime(p) ^ a(e) (where prime(k) denotes the k-th prime number).

A303809	mul	1
# Z.valueOf(2^a(e)
# M.w. a(p^k) = 2^a(k).Multiplicative with a(p^k) = 2^a(k).

A303822	mul	1
# Z.valueOf(3^a(e)
# M.w. a(p^k) = 3^a(k).Multiplicative with a(p^k) = 3^a(k).

A303915	mul	1
# b(1)=1 and
# Dirichlet inverse b(n), n>=1, is M.w. b(1)=1 and for p prime and e>0: b(p^e) = 0 if e mod 3 = 0 otherwise b(p^e) = (-1)^(3 - e mod 3).a(n) = lambda(n)*E(n), where lambda(n) = A008836(n) and E(n) = A005361(n).

A304203	mul	1
# p^prime(e)
# M.w. a(p^e) = p^prime(e). - _M. F. Hasler_, Nov 20 2018If n = Product (p_j^k_j) then a(n) = Product (p_j^prime(k_j)).

A305191	mul	1
# respect to n, that is, if gcd(n,m)=1 then T(n*m,k) = T(n,k mod n)*T(m,k mod m)
# T(n,k) is M.w. respect to n, that is, if gcd(n,m)=1 then T(n*m,k) = T(n,k mod n)*T(m,k mod m).Table read by rows: T(n,k) is the number of pairs (x,y) mod n such that x^2 + y^2 == k (mod n), for k from 0 to n-1.

A305461	mult	1
#--------> p.pow(e/2).add(1)
# M.w. a(p^e) = p^floor(e/2) + 1 for prime p. - _Andrew Howroyd_, Jul 22 2018The number of one-digit numbers, k, in base n such that k^2 and k^3 end in the same digit.

A306198	mult	1
#--------> p.pow(e-1).multiply(p.subtract(1).multiply(p).subtract(1))
# M.w. a(p^e) = p^(e-1)*(p^2 - p - 1).	Multiplicative with a(p^e) = p^(e-1)*(p^2 - p - 1).

A306379	mul	1
# ??? division/pow problem Z.valueOf(e-1).multiply(p.add(1).square()).multiply(p.pow(e-2)).add(p.add(1).multiply(p.pow(e-1)).multiply2())
# M.w. a(p^e) = (e-1)*(p+1)^2*p^(e-2) + 2*(p+1)*p^(e-1).Dirichlet convolution of psi(n) with itself.

A307381	mult	1
#--> is2(p) ? (e == 1 || e >= 4 ? Z.ZERO : p.pow(e-2)) : (is3(p) ? (e >= 3 ? Z.ZERO : (e == 1 ? Z.ONE : Z.FOUR)) : (e == 1 ? (isMod(6, p, 1) ? Z.FIVE : Z.ONE) : Z.ZERO))
# M.w. a(4) = 1, a(8) = 2, a(2^e) = 0 for e = 1 or e >= 4; a(3) = 1, a(9) = 4, a(3^e) = 0 for e >= 3; a(p) = 5 if p == 1 (mod 6) and 1 if p == 5 (mod 6), a(p^e) = 0 if p > 3 and e >= 2.

A307848	mul	1
# Z.valueOf(A037445(e)
# M.w. a(p^e) = A037445(e).The number of exponential infinitary divisors of n.

A308056	mul	1
# Integers.SINGLETON.sum(1, e, i -> LongUtils.gcd(i, e) == 1 ? p.pow(i) : Z.ZERO)
# M.w. a(p^e) = Sum_{i=1..e, gcd(i,e)=1} p^i. a(1) = 1, a(n) is the sum of the divisors d of n such that d and n are exponentially coprime.

A308317	mul	1
# a(prime(k)^e) = A005117(e+1)^(Z.ONE.shiftLeft(k-1))
# M.w. a(prime(k)^e) = A005117(e+1)^(2^(k-1)).Multiplicative with a(prime(k)^e) = A005117(e+1)^(2^(k-1)).

A308993	mul	1
# a(p) = 1 : p^a(e)
# M.w. a(p) = 1 and a(p^e) = p^a(e) for any e > 1 and prime number p.Multiplicative with a(p) = 1 and a(p^e) = p^a(e) for any e > 1 and prime number p.

A309002	mul	1
# a(p) = p^2 : p^a(e)
# M.w. a(p) = p^2 and a(p^e) = p^a(e) for any e > 1 and prime number p.Multiplicative with a(p) = p^2 and a(p^e) = p^a(e) for any e > 1 and prime number p.

A309243	mul	1
# a(p) = p * a(p-1)
# Completely M.w. a(p) = p * a(p-1) for any prime number p.Completely multiplicative with a(p) = p * a(p-1) for any prime number p.

A317690	mul	0
# b(3^e) = (neg1(e)), b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p>3, where b(p) = p minus number of points of elliptic curve modulo p
# a(n) = b(2*n + 1) where b() is M.w. b(3^e) = (-1)^e, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p>3, where b(p) = p minus number of points of elliptic curve modulo p.Coefficients of modular form for elliptic curve "96b1": y^2 = x^3 - x^2 - 2*x divided by q in powers of q^2.

A317797	mul	1
# is2(p) ? Z.valueOf(sigma(Z.ONE.shiftLeft(2e)) = Z.ONE.shiftLeft(2e+1) - 1, Z.valueOf(sigma(p^e).square() = ((p.pow(e+1) - 1).divide(p.subtract(1))).square() if isMod(4, p, 1) : sigma_2(p^e) = A001157(p^e) = (p.pow(2e+2) - 1).divide(p.square().subtract(1)) if p == 3 (mod 4)
# M.w. a(2^e) = sigma(2^(2e)) = 2^(2e+1) - 1, a(p^e) = sigma(p^e)^2 = ((p^(e+1) - 1)/(p - 1))^2 if p == 1 (mod 4) and sigma_2(p^e) = A001157(p^e) = (p^(2e+2) - 1)/(p^2 - 1) if p == 3 (mod 4).Sum of the norm of divisors of n over Gaussian integers, with associated divisors counted only once.

A317934	mul	1
# a(p^n) = 2^A011371(n); denominators
# M.w. a(p^n) = 2^A011371(n); denominators for certain "Dirichlet Square Roots" sequences.Multiplicative with a(p^n) = 2^A011371(n); denominators for certain "Dirichlet Square Roots" sequences.

A318307	mult	1
#--> Z.ONE.shiftLeft(Integers.SINGLETON.sum(0, (e - 1) / 2, k -> Binomial.binomial(e - k - 1, k).mod(Z.TWO)).intValue())
# M.w. a(p^e) = 2^A002487(e).Multiplicative with a(p^e) = 2^A002487(e).

A318314	mul	1
# Z.ONE.shiftLeft(((2-A000035(p))*e)-A000120(e))
# Equally, M.w. a(p^e) = 2^(((2-A000035(p))*e)-A000120(e)) for all primes p.Denominators of the sequence whose Dirichlet convolution with itself yields A068068, number of odd unitary divisors of n.

A318316	mul	1
# Z.valueOf(2^A007306(e)
# M.w. a(p^e) = 2^A007306(e).Multiplicative with a(p^e) = 2^A007306(e).

A318363	mul	1
# a(prime(i)^k) = prime(k)^Z.ONE.shiftLeft(i-1)
# M.w. a(prime(i)^k) = prime(k)^2^(i-1).Multiplicative with a(prime(i)^k) = prime(k)^2^(i-1).

A318375	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p>5, where b(p) = p minus number of points of elliptic curve modulo p
# a(n) = b(6*n + 1) where b() is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p>5, where b(p) = p minus number of points of elliptic curve modulo p.Coefficients of modular form for elliptic curve "108a1": y^2 = x^3 + 4 divided by q in powers of q^6.

A318465	mul	1
# Z.valueOf(2^A007895(e), where A007895(n) gives the number of terms in the Zeckendorf representation of n
# M.w. a(p^e) = 2^A007895(e), where A007895(n) gives the number of terms in the Zeckendorf representation of n.The number of Zeckendorf-infinitary divisors of n = Product_{i} p(i)^r(i): divisors d = Product_{i} p(i)^s(i), such that the Zeckendorf expansion (A014417) of each s(i) contains only terms that are in the Zeckendorf expansion of r(i).

A318469	mul	1
# Z.valueOf(A019565(A003714(e))
# M.w. a(p^e) = A019565(A003714(e)).Multiplicative with a(p^e) = A019565(A003714(e)).

A318470	mul	1
# Z.valueOf(A260443(e)
# M.w. a(p^e) = A260443(e).Multiplicative with a(p^e) = A260443(e).

A318472	mult	1
#--> Z.ONE.shiftLeft(Fibonacci.fibonacci(e).intValue())
# M.w. a(p^e) = 2^A000045(e).

A318474	mult	1
#--> Z.ONE.shiftLeft(Fibonacci.fibonacci(e+1).intValue())
# M.w. a(p^e) = 2^A000045(e+1).

A318476	mult	1
#--> Z.ONE.shiftLeft(Binomial.binomial(2*e, e).divide(e+1).intValue())
# M.w. a(p^e) = 2^A000108(e).Multiplicative with a(p^e) = 2^A000108(e).

A318509	mult	1
#--> e > 1 ? p.pow(e) : Integers.SINGLETON.sum(0, p.subtract(1).divide2().intValue(), k -> Binomial.binomial(p.intValue() - k - 1, k).mod(Z.TWO))
# Completely M.w. a(p) = A002487(p).Completely multiplicative with a(p) = A002487(p).

A318510	mul	1
# a(prime(k)) = A002487(prime(k+1))
# Completely M.w. a(prime(k)) = A002487(prime(k+1)).Completely multiplicative with a(prime(k)) = A002487(prime(k+1)).

A318657	mul	1
# is2(p) ? Z.valueOf(0, Z.valueOf(A257098(p^e)
# a(2n) = 0, a(2n-1) = A257098(2n-1), thus M.w. a(2^e) = 0, a(p^e) = A257098(p^e) for odd primes p.  - _Antti Karttunen_, Sep 01 2018Numerators of the sequence whose Dirichlet convolution with itself yields A087003, a(2n) = 0 and a(2n+1) = moebius(2n+1).

A318667	mul	1
#
# M.w. A318307(p^e) = 2^A002487(e).

A318935	mult	1
#--------> is2(p) ? Z.EIGHT.pow(e+1).subtract(1).divide(7) : Z.ONE
# Thus M.w. a(2^m) = (8^(m+1)-1)/7, and a(p^e) = 1 for odd primes p. - _Antti Karttunen_, Nov 07 2018a(n) = Sum_{2^m divides n} 2^(3*m).

A319099	mult	1
#--> Z.valueOf(is5(p) ? (e == 1 ? 1 : 5) : (isMod(5, p, 1) ? 5 : 1))
# M.w. a(5) = 1, a(5^e) = 5 if e >= 2; for other primes p, a(p^e) = 5 if p == 1 (mod 5), a(p^e) = 1 otherwise.Number of solutions to x^5 == 1 (mod n).

A319100	mult	1
#--> is2(p) ? (e <= 2 ? p.pow(e-1) : Z.FOUR) : (is3(p) ? Z.valueOf(e == 1 ? 2 : 6) : Z.valueOf(isMod(6, p, 1) ? 6 : 2))
# M.w. a(2) = 1, a(4) = 2, a(2^e) = 4 for e >= 3; a(3) = 2, a(3^e) = 6 if e >= 2; for other primes p, a(p^e) = 6 if p == 1 (mod 6), a(p^e) = 2 if p == 5 (mod 6).

A319101	mult	1
#--> Z.valueOf(is7(p) ? (e == 1 ? 1 : 7) : (isMod(7, p, 1) ? 7 : 1))
# M.w. a(7) = 1, a(7^e) = 7 if e >= 2; for other primes p, a(p^e) = 7 if p == 1 (mod 7), a(p^e) = 1 otherwise.

A319442	mult	1
#--> is3(p) ? Z.valueOf(2*e+1) : Z.valueOf(isMod(3, p, 1) ? e*e + 2*e+1 : e+1)
# M.w. a(3^e) = 2*e+1, a(p^e) = (e+1)^2 if p == 1 (mod 3) and e+1 if p == 2 (mod 3).

A319445	mul	1
# a(3^e) = 2*3^(2*e-1), phi(p^e).square() = (p-1).square()*p.pow(2*e-2) if p == 1 (mod 3) : J_2(p^e) = A007434(p^e) = (p.square().subtract(1))*p.pow(2*e-2) if p == 2 (mod 3)
# M.w. a(3^e) = 2*3^(2*e-1), a(p^e) = phi(p^e)^2 = (p-1)^2*p^(2*e-2) if p == 1 (mod 3) and J_2(p^e) = A007434(p^e) = (p^2 - 1)*p^(2*e-2) if p == 2 (mod 3).Number of Eisenstein integers in a reduced system modulo n.

A319449	mul	1
# a(3^e) = sigma(3^(2e)) = (3^(2e+1) - 1)/2, Z.valueOf(sigma(p^e).square() = ((p.pow(e+1) - 1).divide(p.subtract(1))).square() if p == 1 (mod 3) : sigma_2(p^e) = A001157(p^e) = (p.pow(2e+2) - 1).divide(p.square().subtract(1)) if p == 2 (mod 3)
# M.w. a(3^e) = sigma(3^(2e)) = (3^(2e+1) - 1)/2, a(p^e) = sigma(p^e)^2 = ((p^(e+1) - 1)/(p - 1))^2 if p == 1 (mod 3) and sigma_2(p^e) = A001157(p^e) = (p^(2e+2) - 1)/(p^2 - 1) if p == 2 (mod 3).Sum of the norm of divisors of n over Eisenstein integers, with associated divisors counted only once.

A319521	mul	1
# a(prime(2*k-1)) = prime(k) : a(prime(2*k)) = 1
# Completely M.w. a(prime(2*k-1)) = prime(k) and a(prime(2*k)) = 1 for any k > 0 (where prime(k) denotes the k-th prime number).Completely multiplicative with a(prime(2*k-1)) = prime(k) and a(prime(2*k)) = 1 for any k > 0 (where prime(k) denotes the k-th prime number).

A319522	mul	1
# a(prime(2*k)) = prime(k) : a(prime(2*k-1)) = 1
# Completely M.w. a(prime(2*k)) = prime(k) and a(prime(2*k-1)) = 1 for any k > 0 (where prime(k) denotes the k-th prime number).Completely multiplicative with a(prime(2*k)) = prime(k) and a(prime(2*k-1)) = 1 for any k > 0 (where prime(k) denotes the k-th prime number).

A319525	mul	1
# a(prime(k)) = prime(2*k - 1) (where prime(k) denotes the k-th prime)
# Completely M.w. a(prime(k)) = prime(2*k - 1) (where prime(k) denotes the k-th prime).Completely multiplicative with a(prime(k)) = prime(2*k - 1) (where prime(k) denotes the k-th prime).

A319984	mul	1
# prime(p mod 4)^e
# Fully M.w. a(p^e) = prime(p mod 4)^e.Fully multiplicative with a(p^e) = prime(p mod 4)^e.

A319985	mul	1
# prime(p mod 12)^e
# Fully M.w. a(p^e) = prime(p mod 12)^e.Fully multiplicative with a(p^e) = prime(p mod 12)^e.

A319986	mul	1
# prime(p mod 6)^e
# Fully M.w. a(p^e) = prime(p mod 6)^e.Fully multiplicative with a(p^e) = prime(p mod 6)^e.

A319987	mul	1
# prime(p mod 8)^e
# Fully M.w. a(p^e) = prime(p mod 8)^e.Fully multiplicative with a(p^e) = prime(p mod 8)^e.

A321874	mul	1
# prime(p)^prime(e)
# M.w. a(p^e) = prime(p)^prime(e). - _M. F. Hasler_, Nov 20 2018If n = Product (p_j^k_j) then a(n) = Product (prime(p_j)^prime(k_j)).

A322327	mul	1
# ??? Z.TWO.multiply(e)
# Conjecture: Let k be some fixed integer and a_k(n) = A005631(n) * k^A001221(n) for n > 0 with 0^0 = 1. Then a_k(n) is M.w. a_k(p^e) = k*e for prime p and e > 0. For k = 0 see A000007 (offset 1), for k = 1 see A005361, for k = 2 see this sequence, for k = 3 see A226602 (offset 1), and for k = 4 see A322328.a(n) = A005361(n) * A034444(n).

A322328	mul	1
# b(p^e) = 4*e*(neg1(e))
# Dirichlet inverse is b(n) = a(n) * A008836(n) for n > 0, and b(n) is M.w. b(p^e) = 4*e*(-1)^e for prime p and e > 0.a(n) = A005361(n) * 4^A001221(n) for n > 0.

A322361	mul	1
# a(prime(k)) = prime(k+1)
# a(n) = gcd(n, A003961(n)), where A003961 is completely M.w. a(prime(k)) = prime(k+1).a(n) = gcd(n, A003961(n)), where A003961 is completely multiplicative with a(prime(k)) = prime(k+1).

A322362	mult	1
#--------> p.add(2)
# a(n) = gcd(n, A166590(n)), where A166590 is completely M.w. a(p) = p+2 for prime p.

A322485	mul	1
# Z.valueOf(sigma(p^floor((e-1)/2)) + p^e = (p^floor((e+1)/2).subtract(1).divide(p.subtract(1)) + p^e
# M.w. a(p^e) = sigma(p^floor((e-1)/2)) + p^e = (p^floor((e+1)/2) - 1)/(p-1) + p^e.The sum of the semi-unitary divisors of n.

A322857	mult	1
#--> Integers.SINGLETON.sumdiv(e, d -> (LongUtils.gcd(d, e/d) == 1 ? p.pow(d) : Z.ZERO))
# M.w. a(p^e) = Sum_{d|e, gcd(d, e/d)==1} p^d.

A322885	mul	1
# Z.valueOf(A001399(e)
# M.w. a(p^e) = A001399(e).Number of 3-generated Abelian groups of order n.

A324106	mul	1
# Z.valueOf(A005940(p^e)
# M.w. a(p^e) = A005940(p^e).Multiplicative with a(p^e) = A005940(p^e).

A324108	mul	1
# Z.valueOf(A324054((p^e)-1)
# M.w. a(p^e) = A324054((p^e)-1).Multiplicative with a(p^e) = A324054((p^e)-1).

A324283	mul	1
# Z.valueOf(A276086(p^e)
# M.w. a(p^e) = A276086(p^e).Multiplicative with a(p^e) = A276086(p^e).

A324391	mul	1
# Z.valueOf(A070939(p)^e, where A070939(p) gives the length of the binary representation of p
# Fully M.w. a(p^e) = A070939(p)^e, where A070939(p) gives the length of the binary representation of p.Fully multiplicative with a(p^e) = A070939(p)^e, where A070939(p) gives the length of the binary representation of p.

A324900	mul	1
# a(prime(k)) = A000032(2*(k+1)) = A000045(2k+1) + A000045(2k+3)
# Fully M.w. a(prime(k)) = A000032(2*(k+1)) = A000045(2k+1) + A000045(2k+3).Fully multiplicative with a(prime(k)) = Lucas(2*(k+1)) for k-th prime p, where Lucas(n) = A000032(n).

A324911	mul	1
# Z.valueOf(A156552(p^e)
# M.w. a(p^e) = A156552(p^e).Multiplicative with a(p^e) = A156552(p^e).

A324922	mul	1
# a(prime(n)) = prime(n) * a(n)
# Completely M.w. a(prime(n)) = prime(n) * a(n). - _R√©my Sigrist_, Jul 18 2019a(n) = unique m such that m/A003963(m) = n, where A003963 is product of prime indices.

A325032	mul	1
# a(prime(n)) = A003963(n)
# Fully M.w. a(prime(n)) = A003963(n).Product of products of the multisets of prime indices of each prime index of n.

A325035	mul	0
# a(prime(n)) = A056239(n), restricted to odd n
# Fully M.w. a(prime(n)) = A056239(n), restricted to odd n.Product of sums of the multisets of prime indices of each prime index of 2 * n + 1.

A325709	mul	1
# a(prime(n)) = prime(n!)
# Completely M.w. a(prime(n)) = prime(n!).Replace k with k! in the prime indices of n.

A326041	mul	1
# is2(p) ? Z.ONE , and
# M.w. a(2^e) = 1, and for odd primes p, a(p^e) = (q^(e+1)-1)/(q-1), where q = A151799(p).a(n) = sigma(A064989(n)).

A326043	mult	1
#--> Jaguar.factor(p.pow(e)).sigma().add(e - 1).divide(e)
# M.w. a(p^e) = floor[((e-1)+sigma(p^e)) / e].Multiplicative with a(p^e) = floor[((e-1)+sigma(p^e)) / e].

A326304	mul	1
# Z.valueOf(a(p.subtract(1))^e+1
# M.w. a(p^k) = a(p-1)^k + 1 for any k > 0 and any prime number p.Multiplicative with a(p^k) = a(p-1)^k + 1 for any k > 0 and any prime number p.

A326401	mult	1
#--> is3(p) ? p.pow(e) : (isMod(3, p, 2) ? sigmaP(p, e) : p.pow(e+1).add(neg1(e)).divide(p.add(1)))
# M.w. a(3^e) = 3^e, a(p^e) = (p^(e+1) - 1)/(p - 1) if p == 2 (mod 3), and (p^(e+1) + (-1)^e)/(p + 1) if p == 1 (mod 3). - _Amiram Eldar_, Oct 25 2020

A326575	mult	1
#--> p.compareTo(Z.FIVE) < 0 ? p.pow(e) : (isMod(6, p, 5) ? p.pow(e+1).subtract((((e+1) & 1) == 0) ? 1 : -1).divide(p.add(1)) : sigmaP(p, e))
# M.w. a(p^e) = p^e if p < 5, (p^(e+1)-(-1)^(e+1))/(p+1) if p == 5 (mod 6), and (p^(e+1)-1)/(p-1) if p == 1 (mod 6). - _Amiram Eldar_, Dec 02 2020

A328271	mult	1
#--> Integers.SINGLETON.sum(0, e/2, i -> p.pow(2 * e - 4 * i))
# M.w. a(p^e) = Sum_{i=0..floor(e/2)} p^(2*e-4*i) for prime p, i.e., a(p^(2*e)) = (p^(4*e+4).subtract(1).divide(p^4-1) and a(p^(2*e+1)) = p^2 * (p^(4*e+4).subtract(1).divide(p^4-1) for prime p. - _Werner Schulte_, Jul 24 2021

A328617	mul	1
# Z.valueOf(e).mod(p).isZero() ? p.pow(e) : p.pow((p.multiply(Z.valueOf(e).divide(p)) + A124223(A000720(p),e mod p)
# M.w. a(p^e) = p^e, if e = 0 mod p, otherwise a(p^e) = p^((p*floor(e/p)) + A124223(A000720(p),e mod p).Multiplicative with a(p^e) = p^e, if e = 0 mod p, otherwise a(p^e) = p^((p*floor(e/p)) + A124223(A000720(p),e mod p).

A328618	mult	1
#----> is2(p) || Z.valueOf(e).remainder(p).isZero() ? p.pow(e) : p.pow(p.multiply(Z.valueOf(e).divide(p)).add(Z.valueOf(2*e).mod(p)))
# M.w. a(p^e) = p^e if p = 2 or e is a multiple of p, otherwise a(p^e) = p^((p*floor(e/p)) + (2e mod p)).

A328621	mult	1
#--------> p.pow(Z.valueOf(2*e).mod(p))
# M.w. a(p^e) = p^(2e mod p).Multiplicative with a(p^e) = p^(2e mod p).

A329378	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Least common multiple of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Least common multiple of exponents of prime factors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329382	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Product of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Product of exponents of prime factors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329602	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Square root of largest square dividing A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Square root of largest square dividing A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329605	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Number of divisors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Number of divisors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329615	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Bitwise-AND of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Bitwise-AND of exponents of prime factors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329616	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Bitwise-OR of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Bitwise-OR of exponents of prime factors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329617	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Product of distinct exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Product of distinct exponents of prime factors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329647	mul	1
# a(prime(i)) = prime(i)# = Product_{i=1
# Bitwise-XOR of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).Bitwise-XOR of exponents of prime factors of A108951(n), where A108951 is fully multiplicative with a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A330687	mul	1
# Z.valueOf(A018819(e) : A018819(2k) = A018819(2k+1) : this sequence considers just records so we only need exponents of the
# Each term is a perfect square. Proof: A050377(n) is M.w. a(p^e) = A018819(e) and A018819(2k) = A018819(2k+1) and this sequence considers just records so we only need exponents of the form 2k; i.e., terms are squares.Positions of records in A050377, number of ways to factor n into "Fermi-Dirac primes" (A050376).

A330690	mul	1
# a(prime(k)) = k-th primorial
# Number of ways to factor A108951(n) into "Fermi-Dirac primes" (A050376), where A108951 is fully M.w. a(prime(k)) = k-th primorial.Number of ways to factor A108951(n) into "Fermi-Dirac primes" (A050376), where A108951 is fully multiplicative with a(prime(k)) = k-th primorial.

A330749	mul	1
# a(2) = 1 : a(prime(k)) = prime(k-1)
# a(n) = gcd(n, A064989(n)), where A064989 is fully M.w. a(2) = 1 and a(prime(k)) = prime(k-1) for odd primes.a(n) = gcd(n, A064989(n)), where A064989 is fully multiplicative with a(2) = 1 and a(prime(k)) = prime(k-1) for odd primes.

A331107	mul	1
# Z.valueOf(Product_{i} (p^s(i) + 1), where s(i) are the terms in the Zeckendorf representation of e (A014417)
# M.w. a(p^e) = Product_{i} (p^s(i) + 1), where s(i) are the terms in the Zeckendorf representation of e (A014417).The sum of Zeckendorf-infinitary divisors of n = Product_{i} p(i)^r(i): divisors d = Product_{i} p(i)^s(i), such that the Zeckendorf expansion (A014417) of each s(i) contains only terms that are in the Zeckendorf expansion of r(i).

A331109	mul	1
# Z.valueOf(2^A112310(e)
# M.w. a(p^e) = 2^A112310(e).The number of dual-Zeckendorf-infinitary divisors of n: divisors d = Product_{i} p(i)^s(i), such that the dual Zeckendorf expansion (A104326) of each s(i) contains only terms that are in the dual Zeckendorf expansion of r(i).

A331110	mul	1
# Z.valueOf(Product_{i} (p^s(i) + 1), where s(i) are the terms in the dual Zeckendorf representation of e (A104326)
# M.w. a(p^e) = Product_{i} (p^s(i) + 1), where s(i) are the terms in the dual Zeckendorf representation of e (A104326).The sum of dual-Zeckendorf-infinitary divisors of n: divisors d = Product_{i} p(i)^s(i), such that the dual Zeckendorf expansion (A104326) of each s(i) contains only terms that are in the dual Zeckendorf expansion of r(i).

A331737	mult	1
#--------> p.pow(e >> LongUtils.valuation(e, 2))
# M.w. a(p^e) = p^A000265(e), where A000265(x) gives the odd part of x.Multiplicative with a(p^e) = p^A000265(e), where A000265(x) gives the odd part of x.

A331738	mul	1
# p.pow(e-A000265(e)), where A000265(x) gives the odd part of x
# M.w. a(p^e) = p^(e-A000265(e)), where A000265(x) gives the odd part of x.Multiplicative with a(p^e) = p^(e-A000265(e)), where A000265(x) gives the odd part of x.

A332212	mul	1
# a(p) = A332211(A000720(p))
# Fully M.w. a(p) = A332211(A000720(p)).Fully multiplicative with a(p) = A332211(A000720(p)).

A332213	mul	1
# a(p) = A332210(A000720(p))
# Fully M.w. a(p) = A332210(A000720(p)).Fully multiplicative with a(p) = A332210(A000720(p)).

A332332	mul	1
# a(3^n) = (-1)^n, a(11^n) = 1
# a(n) is M.w. a(3^n) = (-1)^n, a(11^n) = 1. a(2^n) = A107920(n+1). a(7^n) = A168175(n).Coefficients of L-series for elliptic curve "33a1": y^2 + x*y = x^3 + x^2 - 11*x.

A332712	mul	1
# Z.valueOf(A028242(e)
# M.w. a(p^e) = A028242(e). - _Amiram Eldar_, Nov 30 2020a(n) = Sum_{d|n} mu(d/gcd(d, n/d)).

A332808	mul	1
# a(p) = A332806(A000720(p))
# Fully M.w. a(p) = A332806(A000720(p)).Fully multiplicative with a(p) = A332806(A000720(p)).

A332818	mul	1
# a(2) = 3, a(A002145(n)) = A002144(n) : a(A002144(n)) = A002145(1+n),
# Fully M.w. a(2) = 3, a(A002145(n)) = A002144(n) and a(A002144(n)) = A002145(1+n), for all n >= 1.a(n) = A108548(A003961(A332808(n))).

A332819	mul	1
# a(2) = 1, a(3) = 2, a(A002144(n)) = A002145(n), : a(A002145(1+n)) = A002144(n)
# Fully M.w. a(2) = 1, a(3) = 2, a(A002144(n)) = A002145(n), and a(A002145(1+n)) = A002144(n) for all n >= 1.a(n) = A108548(A064989(A332808(n))).

A333926	mul	1
# Z.ONE + Sum_{d recursive divisor of e} p^d
# M.w. a(p^k) = 1 + Sum_{d recursive divisor of k} p^d.The sum of recursive divisors of n.

A335115	mul	1
# is2(p) ? Z.valueOf(A001045(e+1) : p^e
# M.w. a(2^e) = A001045(e+1) and a(p^e) = p^e for e >= 0 and prime p > 2. - _Werner Schulte_, Oct 05 2020a(2*n) = 2*n - a(n), a(2*n+1) = 2*n + 1.

A335915	mul	1
# a(2) = 1, and
# Completely M.w. a(2) = 1, and for odd primes p, a(p) = A000265(p-1)*A000265(p+1).Fully multiplicative with a(2) = 1, and a(p) = A000265(p-1)*A000265(p+1) = A000265(p^2 - 1), for odd primes p.

A336459	mul	1
# a(2) = a(3) = 1, : a(p) = p
# a(n) = A065330(sigma(sigma(n))), where A065330 is fully M.w. a(2) = a(3) = 1, and a(p) = p for primes p > 3.a(n) = A065330(sigma(sigma(n))), where A065330 is fully multiplicative with a(2) = a(3) = 1, and a(p) = p for primes p > 3.

A336467	mul	1
# a(2) = 1 : a(p) = A000265(p+1)
# Fully M.w. a(2) = 1 and a(p) = A000265(p+1) for odd primes p, with A000265(k) giving the odd part of k.Fully multiplicative with a(2) = 1 and a(p) = A000265(p+1) for odd primes p, with A000265(k) giving the odd part of k.

A336468	mul	1
# Z.valueOf(A336466(p-1) * A336466(p)^(e-1)
# M.w. a(p^e) = A336466(p-1) * A336466(p)^(e-1).a(n) = A336466(phi(n)), where A336466 is fully multiplicative with a(p) = A000265(p-1) for prime p, with A000265(k) giving the odd part of k.

A337471	mul	1
# a(prime(i)) = A003961(A002110(i)) = A070826(1+i)
# Completely M.w. a(prime(i)) = A003961(A002110(i)) = A070826(1+i). - _Antti Karttunen_, Nov 17 2020Primorial inflation of n prime shifted once: a(n) = A003961(A108951(n)).

A338224	mul	1
# a(A246655(k)) = prime(k)
# M.w. a(A246655(k)) = prime(k) for any k > 0 (where prime(k) denotes the k-th prime number).Multiplicative with a(A246655(k)) = prime(k) for any k > 0 (where prime(k) denotes the k-th prime number).

A338782	mul	1
# p^rad(e), where rad(k) is the largest squarefree number dividing k (A007947)
# M.w. a(p^e) = p^rad(e), where rad(k) is the largest squarefree number dividing k (A007947).The largest e-squarefree e-divisor of n.

A339903	mul	1
# a(p) = A000265(q-1), where q = A151800(p), the next prime > p
# Fully M.w. a(p) = A000265(q-1), where q = A151800(p), the next prime > p.Fully multiplicative with a(p) = A000265(q-1), where q = A151800(p), the next prime > p.

A339904	mul	1
# Z.valueOf(A000265(q-1) * q^(e-1), where q = A151800(p), the next prime larger than p
# M.w. a(p^e) = A000265(q-1) * q^(e-1), where q = A151800(p), the next prime larger than p.The odd part of {Euler totient function phi applied to the prime shifted n}: a(n) = A000265(A000010(A003961(n))).

A339905	mul	1
# a(prime(k)) = prime(k+1) - 1
# Fully M.w. a(prime(k)) = prime(k+1) - 1.Fully multiplicative with a(prime(k)) = prime(k+1) - 1.

A340362	mul	1
# Z.valueOf(A005940(p^e)
# a(n) = A005940(n) - A324106(n), where A324106(n) is M.w. a(p^e) = A005940(p^e).a(n) = A005940(n) - A324106(n), where A324106(n) is multiplicative with a(p^e) = A005940(p^e).

A340364	mul	1
# Z.valueOf(A005940(p^e)
# a(n) = gcd(A005940(n), A324106(n)), where A324106(n) is M.w. a(p^e) = A005940(p^e).a(n) = gcd(A005940(n), A324106(n)), where A324106(n) is multiplicative with a(p^e) = A005940(p^e).

A340365	mul	1
# Z.valueOf(A005940(p^e)
# a(n) = A005940(n) / gcd(A005940(n), A324106(n)), where A324106(n) is M.w. a(p^e) = A005940(p^e).a(n) = A005940(n) / gcd(A005940(n), A324106(n)), where A324106(n) is multiplicative with a(p^e) = A005940(p^e).

A340366	mul	1
# Z.valueOf(A005940(p^e)
# a(n) = A324106(n) / gcd(A005940(n), A324106(n)), where A324106(n) is M.w. a(p^e) = A005940(p^e).a(n) = A324106(n) / gcd(A005940(n), A324106(n)), where A324106(n) is multiplicative with a(p^e) = A005940(p^e).

A341343	mul	1
# b(p.pow(3*e)) = 1
# Let b(n), n > 0, be the Dirichlet inverse of a(n); b(n) is M.w. b(p^(3*e)) = 1 for e >= 0, and b(p^(3*e-2)) = -3*e and b(p^(3*e-1)) = 3*e for e > 0 and prime p.Dirichlet g.f.: Sum_{n>=1} a(n)/n^s = (zeta(s))^3 / (zeta(3*s))^2.

A342017	mul	1
# p^floor(e/p), : A327860 is arithmetic derivative of A276086
# a(n) = A342007(A327860(n)), where A342007 is M.w. a(p^e) = p^floor(e/p), and A327860 is arithmetic derivative of A276086.a(n) = A342007(A327860(n)), where A342007 is multiplicative with a(p^e) = p^floor(e/p), and A327860 is arithmetic derivative of A276086.

A342466	mul	1
# a(p) = A000265(p-1)
# a(n) = A336466(1+A000265(sigma(n))), where A336466 is fully M.w. a(p) = A000265(p-1) for p prime, and A000265(k) is the odd part of k.a(n) = A336466(1+A000265(sigma(n))), where A336466 is fully multiplicative with a(p) = A000265(p-1) for p prime, and A000265(k) is the odd part of k.

A342661	mul	1
# p.pow(e) * (q^(e+1).subtract(1).divide(q-1), where q = 1
# M.w. a(p^e) = (p^e) * (q^(e+1)-1).divide(q-1), where q = 1 for p = 2, and for odd primes p, q = A151799(p), i.e., the previous prime.a(n) = n * sigma(A064989(n)), where A064989 is multiplicative with a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p, and sigma gives the sum of the divisors of its argument.

A342662	mul	1
# sigmaP(p, e)
# M.w. a(p^e) = q^e * (p^(e+1)-1)/(p-1), where q = 1 for p = 2, and for odd primes p, q = A151799(p), i.e., the previous prime.a(n) = sigma(n) * A064989(n), where A064989 is multiplicative with a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p, and sigma is the sum of the divisors of n.

A342670	mul	1
# is2(p) ? Z.ONE : prevprime(p)^e
# a(n) = gcd(n*sigma(A064989(n)), sigma(n)*A064989(n)), where A064989 is M.w. a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p, and sigma gives the sum of the divisors of its argument.a(n) = gcd(n*sigma(A064989(n)), sigma(n)*A064989(n)), where A064989 is multiplicative with a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p, and sigma gives the sum of the divisors of its argument.

A342671	mul	1
# a(prime(k)) = prime(k+1), : sigma is the sum of divisors of n
# a(n) = gcd(sigma(n), A003961(n)), where A003961 is fully M.w. a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.a(n) = gcd(sigma(n), A003961(n)), where A003961 is fully multiplicative with a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.

A342672	mul	1
# a(prime(k)) = prime(k+1), : sigma is the sum of divisors of n
# a(n) = lcm(sigma(n), A003961(n)), where A003961 is fully M.w. a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.a(n) = lcm(sigma(n), A003961(n)), where A003961 is fully multiplicative with a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.

A342673	mul	1
# a(prime(k)) = prime(k+1), : sigma is the sum of divisors of n
# a(n) = gcd(n, sigma(A003961(n))), where A003961 is fully M.w. a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.a(n) = gcd(n, sigma(A003961(n))), where A003961 is fully multiplicative with a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.

A343068	mul	1
# Z.valueOf(e*a(p-1)
# M.w. a(p^e) = e*a(p-1).Multiplicative with a(p^e) = e*a(p-1).

A344683	mul	1
# negative pow ??? p.subtract(1).multiply(p.pow(e-3)).multiply(p.subtract(1).square().multiply(e*e).add(p.square().subtract(1).multiply(3*e)).add(p.add(1).multiply(p).add(1).multiply(2))).divide2()
# M.w. a(p^e) = (1/2)*(p-1)*p^(e-3)*(e^2*(p-1)^2 + 3*e*(p^2-1) + 2*(p^2 + p + 1)).Dirichlet convolution of the Euler totient function with itself, applied twice.

A344877	mult	1
#--------> is2(p) ? Z.ONE.shiftLeft(1+e).subtract(1) : p.pow(e).subtract(1)
# a(n) = gcd(n, A344875(n)), where A344875 is M.w. a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e -1 for odd primes p.a(n) = gcd(n, A344875(n)), where A344875 is multiplicative with a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e -1 for odd primes p.

A344879	mul	1
#cnot this seq.is2(p) ? Z.ONE.shiftLeft(1+e).subtract(1) : p.pow(e).subtract(1)
# a(n) = A344875(n) / A344878(n), where A344875(n) is M.w. a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e -1 for odd primes p, and A344878(n) gives the least common multiple of the same factors.a(n) = A344875(n) / A344878(n), where A344875(n) is multiplicative with a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e -1 for odd primes p, and A344878(n) gives the least common multiple of the same factors.

A345045	mul	1
# p^e - 1, : A345044(n) gives the least common multiple of the same factors
# a(n) = A047994(n) / A345044(n), where A047994(n) is M.w. a(p^e) = p^e - 1, and A345044(n) gives the least common multiple of the same factors.a(n) = A047994(n) / A345044(n), where A047994(n) is multiplicative with a(p^e) = p^e - 1, and A345044(n) gives the least common multiple of the same factors.

A345047	mul	1
# Z.valueOf((neg1(e)), : A345046(n) gives the least common multiple of the same factors
# a(n) = A003958(n) / A345046(n), where A003958(n) is M.w. a(p^e) = (p-1)^e, and A345046(n) gives the least common multiple of the same factors.a(n) = A003958(n) / A345046(n), where A003958(n) is multiplicative with a(p^e) = (p-1)^e, and A345046(n) gives the least common multiple of the same factors.

A345699	mul	1
# a(p) = a(p-1) : Z.valueOf(a(p) + a(e) if e>1
# M.w. a(p) = a(p-1) and a(p^e) = a(p) + a(e) if e>1.Multiplicative with a(p) = a(p-1) and a(p^e) = a(p) + a(e) if e>1.

A347101	mul	1
# a(prime(n)) = A001223(n), where A001223 gives the distance from the n-th prime to the (n+1)-th prime
# Fully M.w. a(prime(n)) = A001223(n), where A001223 gives the distance from the n-th prime to the (n+1)-th prime.Fully multiplicative with a(prime(k)) = A001223(k), where A001223 gives the distance from the k-th prime to the (k+1)-th prime.

A347123	mul	1
# a(prime(n)) = prime(1+floor(A001223(n)/2))
# Fully M.w. a(prime(n)) = prime(1+floor(A001223(n)/2)).Fully multiplicative with a(prime(k)) = prime(1+floor(A001223(k)/2)).

A347125	mul	1
# Z.valueOf(q^(e-1).multiply(p^e*(q*p-1)-q+1).divide(p.subtract(1)), where q = A151800(p)
# M.w. a(p^e) = q^(e-1)*(p^e*(q*p-1)-q+1)/(p-1), where q = A151800(p). - _Sebastian Karlsson_, Sep 02 2021M√∂bius transform of A341529, sigma(n) * A003961(n).

A347136	mul	1
# Z.valueOf((A151800(p)^(e+1) - p.pow(e+1)).divide(A151800(p)-p)
# M.w. a(p^e) = (A151800(p)^(e+1) - p^(e+1))/(A151800(p)-p). - _Amiram Eldar_, Aug 24 2021a(n) = Sum_{d|n} d * A003961(n/d), where A003961 shifts the prime factorization of its argument one step towards larger primes.

