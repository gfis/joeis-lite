A329615	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Bitwise-AND of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329616	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Bitwise-OR of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329647	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Bitwise-XOR of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A235027	mul	0
# a(0)=0, a(1)=1, a(p) = A056539(p)
# Completely M.w. a(0)=0, a(1)=1, a(p) = A056539(p) for primes p (which maps 2 to 2, and reverses the binary representation of odd primes), and a(u*v) = a(u) * a(v) for composites.

A226162	mul	0
# p.equals(Z.TWO) && e == 1 ? Z.NEG_ONE : (p.equals(Z.FIVE) && e == 1 ? Z.ZERO : (p.mod(Z.valueOf(20) ????)) 
# Completely M.w. a(2) = -1, a(5) = 0, a(p) = 1 if p == 1, 3, 7, 9 (mod 20), a(p) = -1 if p == 11, 13, 17, 19 (mod 20). - _Jianing Song_, Dec 30 2018

A090884	mul	0
# a(2) = 1, a(prime(i+1)) = prime(i)^i
# Completely M.w. a(2) = 1, a(prime(i+1)) = prime(i)^i for i > 0. - _Andrew Howroyd_, Jul 31 2018

A198328	mul	0
# a(2) = 1, a(prime(t)) = prime(a(t))
# Completely M.w. a(2) = 1, a(prime(t)) = prime(a(t)) for t > 1. - _Andrew Howroyd_, Aug 01 2018

A335915	mul	0
# a(2) = 1, and
# Completely M.w. a(2) = 1, and for odd primes p, a(p) = A000265(p-1)*A000265(p+1).

A265399	mul	0
# a(2) = 2, a(3) = 3, a(p) = a(A265398(p))
# Completely M.w. a(2) = 2, a(3) = 3, a(p) = a(A265398(p)) for p > 3. - _Andrew Howroyd_ & _Antti Karttunen_, Aug 04 2018

A265398	mul	0
# a(2) = 2, a(3) = 3, a(prime(k)) = prime(k-1) * prime(k-2)
# Completely M.w. a(2) = 2, a(3) = 3, a(prime(k)) = prime(k-1) * prime(k-2) for k > 2. - _Andrew Howroyd_ & _Antti Karttunen_, Aug 04 2018

A064614	mult	0
#--------> p.equals(Z.TWO) ? Z.THREE.pow(e) : (p.equals(Z.THREE) ? Z.TWO.pow(e) : p.pow(e))
# Completely M.w. a(2) = 3, a(3) = 2, and a(p) = p for primes p > 3. - _Charles R Greathouse IV_, Jun 28 2015

A259346	mult	0
#--------> p.equals(Z.TWO) ? Z.THREE.pow(e) : Z.ZERO
# Completely M.w. a(2) = 3, a(p) = 0 for odd prime p. - _Andrew Howroyd_, Jul 27 2018

A209661	mult	0
#--------> p.mod(Z.FOUR).equals(Z.ONE) ? Z.NEG_ONE.pow(e) : Z.ONE
# Completely M.w. a(p) = -1 for p mod 4 = 1, a(p) = 1 otherwise. - _Andrew Howroyd_, Aug 04 2018

A318509	mul	0
# a(p) = A002487(p)
# Completely M.w. a(p) = A002487(p).

A066260	mul	0
# a(p) = A002808(A049084(p)), p prime
# Completely M.w. a(p) = A002808(A049084(p)), p prime.

A118541	mul	0
# a(p) = A007954(p)
# Completely M.w. a(p) = A007954(p) for prime p.

A072087	mul	0
# a(p) = A061712(p)
# Completely M.w. a(p) = A061712(p). - _David W. Wilson_, Aug 03 2005

A072084	mult	0
#--------> Z.valueOf(p.bitCount()).pow(e)
# Completely M.w. a(p) = number of 1 s in binary representation of prime p.

A309243	mul	0
# a(p) = p * a(p-1)
# Completely M.w. a(p) = p * a(p-1) for any prime number p.

A170818	mult	0
#--------> p.mod(Z.FOUR).equals(Z.ONE) ? p.pow(e) : Z.ONE
# Completely M.w. a(p) = p if p = 4k+1 and a(p) = 1 otherwise. - _Tom Edgar_, Mar 05 2015

A248909	mult	0
#--------> p.mod(Z.SIX).equals(Z.ONE) ? p.pow(e) : Z.ONE
# Completely M.w. a(p) = p if p = 6k+1 and a(p) = 1 otherwise.

A343430	mult	0
#--------> p.mod(Z.THREE).equals(Z.TWO) ? p.pow(e) : Z.ONE
# Completely M.w. a(p) = p if p is of the form 3k-1, otherwise a(p) = 1.

A343431	mult	0
#--------> p.mod(Z.SIX).equals(Z.FIVE) ? p.pow(e) : Z.ONE
# Completely M.w. a(p) = p if p is of the form 6k-1 and a(p) = 1 otherwise.

A240023	mult	0
#--------> MemoryFactorial.SINGLETON.factorial(p.intValue()).pow(e)
# Completely M.w. a(p) = p!.

A209615	mult	0
#--------> p.mod(Z.FOUR).equals(Z.ONE) ? Z.ONE : Z.NEG_ONE.pow(e)
# Completely M.w. a(p^e) = 1 if p == 1 (mod 4), a(p^e) = (-1)^e otherwise.

A319522	mul	0
# a(prime(2*k)) = prime(k) : a(prime(2*k-1)) = 1
# Completely M.w. a(prime(2*k)) = prime(k) and a(prime(2*k-1)) = 1 for any k > 0 (where prime(k) denotes the k-th prime number).

A319521	mul	0
# a(prime(2*k-1)) = prime(k) : a(prime(2*k)) = 1
# Completely M.w. a(prime(2*k-1)) = prime(k) and a(prime(2*k)) = 1 for any k > 0 (where prime(k) denotes the k-th prime number).

A337471	mul	0
# a(prime(i)) = A003961(A002110(i)) = A070826(1+i)
# Completely M.w. a(prime(i)) = A003961(A002110(i)) = A070826(1+i). - _Antti Karttunen_, Nov 17 2020

A318510	mul	0
# a(prime(k)) = A002487(prime(k+1))
# Completely M.w. a(prime(k)) = A002487(prime(k+1)).

A297002	mul	0
# a(prime(k)) = prime(2 * k) (where prime(k) denotes the k-th prime)
# Completely M.w. a(prime(k)) = prime(2 * k) (where prime(k) denotes the k-th prime).

A319525	mul	0
# a(prime(k)) = prime(2*k - 1) (where prime(k) denotes the k-th prime)
# Completely M.w. a(prime(k)) = prime(2*k - 1) (where prime(k) denotes the k-th prime).

A325709	mul	0
# a(prime(n)) = prime(n!)
# Completely M.w. a(prime(n)) = prime(n!).

A324922	mul	0
# a(prime(n)) = prime(n) * a(n)
# Completely M.w. a(prime(n)) = prime(n) * a(n). - _Rémy Sigrist_, Jul 18 2019

A248101	mul	0
# a(prime(n)) = prime(n)^((n+1) mod 2)
# Completely M.w. a(prime(n)) = prime(n)^((n+1) mod 2).

A247503	mul	0
# a(prime(n)) = prime(n)^(n mod 2)
# Completely M.w. a(prime(n)) = prime(n)^(n mod 2).

A184160	mul	0
# a(prime(t)) = 1 + a(t)
# Completely M.w. a(prime(t)) = 1 + a(t). - _Andrew Howroyd_, Aug 01 2018

A228732	mul	0
# a(prime(t)) = A228731(t) + A228732(t)
# Completely M.w. a(prime(t)) = A228731(t) + A228732(t). - _Andrew Howroyd_, Aug 01 2018

A228731	mul	0
# a(prime(t)) = A228732(t)
# Completely M.w. a(prime(t)) = A228732(t). - _Andrew Howroyd_, Aug 01 2018

A234747	mul	0
# p_i = p_{A234751(i)} (where p_i stands
# Completely M.w. p_i = p_{A234751(i)} (where p_i stands for the i-th prime, A000040(i)), and a(x*y) = a(x)*a(y) for x, y > 0.

A322327	mul	0
# ??? Z.TWO.multiply(e)
# Conjecture: Let k be some fixed integer and a_k(n) = A005631(n) * k^A001221(n) for n > 0 with 0^0 = 1. Then a_k(n) is M.w. a_k(p^e) = k*e for prime p and e > 0. For k = 0 see A000007 (offset 1), for k = 1 see A005361, for k = 2 see this sequence, for k = 3 see A226602 (offset 1), and for k = 4 see A322328.

A198956	mul	0
# a(3^e) = 3^e, Z.valueOf(sigma_3(p^e)
# Conjecture: M.w. a(3^e) = 3^e, a(p^e) = sigma_3(p^e) for prime p <> 3. - _Andrew Howroyd_, Aug 08 2018

A278086	mul	0
# a(2) = 1, p.equals(Z.TWO) ? Z.valueOf(0
# Conjecture: a(n) is M.w. a(2) = 1, a(2^k) = 0 for k >= 2, and for k >= 1 and p an odd prime, a(p^k) = p^(k-1)*a(p) with a(p) = p + 1 for p == (2, 3, 8, 10, 12, 13, 14, 15, 18) (mod 19), a(p) = p - 1 for p == (1, 4, 5, 6, 7, 9, 11, 16, 17) (mod 19), and p(19) = 19.  It would be nice to have a proof of this.

A181905	mul	0
# a(3^e) = 0, Z.valueOf(((p^2)^(e+1).subtract(1).divide(p.square().subtract(1))
# Conjecture: M.w. a(3^e) = 0, a(p^e) = ((p^2)^(e+1)-1)/(p^2-1) for p == 1 (mod 3), a(p^e) = (1-(-p^2)^(e+1))/(p^2+1) for p == 2 (mod 3). - _Andrew Howroyd_, Aug 05 2018

A262209	mul	0
# Z.ONE if p=2; Z.valueOf(0 if e odd : p in A002145; Z.ONE if e even : p in A002145; Z.valueOf(e+1 if p in A002144
# Conjecture: M.w. a(p^e) = 1 if p=2; a(p^e) = 0 if e odd and p in A002145; a(p^e) = 1 if e even and p in A002145; a(p^e) = e+1 if p in A002144.

A166586	mul	0
# b(p) = 2 - p, b(p^e) = 0,
# Dirichlet g.f.: 1 / Product_{p prime} (1 - p^(1 - s) + 2p^s). The Dirichlet inverse is M.w. b(p) = 2 - p, b(p^e) = 0, for e > 1. - _Álvar Ibeas_, Nov 24 2017

A299406	mul	0
# b(p^e) = (((e & 1) == 0) ? 1 : -1) if e < 3,  0, p prime : e >= 0
# Dirichlet inverse b(n) is M.w. b(p^e) = (-1)^e if e < 3, otherwise 0, p prime and e >= 0.

A226602	mul	0
# b(1) = 1, and
# Dirichlet inverse b(n), n>0, is M.w. b(1) = 1, and for p prime and e>0: b(p^e)=0 if e mod 3 = 0 otherwise b(p^e)=3*(-1)^(e mod 3).

A303915	mul	0
# b(1)=1 and
# Dirichlet inverse b(n), n>=1, is M.w. b(1)=1 and for p prime and e>0: b(p^e) = 0 if e mod 3 = 0 otherwise b(p^e) = (-1)^(3 - e mod 3).

A322328	mul	0
# b(p^e) = 4*e*(((e & 1) == 0) ? 1 : -1)
# Dirichlet inverse is b(n) = a(n) * A008836(n) for n > 0, and b(n) is M.w. b(p^e) = 4*e*(-1)^e for prime p and e > 0.

A330687	mul	0
# Z.valueOf(A018819(e) : A018819(2k) = A018819(2k+1) : this sequence considers just records so we only need exponents of the
# Each term is a perfect square. Proof: A050377(n) is M.w. a(p^e) = A018819(e) and A018819(2k) = A018819(2k+1) and this sequence considers just records so we only need exponents of the form 2k; i.e., terms are squares.

A318314	mul	0
# Z.ONE.shiftLeft(((2-A000035(p))*e)-A000120(e))
# Equally, M.w. a(p^e) = 2^(((2-A000035(p))*e)-A000120(e)) for all primes p.

A267326	mul	0
# a factor of 8: a(k*m) = 8*a(k)*a(m)
# For all pair of relatively prime numbers k, m this sequence is M.w. a factor of 8: a(k*m) = 8*a(k)*a(m). - _Christopher Heiling_, Apr 02 2017

A336467	mul	0
# a(2) = 1 : a(p) = A000265(p+1)
# Fully M.w. a(2) = 1 and a(p) = A000265(p+1) for odd primes p, with A000265(k) giving the odd part of k.

A332819	mul	0
# a(2) = 1, a(3) = 2, a(A002144(n)) = A002145(n), : a(A002145(1+n)) = A002144(n)
# Fully M.w. a(2) = 1, a(3) = 2, a(A002144(n)) = A002145(n), and a(A002145(1+n)) = A002144(n) for all n >= 1.

A079065	mult	0
#--------> p.equals(Z.TWO) ? Z.TWO.pow(e) : Z.THREE.pow(e)
# a(2) = 2, a(p) = 3Fully M.w. a(2) = 2, a(p) = 3 for odd primes p.

A332818	mul	0
# a(2) = 3, a(A002145(n)) = A002144(n) : a(A002144(n)) = A002145(1+n),
# Fully M.w. a(2) = 3, a(A002145(n)) = A002144(n) and a(A002144(n)) = A002145(1+n), for all n >= 1.

A319691	mult	0
#--------> p.mod(Z.THREE).equals(Z.ONE) ? Z.ONE : Z.ZERO
# Fully M.w. a(p) = 1 if p is a prime of the form 3k+1, otherwise a(p) = 0.

A339903	mul	0
# a(p) = A000265(q-1), where q = A151800(p), the next prime > p
# Fully M.w. a(p) = A000265(q-1), where q = A151800(p), the next prime > p.

A332213	mul	0
# a(p) = A332210(A000720(p))
# Fully M.w. a(p) = A332210(A000720(p)).

A332212	mul	0
# a(p) = A332211(A000720(p))
# Fully M.w. a(p) = A332211(A000720(p)).

A332808	mul	0
# a(p) = A332806(A000720(p))
# Fully M.w. a(p) = A332806(A000720(p)).

A133205	mult	0
#--------> p.multiply(p.add(Z.ONE)).divide2().pow(e)
# Fully M.w. a(p) = p*(p+1)/2 for prime p.

A319690	mult	0
#--------> p.mod(Z.THREE).pow(e)
# Fully M.w. a(p^e) = (p mod 3)^e.

A278509	mult	0
#----> p.equals(Z.TWO) ? Z.ONE : p.mod(Z.FOUR).pow(e)
# Fully M.w. a(p^e) = 1 if p = 2, (p mod 4)^e if p > 2.

A324391	mul	0
# Z.valueOf(A070939(p)^e, where A070939(p) gives the length of the binary representation of p
# Fully M.w. a(p^e) = A070939(p)^e, where A070939(p) gives the length of the binary representation of p.

A319985	mul	0
# prime(p mod 12)^e
# Fully M.w. a(p^e) = prime(p mod 12)^e.

A319984	mul	0
# prime(p mod 4)^e
# Fully M.w. a(p^e) = prime(p mod 4)^e.

A319986	mul	0
# prime(p mod 6)^e
# Fully M.w. a(p^e) = prime(p mod 6)^e.

A319987	mul	0
# prime(p mod 8)^e
# Fully M.w. a(p^e) = prime(p mod 8)^e.

A267099	mul	0
# a(p_n) = p_{A267100(n)} = A267101(n)
# Fully M.w. a(p_n) = p_{A267100(n)} = A267101(n).

A248692	mul	0
# a(prime(i)) = 2^i
# Fully M.w. a(prime(i)) = 2^i.

A324900	mul	0
# a(prime(k)) = A000032(2*(k+1)) = A000045(2k+1) + A000045(2k+3)
# Fully M.w. a(prime(k)) = A000032(2*(k+1)) = A000045(2k+1) + A000045(2k+3).

A339905	mul	0
# a(prime(k)) = prime(k+1) - 1
# Fully M.w. a(prime(k)) = prime(k+1) - 1.

A295665	mul	0
# a(prime(m)) = prime(k) when m = prime(k), : a(prime(m)) = 1 when m is not a prime
# Fully M.w. a(prime(m)) = prime(k) when m = prime(k), and a(prime(m)) = 1 when m is not a prime.

A347101	mul	0
# a(prime(n)) = A001223(n), where A001223 gives the distance from the n-th prime to the (n+1)-th prime
# Fully M.w. a(prime(n)) = A001223(n), where A001223 gives the distance from the n-th prime to the (n+1)-th prime.

A325032	mul	0
# a(prime(n)) = A003963(n)
# Fully M.w. a(prime(n)) = A003963(n).

A325035	mul	0
# a(prime(n)) = A056239(n), restricted to odd n
# Fully M.w. a(prime(n)) = A056239(n), restricted to odd n.

A347123	mul	0
# a(prime(n)) = prime(1+floor(A001223(n)/2))
# Fully M.w. a(prime(n)) = prime(1+floor(A001223(n)/2)).

A257538	mul	0
# a(prime(n)) = prime(prime(a(n)))
# Fully M.w. a(prime(n)) = prime(prime(a(n))). - _Antti Karttunen_, Mar 09 2017

A109386	mul	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1)-1 : p.pow(e+2).multiply(e+1)-p.pow(e+1).multiply(e+2)+1).divide(p-1).square()
# G.f.: Sum_{n>0} n*A000005(n)*x^n/(1+x^n). a(n) = A060640(n) if n is odd, else a(n) = A060640(n)-2*A060640(n/2). M.w. a(2^e) = 2^(e+1)-1 and a(p^e) = (p^(e+2)*(e+1)-p^(e+1)*(e+2)+1)/(p-1)^2 for p>2. - _Vladeta Jovovic_, Jul 05 2005

A132705	mul	0
# (p) = p + 2
# If a(1) were 1 rather than 3, the sequence would be completely M.w. a(p) = p + 2. - _Charles R Greathouse IV_, Sep 02 2009

A092342	mul	0
# b(3^e) = 0^e, b(p^e) = (p.pow(3*e+3).subtract(1).divide(p^3 - 1)
# If b(3*n) = 0, b(3*n+1) = a(n), b(3*n+2) = A092343(n), then b(n) is M.w. b(3^e) = 0^e, b(p^e) = (p^(3*e+3) - 1) / (p^3 - 1) otherwise. - _Michael Somos_, Aug 22 2007

A253193	mul	0
# b(23^e) = 1,  b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2))
# If b(n) = a(n) - (1 + sqrt(5))/2 * A232506(n) then b() is M.w. b(23^e) = 1, otherwise b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)).

A091306	mul	0
# b(p,k)=p^k+1 : b(p^e,k)=1
# If b(n,k) = sum of k-th powers of unitary, squarefree divisors of n, including 1, then b(n,k) is M.w. b(p,k)=p^k+1 and b(p^e,k)=1 for e>1.

A249010	mul	0
# b(2^e) = 2 - 2^e, b(5^e) = 1, : b(p^e) = (p.pow(e+1).subtract(1).divide(p.subtract(1))
# If n>0 then a(n) = -3 * b(n) where b is M.w. b(2^e) = 2 - 2^e, b(5^e) = 1, and b(p^e) = (p^(e+1) - 1) / (p - 1) otherwise.

A329378	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Least common multiple of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A194959	mul	0
# B(n,p^e) = A(n,e+1)
# Let B(n,k) be M.w. B(n,p^e) = A(n,e+1) for e >= 0 and some fixed n > 0. That yields the Dirichlet g.f.: Sum_{k>0} B(n,k)/k^s = (zeta(s))^3/(zeta(2*s)*zeta(n*s)).

A341343	mul	0
# b(p.pow(3*e)) = 1
# Let b(n), n > 0, be the Dirichlet inverse of a(n); b(n) is M.w. b(p^(3*e)) = 1 for e >= 0, and b(p^(3*e-2)) = -3*e and b(p^(3*e-1)) = 3*e for e > 0 and prime p.

A182139	mul	0
# a_q(p^e) = (q^(e+1).subtract(1).divide(q-1)
# More generally: Let a_q(n) be M.w. a_q(p^e) = (q^(e+1)-1)/ (q-1) for prime p, e >= 0 and some fixed integer q. Then a_q(n) is the inverse Moebius transform of the completely multiplicative sequence b_q(n) = q^bigomega(n) with b_q(p) = q and b_q(1) = 1. For q = 1 see a_q(n) = A000005(n) and b_q(n) = A000012(n), for q = 0 see a_q(n) = A000012(n) and b_q(n) = A000007(n) with offset 1, and for q = -1 see a_q(n) = A010052(n) with offset 1 and b_q(n) = A008836(n). - _Werner Schulte_, Feb 20 2019

A079707	mul	0
# 2->2 : prime(k)->prime(k-1), k>1
# M.w. 2->2 and prime(k)->prime(k-1), k>1.

A284587	mult	0
#--------> p.equals(Z.valueOf(13)) ? Z.ONE : p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(13^e) = 1 and a(p^e) = (p^(e+1)-1)/(p-1) otherwise. - _Amiram Eldar_, Sep 17 2020

A257477	mul	0
# a(2) = 0, a(4) = -1, p.equals(Z.TWO) ? Z.valueOf(0 if e>2, a(3) = -1, a(3^e) = 0^e if e>1, Z.ONE if p == 1, 3 (mod 8), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5, 7 (mod 8)
# M.w. a(2) = 0, a(4) = -1, a(2^e) = 0 if e>2, a(3) = -1, a(3^e) = 0^e if e>1, a(p^e) = 1 if p == 1, 3 (mod 8), a(p^e) = (1 + (-1)^e) / 2 if p == 5, 7 (mod 8).

A257403	mul	0
# a(2) = 1, p.equals(Z.TWO) ? Z.valueOf(0 if e>1, a(3^e) = 0^e, Z.valueOf(e+1 if p == 1, 3 (mod 8), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5, 7 (mod 8)
# M.w. a(2) = 1, a(2^e) = 0 if e>1, a(3^e) = 0^e, a(p^e) = e+1 if p == 1, 3 (mod 8), a(p^e) = (1 + (-1)^e) / 2 if p == 5, 7 (mod 8).

A319100	mul	0
# a(2) = 1, a(4) = 2, p.equals(Z.TWO) ? Z.valueOf(4
# M.w. a(2) = 1, a(4) = 2, a(2^e) = 4 for e >= 3; a(3) = 2, a(3^e) = 6 if e >= 2; for other primes p, a(p^e) = 6 if p == 1 (mod 6), a(p^e) = 2 if p == 5 (mod 6).

A060594	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.ONE : (e == 2 ? Z.TWO : Z.FOUR)) : Z.TWO
# M.w. a(2) = 1; a(2^2) = 2; a(2^e) = 4 for e > 2; a(q^e) = 2 for q an odd prime. - _Eric M. Schmidt_, Jul 09 2013

A327730	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.TWO : Z.FOUR) : Z.TWO
# M.w. a(2) = 2 and a(2^e) = 4 for e > 1; a(p^e) = 2 for odd primes p.

A182039	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.TWO : (e == 2 ? Z.valueOf(16) : Z.ONE.shiftLeft(e+3))) : (p.mod(Z.FOUR).equals(Z.ONE) ? p.subtract(1).multiply2().multiply(p.pow(e-1)) : p.add(1).multiply2().multiply(p.pow(e-1)))
# M.w. a(2) = 2, a(4) = 16, a(2^e) = 2^(e+3) for e >= 3; a(p^e) = 2*(p-1)*p^(e-1) if p == 1 (mod 4), 2*(p+1)*p^(e-1) if p == 3 (mod 4).

A304182	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.THREE : Z.FOUR) : Z.TWO
# M.w. a(2) = 3, a(2^e) = 4 (for e>1), and a(p^e) = 2 (for p>2).

A062771	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.SIX   : Z.ONE.shiftLeft(e+1)) : p.subtract(1).multiply(p.pow(e-1))
# M.w. a(2) = 6, a(2^e) = 2^(e+1), e>1, a(p^e) = (p-1)*p^(e-1), p>2. - _Christian G. Bower_, May 18 2005

A089146	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.EIGHT : Z.FOUR) : Z.ONE
# M.w. a(2) = 8, a(2^e) = 4 if e >= 2, a(p^e) = 1 otherwise. - _David W. Wilson_, Jun 12 2005

A111973	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.TWO : Z.SIX) : p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(2)=2, a(2^e)=6 if e>1, a(p^e)=(p^(e+1)-1)/(p-1) if p>2.

A319997	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.NEG_ONE: Z.ZERO) : p.subtract(1).multiply(p.pow(e-1))
# M.w. a(2^1) = -1, a(2^e) = 0 for e > 1, and a(p^e) = (p - 1)*p^(e-1) when p is an odd prime.

A319993	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.NEG_ONE: Z.ZERO) : p.pow(e-1)
# M.w. a(2^1) = -1, a(2^e) = 0 for e > 1, and a(p^e) = p^(e-1) when p is an odd prime.

A076109	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.ONE: Z.ZERO) : p
# M.w. a(2^1) = 1; a(2^e) = 0 if e >= 2; a(p^e) = p if p >= 3. - David W. Wilson, Jun 10 2005

A087782	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.TWO: Z.ONE) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.THREE : Z.ONE)
# M.w. a(2^1) = 2, a(2^e) = 1 for e > 1, a(p^e) = 3 for p mod 4 == 1, a(p^e) = 1 for p mod 4 == 3. - _Andrew Howroyd_, Jul 15 2018

A316985	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.FOUR: (e == 2 ? Z.valueOf(24) : Z.ONE.shiftLeft(2*e+1))) : p.add(1).multiply(p.pow(2*e-1))
# M.w. a(2^1) = 4, a(2^2) = 24, a(2^e) = 2^(2*e+1) for e > 2, a(p^e) = (p+1)*p^(2*e-1) for odd prime p.

A115076	mult	0
#--------> p.equals(Z.TWO) ? (e == 1 ? Z.FOUR: Z.ONE.shiftLeft(2*e-2).multiply(3)) : (p.mod(Z.FOUR).equals(Z.ONE) ? p.add(1).multiply(p.pow(2*e-1)) : p.subtract(1).multiply(p.pow(2*e-1)) )
# M.w. a(2^1) = 4, a(2^e) = 3*2^(2*e-2) for e > 1, a(p^e) = (p+1)*p^(2*e-1) for p mod 4 == 1, a(p^e) = (p-1)*p^(2*e-1) for p mod 4 == 3. - _Andrew Howroyd_, Jul 04 2018

A290099	mul	0
# p.equals(Z.TWO) ? Z.valueOf((((e & 1) == 0) ? 1 : -1) : prevprime(p)^e
# M.w. a(2^e) = (-1)^e and a(p^e) = prevprime(p)^e for odd primes p.

A236313	mult	0
#--------> p.equals(Z.TWO) ? Z.ONE.add(Z.THREE.pow(e)).divide2() : Z.ONE
# M.w. a(2^e) = (1 + 3^e)/2, a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 31 2018

A300853	mult	0
#----> p.equals(Z.TWO) ? Z.ONE.subtract(Z.TWO.pow(e+1).multiply((((e + 1) & 1) == 0) ? 1 : -1)).divide(3) : p.pow(2*(e/2 + 1)).subtract(1).divide(p.square().subtract(1))
# M.w. a(2^e) = (1 - (-2)^(e + 1))/3, and a(p^e) = (p^(2*floor(e/2 + 1)) - 1)/(p^2 - 1) for an odd prime p. - _Amiram Eldar_, Oct 25 2020

A328667	mult	0
#----> p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*e+1).add(7).divide(3) : p.pow(2*e+2).subtract(1).divide(p.square().subtract(1))
# M.w. a(2^e) = (2*(2*e+1) + 7)/3 = A321358(e) if e>0, else a(p^e) = (p^(2*e+2) - 1)/(p^2 - 1).

A078306	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*e).multiply(2).add(1).divide(3) : p.pow(2*e+2).subtract(1).divide(p.square().subtract(1))
# M.w. a(2^e) = (2*4^e+1)/3, a(p^e) = (p^(2*e+2)-1)/(p^2-1), p > 2.

A065766	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*(e+1)).subtract(1).divide(3) : p.pow(2*e+1).subtract(1).divide(p.subtract(1))
# M.w. a(2^e) = (4^(e+1)-1)/3 and a(p^e) = (p^(2*e+1)-1)/(p-1) for an odd prime p. - _Vladeta Jovovic_, Dec 01 2001

A328407	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*(e+1)).subtract(1).divide(3) : p.pow(2*e)
# M.w. a(2^e) = (4^(e+1)-1)/3, and a(p^e) = p^(2*e) for an odd prime p. - _Amiram Eldar_, Oct 25 2020

A078747	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*e).subtract(1).divide(3) : p.pow(2*e+1).add(1).divide(p.add(1))
# M.w. a(2^e) = (4^e-1)/3, a(p^e) = (p^(2*e+1)+1)/(p+1), p>2.

A078307	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(3*e).multiply(6).add(1).divide(7) : p.pow(3*e+3).subtract(1).divide(p.pow(3).subtract(1))
# M.w. a(2^e) = (6*8^e+1)/7, a(p^e) = (p^(3*e+3)-1)/(p^3-1), p > 2.

A123726	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e*e + 2*e + 1) : Z.ONE
# M.w. a(2^e) = (e + 1)^2, a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 31 2018

A288571	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e+1).multiply(2-e).divide2() : Z.valueOf(e+1).multiply(e+2).divide2()
# M.w. a(2^e) = (e+1)*(2-e)/2, and a(p^e) = (e+1)*(e+2)/2 for an odd prime p. - _Amiram Eldar_, Oct 25 2020

A326417	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e+1).multiply(e+2).divide2() : Z.valueOf(e+1).multiply(e+2).multiply(e+3).divide(6)
# M.w. a(2^e) = (e+1)*(e+2)/2, and a(p^e) = (e+1)*(e+2)*(e+3)/6 for odd primes p. - _Amiram Eldar_, Dec 02 2020

A317529	mult	0
# p.equals(Z.TWO) ? Z.valueOf((((e & 1) == 1) ? - (e/2+1) : - (e-1)/2)) : Z.valueOf(e/2+1)
# M.w. a(2^e) = -floor(e/2+1) for odd e, -floor((e-1)/2) for even e, and a(p^e) = floor(e/2+1) for an odd prime p. - _Amiram Eldar_, Oct 25 2020

A123565	mult	0
# p.equals(Z.TWO) ? Z.ZERO : p.subtract(3).multiply(p.pow(e-1))
# M.w. a(2^e) = 0 and a(p^e) = (p-3)*p^(e-1) for odd primes p. - _Amiram Eldar_, Nov 22 2020

A328373	mult	0
# p.equals(Z.TWO) ? (((e & 1) == 0) ? Z.ONE : Z.ZERO) : (((e & 1) == 1) ? p.pow(e+2).subtract(p).divide(p.square().subtract(1)) : p.pow(e+2).subtract(1).divide(p.square().subtract(1)))
# M.w. a(2^e) = 0 if e is odd, and 1 if e is even, and for p > 2, a(p^e) = (p^(e + 2) - p)/(p^2 - 1) if e is odd, and (p^(e + 2) - 1)/(p^2 - 1) if e is even. - _Amiram Eldar_, Oct 16 2020

A229297	mul	0
# p.equals(Z.TWO) ? Z.ONE + (((e & 1) == 0) ? 1 : -1), p^floor(e/2)
# M.w. a(2^e) = 1 + (-1)^e, a(p^e) = p^floor(e/2) for odd prime p.

A318768	mult	0
# p.equals(Z.TWO) ? Z.ONE.add((7-e*e)*e/6) : Binomial.binomial(e+3,3)
# M.w. a(2^e) = 1 + (7-e^2)*e/6, and a(p^e) = binomial(e+3,3) for an odd prime p. - _Amiram Eldar_, Oct 25 2020

A089242	mul	0
# p.equals(Z.TWO) ? Z.ONE + a(e), Z.ONE
# M.w. a(2^e) = 1 + a(e), a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 27 2018

A298735	mult	0
# p.equals(Z.TWO) ? Z.ONE : Z.valueOf(e/2 + 1)
# M.w. a(2^e) = 1 and a(p^e) = floor(e/2) + 1 for p > 2. - _Amiram Eldar_, Sep 11 2020

A064989	mul	0
# p.equals(Z.TWO) ? Z.ONE : prevprime(p)^e
# M.w. a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p.

A250207	mult	0
# p.equals(Z.TWO) ? (e <= 3 ? Z.ONE : Z.ONE.shiftLeft(e-4)) : p.pow(e-1).multiply(p.subtract(1)).divide(p.mod(Z.FOUR).equals(Z.ONE) ? 4 : 2)
# M.w. a(2^e) = 1 for e<=3; a(2^e) = 2^(e-4) for e>=4; a(p^e) = p^(e-1)*(p-1)/4 for e>=1 and p == 1 (mod 4); a(p^e) = p^(e-1)*(p-1)/2 for e>=1 and p == 3 (mod 4). (Derived from A073103.) - _R. J. Mathar_, Oct 13 2017

A293485	mult	0
# p.equals(Z.TWO) ? (e <= 4 ? Z.ONE : Z.ONE.shiftLeft(e-5)) : p.pow(e-1).multiply(p.subtract(1)).divide(p.mod(Z.EIGHT).equals(Z.ONE) ? 8 : (p.mod(Z.EIGHT).equals(Z.FIVE) ? 4 : 2))
# M.w. a(2^e) = 1 for e<=5, a(2^e) = 2^(e-5) for e>=5; a(p^e) = (p-1)*p^(e-1)/8 for p == 1 (mod 8); a(p^e) = (p-1)*p^(e-1)/4 for p == 5 (mod 8); a(p^e) = (p-1)*p^(e-1)/2 for p == {3,5} (mod 8). - _R. J. Mathar_, Oct 15 2017

A300894	mult	0
# p.equals(Z.TWO) ? (e == 1 ? Z.ONE : Z.valueOf(-3)) : p.add(1)
# M.w. a(2^e) = 1 if e = 1, and -3 otherwise, and a(p^e) = p+1 for an odd prime p. - _Amiram Eldar_, Oct 25 2020

A109712	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e).add(1) : p.pow(e).subtract(1)
# M.w. a(2^e) = 1+2^e, a(p^e)=p^e-1 for primes p>2, e>0. - _R. J. Mathar_, Jun 02 2011

A104117	mult	0
# p.equals(Z.TWO) ? Z.ONE.add(e) : Z.ZERO
# M.w. a(2^e) = 1+e, and a(p^e)=0 for odd primes p and e>=1. Dirichlet convolution square of A209229. - _R. J. Mathar_, Mar 12 2012

A244611	mult	0
# p.equals(Z.TWO) ? Z.ONE : (p.equals(Z.THREE) ? (((e & 1) == 0) ? Z.ONE : Z.NEG_ONE) : (((e & 1) == 0) ? Z.ONE : Z.NEG_ONE).add(1).divide2())
# M.w. a(2^e) = 1, a(3^e) = (-1)^e, and a(p^e) = (1 + (-1)^e) / 2 if p>3.

A132740	mult	0
# p.equals(Z.TWO) ? Z.ONE : (p.equals(Z.FIVE) ? Z.ONE : p.pow(e))
# M.w. a(2^e) = 1, a(5^e) = 1 and a(p^e) = p^e for p = 3 and p >= 7.

A336649	mult	0
# p.equals(Z.TWO) ? Z.ONE : (e == 1 ? Z.ONE : p.pow(e).subtract(1).divide(p.subtract(1)))
# M.w. a(2^e) = 1, a(p^1) = 1 and a(p^e) = (p^e - 1)/(p-1) if e > 1.

A347385	mult	0
# p.equals(Z.TWO) ? Z.ONE : p.add(1).multiply(p.pow(e-1))
# M.w. a(2^e) = 1, a(p^e) = (p+1)*p^(e-1) for all odd primes p.

A275367	mult	0
# p.equals(Z.TWO) ? Z.ONE : Z.valueOf(2*e + 1)
# M.w. a(2^e) = 1, a(p^e) = 2*e + 1 for odd prime p. - _Andrew Howroyd_, Jul 20 2018

A206787	mult	0
# p.equals(Z.TWO) ? Z.ONE : p.add(1)
# M.w. a(2^e) = 1, and a(p^e) = p + 1 for p > 2. - _Amiram Eldar_, Sep 18 2020

A192066	mult	0
# p.equals(Z.TWO) ? Z.ONE : p.pow(e).add(1)
# M.w. a(2^e) = 1, and a(p^e) = p^e + 1 for p > 2. - _Amiram Eldar_, Sep 18 2020

A326041	mul	0
# p.equals(Z.TWO) ? Z.ONE , and
# M.w. a(2^e) = 1, and for odd primes p, a(p^e) = (q^(e+1)-1)/(q-1), where q = A151799(p).

A256232	mult	0
# p.equals(Z.TWO) ? Z.ONE.subtract(e) : (p.equals(Z.THREE) ? Z.ONE : Z.valueOf(e+1))
# M.w. a(2^e) = 1-e, a(3^e) = 1, a(p^e) = e+1 if p>3.

A062327	mult	0
# p.equals(Z.TWO) ? Z.valueOf(2*e+1) : (p.mod(Z.FOUR).equals(Z.THREE) ? Z.valueOf(e+1) : Z.valueOf(e+1).square())
# M.w. a(2^e) = 2*e+1, a(p^e) = e+1 if p mod 4=3 and a(p^e) = (e+1)^2 if p mod 4=1. - _Vladeta Jovovic_, Jan 23 2003

A309324	mult	0
# p.equals(Z.TWO) ? Z.TWO : p.pow(e).multiply(p.add(1)).subtract(2).divide(p.subtract(1))
# M.w. a(2^e) = 2, and a(p^e) = (p^e*(p+1)-2)/(p-1) for odd primes p. - _Amiram Eldar_, Dec 01 2020

A344875	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(1+e).subtract(1) : p.pow(e).subtract(1)
# M.w. a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e - 1 for odd primes p.

A079458	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*e-1) : p.pow(2*e-2).multiply(p.mod(Z.FOUR).equals(Z.THREE) ? p.square().subtract(1) : p.subtract(1).square())
# M.w. a(2^e) = 2^(2*e-1), a(p^e) = (p^2-1)*p^(2*e-2) if p mod 4=3 and a(p^e) = (p-1)^2*p^(2*e-2) if p mod 4=1.

A332793	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*e-1) : (e == 1 ? p.negate() : Z.ZERO)
# M.w. a(2^e) = 2^(2*e-1), and a(p^e) = -p if e=1 and 0 for e>1, for odd primes p. - _Amiram Eldar_, Dec 02 2020

A214682	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft((e/2) * 2) : p.pow(e)
# M.w. a(2^e) = 2^(2*floor(e/2)), and a(p^e) = p^e for odd primes p. - _Amiram Eldar_, Dec 09 2020

A316148	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(2*e+1).multiply(Z.ONE.shiftLeft(e).subtract(1)) : p.pow(3*e).add(p.pow(3*e-1)).subtract(p.pow(2*e-1))
# M.w. a(2^e) = 2^(2e+1)*(2^e-1), a(p^e) = p^(3e)+p^(3e-1)-p^(2e-1) for odd primes p.

A069256	mul	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(4*e-3) : ZUtils.valuation((p.subtract(1)).multiply(p.square().subtract(1)), Z.TWO)
# M.w. a(2^e) = 2^(4*e-3) and a(p^e) = power of 2 in prime factorization of (p.subtract(1))*(p^2-1) for an odd prime p. - _Vladeta Jovovic_, Apr 17 2002

A238534	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(6*e-1) : p.subtract(1).multiply(p.pow(6*e - 4)).multiply(p.pow(3).subtract(p.subtract(1).multiply(3).divide2().isEven() ? Z.ONE : Z.NEG_ONE))
# M.w. a(2^e) = 2^(6*e-1), a(p^e) = (p - 1)*p^(6*e - 4)*(p^3 - (-1)^(3*(p-1)/2)) for odd prime p. - _Andrew Howroyd_, Aug 07 2018

A239441	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(8*e-1) : p.subtract(1).multiply(p.pow(8*e - 5)).multiply(p.pow(4).subtract(1))
# M.w. a(2^e) = 2^(8*e-1), a(p^e) = (p - 1)*p^(8*e - 5)*(p^4 - 1) for odd prime p. - _Andrew Howroyd_, Aug 06 2018

A297402	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1) : Z.ONE
# M.w. a(2^e) = 2^(e+1), a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 25 2018

A065745	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).subtract(1) : p.pow(e+ (((e & 1) == 0) ? 2 : 1)).subtract(1).divide(p.subtract(1)).divide(p.add(1))
# M.w. a(2^e) = 2^(e+1)-1, a(p^e) = (p^(e+2)-1)/(p-1)/(p+1) for odd p and even e and a(p^e) = (p^(e+1)-1)/(p-1)/(p+1) for odd p and odd e.

A107749	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).subtract(1) : p.pow(e).add(1)
# M.w. a(2^e) = 2^(e+1)-1, a(p^e) = p^e+1 for p>2, e>0.

A174238	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).subtract(1) : Z.valueOf(e+1)
# M.w. a(2^e) = 2^(e+1)-1, and a(p^e) = e+1 for p > 2. - _Amiram Eldar_, Sep 30 2020

A113184	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).subtract(3) : p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(2^e) = 2^(e+1)-3 if e>0, a(p^e) = (p^(e+1)-1)/(p-1) if p>2.

A317623	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e-1) : (p.equals(Z.THREE) ? Z.THREE.pow(e) : Z.ONE.add(p.pow(e+1).divide(p.multiply(2).add(2))))
# M.w. a(2^e) = 2^(e-1), a(3^e) = 3^e, a(p^e) = 1 + floor( p^(e+1)/(2*p+2) ) for prime p >= 5.

A290731	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e-1) : p.pow(e+1).divide(p.multiply2().add(2)).add(1)
# M.w. a(2^e) = 2^(e-1), a(p^2) = 1 + floor(p^(e+1)/(2*p+2)) for odd prime p. - _Andrew Howroyd_, Aug 01 2018

A329272	mult	0
# p.equals(Z.TWO) ? (2 <= e && e <= 5 ? Z.ONE.shiftLeft(e-2) : Z.ZERO) : (e == 1 ? Z.EIGHT.gcd(p.subtract(1)).subtract(1) : Z.ZERO)
# M.w. a(2^e) = 2^(e-2) for 2 <= e <= 5, a(2^e) = 0 for e = 1 or e >= 6; a(p^e) = gcd(p-1, 8)-1 if p > 2 and e = 1, a(p^e) = 0 if p > 2 and e >= 2.

A117659	mult	0
# p.equals(Z.TWO) ? (e < 3 ? Z.ONE.shiftLeft(e) : Z.ONE.shiftLeft(e-1).add(4)) : p.pow(e-1).add(2)
# M.w. a(2^e) = 2^e for e < 3 and 2^(e-1) + 4 for e >= 3, and a(p^e) =  p^(e-1) + 2 for p > 2. - _Amiram Eldar_, Sep 08 2020

A089002	mult	0
# p.equals(Z.TWO) ? (e <= 2 ? Z.ONE.shiftLeft(e) : Z.ZERO) : p.pow(e-1).multiply(p.add(p.subtract(2).mod(Z.EIGHT).equals(Z.ONE) || p.subtract(2).mod(Z.EIGHT).equals(Z.SEVEN) ? Z.NEG_ONE : Z.ONE))
# M.w. a(2^e) = 2^e for e <= 2, a(2^e) = 0 for e > 2, a(p^e) = (p-1)*p^(e-1) for p-2 mod 8 = +-1, a(p^e) = (p+1)*p^(e-1) for p-2 mod 8 = +-3. - _Andrew Howroyd_, Jul 15 2018

A088965	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e <= 2 ? e : e + 1) : p.pow(e-1).multiply(p.add(p.subtract(2).mod(Z.EIGHT).equals(Z.ONE) || p.subtract(2).mod(Z.EIGHT).equals(Z.SEVEN) ? Z.NEG_ONE : Z.ONE))
# M.w. a(2^e) = 2^e for e <= 2, a(2^e) = 2^(e + 1) for e > 2, a(p^e) = (p-1)*p^(e-1) for p-2 mod 8 = +-1, a(p^e) = (p+1)*p^(e-1) for p-2 mod 8 = +-3. - _Andrew Howroyd_, Jul 13 2018

A089003	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e <= 2 ? e : e + 1) : p.pow(e-1).multiply(p.add(p.mod(Z.EIGHT).equals(Z.ONE) || p.mod(Z.EIGHT).equals(Z.SEVEN) ? Z.NEG_ONE : Z.ONE))
# M.w. a(2^e) = 2^e for e <= 2, a(2^e) = 2^(e+1) for e > 2, a(p^e) = (p-1)*p^(e-1) for p == +-1 (mod 8), a(p^e) = (p+1)*p^(e-1) for p == +-3 (mod 8). - _Andrew Howroyd_, Jul 15 2018

A069184	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e).add(1) : p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(2^e) = 2^e+1 and a(p^e) = (p^(e+1)-1)/(p-1) for an odd prime p.

A290732	mult	0
# p.compareTo(Z.THREE) <= 0 ? p.pow(e) : Z.ONE.add(p.pow(e+1).divide(p.multiply2().add(2)))
# M.w. a(2^e) = 2^e, a(3^e) = 3^e, a(p^e) = 1 + floor( p^(e+1)/(2*p+2) ) for prime p >= 5. - _Andrew Howroyd_, Nov 03 2018

A117484	mult	0
# p.equals(Z.TWO) ?Z.ONE.shiftLeft(e) : Z.ONE.add(p.pow(e+1).divide(p.multiply2().add(2)))
# M.w. a(2^e) = 2^e, a(p^e) = floor(p^(e+1)/(2p+2))+1 for p > 2.

A087561	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e) : (p.subtract(2).mod(Z.EIGHT).equals(Z.THREE) || p.subtract(2).mod(Z.EIGHT).equals(Z.FIVE) ? p.pow((e/2) * 2) : p.subtract(1).multiply(e).add(p).multiply(p.pow(e-1)))
# M.w. a(2^e) = 2^e, a(p^e) = p^(2*floor(e/2)) for p - 2 == +-3 (mod 8), a(p^e) = ((p-1)*e+p)*p^(e-1) for p - 2 == +-1 (mod 8). - _Andrew Howroyd_, Jul 16 2018

A088964	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e) : (p.mod(Z.EIGHT).equals(Z.THREE) || p.mod(Z.EIGHT).equals(Z.FIVE) ? p.pow((e/2) * 2) : p.subtract(1).multiply(e).add(p).multiply(p.pow(e-1)))
# M.w. a(2^e) = 2^e, a(p^e) = p^(2*floor(e/2)) for p mod 8 = +-3, a(p^e) = ((p-1)*e+p)*p^(e-1) for p mod 8 = +-1. - _Andrew Howroyd_, Jul 13 2018

A235872	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e) : p.pow((e/2) * 2)
# M.w. a(2^e) = 2^e, a(p^e) = p^(2*floor(e/2)). - _Andrew Howroyd_, Aug 06 2018

A227091	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e < 3 ? e : 3) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.FOUR : Z.TWO)
# M.w. a(2^e) = 2^min(e, 3); a(p^e) = 4 for p == 1 (mod 4); a(p^e) = 2 for p == 3 (mod 4). - _Eric M. Schmidt_, Jul 09 2013

A185152	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e).multiply(3) : p.pow(e).multiply(p.pow(e+1).subtract(1)).divide(p.subtract(1))
# M.w. a(2^e) = 3 * 2^e if e>0, a(p^e) = p^e * (p^(e+1) - 1) / (p - 1) otherwise.

A328154	mult	0
# p.equals(Z.TWO) ? Z.THREE.subtract(Z.ONE.shiftLeft(e+1)) : p.pow(e)
# M.w. a(2^e) = 3 - 2^(e+1) and a(p^e) = p^e for e >= 0 and prime p > 2.

A240226	mult	0
# p.equals(Z.TWO) ? Z.FOUR.pow(new Q(e, 2).ceiling().intValue()) : Z.ONE
# M.w. a(2^e) = 4^ceiling(e/2), a(p^e) = 1 for odd prime p. (End)

A076598	mult	0
# p.equals(Z.TWO) ? Z.FOUR.pow(e).add(1) :  p.pow(2*e+2).subtract(1).divide(p.square().subtract(1))
# M.w. a(2^e) = 4^e+1, a(p^e) = (p^(2*e+2)-1)/(p^2-1) for an odd prime p. G.f.: Sum_{m>0} m^2*x^m*(1+2*x^m+3*x^(2*m))/(1+x^(2*m))/(1+x^m). More generally, if b(n, k) is sum of k-th powers of divisors d of n such that d or n/d is odd then b(n, k) = sigma_k(n)-2^k*sigma_k(n/4) if n mod 4=0, otherwise b(n, k) = sigma_k(n). G.f. for b(n, k): Sum_{m>0} m^k*x^m*(1+x^m+x^(2*m)-(2^k-1)*x^(3*m))/(1-x^(4*m)). b(n, k) is multiplicative and b(2^e, k) = 2^(k*e)+1, b(p^e, k) = (p^(k*e+k)-1)/(p^k-1) for an odd prime p.

A284341	mult	0
# p.equals(Z.TWO) ? (e >= 3 ? Z.SEVEN : p.pow(e+1).subtract(1).divide(p.subtract(1))) : p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(2^e) = 7 if e>=3, and a(p^e) = (p^(e + 1) - 1)/(p - 1) otherwise. - _Amiram Eldar_, Sep 17 2020

A335115	mul	0
# p.equals(Z.TWO) ? Z.valueOf(A001045(e+1) : p^e
# M.w. a(2^e) = A001045(e+1) and a(p^e) = p^e for e >= 0 and prime p > 2. - _Werner Schulte_, Oct 05 2020

A082388	mul	0
# p.equals(Z.TWO) ? Z.valueOf(A006012(e), Z.ONE
# M.w. a(2^e) = A006012(e), a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Jul 31 2018

A268361	mult	0
# p.equals(Z.TWO) ? Fibonacci.fibonacci(2 + e) : Z.ONE
# M.w. a(2^e) = Fibonacci(2 + e), a(p^e) = 1 for odd prime p. - _Andrew Howroyd_, Aug 02 2018

A129502	mult	0
# p.equals(Z.TWO) ? Binomial.binomial(e + 2, 2) : Z.ZERO
# M.w. a(2^e) = binomial(e + 2, 2), a(p^e) = 0 for odd prime p.

A288417	mul	0
# p.equals(Z.TWO) ? Z.valueOf(e+1 : Z.valueOf(Sum_{i=0
# M.w. a(2^e) = e+1 and a(p^e) = Sum_{i=0..e} (i+1)*p^(e-i) for e >= 0 and prime p > 2. - _Werner Schulte_, Jan 05 2021

A065704	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e+1) : Z.valueOf(e/2).add(1)
# M.w. a(2^e) = e+1 and a(p^e) = floor(e/2)+1 for an odd prime p.

A320111	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e) : Z.valueOf(e+1)
# M.w. a(2^e) = e, a(p^e) = (e+1) for odd primes p.

A099751	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e-1) : (p.equals(Z.THREE) ? Z.ONE : Z.valueOf(e+1))
# M.w. a(2^e) = e-1 if e>0, a(3^e) = 1, a(p^e) = e+1 if p>3.

A112329	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e-1) : Z.valueOf(e+1)
# M.w. a(2^e) = e-1 if e>0, a(p^e) = 1+e if p>2.

A228441	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e-3) : Z.valueOf(e+1)
# M.w. a(2^e) = e-3 if e>0, a(p^e) = e+1 if p>2.

A326813	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e/2 + 1) : (((e & 1) == 1) ? Z.ZERO : Z.ONE)
# M.w. a(2^e) = floor(e/2) + 1, and a(p^e) = 0 if e is odd and 1 if e is even, for odd primes p. - _Amiram Eldar_, Nov 30 2020

A317797	mul	0
# p.equals(Z.TWO) ? Z.valueOf(sigma(Z.ONE.shiftLeft(2e)) = Z.ONE.shiftLeft(2e+1) - 1, Z.valueOf(sigma(p^e).square() = ((p.pow(e+1) - 1).divide(p.subtract(1))).square() if p == 1 (mod 4) : sigma_2(p^e) = A001157(p^e) = (p.pow(2e+2) - 1).divide(p.square().subtract(1)) if p == 3 (mod 4)
# M.w. a(2^e) = sigma(2^(2e)) = 2^(2e+1) - 1, a(p^e) = sigma(p^e)^2 = ((p^(e+1) - 1)/(p - 1))^2 if p == 1 (mod 4) and sigma_2(p^e) = A001157(p^e) = (p^(2e+2) - 1)/(p^2 - 1) if p == 3 (mod 4).

A099892	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e-1).multiply(3) : Z.ZERO
# M.w. a(2^e) =3*2^(e-1), a(p^e) = 0 otherwise. - _David W. Wilson_, Jun 12 2005

A267092	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e-1).multiply(e+2) : p.pow(e)
# M.w. a(2^e)=(e+2)*2^(e-1) and a(p^e)=p^e for p>2 and e>0.

A065330	mult	0
# p.compareTo(Z.THREE) <= 0 ? Z.ONE : p.pow(e)
# M.w. a(2^e)=1, a(3^e)=1, a(p^e)=p^e, p>3. - _Vladeta Jovovic_, Nov 02 2001

A091396	mult	0
# p.equals(Z.TWO) ? Z.ONE : (p.mod(Z.EIGHT).equals(Z.THREE) || p.mod(Z.EIGHT).equals(Z.FIVE) ? Z.ZERO : Z.TWO)
# M.w. a(2^e)=1, a(p^e)=0 if p mod 8=3 or p mod 8=5 and a(p^e)=2 if p mod 8=1 or p mod 8=7. - _Vladeta Jovovic_, Mar 02 2004

A255655	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e-1) : p.subtract(1).multiply(e).add(p).multiply(p.pow(e-1))
# M.w. a(2^e)=2^(e-1) for e>0 and a(p^e)=((p-1)*e+p)*p^(e-1) for e>0 and p>2. - _Werner Schulte_, Feb 04 2018

A132741	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e) : (p.equals(Z.FIVE) ? p.pow(e): Z.ONE)
# M.w. a(2^e)=2^e, a(5^e)=5^e and a(p^e)=1 for p=3 or p>=7. - _R. J. Mathar_, Sep 06 2011

A086933	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e) : (p.mod(Z.FOUR).equals(Z.THREE) ? p.pow(e-(e%2)) : p.subtract(1).multiply(e).add(p).multiply(p.pow(e-1)))
# M.w. a(2^e)=2^e, a(p^e)=p^(e-(e mod 2)) if p mod 4=3, a(p^e)=((p-1)*e+p)*p^(e-1) if p mod 4<>3 and p<>2. - _Vladeta Jovovic_, Sep 22 2003

A109040	mult	0
#  p.compareTo(Z.THREE) <= 0 ? Z.ONE : (p.mod(Z.valueOf(12)).equals(Z.ONE) || p.mod(Z.valueOf(12)).equals(Z.valueOf(11)) ? p.pow(e+1).subtract(1).divide(p.subtract(1)) : p.negate().pow(e+1).subtract(1).divide(p.negate().subtract(1)))
# M.w. a(2^e)=a(3^e)=1, a(p^e)=(p^(e+1)-1)/(p-1) if p = 1, 11 (mod 12), a(p^e)=((-p)^(e+1)-1)/(-p-1) if p = 5, 7 (mod 12).

A062803	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e).multiply(e) : p.subtract(1).multiply(e).add(p).multiply(p.pow(e-1))
# M.w. a(2^e)=e*2^e and a(p^e)=((p-1)*e+p)*p^(e-1) for an odd prime p. - _Vladeta Jovovic_, Sep 22 2003

A279395	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(4*e).subtract(1).multiply(16).divide(15).subtract(1) : p.pow(4*(e+1)).subtract(1).divide(p.pow(4).subtract(1))
# M.w. a(2^k) = 2^4*(2^(4*k)-1)/(2^4-1) - 1 = (2^(4*(k+1)) - 31)/15 and a(p^k) = (p^(4*(k+1))-1)/(p^4-1) for primes p > 2 (see A001159).

A115364	mul	0
# p.equals(Z.TWO) ? Z.valueOf(A000217(e+1), Z.ONE
# M.w. a(2^k) = A000217(k+1), a(p^k) = 1 for odd primes p. - _Antti Karttunen_, Nov 02 2018

A264740	mul	0
# p.equals(Z.TWO) ? Z.valueOf(e + 1, Z.valueOf(sigmp.pow(e+1)-1).divide(p-1)
# M.w. a(2^k) = k + 1, a(p^k) = sigma(p^k) = (p^(k+1)-1) / (p-1) for p > 2.

A060839	mul	0
# p.equals(Z.THREE) ? (e == Z.ONE ? Z.THREE) : ??? valueOf(e + 1
# M.w. a(3) = 1, a(3^e) = 3, e >= 2, a((3k+1)^e) = 3, a((3k+2)^e) = 1. _David W. Wilson_, May 22 2005

A117660	mult	0
# p.equals(Z.THREE) ? (e == 1 ? Z.TWO : Z.THREE.pow(e-1).add(3)) : p.pow(e-1).add(p.mod(Z.THREE).equals(Z.ONE) ? 3 : 1)
# M.w. a(3) = 2, a(3^e) = 3^(e-1) + 3 for e > 1, and for p != 3, if p == 1 (mod 3), a(p^e) = p^(e-1) + 3, and if p == 2 (mod 3), a(p^e) = p^(e-1) + 1. - _Amiram Eldar_, Sep 08 2020

A235489	mul	0
# a(3^(2k)) = 2^3k = 8^k, a(3^(2k+1)) = 3*2^3k, a(Z.ONE.shiftLeft(3k)) = 3^2k = 9^k, a(Z.ONE.shiftLeft(3k+1)) = 2*9^k, a(Z.ONE.shiftLeft(3k+2)) = 4*9^k, a(p_i) = p_{a(i)}
# M.w. a(3^(2k)) = 2^3k = 8^k, a(3^(2k+1)) = 3*2^3k, a(2^(3k)) = 3^2k = 9^k, a(2^(3k+1)) = 2*9^k, a(2^(3k+2)) = 4*9^k, a(p_i) = p_{a(i)} for primes with index i, and a(u*v) = a(u) * a(v) for composites other than 8 or 9.

A319445	mul	0
# a(3^e) = 2*3^(2*e-1), phi(p^e).square() = (p-1).square()*p.pow(2*e-2) if p == 1 (mod 3) : J_2(p^e) = A007434(p^e) = (p.square().subtract(1))*p.pow(2*e-2) if p == 2 (mod 3)
# M.w. a(3^e) = 2*3^(2*e-1), a(p^e) = phi(p^e)^2 = (p-1)^2*p^(2*e-2) if p == 1 (mod 3) and J_2(p^e) = A007434(p^e) = (p^2 - 1)*p^(2*e-2) if p == 2 (mod 3).

A319442	mul	0
# a(3^e) = 2*e + 1, Z.valueOf((e + 1).square() if p == 1 (mod 3) : e + 1 if p == 2 (mod 3)
# M.w. a(3^e) = 2*e + 1, a(p^e) = (e + 1)^2 if p == 1 (mod 3) and e + 1 if p == 2 (mod 3).

A087694	mul	0
# a(3^e) = 3^e, Z.valueOf(((p-1)*e+p)*p.pow(e-1) if p mod 3 = 1, p.pow(2*floor(e/2)) if p mod 3 = 2
# M.w. a(3^e) = 3^e, a(p^e) = ((p-1)*e+p)*p^(e-1) if p mod 3 = 1, a(p^e) = p^(2*floor(e/2)) if p mod 3 = 2. - _Vladeta Jovovic_, Sep 27 2003

A326401	mul	0
# a(3^e) = 3^e, p.pow(e+1) - 1).divide(p.subtract(1)) if p == 2 (mod 3), : (p.pow(e+1) + (((e & 1) == 0) ? 1 : -1)).divide(p + 1) if p == 1 (mod 3)
# M.w. a(3^e) = 3^e, a(p^e) = (p^(e+1) - 1)/(p - 1) if p == 2 (mod 3), and (p^(e+1) + (-1)^e)/(p + 1) if p == 1 (mod 3). - _Amiram Eldar_, Oct 25 2020

A319449	mul	0
# a(3^e) = sigma(3^(2e)) = (3^(2e+1) - 1)/2, Z.valueOf(sigma(p^e).square() = ((p.pow(e+1) - 1).divide(p.subtract(1))).square() if p == 1 (mod 3) : sigma_2(p^e) = A001157(p^e) = (p.pow(2e+2) - 1).divide(p.square().subtract(1)) if p == 2 (mod 3)
# M.w. a(3^e) = sigma(3^(2e)) = (3^(2e+1) - 1)/2, a(p^e) = sigma(p^e)^2 = ((p^(e+1) - 1)/(p - 1))^2 if p == 1 (mod 3) and sigma_2(p^e) = A001157(p^e) = (p^(2e+2) - 1)/(p^2 - 1) if p == 2 (mod 3).

A227128	mul	0
# a(3^e)=3^e, p.pow(e-1).multiply(p-1) if p== 1 (mod 3) : p.pow(e-1).multiply(p+1) if p = 2 (mod 3)
# M.w. a(3^e)=3^e, a(p^e) = p^(e-1)*(p.subtract(1) if p== 1 (mod 3) and a(p^e) = p^(e-1)*(p+1) if p = 2 (mod 3). - _R. J. Mathar_, Jul 10 2013

A235201	mul	0
# a(3^k) = Z.ONE.shiftLeft(2k), a(Z.ONE.shiftLeft(2k)) = 3^k, a(Z.ONE.shiftLeft(2k+1)) = 2*3^k, a(p_i) = p_{a(i)}
# M.w. a(3^k) = 2^(2k), a(2^(2k)) = 3^k, a(2^(2k+1)) = 2*3^k, a(p_i) = p_{a(i)} for primes with index i > 2, and for composites > 4, a(u * v) = a(u) * a(v) for u, v > 0.

A160499	mul	0
# a(4) = 1, a(8) = 2, a(16) = 4, p.equals(Z.TWO) ? Z.valueOf(0
# M.w. a(4) = 1, a(8) = 2, a(16) = 4, a(2^e) = 0 for e = 1 or e >= 5; for odd primes p, a(p) = 3 if p == 1 (mod 4) and 1 if p == 3 (mod 4), a(p^e) = 0 for e >= 2. - _Jianing Song_, Mar 02 2019

A307381	mul	0
# a(4) = 1, a(8) = 2, p.equals(Z.TWO) ? Z.valueOf(0
# M.w. a(4) = 1, a(8) = 2, a(2^e) = 0 for e = 1 or e >= 4; a(3) = 1, a(9) = 4, a(3^e) = 0 for e >= 3; a(p) = 5 if p == 1 (mod 6) and 1 if p == 5 (mod 6), a(p^e) = 0 if p > 3 and e >= 2.

A319099	mul	0
# a(5) = 1, a(5^e) = 5 if e >= 2;
# M.w. a(5) = 1, a(5^e) = 5 if e >= 2; for other primes p, a(p^e) = 5 if p == 1 (mod 5), a(p^e) = 1 otherwise.

A319101	mul	0
# a(7) = 1, a(7^e) = 7 if e >= 2;
# M.w. a(7) = 1, a(7^e) = 7 if e >= 2; for other primes p, a(p^e) = 7 if p == 1 (mod 7), a(p^e) = 1 otherwise.

A287926	mul	0
# a(7^e) = 8 : p.pow(e+1).subtract(1).divide(p.subtract(1)
# M.w. a(7^e) = 8 and a(p^e) = (p^(e+1)-1)/(p-1) otherwise. - _Amiram Eldar_, Sep 17 2020

A338224	mul	0
# a(A246655(k)) = prime(k)
# M.w. a(A246655(k)) = prime(k) for any k > 0 (where prime(k) denotes the k-th prime number).

A259445	mul	0
# a(n) = n if n is odd : a(2^s)=2
# M.w. a(n) = n if n is odd and a(2^s)=2.

A279510	mul	0
# a(p(i)^j) = p(i+1)^a(j)
# M.w. a(p(i)^j) = p(i+1)^a(j) for i-th prime p(i) and j>0.

A072028	mul	0
# a(p) = (if p mod 4 = 1 : p+2 is prime then p+2 else (if p mod 4 = 3 : p-2 is prime then p-2 else p)), p prime
# M.w. a(p) = (if p mod 4 = 1 and p+2 is prime then p+2 else (if p mod 4 = 3 and p-2 is prime then p-2 else p)), p prime.

A072029	mul	0
# a(p) = (if p mod 4 = 3 : p+2 is prime then p+2 else (if p mod 4 = 1 : p-2 is prime then p-2 else p)), p prime
# M.w. a(p) = (if p mod 4 = 3 and p+2 is prime then p+2 else (if p mod 4 = 1 and p-2 is prime then p-2 else p)), p prime.

A072963	mul	0
# a(p) = (if p+2 or p-2 is prime then p else 1), p prime
# M.w. a(p) = (if p+2 or p-2 is prime then p else 1), p prime.

A072027	mul	0
# a(p) = (if p<=3 then 5-p else (if p+2 is prime then p+2 else (if p-2 is prime then p-2 else p))), p prime
# M.w. a(p) = (if p<=3 then 5-p else (if p+2 is prime then p+2 else (if p-2 is prime then p-2 else p))), p prime.

A072026	mul	0
# a(p) = (if p<=3 then p else (if p+2 is prime then p+2 else (if p-2 is prime then p-2 else p))), p prime
# M.w. a(p) = (if p<=3 then p else (if p+2 is prime then p+2 else (if p-2 is prime then p-2 else p))), p prime.

A072436	mult	0
# p.mod(Z.FOUR).equals(Z.THREE) ? Z.ONE : p.pow(e)
# M.w. a(p) = (if p==3 (mod 4) then 1 else p).

A254981	mult	0
# e == 1 ? p.add(1) : p.pow(e-2).multiply(p.add(p.square()).add(1))
# M.w. a(p) = 1 + p; a(p^e) = p^(e-2) * (1 + p + p^2), for e>1.

A295295	mult	0
# e == 1 ? Z.ONE : p.add(1)
# M.w. a(p) = 1 and a(p^e) = (p+1) for e > 1.

A295294	mult	0
# e == 1 ? Z.ONE : p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(p) = 1 and a(p^e) = (p^(e+1)-1)/(p-1) for e > 1.

A308993	mul	0
# a(p) = 1 : p^a(e)
# M.w. a(p) = 1 and a(p^e) = p^a(e) for any e > 1 and prime number p.

A295879	mul	0
# a(p) = 1, prime(e-1) if e > 1
# M.w. a(p) = 1, a(p^e) = prime(e-1) if e > 1.

A071785	mul	0
# a(p) = A007953(p), p prime
# M.w. a(p) = A007953(p), p prime.

A122261	mul	0
# a(p) = A065333(p-1),
# M.w. a(p) = A065333(p-1), for p prime.

A345699	mul	0
# a(p) = a(p-1) : Z.valueOf(a(p) + a(e) if e>1
# M.w. a(p) = a(p-1) and a(p^e) = a(p) + a(e) if e>1.

A072010	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e) : (p.mod(Z.FOUR).equals(Z.ONE) ? p.add(2).pow(e) : p.subtract(2).pow(e))
# M.w. a(p) = p + 2*(2 - p mod 4), p prime.

A063659	mult	0
# e == 1 ? p : p.pow(e).subtract(p.pow(e-2))
# M.w. a(p) = p and a(p^e) = p^e-p^(e-2), e>1. - _Vladeta Jovovic_, Jul 26 2001

A092261	mult	0
# e == 1 ? p.add(1) : Z.ONE
# M.w. a(p) = p+1 and a(p^e) = 1 for e > 1. - _Vladeta Jovovic_, Feb 22 2004

A254503	mul	0
# a(p) = p; phi(p^e),
# M.w. a(p) = p; a(p^e) = phi(p^e), for e > 1.

A063445	mult	0
# e == 1 ? p.multiply(p.subtract(1)).subtract(1) : p.pow(2*e).subtract(p.pow(2*e-1)).subtract(p.pow(2*e-2)).add(p.pow(2*e-3))
# M.w. a(p) = p^2 - p - 1 and a(p^e) = p^(2*e) - p^(2*e-1) - p^(2*e-2) + p^(2*e-3), e > 1. - _Vladeta Jovovic_, Jul 29 2001

A309002	mul	0
# a(p) = p^2 : p^a(e)
# M.w. a(p) = p^2 and a(p^e) = p^a(e) for any e > 1 and prime number p.

A254520	mult	0
# e == 1 ? p.square() : p.pow(2*e).subtract(p.pow(2*e-2))
# M.w. a(p) = p^2; a(p^e) = p^(2e) - p^(2e-2), for e > 1.

A254521	mult	0
# e == 1 ? p.pow(3) : (e == 2 ? p.pow(6) : p.pow(3*e).subtract(p.pow(3*e-6)))
# M.w. a(p) = p^3; a(p^2) = p^6; a(p^e) = p^(3e) - p^(3e-6), for e > 2.

A072438	mult	0
# p.mod(Z.FOUR).equals(Z.ONE) ? Z.ONE : p.pow(e)
# M.w. a(p)=(if p==1 (mod 4) then 1 else p).

A189021	mult	0
# e == 1 ? Z.ONE : (e == 2 ? Z.NEG_ONE : Z.ZERO)
# M.w. a(p)=1, a(p^2)=-1 and a(p^e)=0 if e>=3. Dirichlet g.f. product_{primes p} (1+p^(-s)-p^(-2s)). - _R. J. Mathar_, Oct 31 2011

A295878	mul	0
# a(p.pow(2e)) = 1, a(p.pow(2e-1)) = prime(e)
# M.w. a(p^(2e)) = 1, a(p^(2e-1)) = prime(e).

A300828	mult	0
# e == 2 ? Z.ONE : (e == 3 ? Z.valueOf(-2) : Z.ZERO)
# M.w. a(p^2) = 1, a(p^3) = -2 and a(p^e) = 0 when e = 1 or e > 3.

A324706	mult	0
# e == 3 ? p.multiply(p.multiply(p.add(1)).add(1)).add(1) : (e == 6 ? p.square().multiply(p.square().multiply(p.square().add(1)).add(1)).add(1) : p.pow(e).add(1))
# M.w. a(p^3) = 1 + p + p^2 + p^3, a(p^6) = 1 + p^2 + p^4 + p^6, and a(p^e) = 1 + p^e otherwise.

A241405	mul	0
# a(p^a) = sum p^b such that b+1 divides a+1
# M.w. a(p^a) = sum p^b such that b+1 divides a+1.

A253206	mult	0
# e % 5 == 0 ? Z.ONE : (e % 5 == 1 ? Z.NEG_ONE : Z.ZERO)
# M.w. a(p^d) = 1 if d == 0 mod 5, -1 if d == 1 mod 5, 0 otherwise. - _Robert Israel_, Mar 27 2015

A097988	mult	0
# Z.valueOf(e+1).multiply(e+2).divide2().square()
# M.w. a(p^e) = ((e+1)*(e+2)/2)^2. - _Amiram Eldar_, Sep 20 2020

A069193	mult	0
# p.multiply(e+1).subtract(1).multiply(p.pow(e-1))
# M.w. a(p^e) = ((e+1)*p - 1) * p^(e-1). - _Amiram Eldar_, Sep 15 2019

A109624	mult	0
# p.subtract(1).multiply(p.add(3)).pow(e)
# M.w. a(p^e) = ((p-1)*(p+3))^e. If n = Product p(k)^e(k) then a(n) = Product ((p(k)-1)*(p(k)+3))^e(k). a(n) = A003958(n) * A166591(n).

A072861	mult	0
# p.pow(e+1).subtract(1).divide(p.subtract(1)).square()
# M.w. a(p^e) = ((p^(e+1)-1)/(p-1))^2. a(n) = Sum_{d|n} n/d*sigma(d^2). - _Vladeta Jovovic_, Jul 30 2002

A247343	mult	0
# Binomial.binomial(4, e).multiply(((e & 1) == 0) ? 1 : -1)
# M.w. a(p^e) = (-1)^e * binomial(4, e). - _Amiram Eldar_, Sep 11 2020

A158523	mult	0
# Z.valueOf(((e & 1) == 0) ? 1 : -1).multiply(p.add(1)).multiply(p.pow(e-1))
# M.w. a(p^e) = (-1)^e*(p+1)*p^(e-1), e>0. a(1)=1.

A329445	mult	0
# Z.valueOf(((e & 1) == 0) ? 1 : -1).multiply(Binomial.binomial(p, Z.valueOf(e)))
# M.w. a(p^e) = (-1)^e*binomial(p,e) for prime p and e >= 0.

A197774	mul	0
# Z.valueOf((-1)^sqrt(e) if e is a square, 0
# M.w. a(p^e) = (-1)^sqrt(e) if e is a square, 0 otherwise. - _Franklin T. Adams-Watters_, Oct 18 2011

A076792	mult	0
# Z.ONE.add(Z.valueOf(((e & 1) == 0) ? 1 : -1).multiply(p.pow(2*e+2))).divide(p.square().add(1))
# M.w. a(p^e) = (1+(-1)^e*p^(2*e+2))/(1+p^2).

A344683	mul	0
# negative pow ??? p.subtract(1).multiply(p.pow(e-3)).multiply(p.subtract(1).square().multiply(e*e).add(p.square().subtract(1).multiply(3*e)).add(p.add(1).multiply(p).add(1).multiply(2))).divide2()
# M.w. a(p^e) = (1/2)*(p-1)*p^(e-3)*(e^2*(p-1)^2 + 3*e*(p^2-1) + 2*(p^2 + p + 1)).

A324910	mult	0
# Z.ONE.shiftLeft(e).subtract(1)
# M.w. a(p^e) = (2^e)-1.

A347136	mul	0
# Z.valueOf((A151800(p)^(e+1) - p.pow(e+1)).divide(A151800(p)-p)
# M.w. a(p^e) = (A151800(p)^(e+1) - p^(e+1))/(A151800(p)-p). - _Amiram Eldar_, Aug 24 2021

A166707	mul	0
# Z.valueOf((a(p-1)+10)^e
# M.w. a(p^e) = (a(p-1)+10)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+10)^e(k).

A166699	mul	0
# Z.valueOf((a(p-1)+2)^e
# M.w. a(p^e) = (a(p-1)+2)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+2)^e(k).

A166700	mul	0
# Z.valueOf((a(p-1)+3)^e
# M.w. a(p^e) = (a(p-1)+3)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+3)^e(k).

A166701	mul	0
# Z.valueOf((a(p-1)+4)^e
# M.w. a(p^e) = (a(p-1)+4)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+4)^e(k).

A166702	mul	0
# Z.valueOf((a(p-1)+5)^e
# M.w. a(p^e) = (a(p-1)+5)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+5)^e(k).

A166703	mul	0
# Z.valueOf((a(p-1)+6)^e
# M.w. a(p^e) = (a(p-1)+6)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+6)^e(k).

A166704	mul	0
# Z.valueOf((a(p-1)+7)^e
# M.w. a(p^e) = (a(p-1)+7)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+7)^e(k).

A166705	mul	0
# Z.valueOf((a(p-1)+8)^e
# M.w. a(p^e) = (a(p-1)+8)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+8)^e(k).

A166706	mul	0
# Z.valueOf((a(p-1)+9)^e
# M.w. a(p^e) = (a(p-1)+9)^e. If n = Product p(k)^e(k) then a(n) = Product (a(p(k)-1)+9)^e(k).

A166698	mul	0
# Z.valueOf((a(p-1)-1)^e
# M.w. a(p^e) = (a(p-1)-1)^e.

A326815	mult	0
# Z.valueOf(e+1).multiply(2-e).divide2()
# M.w. a(p^e) = (e+1)*(2-e)/2 = A080956(e). - _Amiram Eldar_, Oct 26 2020

A062368	mult	0
# Z.valueOf(e+1).multiply(e+2).multiply(4*e+3).divide(6)
# M.w. a(p^e) = (e+1)*(e+2)*(4*e+3)/6.

A306379	mul	0
# ??? division/pow problem Z.valueOf(e-1).multiply(p.add(1).square()).multiply(p.pow(e-2)).add(p.add(1).multiply(p.pow(e-1)).multiply2())
# M.w. a(p^e) = (e-1)*(p+1)^2*p^(e-2) + 2*(p+1)*p^(e-1).

A305186	mult	0
# p.subtract(1).multiply(p.square().subtract(1)).multiply(p.pow(3).subtract(1)).multiply(p.pow(4).subtract(1)).multiply(p.pow(16*e-10))
# M.w. a(p^e) = (p - 1)*(p^2 - 1)*(p^3 - 1)*(p^4 - 1)*p^(16*e-10).

A306411	mult	0
# p.subtract(1).multiply(p.pow(6*e-1))
# M.w. a(p^e) = (p - 1)*p^(6*e-1).

A306412	mult	0
# p.subtract(1).multiply(p.pow(8*e-1))
# M.w. a(p^e) = (p - 1)*p^(8*e-1).

A090780	mult	0
# p.subtract(1).multiply(p.pow(e)).divide2()
# M.w. a(p^e) = (p - 1)*p^e/2 = A000217(p-1)*p^(e-1).

A069088	mult	0
# ((e & 1) == 1) ? p.add(1).multiply(e+1).divide2() : p.add(1).multiply(e/2).add(1)
# M.w. a(p^e) = (p+1)*(e+1)/2 if e odd, and (p+1)*e/2 + 1 if e even. - _Amiram Eldar_, Sep 03 2020

A319132	mult	0
# p.add(1).multiply(e).add(1)
# M.w. a(p^e) = (p+1)*e+1. - _Amiram Eldar_, Oct 25 2020

A166590	mult	0
# p.add(2).pow(e)
# M.w. a(p^e) = (p+2)^e.

A166591	mult	0
# p.add(3).pow(e)
# M.w. a(p^e) = (p+3)^e.

A166589	mult	0
# p.add(-3).pow(e)
# M.w. a(p^e) = (p-3))^e. If n = Product p(k)^e(k) then a(n) = Product (p(k)-3)^e(k). a(3k) = 0 for k >= 1. Abs (a(2^k)) = 1 for k >= 1.

A077455	mult	0
# p.pow(12*e+3).add(p.pow(8*e+2)).add(p.pow(4*e+1)).add(1).divide(p.pow(3).add(p.square()).add(p).add(1))
# M.w. a(p^e) = (p^(12*e+3) + p^(8*e+2) + p^(4*e+1) + 1)/(p^3 + p^2 + p + 1). - _Amiram Eldar_, Sep 09 2020

A062952	mult	0
# p.pow(2*e+2).subtract(p.pow(e+1)).subtract(p.pow(e)).add(p).divide(p.square().subtract(1))
# M.w. a(p^e) = (p^(2*e+2)-p^(e+1)-p^e+p)/(p^2-1).

A077456	mul	0
# p.pow(20*e+4) + p.pow(15*e+3) + p.pow(10*e+2) + p.pow(5*e+1) + 1).divide(p^4 + p^3 + p^2 + p + 1)
# M.w. a(p^e) = (p^(20*e+4) + p^(15*e+3) + p^(10*e+2) + p^(5*e+1) + 1)/(p^4 + p^3 + p^2 + p + 1). - _Amiram Eldar_, Sep 09 2020

A113061	mult	0
# p.pow(3*(1+e/3)).subtract(1).divide(p.pow(3).subtract(1))
# M.w. a(p^e) = (p^(3*(1+floor(e/3)))-1)/(p^3-1). The Dirichlet generating function is zeta(s)*zeta(3s-3). The sequence is the inverse Mobius transform of n*A010057(n). - _R. J. Mathar_, Feb 18 2011

A175926	mult	0
# p.pow(3*e+1).subtract(1).divide(p.subtract(1))
# M.w. a(p^e) = (p^(3e+1)-1)/(p-1). - _R. J. Mathar_, Mar 31 2011

A300909	mult	0
# p.pow(4*(1+e/4)).subtract(1).divide(p.pow(4).subtract(1))
# M.w. a(p^e) = (p^(4*(1+floor(e/4)))-1)/(p^4-1). - _Robert Israel_, Mar 15 2018

A084218	mult	0
# p.pow(4*e + 2).add(1).divide(p.square().add(1))
# M.w. a(p^e) = (p^(4*e + 2) + 1)/(p^2 + 1). - _Amiram Eldar_, Sep 13 2020

A202994	mult	0
# p.pow(4*e+1).subtract(1).divide(p.subtract(1))
# M.w. a(p^e) = (p^(4*e+1)-1)/(p-1) for prime p. - _Andrew Howroyd_, Jul 23 2018

A065827	mult	0
# p.pow(4*e+2).subtract(1).divide(p.square().subtract(1))
# M.w. a(p^e) = (p^(4*e+2)-1)/(p^2-1).

A203556	mult	0
# p.pow(5*e+1).subtract(1).divide(p.subtract(1))
# M.w. a(p^e) = (p^(5*e+1).subtract(1)/(p-1) for prime p. - _Andrew Howroyd_, Jul 23 2018

A084220	mult	0
# p.pow(6*e + 3).add(1).divide(p.pow(3).add(1))
# M.w. a(p^e) = (p^(6*e + 3) + 1)/(p^3 + 1). - _Amiram Eldar_, Sep 13 2020

A077454	mult	0
# p.pow(6*e+2).add(p.pow(3*e+1)).add(1).divide(p.add(1).multiply(p).add(1))
# M.w. a(p^e) = (p^(6*e+2) + p^(3*e+1) + 1)/(p^2 + p + 1). - _Amiram Eldar_, Sep 09 2020

A077457	mult	0
# p.pow(8*e+2).add(1).divide(p.square().add(1))
# M.w. a(p^e) = (p^(8*e+2) + 1)/(p^2 + 1). - _Amiram Eldar_, Sep 09 2020

A328181	mult	0
# p.pow(e+1).subtract(Z.valueOf(((e & 1) == 0) ? 1 : -1).multiply(p.multiply(2).add(1))).divide(p.add(1))
# M.w. a(p^e) = (p^(e+1) - (-1)^e*(2*p+1))/(p+1). - _Amiram Eldar_, Dec 02 2020

A324891	mult	0
# p.mod(Z.FOUR).equals(Z.ONE) ? p.pow(e+1).subtract(1).divide(p.subtract(1)) : Z.ONE
# M.w. a(p^e) = (p^(e+1) - 1)/(p-1) if p == 1 (mod 4), otherwise a(p^e) = 1.

A324893	mult	0
# p.mod(Z.FOUR).equals(Z.THREE) ? p.pow(e+1).subtract(1).divide(p.subtract(1)) : Z.ONE
# M.w. a(p^e) = (p^(e+1) - 1)/(p-1) if p == 3 (mod 4), otherwise a(p^e) = 1.

A069546	mult	0
# p.pow(e+1).multiply(p.pow(e+1).subtract(1)).subtract(p.subtract(1).multiply(e+1)).divide(p.subtract(1).square())
# M.w. a(p^e) = (p^(e+1)*(p^(e+1)-1)-(p-1)*(e+1))/(p-1)^2.

A188999	mult	0
# ((e & 1) == 1) ? p.pow(e+1).subtract(1).divide(p.subtract(1)) : p.pow(e+1).subtract(1).divide(p.subtract(1)).subtract(p.pow(e/2))
# M.w. a(p^e) = (p^(e+1)-1).divide(p-1) if e is odd, a(p^e) = (p^(e+1)-1)/(p-1) -p^(e/2) if e is even.

A069208	mult	0
# p.pow(e+1).subtract(p.pow(e)).add(p.pow(e-1).subtract(1)).divide(p.subtract(1))
# M.w. a(p^e) = (p^(e+1)-p^e+p^(e-1)-1)/(p-1).

A076752	mult	0
# p.pow(e+2).subtract(1).divide(p.square().subtract(1))
# M.w. a(p^e) = (p^(e+2)-1)/(p^2-1) for even e and a(p^e) = p*(p^(e+1)-1).divide(p^2-1) for odd e.

A068984	mul	0
# p.pow(e+3)-3*p.pow(e+2)+4*p.pow(e+1)-p-1+2*p.pow(e+3)*e-6*p.pow(e+2)*e+4*p.pow(e+1)*e+p.pow(e+3)*e^2-2*p.pow(e+2)*e^2+p.pow(e+1)*e^2)/(p.subtract(1))^3
# M.w. a(p^e) = (p^(e+3)-3*p^(e+2)+4*p^(e+1)-p-1+2*p^(e+3)*e-6*p^(e+2)*e+4*p^(e+1)*e+p^(e+3)*e^2-2*p^(e+2)*e^2+p^(e+1)*e^2).divide(p-1)^3.

A321140	mult	0
# p.pow(3).multiply(p.pow(3*e+3).subtract(e+2)).add(e + 1).divide(p.pow(3).subtract(1).square())
# M.w. a(p^e) = (p^3*(p^(3e+3) - e - 2) + e + 1).divide(p^3 - 1)^2.

A342661	mul	0
# p.pow(e) * (q^(e+1).subtract(1).divide(q-1), where q = 1
# M.w. a(p^e) = (p^e) * (q^(e+1)-1).divide(q-1), where q = 1 for p = 2, and for odd primes p, q = A151799(p), i.e., the previous prime.

A190125	mult	0
# p.pow(e).pow(p.pow(e))
# M.w. a(p^e) = (p^e)^(p^e) = p^(e*p^e).

A210826	mult	0
# Z.NEG_ONE.add((e+2) % 3)
# M.w. a(p^e) = -1 + ((e+2) mod 3). Thus the Dirichlet g.f. is indeed zeta(3s)/zeta(s). Also sumdiv(n,d,a(d))=1 iff n is a cube, else sumdiv(n,d,a(d))=0 hence Sum_{k=1..n} a(k)*floor(n/k) = floor(n^(1/3)). - _Benoit Cloitre_, Oct 28 2012

A326814	mult	0
# e == 1 ? Z.valueOf(-3) : (e == 2 ? Z.TWO : Z.ZERO)
# M.w. a(p^e) = -3 if e = 1, 2 if e = 2, and 0 otherwise. - _Amiram Eldar_, Oct 26 2020

A197881	mult	0
# e == 1 ? Z.ZERO : (e == 2 ? Z.TWO : Z.ONE)
# M.w. a(p^e) = 0 if e = 1, 2 if e = 2, and 1 otherwise.

A091069	mult	0
# p.equals(Z.TWO) || e > 1 ? Z.ZERO : (p.mod(Z.EIGHT).equals(Z.THREE) || p.mod(Z.EIGHT).equals(Z.FIVE) ? Z.NEG_ONE : Z.ONE)
# M.w. a(p^e) = 0 if p = 2 or e > 1, a(p) = 1 if p == +-1 (mod 8) and -1 if p == +-3 (mod 8).

A318608	mult	0
# p.equals(Z.TWO) || e > 1 ? Z.ZERO : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.ONE : Z.NEG_ONE)
# M.w. a(p^e) = 0 if p = 2 or e > 1, a(p) = 1 if p == 1 (mod 4) and -1 if p == 3 (mod 4).

A319448	mult	0
# p.equals(Z.THREE) || e > 1 ? Z.ZERO : (p.mod(Z.THREE).equals(Z.ONE) ? Z.ONE : Z.NEG_ONE)
# M.w. a(p^e) = 0 if p = 3 or e > 1, a(p) = 1 if p == 1 (mod 3) and -1 if p == 2 (mod 3).

A062370	mul	0
# Z.ONE + Sum_{k=1
# M.w. a(p^e) = 1 + Sum_{k=1..e} (2k+1)sigma(p^k). - _Mitch Harris_, May 24 2005

A117658	mult	0
#--------> p.pow(e-1).add(1)
# M.w. a(p^e) = 1 + p^(e-1) for primes p. - _Robert Israel_, Jul 06 2016

A068963	mult	0
# Z.ONE.add(p.pow(2).multiply(p.subtract(1)).multiply(p.pow(3*e).subtract(1)).divide(p.pow(3).subtract(1)))
# M.w. a(p^e) = 1 + p^2 * (p-1)*(p^(3e)-1).divide(p^3-1).

A068970	mult	0
# Z.ONE.add(p.pow(3).multiply(p.subtract(1)).multiply(p.pow(4*e).subtract(1)).divide(p.pow(4).subtract(1)))
# M.w. a(p^e) = 1 + p^3 + (p-1)*(p^(4e)-1).divide(p^4-1).

A062380	mul	0
# Z.ONE + sum_{k=1
# M.w. a(p^e) = 1 + sum_{k=1..e} (2k+1)(p^k-p^{k-1}) = ((2e+1)p^(e+1) - (2e+3)p^e+2)/(p-1). - _Mitch Harris_, May 24 2005

A323308	mult	0
#--------> e == 1 ? Z.ONE : Z.TWO
# M.w. a(p^e) = 1 for e = 1 and 2 otherwise.

A227291	mult	0
#--------> e == 2 ? Z.ONE : Z.ZERO
# M.w. a(p^e) = 1 if e=2, a(p^e) = 0 if e=1 or e>2. - _Antti Karttunen_, Jul 28 2017

A242603	mult	0
#--------> p.equals(Z.SEVEN) ? Z.ONE : p.pow(e)
# M.w. a(p^e) = 1 if p = 7, else p^e.

A070919	mult	0
#--------> Z.valueOf(1+3*e+3*e*e)
# M.w. a(p^e) = 1+3*e+3*e^2 for prime p and e >= 0. - _Werner Schulte_, Nov 30 2018

A069915	mul	0
# Z.ONE+Sum_{k=1
# M.w. a(p^e) = 1+Sum_{k=1..e, gcd(k, e)=1} p^k.

A328729	mult	0
# e < 3 ? Z.valueOf(2-e).subtract(p) : Z.ZERO
# M.w. a(p^e) = 2 - p - e if e < 3, and 0 otherwise. - _Amiram Eldar_, Dec 02 2020

A277847	mul	0
# Z.valueOf(2 if p = 2; oddpart(p-1)*p.pow(e-1) + 1 if p > 2
# M.w. a(p^e) = 2 if p = 2; oddpart(p-1)*p^(e-1) + 1 if p > 2.

A160498	mult	0
# p.equals(Z.THREE) && e == 2 || p.mod(Z.THREE).equals(Z.ONE) && e == 1 ? Z.TWO : Z.ZERO
# M.w. a(p^e) = 2 if p^e = 9 or p == 1 (mod 3) and e = 1, otherwise 0. - _Jianing Song_, Mar 02 2019

A100635	mult	0
# Z.TWO.multiply(e*e + 2*e + 1).subtract(1)
# M.w. a(p^e) = 2*((e+1)^2) - 1.

A074722	mult	0
# Z.TWO.multiply((((e + 1) & 1) == 0) ? 1 : -1).multiply(p.negate().pow(e+1).subtract(1)).divide(p.add(1)).subtract(p.pow(e))
# M.w. a(p^e) = 2*(-1)^(e+1)*((-p)^(e+1)-1)/(p+1)-p^e.

A298473	mult	0
# p.negate().pow(e).multiply2()
# M.w. a(p^e) = 2*(-p)^e (p prime, e>0).

A256452	mult	0
# p.mod(Z.FOUR).equals(Z.ONE) ? Z.valueOf(2*e + 1) : Z.ONE
# M.w. a(p^e) = 2*e + 1 if p == 1 (mod 4), otherwise a(p^e) = 1.

A307000	mult	0
# p.equals(Z.TWO) ? (e == 1 ? Z.THREE : Z.valueOf(4*e - 2)) : Z.valueOf(2*e + 1)
# M.w. a(p^e) = 2*e + 1, a(2) = 3 and a(2^e) = 4*e - 2 for e >= 2.

A335852	mult	0
# p.equals(Z.TWO) ? Z.valueOf(2*e) : (p.mod(Z.FOUR).equals(Z.THREE) ? Z.valueOf(e) : Z.valueOf(e*e))
# M.w. a(p^e) = 2*e if p = 2, e if p == 3 (mod 4) and e^2 if p == 1 (mod 4).

A176345	mult	0
# p.pow(e).multiply2().subtract(p.pow(e-1))
# M.w. a(p^e) = 2*p^e-p^(e-1).

A318472	mul	0
# Z.valueOf(2^A000045(e)
# M.w. a(p^e) = 2^A000045(e).

A318474	mul	0
# Z.valueOf(2^A000045(e+1)
# M.w. a(p^e) = 2^A000045(e+1).

A318476	mul	0
# Z.valueOf(2^A000108(e)
# M.w. a(p^e) = 2^A000108(e).

A318307	mul	0
# Z.valueOf(2^A002487(e)
# M.w. a(p^e) = 2^A002487(e).

A318316	mul	0
# Z.valueOf(2^A007306(e)
# M.w. a(p^e) = 2^A007306(e).

A318465	mul	0
# Z.valueOf(2^A007895(e), where A007895(n) gives the number of terms in the Zeckendorf representation of n
# M.w. a(p^e) = 2^A007895(e), where A007895(n) gives the number of terms in the Zeckendorf representation of n.

A331109	mul	0
# Z.valueOf(2^A112310(e)
# M.w. a(p^e) = 2^A112310(e).

A278908	mul	0
# Z.valueOf(2^omega(e), where omega = A001221
# M.w. a(p^e) = 2^omega(e), where omega = A001221.

A092089	mult	0
# p.equals(Z.TWO) ? (e == 1 ? Z.TWO : Z.valueOf(4*(e-1))) : Z.valueOf(2*e + 1)
# M.w. a(p^e) = 2e+1 if p is odd; a(2) = 2, a(2^e)= 4*(e-1), if e > 1. - _Michel Marcus_, Jun 26 2014

A286779	mult	0
# Z.valueOf(2*e*e + 2)
# M.w. a(p^e) = 2e^2 + 2.

A087688	mult	0
# p.equals(Z.TWO) ? (e == 1 ? Z.TWO : (e == 2 ? Z.THREE : Z.FIVE)) : Z.THREE
# M.w. a(p^e) = 3 for p an odd prime, a(2^1) = 2, a(2^2) = 3, a(2^e) = 5 for e >= 3. - _Eric M. Schmidt_, Apr 08 2013

A224516	mult	0
# p.equals(Z.THREE) ? (e == 1 ? Z.TWO : Z.FOUR) : (p.mod(Z.THREE).equals(Z.ONE) ? Z.FOUR : Z.TWO)
# M.w. a(p^e) = 4 for p == 1 (mod 3); a(p^e) = 2 for p == 2 (mod 3); a(3^1) = 2; a(3^e) = 4 for e > 1.

A335385	mult	0
# e == 3 || e == 6 ? Z.FOUR : Z.TWO
# M.w. a(p^e) = 4 if e = 3 or 6, and a(p^e) = 2 otherwise.

A332476	mult	0
# p.mod(Z.FOUR).equals(Z.ONE) ? Z.FOUR : Z.TWO
# M.w. a(p^e) = 4 if p == 1 (mod 4) and 2 otherwise.

A307380	mult	0
# p.equals(Z.FIVE) && e == 2 || p.mod(Z.FIVE).equals(Z.ONE) && e == 1 ? Z.FOUR : Z.ZERO
# M.w. a(p^e) = 4 if p^e = 25 or p == 1 (mod 5) and e = 1, otherwise 0.

A307382	mult	0
# p.equals(Z.SEVEN) && e == 2 || p.mod(Z.SEVEN).equals(Z.ONE) && e == 1 ? Z.SIX : Z.ZERO
# M.w. a(p^e) = 6 if p^e = 49 or p == 1 (mod 7) and e = 1, otherwise 0.

A061389	mul	0
# Z.valueOf(A000010(e)+1
# M.w. a(p^e) = A000010(e)+1.

A295316	mul	0
# Z.valueOf(A000035(e)
# M.w. a(p^e) = A000035(e).

A188581	mul	0
# Z.valueOf(A000070(e)
# M.w. a(p^e) = A000070(e). - _Amiram Eldar_, Sep 09 2020

A339904	mul	0
# Z.valueOf(A000265(q-1) * q^(e-1), where q = A151800(p), the next prime larger than p
# M.w. a(p^e) = A000265(q-1) * q^(e-1), where q = A151800(p), the next prime larger than p.

A095691	mul	0
# Z.valueOf(A000720(e)+1
# M.w. a(p^e) = A000720(e)+1.

A095683	mul	0
# Z.valueOf(A000720(e)
# M.w. a(p^e) = A000720(e). - _Vladeta Jovovic_, Jul 06 2004

A322885	mul	0
# Z.valueOf(A001399(e)
# M.w. a(p^e) = A001399(e).

A324106	mul	0
# Z.valueOf(A005940(p^e)
# M.w. a(p^e) = A005940(p^e).

A318469	mul	0
# Z.valueOf(A019565(A003714(e))
# M.w. a(p^e) = A019565(A003714(e)).

A293443	mul	0
# Z.valueOf(A019565(A193231(e))
# M.w. a(p^e) = A019565(A193231(e)).

A294931	mul	0
# Z.valueOf(A019565(A289813(e))
# M.w. a(p^e) = A019565(A289813(e)).

A294932	mul	0
# Z.valueOf(A019565(A289814(e))
# M.w. a(p^e) = A019565(A289814(e)).

A293442	mul	0
# Z.valueOf(A019565(e)
# M.w. a(p^e) = A019565(e).

A332712	mul	0
# Z.valueOf(A028242(e)
# M.w. a(p^e) = A028242(e). - _Amiram Eldar_, Nov 30 2020

A307848	mul	0
# Z.valueOf(A037445(e)
# M.w. a(p^e) = A037445(e).

A324911	mul	0
# Z.valueOf(A156552(p^e)
# M.w. a(p^e) = A156552(p^e).

A318470	mul	0
# Z.valueOf(A260443(e)
# M.w. a(p^e) = A260443(e).

A324283	mul	0
# Z.valueOf(A276086(p^e)
# M.w. a(p^e) = A276086(p^e).

A324108	mul	0
# Z.valueOf(A324054((p^e)-1)
# M.w. a(p^e) = A324054((p^e)-1).

A336468	mul	0
# Z.valueOf(A336466(p-1) * A336466(p)^(e-1)
# M.w. a(p^e) = A336466(p-1) * A336466(p)^(e-1).

A113176	mult	0
# Fibonacci.fibonacci(p.intValue())
# M.w. a(p^e) = F(p). - _Franklin T. Adams-Watters_, Jun 05 2006

A113195	mult	0
# Fibonacci.fibonacci(p.pow(e).intValue())
# M.w. a(p^e) = F(p^e). - _Franklin T. Adams-Watters_, Jun 05 2006

A331107	mul	0
# Z.valueOf(Product_{i} (p^s(i) + 1), where s(i) are the terms in the Zeckendorf representation of e (A014417)
# M.w. a(p^e) = Product_{i} (p^s(i) + 1), where s(i) are the terms in the Zeckendorf representation of e (A014417).

A331110	mul	0
# Z.valueOf(Product_{i} (p^s(i) + 1), where s(i) are the terms in the dual Zeckendorf representation of e (A104326)
# M.w. a(p^e) = Product_{i} (p^s(i) + 1), where s(i) are the terms in the dual Zeckendorf representation of e (A104326).

A069934	mul	0
# Z.valueOf(Product_{k=2
# M.w. a(p^e) = Product_{k=2..e+1} Phi_k(p), where Phi_k(x) is k-th cyclotomic polynomial.

A322857	mul	0
# Z.valueOf(Sum_{d|e, gcd(d, e/d)==1} p^d
# M.w. a(p^e) = Sum_{d|e, gcd(d, e/d)==1} p^d.

A293303	mul	0
# Z.valueOf(Sum_{d|e} A008683(e/d)*p^d
# M.w. a(p^e) = Sum_{d|e} A008683(e/d)*p^d.

A328271	mul	0
# Z.valueOf(Sum_{i=0
# M.w. a(p^e) = Sum_{i=0..floor(e/2)} p^(2*e-4*i) for prime p, i.e., a(p^(2*e)) = (p^(4*e+4).subtract(1).divide(p^4-1) and a(p^(2*e+1)) = p^2 * (p^(4*e+4).subtract(1).divide(p^4-1) for prime p. - _Werner Schulte_, Jul 24 2021

A308056	mul	0
# Z.valueOf(Sum_{i=1
# M.w. a(p^e) = Sum_{i=1..e, gcd(i,e)=1} p^i.

A203908	mult	0
# p.subtract(e).abs()
# M.w. a(p^e) = abs(p-e).

A286324	mult	0
# Z.valueOf(e + (e % 2))
# M.w. a(p^e) = e + (e mod 2). - _Andrew Howroyd_, Aug 05 2018

A338690	mult	0
# p.mod(Z.FOUR).equals(Z.ONE) ? Z.valueOf(e + 1) : Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1))/2)
# M.w. a(p^e) = e + 1 if p == 1 (mod 4), a(p^e) = (1 + (-1)^e)/2 if p = 2 or p == 3 (mod 4).

A343068	mul	0
# Z.valueOf(e*a(p-1)
# M.w. a(p^e) = e*a(p-1).

A124315	mult	0
# Z.valueOf(e+1+(e*e/4))
# M.w. a(p^e) = e+1+floor(e^2/4). - _R. J. Mathar_, Apr 14 2011

A090740	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e+2) : Z.ONE
# M.w. a(p^e) = e+2 if p = 2; 1 if p > 2. G.f.: A(x) = 1/(1-x^2) + Sum_{k>=0} x^(2^k)/(1-x^(2^k)). - _Vladeta Jovovic_, Jan 19 2004

A092520	mult	0
# Z.valueOf((3*e+2)/2)
# M.w. a(p^e) = floor((3*e+2)/2) = A001651(e+1), p prime and e >= 0.

A325837	mult	0
# Z.valueOf((e+1)/2)
# M.w. a(p^e) = floor((e+1)/2).

A322483	mult	0
# Z.valueOf((e+3)/2)
# M.w. a(p^e) = floor((e+3)/2).

A061704	mult	0
# Z.valueOf(e/3).add(1)
# M.w. a(p^e) = floor(e/3) + 1. - _Mitch Harris_, Apr 19 2005

A326043	mul	0
# Z.valueOf(floor[((e-1)+sigma(p^e)) / e]
# M.w. a(p^e) = floor[((e-1)+sigma(p^e)) / e].

A190867	mult	0
# Z.valueOf(1 >= e-1 ? 1 : e-1)
# M.w. a(p^e) = max(1,e-1).

A252505	mult	0
# Z.valueOf(3 <= e ? 3 : e).add(1)
# M.w. a(p^e) = min(e, 3) + 1. - _Amiram Eldar_, Sep 19 2020

A161946	mul	0
# Z.valueOf(oddpart(p^e+1), where oddpart(n) = A000265(n) is the largest odd divisor of n
# M.w. a(p^e) = oddpart(p^e+1), where oddpart(n) = A000265(n) is the largest odd divisor of n.

A058035	mult	0
# p.pow(e < 3 ? e : 3)
# M.w. a(p^e) = p ^ min(e,3), p prime, e > 0. [_Reinhard Zumkeller_, Jan 06 2012]

A323309	mult	0
# e == 1 ? p : p.pow(e).add(p)
# M.w. a(p^e) = p for e = 1 and p^e + p otherwise.

A327936	mult	0
# Z.valueOf(e).compareTo(p) >= 0 ? p : Z.ONE
# M.w. a(p^e) = p if e >= p, otherwise 1.

A329376	mult	0
# e == 2 ? p : Z.ONE
# M.w. a(p^e) = p when e == 2, otherwise a(p^e) = 1.

A170819	mul	0
# p*A011765(p+1), e > 0
# M.w. a(p^e) = p*A011765(p+1), e > 0. - R. J. Mathar, Jun 07 2011

A302138	mult	0
# p.equals(Z.TWO) ? (((e & 1) == 0) ? Z.TWO : Z.EIGHT) : p
# M.w. a(p^e) = p, p > 2; a(2^e) = 2 for even e and 8 for odd e.

A130107	mult	0
# e == 1 ? p.subtract(1) :(e == 2 ? p.add(1).multiply(p).add(1) : p.pow(e-3).multiply(p.add(1)).multiply(p.subtract(1).square()))
# M.w. a(p^e) = p-1 if e=1,  a(p^e) = p^2-p-1 if e=2, a(p^e) = p^(e-3)*(p+1)*(p-1)^2. - _Enrique Pérez Herrero_, Apr 03 2014

A270419	mul	0
# p.pow(-A065620(e))
# M.w. a(p^e) = p^(-A065620(e)) for evil e, a(p^e)=1 for odious e, or equally, a(p^e) = p^(A010059(e) * -A065620(e)).

A066990	mult	0
# p.pow(2 - e % 2)
# M.w. a(p^e) = p^(2 - e mod 2), p prime, e>0.

A191414	mult	0
# p.pow(2*e).subtract(1)
# M.w. a(p^e) = p^(2*e)-1, e>0.

A087786	mul	0
# p.pow(2*(2*e/3)) + Sum_{i=0
# M.w. a(p^e) = p^(2*floor(2*e/3)) + Sum_{i=0..floor((e-1)/3)} k*(p-1)*p^(e+i-1) where k = 3 if (p = 3 and 3*i+1 = e) or (p mod 3 = 1) otherwise k = 1. - _Andrew Howroyd_, Jul 17 2018

A328621	mult	0
# p.pow(Z.valueOf(2*e).mod(p))
# M.w. a(p^e) = p^(2e mod p).

A105634	mult	0
# p.equals(Z.SEVEN) ? p.pow(2*e) : (p.mod(Z.SEVEN).bitCount() == 1 ? p.pow(2*e+2).subtract(1).divide(p.square().subtract(1)) : p.pow(2*e+2).add(((e & 1) == 0) ? 1 : -1).divide(p.square().add(1)))
# M.w. a(p^e) = p^(2e) if p = 7; (p^(2e+2)-1).divide(p^2-1) if p == 1, 2, 4 (mod 7); (p^(2e+2)+(-1)^e)/(p^2+1) if p == 3, 5, 6 (mod 7).

A059479	mult	0
# p.pow(3*e - (e % 2))
# M.w. a(p^e) = p^(3e - (e % 2)). - _Mitch Harris_, Jun 09 2005

A115226	mult	0
# p.pow(6*e - 4).multiply(p.pow(3).subtract(1)).multiply(p.subtract(1))
# M.w. a(p^e) = p^(6*e - 4)*(p^3 - 1)*(p - 1). - _Amiram Eldar_, Sep 10 2020

A087122	mult	0
# p.pow(e + e/2 - 1).multiply(p.subtract(1).multiply(new Q(e, 2).ceiling()).add(p))
# M.w. a(p^e) = p^(e + floor(e/2) - 1)*((p-1)*ceiling(e/2) + p). - _Andrew Howroyd_, Jul 15 2018

A327938	mult	0
# p.pow(e % p.intValue())
# M.w. a(p^e) = p^(e mod p).

A327939	mult	0
# p.pow(e-(e % p.intValue()))
# M.w. a(p^e) = p^(e-(e mod p)).

A319516	mult	0
# p.compareTo(Z.FIVE) <= 0 ? p.pow(e-1) : p.subtract(4).multiply(p.pow(e-1))
# M.w. a(p^e) = p^(e-1) if p <= 5; (p-4)*p^(e-1) if p > 5.

A321029	mult	0
# p.compareTo(Z.FIVE) <= 0 ? p.pow(e-1) : p.subtract(5).multiply(p.pow(e-1))
# M.w. a(p^e) = p^(e-1) if p <= 5; (p-5)*p^(e-1) if p >= 7.

A321030	mult	0
# p.compareTo(Z.SEVEN) <= 0 ? p.pow(e-1) : p.subtract(6).multiply(p.pow(e-1))
# M.w. a(p^e) = p^(e-1) if p <= 7; (p-6)*p^(e-1) if p > 7.

A319534	mult	0
# p.compareTo(Z.FIVE) < 0 ? p.pow(e-1) : p.subtract(3).multiply(p.pow(e-1))
# M.w. a(p^e) = p^(e-1) if p = 2,3; (p-3)*p^(e-1) if p > 3.

A241663	mult	0
# p.compareTo(Z.FIVE) < 0 ? Z.ZERO : p.pow(e-1).multiply(p.subtract(4))
# M.w. a(p^e) = p^(e-1)*(p-4) for p > 3. a(2^e) = a(3^e) = 0 for e > 0.

A062354	mult	0
# p.pow(e-1).multiply(p.pow(e+1).subtract(1))
# M.w. a(p^e) = p^(e-1)*(p^(e+1)-1). - _Vladeta Jovovic_, Apr 17 2002

A306198	mult	0
# p.pow(e-1).multiply(p.add(1).multiply(p).add(1))
# M.w. a(p^e) = p^(e-1)*(p^2 - p - 1).

A204617	mul	0
# p.pow(e-1)*H(p)
# M.w. a(p^e) = p^(e-1)*H(p). H(2)=1, H(p) = p-1 if p=1 (mod 4) and H(p) = p+1 if p=3 (mod 4).

A331738	mul	0
# p.pow(e-A000265(e)), where A000265(x) gives the odd part of x
# M.w. a(p^e) = p^(e-A000265(e)), where A000265(x) gives the odd part of x.

A327937	mult	0
# Z.valueOf(e).compareTo(p) >= 0 ? p.pow(p.subtract(1)) : p.pow(e)
# M.w. a(p^e) = p^(p-1) if e >= p, otherwise a(p^e) = p^e.

A133482	mult	0
# p.pow(p.multiply(e))
# M.w. a(p^e) = p^(pe). If n = Product p(k)^e(k) then a(n) = Product p(k)^(p(k)*e(k)). - _Jaroslav Krizek_, Oct 17 2009

A321322	mult	0
# e == 1 ? p.square().subtract(2) : (p.square().subtract(1)).square().multiply(p.pow(2*e - 4))
# M.w. a(p^e) = p^2 - 2 if e = 1 and (p^2 - 1)^2 * p^(2*e - 4) otherwise. - _Amiram Eldar_, Oct 26 2020

A078615	mult	0
# p.square()
# M.w. a(p^e) = p^2. - _Mitch Harris_, May 17 2005

A331737	mult	0
# p.pow(e >> LongUtils.valuation(e, 2))
# M.w. a(p^e) = p^A000265(e), where A000265(x) gives the odd part of x.

A270437	mult	0
# p.pow(e ^ (2*e))
# M.w. a(p^e) = p^A048724(e), where A048724(e) = (e XOR 2e).

A270418	mul	0
# p^A065620(e)
# M.w. a(p^e) = p^A065620(e) for odious e, a(p^e)=1 for evil e, or equally, a(p^e) = p^(A010060(e)*A065620(e)).

A270436	mul	0
# p^A065621(e)
# M.w. a(p^e) = p^A065621(e).

A307037	mult	0
# p.pow(e).add(((e & 1) == 0) ? 1 : -1)
# M.w. a(p^e) = p^e + (-1)^e.

A306408	mult	0
# p.pow(e).subtract(p.pow(e).subtract(1).divide(p.subtract(1)))
# M.w. a(p^e) = p^e - (p^e - 1)/(p-1).

A326575	mul	0
# p^e if p < 5, (p.pow(e+1)-(-1)^(e+1)).divide(p+1) if p == 5 (mod 6), : (p.pow(e+1).subtract(1).divide(p.subtract(1)) if p == 1 (mod 6)
# M.w. a(p^e) = p^e if p < 5, (p^(e+1)-(-1)^(e+1))/(p+1) if p == 5 (mod 6), and (p^(e+1)-1)/(p-1) if p == 1 (mod 6). - _Amiram Eldar_, Dec 02 2020

A328618	mul	0
# p^e if p = 2 or e is a multiple of p,  p.pow((p*floor(e/p)) + (2e mod p))
# M.w. a(p^e) = p^e if p = 2 or e is a multiple of p, otherwise a(p^e) = p^((p*floor(e/p)) + (2e mod p)).

A111938	mul	0
# p^e if p = 2; (e+1)p^e if p == 1 (mod 4); (1+(((e & 1) == 0) ? 1 : -1))/2 p^e if p == 3 (mod 4)
# M.w. a(p^e) = p^e if p = 2; (e+1)p^e if p == 1 (mod 4); (1+(-1)^e)/2 p^e if p == 3 (mod 4).

A155918	mul	0
# p^e if p == 1 (mod 4); ceiling(p.pow(e+1).divide(p+1)) if p == 3 (mod 4); Z.ONE.shiftLeft(e-1) + 1 if p = 2
# M.w. a(p^e) = p^e if p == 1 (mod 4); ceiling(p^(e+1)/(p+1)) if p == 3 (mod 4); 2^(e-1) + 1 if p = 2. - _Jianing Song_, Apr 20 2019

A085731	mult	0
# Z.valueOf(e).remainder(p).isZero() ? p.pow(e) : p.pow(e-1)
# M.w. a(p^e) = p^e if p divides e; a(p^e) = p^(e-1) otherwise. - _Eric M. Schmidt_, Oct 22 2013

A282254	mult	0
# p.pow(e).multiply(p.pow(9*(e+1)).subtract(1)).divide(p.pow(9).subtract(1))
# M.w. a(p^e) = p^e*(p^(9*(e+1))-1)/(p^9-1). - _Jianing Song_, Aug 12 2020

A069194	mult	0
# p.pow(e).multiply(p.pow(e).subtract(p.pow(e-1)).add(p.pow(2*e)).subtract(1)).divide(p.square().subtract(1))
# M.w. a(p^e) = p^e*(p^e - p^(e-1)) + (p^(2*e) - 1)/(p^2 - 1). - _Amiram Eldar_, Sep 15 2019

A064971	mult	0
# p.pow(e).multiply(p.pow(e).add(1))
# M.w. a(p^e) = p^e*(p^e+1). - _Vladeta Jovovic_, Nov 01 2001

A328617	mul	0
# Z.valueOf(e).mod(p).isZero() ? p.pow(e) : p.pow((p.multiply(Z.valueOf(e).divide(p)) + A124223(A000720(p),e mod p)
# M.w. a(p^e) = p^e, if e = 0 mod p, otherwise a(p^e) = p^((p*floor(e/p)) + A124223(A000720(p),e mod p).

A117657	mult	0
# p.pow(2*e/3).add(p.subtract(1).multiply(p.pow(e-1)))
# M.w. a(p^e) = p^floor(2*e/3) + (p-1)*p^(e-1) for prime p. - _Andrew Howroyd_, Jul 17 2018

A117656	mult	0
# p.pow(e/2).add(p.subtract(1).multiply(p.pow(e-1)))
# M.w. a(p^e) = p^floor(e/2) + (p-1)*p^(e-1) for prime p. - _Andrew Howroyd_, Jul 17 2018

A305461	mult	0
# p.pow(e/2).add(1)
# M.w. a(p^e) = p^floor(e/2) + 1 for prime p. - _Andrew Howroyd_, Jul 22 2018

A197863	mult	0
# p.pow(e > 2 ? e : 2)
# M.w. a(p^e) = p^max(e,2).

A062379	mulr	0
# p.pow(e - 3 > 0 ? e - 3 : 0)
# M.w. a(p^e) = p^max(e-3, 0). - _Amiram Eldar_, Sep 07 2020

A073103	mult	0
# p.equals(Z.TWO) ? p.pow(e-1 < 3 ? e-1 : 3) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.FOUR : Z.TWO)
# M.w. a(p^e) = p^min(e-1, 3) if p = 2, 4 if p == 1 (mod 4), 2 if p == 3 (mod 4). - _David W. Wilson_, Jun 09 2005

A247257	mult	0
# p.equals(Z.TWO) ? p.pow(e-1 < 4 ? e-1 : 4) : p.subtract(1).gcd(Z.EIGHT)
# M.w. a(p^e) = p^min(e-1, 4) if p = 2, gcd(8, p-1) if p > 2. - _Jianing Song_, Nov 10 2019

A304203	mul	0
# p^prime(e)
# M.w. a(p^e) = p^prime(e). - _M. F. Hasler_, Nov 20 2018

A338782	mul	0
# p^rad(e), where rad(k) is the largest squarefree number dividing k (A007947)
# M.w. a(p^e) = p^rad(e), where rad(k) is the largest squarefree number dividing k (A007947).

A058067	mul	0
# p^t_p(e)
# M.w. a(p^e) = p^t_p(e). - _David W. Wilson_, Aug 14 2005 [t_p(e) = Sum_{k>=0: e > A090622(k, p)} (e - A090622(k, p)) = p * Sum_{k = 1..e} max(0, k - A090622(e-k, p)). In particular, t_p(e) = p*e*(e+1)/2 for e <= p. - _Andrey Zabolotskiy_, Nov 09 2017 and Sep 29 2020]

A102631	mult	0
# p.pow(2*e-1)
# M.w. a(p^e) = p^{2e-1}. - _Franklin T. Adams-Watters_, Nov 17 2006

A126246	mul	0
# phi(p^e) = p*(p.subtract(1))^(e-1), except when p=2, then a(2)=2, because F(1)=F(2)=1 : p.equals(Z.TWO) ? Z.valueOf(3*(Z.ONE.shiftLeft(e-2)), (e > 1, all smaller Fibonacci numbers are coprime, except ones that are multiples of 3, i
# M.w. a(p^e) = phi(p^e) = p*(p-1)^(e-1), except when p=2, then a(2)=2, because F(1)=F(2)=1 and a(2^e) = 3*(2^(e-2)), (e > 1, all smaller Fibonacci numbers are coprime, except ones that are multiples of 3, i.e., every 4th one). - _Jud McCranie_, Nov 11 2017

A301315	mul	0
# prime(p) ^ a(e) (where prime(k) denotes the k-th prime number)
# M.w. a(p^e) = prime(p) ^ a(e) (where prime(k) denotes the k-th prime number).

A064988	mul	0
# prime(p)^e
# M.w. a(p^e) = prime(p)^e.

A321874	mul	0
# prime(p)^prime(e)
# M.w. a(p^e) = prime(p)^prime(e). - _M. F. Hasler_, Nov 20 2018

A290641	mul	0
# prime(p.subtract(1))^e
# M.w. a(p^e) = prime(p-1)^e.

A347125	mul	0
# Z.valueOf(q^(e-1).multiply(p^e*(q*p-1)-q+1).divide(p.subtract(1)), where q = A151800(p)
# M.w. a(p^e) = q^(e-1)*(p^e*(q*p-1)-q+1)/(p-1), where q = A151800(p). - _Sebastian Karlsson_, Sep 02 2021

A342662	mult	0
# p.pow(e+1).subtract(1).divide(p.subtract(1))
# M.w. a(p^e) = q^e * (p^(e+1)-1)/(p-1), where q = 1 for p = 2, and for odd primes p, q = A151799(p), i.e., the previous prime.

A102574	mul	0
# Z.valueOf(sigma(p.pow(2e)) = (p.pow(2e+1).subtract(1).divide(p.subtract(1)) if p = 2 or p == 1 (mod 4); sigma_2(p^e) = (p.pow(2e+2).subtract(1).divide(p.square().subtract(1)) if p == 3 (mod 4)
# M.w. a(p^e) = sigma(p^(2e)) = (p^(2e+1) - 1)/(p - 1) if p = 2 or p == 1 (mod 4); sigma_2(p^e) = (p^(2e+2) - 1)/(p^2 - 1) if p == 3 (mod 4). - _Jianing Song_, Aug 03 2018

A322485	mul	0
# Z.valueOf(sigma(p^floor((e-1)/2)) + p^e = (p^floor((e+1)/2).subtract(1).divide(p.subtract(1)) + p^e
# M.w. a(p^e) = sigma(p^floor((e-1)/2)) + p^e = (p^floor((e+1)/2) - 1)/(p-1) + p^e.

A333926	mul	0
# Z.ONE + Sum_{d recursive divisor of e} p^d
# M.w. a(p^k) = 1 + Sum_{d recursive divisor of k} p^d.

A303809	mul	0
# Z.valueOf(2^a(e)
# M.w. a(p^k) = 2^a(k).

A303822	mul	0
# Z.valueOf(3^a(e)
# M.w. a(p^k) = 3^a(k).

A300955	mul	0
# Z.valueOf(A064614(p)^a(e)
# M.w. a(p^k) = A064614(p)^a(k).

A326304	mul	0
# Z.valueOf(a(p.subtract(1))^e + 1
# M.w. a(p^k) = a(p-1)^k + 1 for any k > 0 and any prime number p.

A279513	mul	0
# p*a(e)
# M.w. a(p^k) = p*a(k) for any prime p and k>0.

A183091	mult	0
# p.pow(e*(e+1)/2)
# M.w. a(p^k) = p^(k*(k+1)/2).

A279912	mult	0
# p.pow(e-1).multiply(p.subtract(1).multiply(p.pow(e)).add(1))
# M.w. a(p^k) = p^(k-1) * ((p-1) * p^k + 1). - _Daniel Suteu_, Oct 24 2018

A087780	mult	0
# p.equals(Z.TWO) ? (e == 1 ? Z.ONE : Z.ZERO) : (p.equals(Z.THREE) ? Z.ZERO : (p.mod(Z.EIGHT).bitCount() == 2 ? Z.ZERO : Z.TWO))
# M.w. a(p^m) = 2 for p == 1, 7 (mod 8); a(p^m) = 0 for p == 3, 5 (mod 8); a(2^1) = 1; a(2^m) = 0 for m > 1. - _Eric M. Schmidt_, Apr 20 2013

A069739	mult	0
# Binomial.binomial(2*e, e).divide(e + 1)
# M.w. a(p^m) = Catalan(m) (A000108). Coincides with A066060 up to n=63 except for n=32.

A066060	mul	0
# a(p^m) equal to the number of groups of order p^m
# M.w. a(p^m) equal to the number of groups of order p^m.

A317934	mul	0
# a(p^n) = 2^A011371(n); denominators
# M.w. a(p^n) = 2^A011371(n); denominators for certain "Dirichlet Square Roots" sequences.

A159253	mult	0
# e % 3 == 0 ? p.pow(e) : (e % 3 == 1 ? p.pow(e + 1) : p.pow(e - 1))
# M.w. a(p^{3n}) = p^{3n}, a(p^{3n+1}) = p^{3n+2), and a(p^{3n+2)) = p^{3n+1).

A234744	mul	0
# a(p_i) = p_{A235048(i)}
# M.w. a(p_i) = p_{A235048(i)} for primes with index i, except for cases i=3 and i=4, use p_18 and p_8 (61 and 19) instead of 19 and 61. For the composites, the value is determined as: a(u*v) = a(u) * a(v).

A235487	mul	0
# a(p_i) = p_{a(i)}
# M.w. a(p_i) = p_{a(i)} for primes with index i <> 4, a(7) = 8, a(2^(3k)) = 7^k, a(2^(3k+1)) = 2*7^k, a(2^(3k+2)) = 4*7^k, and for other composites, a(u * v) = a(u) * a(v).

A318363	mul	0
# a(prime(i)^k) = prime(k)^Z.ONE.shiftLeft(i-1)
# M.w. a(prime(i)^k) = prime(k)^2^(i-1).

A308317	mul	0
# a(prime(k)^e) = A005117(e+1)^(Z.ONE.shiftLeft(k-1))
# M.w. a(prime(k)^e) = A005117(e+1)^(2^(k-1)).

A156061	mul	0
# a(prime(k)^e) = k
# M.w. a(prime(k)^e) = k. Note that in contrast to A003963, this is not fully multiplicative. a(1) = 1 as an empty product. - _Antti Karttunen_, Aug 13 2017

A290106	mul	0
# a(prime(k)^e) = k^(e-1)
# M.w. a(prime(k)^e) = k^(e-1).

A299200	mul	0
# a(prime(n)) = A000041(n)
# M.w. a(prime(n)) = A000041(n).

A262401	mul	0
# p -> A054055(p), p prime
# M.w. p -> A054055(p), p prime.

A108548	mul	0
# p -> A108546(A049084(p)), p prime
# M.w. p -> A108546(A049084(p)), p prime.

A124508	mult	0
# Z.ONE.shiftLeft(e).multiply(3)
# M.w. p^e -> 3*2^e, p prime and e>0.

A081210	mul	0
# p^e -> A070321(p^e), p prime
# M.w. p^e -> A070321(p^e), p prime.

A097246	mul	0
# p^e -> NextPrime(p)^floor(e/2) * p.pow(e mod 2), where p prime : NextPrime(p)=A000040(A049084(p)+1)
# M.w. p^e -> NextPrime(p)^floor(e/2) * p^(e mod 2), where p prime and NextPrime(p)=A000040(A049084(p)+1).

A268385	mul	0
# p^e -> p^A193231(e), p prime : e > 0
# M.w. p^e -> p^A193231(e), p prime and e > 0.

A124859	mul	0
# p^e -> primorial(e), p prime : e > 0
# M.w. p^e -> primorial(e), p prime and e > 0.

A102440	mul	0
# prime(i) -> (if i<=2 then prime(i) else A102415(i))
# M.w. prime(i) -> (if i<=2 then prime(i) else A102415(i)).

A329605	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Number of divisors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A065770	mul	0
# a(p(m)^k) = p(m-1) * p(m)^(k-1)
# Number of prime cascades to reach 1, where a prime cascade (A065769) is M.w. a(p(m)^k) = p(m-1) * p(m)^(k-1).

A330690	mul	0
# a(prime(k)) = k-th primorial
# Number of ways to factor A108951(n) into "Fermi-Dirac primes" (A050376), where A108951 is fully M.w. a(prime(k)) = k-th primorial.

A318667	mul	0
# A318307(p^e) = 2^A002487(e)
# Numerators of the sequence whose Dirichlet convolution with itself yields A318307, which is M.w. A318307(p^e) = 2^A002487(e).

A065769	mul	0
# a(p(m)^k) = p(m-1) * p(m)^(k-1)
# Prime cascade: M.w. a(p(m)^k) = p(m-1) * p(m)^(k-1).

A329617	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Product of distinct exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A329382	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Product of exponents of prime factors of A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A325117	mul	0
# d(p^i)=i+1
# Proof: Let d be the number of divisors function (A000005). Recall that it is M.w. d(p^i)=i+1. If m = 2 mod 4 and has 18 divisors, then m/2 is odd and has 9 divisors, so m=2*r^2 for some odd r. Then m-2=2(r-1)(r+1). r-1 and r+1 are even and one of them is divisible by 4, so 2^4 divides m-2. r-1 and r+1 have no prime factors in common except 2, so if they are both divisible by odd primes, call them s and t, then m-2 is divisible by 2^4*s*t and has at least 20 divisors, contrary to hypothesis. Therefore either r-1 or r+1 is a power of 2; call it 2^j. Then the exponent of 2 in m-2 is j+2, so j+3 divides 18, so j is 3 or 6. This leaves 4 possibilities for m-2: 2*6*8, 2*8*10, 2*62*64, or 2*64*66. Of these, only 2*62*64 has 18 divisors, and 2*62*64+2 does not have 18 divisors.

A125139	mult	0
# p.multiply(p.pow(e).subtract(1)).divide(p.subtract(1)).subtract(((e & 1) == 0) ? 1 : -1)
# SENSigma: M.w. a(p^e) = p*(p^e-1)/(p-1) - (-1)^e.

A329602	mul	0
# a(prime(i)) = prime(i)# = Product_{i=1
# Square root of largest square dividing A108951(n), where A108951 is fully M.w. a(prime(i)) = prime(i)# = Product_{i=1..i} A000040(i).

A067856	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e - 1) : (e == 1 ? Z.NEG_ONE : Z.ZERO)
# Sum_{n > 0} a(n)*x^n/(1 + x^n) = x. Moebius transform of A048298. M.w. a(2^e) = 2^(e - 1), a(p) = -1 for p > 2, a(p^e) = 0 for p > 2 and e > 1. - _Vladeta Jovovic_, Jan 02 2003

A305191	mul	0
# respect to n, that is, if gcd(n,m)=1 then T(n*m,k) = T(n,k mod n)*T(m,k mod m)
# T(n,k) is M.w. respect to n, that is, if gcd(n,m)=1 then T(n*m,k) = T(n,k mod n)*T(m,k mod m).

A275966	mul	0
# a(p^n) = Re(I^(p^n+1) - I^(p.pow(n-1)+1))
# This function is M.w. a(p^n) = Re(I^(p^n+1) - I^(p^(n-1)+1)).

A112070	mul	0
# respect to its modulus, it follows that if n occurs on row i : m occurs on row j, then n*m cannot occur be
# This is a permutation of odd numbers greater than unity provided that the sequence A112046 contains only prime values and every prime occurs infinitely many times there. Because the Jacobi symbol is M.w. respect to its modulus, it follows that if n occurs on row i and m occurs on row j, then n*m cannot occur before row min(i,j).

A236852	mul	0
# a(p) = A234742(p) although neither A234741 or A234742 are even multiplicative
# This sequence appears to be completely M.w. a(p) = A234742(p) although neither A234741 or A234742 are even multiplicative. Terms tested up to n = 10^7. - _Andrew Howroyd_, Aug 01 2018

A114643	mult	0
# p.equals(Z.TWO) ? (e == 1 ? Z.ZERO : (e == 2 ? Z.ONE : (e == 3 ? Z.TWO : Z.ZERO))) : (e == 1 ? Z.ONE : Z.ZERO)
# This sequence is M.w. a(2) = 0, a(4) = 1, a(8) = 2, a(2^r) = 0 for r > 3, a(p) = 1 for prime p > 2 and a(p^r) = 0 for r > 1. - _Steven Finch_, Mar 08 2006 (With correction by _Jianing Song_, Jun 28 2018)

A114811	mult	0
# p.equals(Z.TWO) ? (e <= 2 ? Z.ONE : (e == 3 ? Z.TWO : Z.ZERO)) : (e == 1 ? Z.TWO : Z.ZERO)
# This sequence is M.w. a(2)=1, a(4)=1, a(8)=2, a(2^r)=0 for r>2, a(p)=2 for prime p>2 and a(p^r)=0 for r>1. - _Steven Finch_, Mar 08 2006

A318935	mult	0
# p.equals(Z.TWO) ? Z.EIGHT.pow(e + 1).subtract(1).divide(7) : Z.ONE
# Thus M.w. a(2^m) = (8^(m+1)-1)/7, and a(p^e) = 1 for odd primes p. - _Antti Karttunen_, Nov 07 2018

A067029	mul	0
# Z.valueOf(f(e), as recurrences of the
# Together with A028234 is useful for defining sequences that are M.w. a(p^e) = f(e), as recurrences of the form: a(1) = 1 and for n > 1, a(n) = f(A067029(n)) * a(A028234(n)). - _Antti Karttunen_, May 29 2017

A120119	mul	0
# a(Prime(k)) = A055025(k)
# Totally M.w. a(Prime(k)) = A055025(k).

A061142	mult	0
# e == 1 ? Z.TWO : p.pow(e)
# Totally M.w. a(p) = 2. - _Franklin T. Adams-Watters_, Oct 04 2006

A123667	mult	0
# e == 1 ? p.multiply2() : p.pow(e)
# Totally M.w. a(p) = 2p.

A113175	mult	0
# Fibonacci.fibonacci(p.intValue()).pow(e)
# Totally M.w. a(p) = F(p). - _Franklin T. Adams-Watters_, Jun 05 2006

A079579	mult	0
# p.subtract(1).multiply(p)
# Totally M.w. p -> (p-1)*p, p prime.

A192577	mul	0
# Z.valueOf((1+p^e)/2
# [Note that A034448(n) and A034444(n) are multiplicative, so the arithmetic mean A034448(n)/A034444(n) is M.w. a(p^e) = (1+p^e)/2.]

A318657	mul	0
# p.equals(Z.TWO) ? Z.valueOf(0, Z.valueOf(A257098(p^e)
# a(2n) = 0, a(2n-1) = A257098(2n-1), thus M.w. a(2^e) = 0, a(p^e) = A257098(p^e) for odd primes p.  - _Antti Karttunen_, Sep 01 2018

A228745	mul	0
# a(0) = 1, b(2^e) = -4 if e>1, b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)), if p>2
# a(n) = -6 * b(n) where b() is M.w. a(0) = 1, b(2^e) = -4 if e>1, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)), if p>2.

A068074	mul	0
# b(2^e) = abs(2*e-3) : b(p^e) = 2*e+1
# a(n) = -tau(n^2) for odd n and 2*tau(n^2/4) - tau(n^2) for even n. b(n) = abs(a(n)) is M.w. b(2^e) = abs(2*e-3) and b(p^e) = 2*e+1 for an odd prime p. - _Vladeta Jovovic_, Apr 25 2002

A227354	mul	0
# b(2^e) = (1 + 3*(((e & 1) == 0) ? 1 : -1)) / 4, b(3^e) = 1, b(p^e) = e+1 if p == 1 (mod 6), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6)
# a(n) = 12 * b(n) where b(n) is M.w. b(2^e) = (1 + 3*(-1)^e) / 4, b(3^e) = 1, b(p^e) = e+1 if p == 1 (mod 6), b(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A245572	mul	0
# b(2) = -1, b(2^e) = 3 if e>1, b(p^e) = e+1 if p == 1, 3 (mod 8), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 5, 7 (mod 8)
# a(n) = 2 * b(n) where b(n) is M.w. b(2) = -1, b(2^e) = 3 if e>1, b(p^e) = e+1 if p == 1, 3 (mod 8), b(p^e) = (1 + (-1)^e)/2 if p == 5, 7 (mod 8).

A259761	mul	0
# b(2^e) = 1, b(3^e) = 1 + (((e & 1) == 0) ? 1 : -1) if e>0, b(p^e) = e+1 if p == 1, 5 (mod 12), (p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 7, 11 (mod 12)
# a(n) = 2 * b(n) with a(0) = 1 and b() is M.w. b(2^e) = 1, b(3^e) = 1 + (-1)^e if e>0, b(p^e) = e+1 if p == 1, 5 (mod 12), (p^e) = (1 + (-1)^e)/2 if p == 7, 11 (mod 12).

A138805	mul	0
# b(3^e) = 3 if e>1, b(p^e) = e+1 if p == 1 (mod 6), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6)
# a(n) = 2*b(n) where b() is M.w. b(3^e) = 3 if e>1, b(p^e) = e+1 if p == 1 (mod 6), b(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A138811	mul	0
# b(43^e) = 1, b(p^e) = e + 1 if Kronecker(-43, p) = 1, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2
# a(n) = 2*b(n) where b() is M.w. b(43^e) = 1, b(p^e) = e + 1 if Kronecker(-43, p) = 1, b(p^e) = (1 + (-1)^e) / 2 otherwise.

A281786	mul	0
# b(2^e) = 1, b(3^e) = -8 if e>0, b(p^e) = (p.pow(e+1).subtract(1).divide(p.subtract(1)) if p>3
# a(n) = 3*b(n) if n>0 where b() is M.w. b(2^e) = 1, b(3^e) = -8 if e>0, b(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.

A217220	mul	0
# b(2^e) = (1+(((e & 1) == 0) ? 1 : -1))*3/4, b(3^e) = 1, b(p^e) = (1+(((e & 1) == 0) ? 1 : -1))/2 if p == 5 (mod 6), b(p^e) = e+1 if p == 1 (mod 6)
# a(n) = 4 * b(n) where b() is M.w. b(2^e) = (1+(-1)^e)*3/4, b(3^e) = 1, b(p^e) = (1+(-1)^e)/2 if p == 5 (mod 6), b(p^e) = e+1 if p == 1 (mod 6). - _Michael Somos_, Feb 01 2017

A125510	mul	0
# b(2^e) = 1, b(3^e) = 3^(e+1) - 2, b(p^e) = (p.pow(e+1).subtract(1).divide(p.subtract(1)) if p>3
# a(n) = 6*b(n) where b() is M.w. b(2^e) = 1, b(3^e) = 3^(e+1) - 2, b(p^e) = (p^(e+1) - 1) / (p-1) if p>3. - _Michael Somos_, Feb 17 2017

A345047	mul	0
# Z.valueOf((((e & 1) == 0) ? 1 : -1), : A345046(n) gives the least common multiple of the same factors
# a(n) = A003958(n) / A345046(n), where A003958(n) is M.w. a(p^e) = (p-1)^e, and A345046(n) gives the least common multiple of the same factors.

A340362	mul	0
# Z.valueOf(A005940(p^e)
# a(n) = A005940(n) - A324106(n), where A324106(n) is M.w. a(p^e) = A005940(p^e).

A340365	mul	0
# Z.valueOf(A005940(p^e)
# a(n) = A005940(n) / gcd(A005940(n), A324106(n)), where A324106(n) is M.w. a(p^e) = A005940(p^e).

A345045	mul	0
# p^e - 1, : A345044(n) gives the least common multiple of the same factors
# a(n) = A047994(n) / A345044(n), where A047994(n) is M.w. a(p^e) = p^e - 1, and A345044(n) gives the least common multiple of the same factors.

A336459	mul	0
# a(2) = a(3) = 1, : a(p) = p
# a(n) = A065330(sigma(sigma(n))), where A065330 is fully M.w. a(2) = a(3) = 1, and a(p) = p for primes p > 3.

A293444	mul	0
# Z.valueOf(A019565(e)
# a(n) = A293442(A293442(n)), where A293442 is M.w. a(p^e) = A019565(e).

A340366	mul	0
# Z.valueOf(A005940(p^e)
# a(n) = A324106(n) / gcd(A005940(n), A324106(n)), where A324106(n) is M.w. a(p^e) = A005940(p^e).

A342466	mul	0
# a(p) = A000265(p-1)
# a(n) = A336466(1+A000265(sigma(n))), where A336466 is fully M.w. a(p) = A000265(p-1) for p prime, and A000265(k) is the odd part of k.

A342017	mul	0
# p^floor(e/p), : A327860 is arithmetic derivative of A276086
# a(n) = A342007(A327860(n)), where A342007 is M.w. a(p^e) = p^floor(e/p), and A327860 is arithmetic derivative of A276086.

A344879	mul	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(1+e) - 1, : p^e -1
# a(n) = A344875(n) / A344878(n), where A344875(n) is M.w. a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e -1 for odd primes p, and A344878(n) gives the least common multiple of the same factors.

A064950	mult	0
# (p.pow(e+2).subtract(p.pow(e+1).multiply(3)).add(p).add(1).add(p.pow(e+2).multiply(2*e)).subtract(p.pow(e+1).multiply(2*e))).divide(p.subtract(1).square())
# a(n) = Sum_{d|n} d*tau(d^2). M.w. a(p^e) = (p^(e+2) - 3*p^(e+1) + p + 1 + 2*p^(e+2)*e - 2*p^(e+1)*e)/(p-1)^2.

A122266	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 * p.pow(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p.pow(e-1)) - p^4 * b(p.pow(e-2)) if p == 1 or 5 (mod 12)
# a(n) = b(12*n + 1) where b() is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e) / 2 * p^(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p^(e-1)) - p^4 * b(p^(e-2)) if p == 1 or 5 (mod 12). - _Michael Somos_, Jun 24 2013

A187097	mul	0
# b(2^e) = 0^e, b(19^e) = 1, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if -1 = Kronecker(-19, p), b(p^e) = e + 1 if p = x^2 + 19 * y^2, b(p^e) = Kronecker(-3, e+1) if p = 4*x^2 + 2*x*y + 5*y^2
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(19^e) = 1, b(p^e) = (1 + (-1)^e) / 2 if -1 = Kronecker(-19, p), b(p^e) = e + 1 if p = x^2 + 19 * y^2, b(p^e) = Kronecker(-3, e+1) if p = 4*x^2 + 2*x*y + 5*y^2.

A261277	mul	0
# b(2^e) = 0^e, b(3^e) = -2 * (((e & 1) == 0) ? 1 : -1) if e>0, b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p>3
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = -2 * (-1)^e if e>0, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p>3.

A152244	mul	0
# b(2^e) = 0^e, b(3^e) = -2 * (-3)^e if e>0, b(p^e) = p^e * (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6), b(p^e) = b(p) * b(p.pow(e-1)) - p^2 * b(p.pow(e-2)) if p == 1 (mod 6)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = -2 * (-3)^e if e>0, b(p^e) = p^e * (1 + (-1)^e) / 2 if p == 5 (mod 6), b(p^e) = b(p) * b(p^(e-1)) - p^2 * b(p^(e-2)) if p == 1 (mod 6).

A262780	mul	0
# b(2^e) = 0^e, b(3^e) = 1, b(p^e) = e+1 if p == 1, 19 (mod 24), b(p^e) = (((e & 1) == 0) ? 1 : -1) * (e+1) if p == 7, 13 (mod 24), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = 1, b(p^e) = e+1 if p == 1, 19 (mod 24), b(p^e) = (-1)^e * (e+1) if p == 7, 13 (mod 24), b(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A134080	mul	0
# b(2^e) = 0^e, b(5^e) = 5^e, b(p^e) = (p.pow(e+1).subtract(1).divide(p.subtract(1)) if p == 1, 9 (mod 10), b(p^e) = (p.pow(e+1)  + (((e & 1) == 0) ? 1 : -1)).divide(p + 1) if p == 3, 7 (mod 10)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(5^e) = 5^e, b(p^e) = (p^(e+1) - 1) / (p - 1) if p == 1, 9 (mod 10), b(p^e) = (p^(e+1)  + (-1)^e) / (p + 1) if p == 3, 7 (mod 10).

A133827	mul	0
# b(2^e) = 0^e, b(7^e) = 1, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 3, 5, 6 (mod 7), b(p^e) = e + 1 if p == 1, 2, 4 (mod 7)
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(7^e) = 1, b(p^e) = (1 + (-1)^e) / 2 if p == 3, 5, 6 (mod 7), b(p^e) = e + 1 if p == 1, 2, 4 (mod 7).

A228443	mul	0
# b(2^e) = 0^e, b(p^e) = (p.pow(e+1).subtract(1).divide(p.subtract(1)) if p == 1 (mod 4), b(p^e) = (p.pow(e+1) + (((e & 1) == 0) ? 1 : -1)).divide(p + 1) if p == 3 (mod 4), with a(0) = 1
# a(n) = b(2*n + 1) where b() is M.w. b(2^e) = 0^e, b(p^e) = (p^(e+1) - 1) / (p - 1) if p == 1 (mod 4), b(p^e) = (p^(e+1) + (-1)^e) / (p + 1) if p == 3 (mod 4), with a(0) = 1.

A317690	mul	0
# b(3^e) = (((e & 1) == 0) ? 1 : -1), b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p>3, where b(p) = p minus number of points of elliptic curve modulo p
# a(n) = b(2*n + 1) where b() is M.w. b(3^e) = (-1)^e, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p>3, where b(p) = p minus number of points of elliptic curve modulo p.

A252731	mul	0
# b(p^e) = (((e & 1) == 0) ? 1 : -1) if p = 11, b(p^e) = b(p)*b(p.pow(e-1)) - p*b(p.pow(e-2)) if p != 11
# a(n) = b(2*n + 1) where b() is M.w. b(p^e) = (-1)^e if p = 11, b(p^e) = b(p)*b(p^(e-1)) - p*b(p^(e-2)) if p != 11.

A204342	mul	0
# b(2^e) = 0^e, b(p^e) = ((p^4)^(e+1) + 1).divide(p^4 + 1) if p == 3 (mod 4), b(p^e) = ((p^4)^(e+1).subtract(1).divide(p^4 - 1) if p == 1 (mod 4)
# a(n) = b(2*n + 1) where b(n) is M.w. b(2^e) = 0^e, b(p^e) = ((p^4)^(e+1) + 1) / (p^4 + 1) if p == 3 (mod 4), b(p^e) = ((p^4)^(e+1) - 1) / (p^4 - 1) if p == 1 (mod 4).

A228072	mul	0
# b(2^e) = 0^e, b(p^e) = b(p) * b(p.pow(e-1)) - p^3 * b(p.pow(e-2)) if p>2
# a(n) = b(2*n + 1) where b(n) is M.w. b(2^e) = 0^e, b(p^e) = b(p) * b(p^(e-1)) - p^3 * b(p^(e-2)) if p>2.

A143062	mul	0
# b(p.pow(2*e)) = (((e & 1) == 0) ? 1 : -1) if p = 5 (mod 6), b(p.pow(2*e)) = +1 if p = 1 (mod 6) : b(p.pow(2*e-1)) = b(2^e) = b(3^e) = 0 if e>0
# a(n) = b(24*n + 1) where b() is M.w. b(p^(2*e)) = (-1)^e if p = 5 (mod 6), b(p^(2*e)) = +1 if p = 1 (mod 6) and b(p^(2*e-1)) = b(2^e) = b(3^e) = 0 if e>0.

A133079	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 * p.pow(e/2) if p == 1, 3 (mod 8), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 * (-p)^(e/2) if p == 5, 7 (mod 8)
# a(n) = b(24*n + 1) where b(n) is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 * p^(e/2) if p == 1, 3 (mod 8), b(p^e) = (1 + (-1)^e)/2 * (-p)^(e/2) if p == 5, 7 (mod 8).

A199918	mul	0
# b(p.pow(2*e)) = (((e & 1) == 0) ? 1 : -1) if p == 13, 17, 29, 23 (mod 24), b(p.pow(2*e)) = +1 if p = 1, 5, 7, 11 (mod 24) : b(p.pow(2*e - 1)) = b(2^e) = b(3^e) = 0 if e > 0
# a(n) = b(24*n + 1) where b(n) is M.w. b(p^(2*e)) = (-1)^e if p == 13, 17, 29, 23 (mod 24), b(p^(2*e)) = +1 if p = 1, 5, 7, 11 (mod 24) and b(p^(2*e - 1)) = b(2^e) = b(3^e) = 0 if e > 0.

A263571	mul	0
# b(2^e) = b(3^e) = (((e & 1) == 0) ? 1 : -1), b(p^e) = e+1 if p == 1, 7 (mod 24), b(p^e) = (e+1) * (((e & 1) == 0) ? 1 : -1) if p == 5, 11 (mod 24), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 13, 17, 19, 23 (mod 24)
# a(n) = b(3*n + 1) where b() is M.w. b(2^e) = b(3^e) = (-1)^e, b(p^e) = e+1 if p == 1, 7 (mod 24), b(p^e) = (e+1) * (-1)^e if p == 5, 11 (mod 24), b(p^e) = (1 + (-1)^e) / 2 if p == 13, 17, 19, 23 (mod 24).

A143064	mul	0
# b(p.pow(2*e)) = -(((e & 1) == 0) ? 1 : -1) if p = 2, b(p.pow(2*e)) = (((e & 1) == 0) ? 1 : -1) if p = 5 (mod 6), b(p.pow(2*e)) = 1 if p = 1 (mod 6), : b(p.pow(2*e-1)) = b(3^e) = 0 if e>0
# a(n) = b(3*n + 1) where b() is M.w. b(p^(2*e)) = -(-1)^e if p = 2, b(p^(2*e)) = (-1)^e if p = 5 (mod 6), b(p^(2*e)) = 1 if p = 1 (mod 6), and b(p^(2*e-1)) = b(3^e) = 0 if e>0. - _Michael Somos_, Jul 19 2013

A127863	mul	0
# b(3^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 * (-p)^(e/2) if p == 2 (mod 3), b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p == 1 (mod 3) where b(p) = -Sum_{x=0
# a(n) = b(3*n + 1) where b(n) is M.w. b(3^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 * (-p)^(e/2) if p == 2 (mod 3), b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p == 1 (mod 3) where b(p) = -Sum_{x=0..p-1} Kronecker(4*x^3 + 9, p).

A277076	mul	0
# b(p^e) = 0^e if p=3 : b(p^e) = b(p)*b(p.pow(e-1))  - p^7*b(p.pow(e-2))
# a(n) = b(3*n+1) where b() is M.w. b(p^e) = 0^e if p=3 and b(p^e) = b(p)*b(p^(e-1))  - p^7*b(p^(e-2)) otherwise.

A234565	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 * p.pow(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p.pow(e-1)) - p^4 * b(p.pow(e-2)) if p == 1 or 5 (mod 12)
# a(n) = b(4*n + 1) where b() is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e) / 2 * p^(2*e) if p == 7 or 11 (mod 12), b(p^e) = b(p) * b(p^(e-1)) - p^4 * b(p^(e-2)) if p == 1 or 5 (mod 12).

A258739	mul	0
# b(2^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 * p.pow(5*e/2) if p == 3 (mod 4), b(p^e) = b(p) * b(p.pow(e-1)) - p^4 * b(p.pow(e-2)) if p == 1 (mod 4)
# a(n) = b(4*n + 1) where b(n) is M.w. b(2^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 * p^(5*e/2) if p == 3 (mod 4), b(p^e) = b(p) * b(p^(e-1)) - p^4 * b(p^(e-2)) if p == 1 (mod 4).

A179851	mul	0
# b(2^e) = b(5^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 3 (mod 4), b(p^e) = (e + 1) * s^e where s = Kronecker(10, p)
# a(n) = b(4*n + 1) where b(n) is M.w. b(2^e) = b(5^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 if p == 3 (mod 4), b(p^e) = (e + 1) * s^e where s = Kronecker(10, p) for other primes p.

A182004	mul	0
# b(2^e) = b(5^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 3 (mod 4), b(p^e) = (e + 1) * s^e where s = Kronecker(10, p)
# a(n) = b(4*n + 1) where b(n) is M.w. b(2^e) = b(5^e) = 0^e, b(p^e) = (1 + (-1)^e)/2 if p == 3 (mod 4), b(p^e) = (e + 1) * s^e where s = Kronecker(10, p) for other primes p.

A318375	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = b(p) * b(p.pow(e-1)) - p * b(p.pow(e-2)) if p>5, where b(p) = p minus number of points of elliptic curve modulo p
# a(n) = b(6*n + 1) where b() is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = b(p) * b(p^(e-1)) - p * b(p^(e-2)) if p>5, where b(p) = p minus number of points of elliptic curve modulo p.

A153728	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1)) / 2 * (-1)^(e/2) * p.pow(3*e/2) if p == 5 (mod 6), b(p^e) = b(p) * b(p.pow(e-1)) - b(p.pow(e-2)) * p^3 if p == 1 (mod 6) where b(p) = (x^2 - 3*p)*x, 4*p = x^2 + 3*y^2, |x| < |y| : x == 2 (mod 3)
# a(n) = b(6*n + 1) where b(n) is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = (1 + (-1)^e) / 2 * (-1)^(e/2) * p^(3*e/2) if p == 5 (mod 6), b(p^e) = b(p) * b(p^(e-1)) - b(p^(e-2)) * p^3 if p == 1 (mod 6) where b(p) = (x^2 - 3*p)*x, 4*p = x^2 + 3*y^2, |x| < |y| and x == 2 (mod 3).

A152243	mul	0
# b(2^e) = b(3^e) = 0^e, b(p^e) = p^e * (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6), b(p^e) = b(p) * b(p.pow(e-1)) - p^2 * b(p.pow(e-2)) if p == 1 (mod 6)
# a(n) = b(6*n + 1) where b(n) is M.w. b(2^e) = b(3^e) = 0^e, b(p^e) = p^e * (1 + (-1)^e) / 2 if p == 5 (mod 6), b(p^e) = b(p) * b(p^(e-1)) - p^2 * b(p^(e-2)) if p == 1 (mod 6).

A204850	mul	0
# b(2^e) = 0^e, b(3^e) = - (1 + (((e & 1) == 0) ? 1 : -1)) * 3^(e/2), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 * p.pow(e/2) if p == 1, 3 (mod 8), b(p^e) = (1 + (((e & 1) == 0) ? 1 : -1))/2 * (-p)^(e/2) if p == 5, 7 (mod 8)
# a(n) = b(8*n + 1) where b() is M.w. b(2^e) = 0^e, b(3^e) = - (1 + (-1)^e) * 3^(e/2), b(p^e) = (1 + (-1)^e)/2 * p^(e/2) if p == 1, 3 (mod 8), b(p^e) = (1 + (-1)^e)/2 * (-p)^(e/2) if p == 5, 7 (mod 8). - _Michael Somos_, Jun 19 2015

A178737	mul	0
# b(p^e) = 0 if e odd, b(2^e) = 0^e, b(p^e) = p.pow(3 * e/2) if p == 1 (mod 4), b(p^e) = (-p)^(3 * e/2) if p == 3 (mod 4)
# a(n) = b(8*n + 1) where b() is M.w. b(p^e) = 0 if e odd, b(2^e) = 0^e, b(p^e) = p^(3 * e/2) if p == 1 (mod 4), b(p^e) = (-p)^(3 * e/2) if p == 3 (mod 4).

A340364	mul	0
# Z.valueOf(A005940(p^e)
# a(n) = gcd(A005940(n), A324106(n)), where A324106(n) is M.w. a(p^e) = A005940(p^e).

A342670	mul	0
# p.equals(Z.TWO) ? Z.ONE : prevprime(p)^e
# a(n) = gcd(n*sigma(A064989(n)), sigma(n)*A064989(n)), where A064989 is M.w. a(2^e) = 1 and a(p^e) = prevprime(p)^e for odd primes p, and sigma gives the sum of the divisors of its argument.

A322361	mul	0
# a(prime(k)) = prime(k+1)
# a(n) = gcd(n, A003961(n)), where A003961 is completely M.w. a(prime(k)) = prime(k+1).

A330749	mul	0
# a(2) = 1 : a(prime(k)) = prime(k-1)
# a(n) = gcd(n, A064989(n)), where A064989 is fully M.w. a(2) = 1 and a(prime(k)) = prime(k-1) for odd primes.

A322362	mult	0
# p.add(2).pow(e)
# a(n) = gcd(n, A166590(n)), where A166590 is completely M.w. a(p) = p+2 for prime p.

A344877	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(1+e).subtract(1) : p.pow(e).subtract(1)
# a(n) = gcd(n, A344875(n)), where A344875 is M.w. a(2^e) = 2^(1+e) - 1, and a(p^e) = p^e -1 for odd primes p.

A342673	mul	0
# a(prime(k)) = prime(k+1), : sigma is the sum of divisors of n
# a(n) = gcd(n, sigma(A003961(n))), where A003961 is fully M.w. a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.

A342671	mul	0
# a(prime(k)) = prime(k+1), : sigma is the sum of divisors of n
# a(n) = gcd(sigma(n), A003961(n)), where A003961 is fully M.w. a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.

A342672	mul	0
# a(prime(k)) = prime(k+1), : sigma is the sum of divisors of n
# a(n) = lcm(sigma(n), A003961(n)), where A003961 is fully M.w. a(prime(k)) = prime(k+1), and sigma is the sum of divisors of n.

A227131	mult	0
# p.equals(Z.FIVE) ? Z.SIX : p.pow(e+1).subtract(1).divide(p.subtract(1))
# a(n) is M.w. a(0) = 1, a(5^e) = 6 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) otherwise.

A129522	mul	0
# a(11^e) = (-11)^e, Z.valueOf((1+(((e & 1) == 0) ? 1 : -1))/2*p^e if p == 2, 6, 7, 8, 10 (mod 11), Z.valueOf(a(p)*a(p.pow(e-1)) - p^2*a(p.pow(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^2 - 2*p : 4*p = y^2 + 11*x^2
# a(n) is M.w. a(11^e) = (-11)^e, a(p^e) = (1+(-1)^e)/2*p^e if p == 2, 6, 7, 8, 10 (mod 11), a(p^e) = a(p)*a(p^(e-1)) - p^2*a(p^(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^2 - 2*p and 4*p = y^2 + 11*x^2.

A138661	mul	0
# a(11^e) = (-1331)^e, p.pow(3*e) * (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 2, 6, 7, 8, 10 (mod 11), Z.valueOf(a(p) * a(p.pow(e-1)) - p^6 * a(p.pow(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^6 - 6*p*y^4 + 9*p^2*y^2 - 2*p^3 : 4 * p = y^2 + 11 * x^2
# a(n) is M.w. a(11^e) = (-1331)^e, a(p^e) = p^(3*e) * (1 + (-1)^e) / 2 if p == 2, 6, 7, 8, 10 (mod 11), a(p^e) = a(p) * a(p^(e-1)) - p^6 * a(p^(e-2)) if p == 1, 3, 4, 5, 9 (mod 11) where a(p) = y^6 - 6*p*y^4 + 9*p^2*y^2 - 2*p^3 and 4 * p = y^2 + 11 * x^2.

A279371	mul	0
# a(11^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2))
# a(n) is M.w. a(11^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) for p != 11.

A226075	mul	0
# a(11^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) if p != 11
# a(n) is M.w. a(11^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) if p != 11.

A128263	mul	0
# a(17^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p minus number of points of elliptic curve modulo p
# a(n) is M.w. a(17^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p minus number of points of elliptic curve modulo p.

A187096	mul	0
# a(19^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(19^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.

A133691	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e == 1 ? -2 : -6) : p.pow(e+1).subtract(1).divide(p.subtract(1))
# a(n) is M.w. a(2) = -2, a(2^e) = -6 if e>1, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>2.

A134015	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e == 1 ? 0 : -2) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.valueOf(e+1) : Z.valueOf(1+(((e & 1) == 0) ? 1 : -1)/2))
# a(n) is M.w. a(2) = 0, a(2^e) = -2 if e>1, a(p^e) = e+1 if p == 1 (mod 4), a(p^e) = (1+(-1)^e)/2 if p == 3 (mod 4).

A125096	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e == 1 ? 0 : 2) : isMod2(8, p, 1, 3) ? Z.valueOf(e+1) : Z.valueOf(1+(((e & 1) == 0) ? 1 : -1)/2))
# a(n) is M.w. a(2) = 0, a(2^e) = 2 if e>1, a(p^e) = e+1 if p == 1, 3 (mod 8), a(p^e) = (1+(-1)^e)/2 if p == 5, 7 (mod 8).

A258260	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e == 1 ? 1 : 0) : (p.equals(Z.THREE) ? Z.valueOf(e == 1 ? -1 : 4) : (p.mod(Z.FOUR).equals(Z.ONE) ? Z.ONE : Z.valueOf(((e & 1) == 0) ? 1 : -1)))
# a(n) is M.w. a(2) = 1, a(2^e) = 0 if e>1, a(3) = -1, a(3^e) = 4 * (-1)^e if e>1, a(p^e) = 1 if p == 1 (mod 4), a(p^e) = (-1)^e if p == 3 (mod 4).

A227239	mul	0
# p.equals(Z.TWO) ? Z.valueOf(e == 1 ? 8 : 0) : ??
# a(2) = 8, p.equals(Z.TWO) ? Z.valueOf(0 if e > 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p^5 * a(p.pow(e-2)) if p > 2
# a(n) is M.w. a(2) = 8, a(2^e) = 0 if e > 1, a(p^e) = a(p) * a(p^(e-1)) - p^5 * a(p^(e-2)) if p > 2.

A092673	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e == 1 ? -2 : (e == 2 ? 1 : 0)) : (e == 1 ? Z.NEG_ONE : Z.ZERO)
# a(n) is M.w. a(2)= -2, a(4)= 1, a(2^e)= 0 if e>2. a(p)= -1, a(p^e)= 0 if e>1, p>2. - _Michael Somos_, Mar 26 2007

A261278	mul	0
# a(Z.ONE.shiftLeft(2*k)) = (-8)^k, a(Z.ONE.shiftLeft(2*k+1)) = 4 * (-8)^k, a(3^e) = 0^e, a(p.pow(2*k)) = (-p)^(3^k) : a(p.pow(2*k+1)) = 0 if p == 5 (mod 6), Z.valueOf(a(p) * a(p.pow(e-1)) - p^3 * a(p.pow(e-2)) if p == 1 (mod 6)
# a(n) is M.w. a(2^(2*k)) = (-8)^k, a(2^(2*k+1)) = 4 * (-8)^k, a(3^e) = 0^e, a(p^(2*k)) = (-p)^(3^k) and a(p^(2*k+1)) = 0 if p == 5 (mod 6), a(p^e) = a(p) * a(p^(e-1)) - p^3 * a(p^(e-2)) if p == 1 (mod 6).

A138507	mult	0
# p.equals(Z.TWO) ? Z.TWO.negate().pow(e+1).subtract(1).divide(3) : (p.mod(Z.TEN).and(Z.THREE).equals(Z.THREE) ? p.negate().pow(e+1).subtract(1).divide(p.add(1).negate()) : p.pow(e+1).subtract(1).divide(p.subtract(1)))
# a(n) is M.w. a(2^e) = ((-2)^(e+1) - 1) / 3, a(p^e) = ((-p)^(e+1) - 1) / (-p - 1) if p == 3, 7 (mod 10), a(p^e) = (p^(e+1) - 1) / (p - 1) if p == 1, 9 (mod 10).

A113260	mul	0
# p.equals(Z.TWO) ? Z.valueOf(((-2)^(e+2).subtract(1)/3, a(5^e) = 1, p.pow(e+1).subtract(1).divide(p.subtract(1)) if p == 1, 4 (mod 5), Z.valueOf(((-p)^(e+1).subtract(1).divide(-p-1) if p == 2, 3 (mod 5)
# a(n) is M.w. a(2^e) = ((-2)^(e+2)-1)/3, a(5^e) = 1, a(p^e) = (p^(e+1)-1)/(p-1) if p == 1, 4 (mod 5), a(p^e) = ((-p)^(e+1)-1)/(-p-1) if p == 2, 3 (mod 5).

A258998	mult	0
# p.equals(Z.TWO) ? (((e & 1) == 0) ? Z.ONE.shiftLeft(e/2) : Z.ZERO) : (((e & 1) == 0) ? Z.ONE : Z.ZERO)
# p.equals(Z.TWO) ? Z.valueOf((-1)^(e/2) if e even, Z.ONE if p>2 : e even,  0
# a(n) is M.w. a(2^e) = (-1)^(e/2) if e even, a(p^e) = 1 if p>2 and e even, otherwise 0.

A247198	mul	0
# p.equals(Z.TWO) ? Z.valueOf((((e & 1) == 0) ? 1 : -1), a(13^e) = 1, else Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(2^e) = (-1)^e, a(13^e) = 1, else a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.

A261884	mul	0
# p.equals(Z.TWO) ? Z.valueOf((((e & 1) == 0) ? 1 : -1), a(3^e) = -1 if e>0, Z.valueOf(e+1 if p == 1 (mod 6), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 5 (mod 6)
# a(n) is M.w. a(2^e) = (-1)^e, a(3^e) = -1 if e>0, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e)/2 if p == 5 (mod 6).

A263649	mul	0
# p.equals(Z.TWO) ? Z.valueOf((((e & 1) == 0) ? 1 : -1), a(3^e) = -2*(((e & 1) == 0) ? 1 : -1) if e>0, Z.valueOf(e+1 if p == 1, 7 (mod 24), Z.valueOf((e+1) * (((e & 1) == 0) ? 1 : -1) if p == 5, 11 (mod 24), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 13, 17, 19, 23 (mod 24)
# a(n) is M.w. a(2^e) = (-1)^e, a(3^e) = -2*(-1)^e if e>0, a(p^e) = e+1 if p == 1, 7 (mod 24), a(p^e) = (e+1) * (-1)^e if p == 5, 11 (mod 24), a(p^e) = (1 + (-1)^e) / 2 if p == 13, 17, 19, 23 (mod 24).

A247067	mul	0
# p.equals(Z.TWO) ? Z.valueOf((-64)^e, p.pow(6*e) * (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 3 (mod 4), Z.valueOf(a(p) * a(p.pow(e-1)) - p^12 * a(p.pow(e-2)) if p == 1 (mod 4) where a(p) = 2 * Re( (x + i*y)^12 ) : p = x^2 + y^2 with even x
# a(n) is M.w. a(2^e) = (-64)^e, a(p^e) = p^(6*e) * (1 + (-1)^e)/2 if p == 3 (mod 4), a(p^e) = a(p) * a(p^(e-1)) - p^12 * a(p^(e-2)) if p == 1 (mod 4) where a(p) = 2 * Re( (x + i*y)^12 ) and p = x^2 + y^2 with even x. - _Michael Somos_, Nov 18 2014

A259024	mul	0
# p.equals(Z.TWO) ? Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2, a(3) = -1, a(3^e) = 0 if e>1, Z.ONE if p == 1 (mod 6), Z.valueOf((((e & 1) == 0) ? 1 : -1) if p == 5 (mod 6)
# a(n) is M.w. a(2^e) = (1 + (-1)^e) / 2, a(3) = -1, a(3^e) = 0 if e>1, a(p^e) = 1 if p == 1 (mod 6), a(p^e) = (-1)^e if p == 5 (mod 6).

A084091	mul	0
# p.equals(Z.TWO) ? Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1))/2, a(3^e) = 0^e, Z.ONE if p == 1 (mod 6), Z.valueOf((((e & 1) == 0) ? 1 : -1) if p == 5 (mod 6)
# a(n) is M.w. a(2^e) = (1 + (-1)^e)/2, a(3^e) = 0^e, a(p^e) = 1 if p == 1 (mod 6), a(p^e) = (-1)^e if p == 5 (mod 6). - _Michael Somos_, Jul 18 2004

A123331	mul	0
# p.equals(Z.TWO) ? Z.valueOf((3-(((e & 1) == 0) ? 1 : -1))/2, a(3^e) = 1, Z.valueOf(e+1 if p == 1 (mod 6), Z.valueOf((1+(((e & 1) == 0) ? 1 : -1))/2 if p == 5 (mod 6)
# a(n) is M.w. a(2^e) = (3-(-1)^e)/2, a(3^e) = 1, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1+(-1)^e)/2 if p == 5 (mod 6).

A143521	mult	0
# p.equals(Z.TWO) ? Z.valueOf(3-e).multiply(Z.ONE.shiftLeft(e)) : p.pow(e).multiply(e+1)
# a(n) is M.w. a(2^e) = (3-e) * 2^e if e>0, a(p^e) = (e+1) * p^e if p>2.

A143520	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e-1).multiply(Z.ONE.shiftLeft(e)) : p.pow(e).multiply(e+1)
# a(n) is M.w. a(2^e) = (e-1) * 2^e if e>0, a(p^e) = (e+1) * p^e if p>2.

A230277	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-(-2)^e if e>0,  a(3^e) = 0^e, p^e * (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 3, 7 (mod 8), Z.valueOf(a(p)*a(p.pow(e-1)) - p^2*a(p.pow(e-2)) : a(p) = t * (-1)^(t mod 3) if p == 1, 5 (mod 8) where t = 2 * if( p == 5 (mod 6) then 4*x*y else p - 8*y^2 ) : p = x^2 + 4*y^2
# a(n) is M.w. a(2^e) = -(-2)^e if e>0,  a(3^e) = 0^e, a(p^e) = p^e * (1 + (-1)^e)/2 if p == 3, 7 (mod 8), a(p^e) = a(p)*a(p^(e-1)) - p^2*a(p^(e-2)) and a(p) = t * (-1)^(t mod 3) if p == 1, 5 (mod 8) where t = 2 * if( p == 5 (mod 6) then 4*x*y else p - 8*y^2 ) and p = x^2 + 4*y^2.

A259030	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-(1 - (((e & 1) == 0) ? 1 : -1)) / 2 if e > 0, Z.valueOf(Kronecker(5, p)^e if p > 2
# a(n) is M.w. a(2^e) = -(1 - (-1)^e) / 2 if e > 0, a(p^e) = Kronecker(5, p)^e if p > 2.

A138952	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, a(3^e) = -1 + 2 * (((e & 1) == 0) ? 1 : -1), Z.valueOf(e+1 if p == 1, 5 (mod 12), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 7, 11 (mod 12)
# a(n) is M.w. a(2^e) = -1 if e>0, a(3^e) = -1 + 2 * (-1)^e, a(p^e) = e+1 if p == 1, 5 (mod 12), a(p^e) = (1 + (-1)^e) / 2 if p == 7, 11 (mod 12).

A257900	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, a(3^e) = 1 + (((e & 1) == 0) ? 1 : -1) if e>0, Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 3 (mod 4), Z.valueOf(e+1 if p == 1 (mod 4)
# a(n) is M.w. a(2^e) = -1 if e>0, a(3^e) = 1 + (-1)^e if e>0, a(p^e) = (1 + (-1)^e) / 2 if p == 3 (mod 4), a(p^e) = e+1 if p == 1 (mod 4).

A138746	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, a(3^e) = 2 - (((e & 1) == 0) ? 1 : -1), Z.valueOf(e+1 if p == 1, 5 (mod 12), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 7, 11 (mod 12)
# a(n) is M.w. a(2^e) = -1 if e>0, a(3^e) = 2 - (-1)^e, a(p^e) = e+1 if p == 1, 5 (mod 12), a(p^e) = (1 + (-1)^e) / 2 if p == 7, 11 (mod 12).

A113186	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, a(5^e) = 1, p.pow(e+1).subtract(1).divide(p.subtract(1)) if p == 1, 9 (mod 10), Z.valueOf(((-p)^(e+1).subtract(1).divide(-p-1) if p == 3, 7 (mod 10)
# a(n) is M.w. a(2^e) = -1 if e>0, a(5^e) = 1, a(p^e) = (p^(e+1)-1)/(p-1) if p == 1, 9 (mod 10), a(p^e) = ((-p)^(e+1)-1)/(-p-1) if p == 3, 7 (mod 10).

A138505	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, Z.valueOf(((p^2)^(e+1).subtract(1).divide(p.square().subtract(1)) if p == 1 (mod 4), Z.valueOf(((-p^2)^(e+1).subtract(1).divide( -p.square().subtract(1)) if p == 3 (mod 4)
# a(n) is M.w. a(2^e) = -1 if e>0, a(p^e) = ((p^2)^(e+1) - 1) / (p^2 - 1) if p == 1 (mod 4), a(p^e) = ((-p^2)^(e+1) - 1) / ( -p^2 - 1) if p == 3 (mod 4).

A133693	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5, 7 (mod 8), Z.valueOf(e + 1 if p == 1, 3 (mod 8)
# a(n) is M.w. a(2^e) = -1 if e>0, a(p^e) = (1 + (-1)^e) / 2 if p == 5, 7 (mod 8), a(p^e) = e + 1 if p == 1, 3 (mod 8).

A113652	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 if e>0, Z.valueOf(e+1 if p == 1 (mod 4), (1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 3 (mod 4)
# a(n) is M.w. a(2^e) = -1 if e>0, a(p^e) = e+1 if p == 1 (mod 4), (1 + (-1)^e)/2 if p == 3 (mod 4).

A137608	mul	0
# p.equals(Z.TWO) ? Z.valueOf(-1 unless e=0, a(3^e) = 1, Z.valueOf(e + 1 if p == 1 (mod 6), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6)
# a(n) is M.w. a(2^e) = -1 unless e=0, a(3^e) = 1, a(p^e) = e + 1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A143348	mult	0
# p.equals(Z.TWO) ? Z.ONE.subtract(Z.ONE.shiftLeft(e+1)) : p.pow(e+1).subtract(1).divide(p.subtract(1))
# a(n) is M.w. a(2^e) = 1 - 2^(e+1) if e > 0, a(p^e) = (p^(e+1) - 1) / (p - 1) if p > 2.

A209198	mult	0
# p.equals(Z.TWO) ? (e > 1 ? Z.ONE : Z.TWO) : (p.equals(Z.THREE) ? (e == 1 ? Z.ONE : p.pow(e)) : (p.equals(Z.SEVEN) ? Z.ZERO : Z.ONE))
# a(n) is M.w. a(2^e) = 1 if e!=1, a(3^e) = 1 if e<2, a(7^e) = 0^e, a(p^e) = 1 otherwise.

A251913	mul	0
# p.equals(Z.TWO) ? Z.ONE , a(13^e) = (((e & 1) == 0) ? 1 : -1), else Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(2^e) = 1, a(13^e) = (-1)^e, else a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.

A256678	mul	0
# p.equals(Z.TWO) ? Z.ONE, a(17^e) = (((e & 1) == 0) ? 1 : -1)
# a(n) is M.w. a(2^e) = 1, a(17^e) = (-1)^e. For p prime, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) and a(p) = p minus number of points of elliptic curve modulo p.

A138950	mul	0
# p.equals(Z.TWO) ? Z.ONE, a(3^e) = -1 + 2 * (((e & 1) == 0) ? 1 : -1), Z.valueOf(e+1 if p == 1, 5 (mod 12), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 7, 11 (mod 12)
# a(n) is M.w. a(2^e) = 1, a(3^e) = -1 + 2 * (-1)^e, a(p^e) = e+1 if p == 1, 5 (mod 12), a(p^e) = (1 + (-1)^e) / 2 if p == 7, 11 (mod 12).

A281785	mult	0
# p.equals(Z.TWO) ? Z.ONE : (p.equals(Z.THREE) ? Z.valueOf(-8) : p.pow(e+1).subtract(1).divide(p.subtract(1)))
# a(n) is M.w. a(2^e) = 1, a(3^e) = -8 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.

A279929	mult	0
# p.equals(Z.TWO) ? Z.ONE : (p.equals(Z.THREE) ? Z.ZERO : p.pow(e+1).subtract(1).divide(p.subtract(1)))
# a(n) is M.w. a(2^e) = 1, a(3^e) = 0^e, a(p^e) = (p^(e+1) - 1) / (p-1) if p>3.

A255648	mul	0
# p.equals(Z.TWO) ? Z.ONE, a(3^e) = 2 if e>1, Z.valueOf(e+1 if p == 1 (mod 6), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 5 (mod 6)
# a(n) is M.w. a(2^e) = 1, a(3^e) = 2 if e>1, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e) / 2 if p == 5 (mod 6).

A163746	mul	0
# p.equals(Z.TWO) ? Z.ONE, a(3^e) = 2-(((e & 1) == 0) ? 1 : -1), Z.valueOf(e+1 if p == 1 (mod 4), = (1-(((e & 1) == 0) ? 1 : -1))/2 if p == 3 (mod 4)
# a(n) is M.w. a(2^e) = 1, a(3^e) = 2-(-1)^e, a(p^e) = e+1 if p == 1 (mod 4), a(p^e) == (1-(-1)^e)/2 if p == 3 (mod 4).

A131944	mult	0
# p.equals(Z.TWO) ? Z.ONE : (p.equals(Z.THREE) ? Z.FOUR.subtract(Z.THREE.pow(e+1)) : p.pow(e+1).subtract(1).divide(p.subtract(1)))
# a(n) is M.w. a(2^e) = 1, a(3^e) = 4- 3^(e+1), a(p^e) = (p^(e+1) - 1) / (p-1) if p>3.

A117000	mul	0
# p.equals(Z.TWO) ? Z.ONE, p.pow(e+1).subtract(1).divide(p.subtract(1)) if p == 1, 7 (mod 8), ((-p)^(e+1) - 1).divide(-p - 1) if p == 3, 5 (mod 8)
# a(n) is M.w. a(2^e) = 1, a(p^e) = (p^(e+1).subtract(1) / (p - 1) if p == 1, 7 (mod 8), ((-p)^(e+1) - 1) / (-p - 1) if p == 3, 5 (mod 8). - _Michael Somos_, Aug 08 2007

A173763	mul	0
# p.equals(Z.TWO) ? Z.valoeOf(16).pow(e) : ??? Z.valueOf(a(p) * a(p.pow(e-1)) - p^9 * a(p.pow(e-2)) if p>2
# a(n) is M.w. a(2^e) = 16^e, a(p^e) = a(p) * a(p^(e-1)) - p^9 * a(p^(e-2)) if p>2.

A132001	mul	0
# p.equals(Z.TWO) ? Z.valueOf(2 + ((-4)^(e+1).subtract(1)/5, a(3^e) = 1, Z.valueOf((q^(e+1) - 1).divide(q - 1) where q = p^2 * Kronecker(-3, p) if p > 3
# a(n) is M.w. a(2^e) = 2 + ((-4)^(e+1) - 1)/5, a(3^e) = 1, a(p^e) = (q^(e+1) - 1) / (q - 1) where q = p^2 * Kronecker(-3, p) if p > 3.

A132004	mul	0
# p.equals(Z.TWO) ? Z.valueOf(2*0^e - 1, a(3^e) = 1, Z.valueOf(e + 1 if p == 1 (mod 4), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 3 (mod 4)
# a(n) is M.w. a(2^e) = 2*0^e - 1, a(3^e) = 1, a(p^e) = e + 1 if p == 1 (mod 4), a(p^e) = (1 + (-1)^e) / 2 if p == 3 (mod 4).

A163659	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).subtract(1) : (p.equals(Z.THREE) ? Z.valueOf(-2) : Z.ONE)
# a(n) is M.w. a(2^e) = 2^(e+1) - 1, a(3^e) = -2 if e>0, a(p^e) = 1 if p>3. - _Michael Somos_, Feb 14 2011

A131947	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).negate().add(3) : (p.equals(Z.THREE) ? Z.ONE : p.pow(e+1).subtract(1).divide(p.subtract(1)))
# a(n) is M.w. a(2^e) = 3 - 2^(e+1), a(3^e) = 1, a(p^e) = (p^(e+1) - 1) / (p-1) if p>3.

A204386	mult	0
# p.equals(Z.TWO) ? Z.EIGHT.pow(e).divide2().multiply(3) : (p.pow(3).pow(e+1).subtract(1).divide(p.pow(3).subtract(1)))
# a(n) is M.w. a(2^e) = 3/2 * 8^e if e>0, a(p^e) = ((p^3) ^ (e+1) - 1) / (p^3 - 1).

A133639	mult	0
# p.compareTo(Z.THREE) <= 0 ? Z.valueOf(e == 1 ? -1 : 0) : Z.valueOf(((e & 1) == 0) ? 1 : -1)
# a(n) is M.w. a(2^e) = a(3^e) = -1 if e=1, 0 if e>1, a(p^e) = (-1)^e if p > 3.

A186099	mult	0
# p.compareTo(Z.THREE) <= 0 ? Z.ONE : p.pow(e+1).subtract(1).divide(p.subtract(1))
# a(n) is M.w. a(2^e) = a(3^e) = 1, a(p^e) = (p^(e+1) - 1) / (p - 1) if p>3.

A163819	mul	0
# p.equals(Z.TWO) ? Z.valueOf(a(5^e) = (((e & 1) == 0) ? 1 : -1), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 3, 17, 21, 27, 29, 31, 33, 39 (mod 40), Z.valueOf(e+1 if p == 1, 9, 11, 19 (mod 40), Z.valueOf((((e & 1) == 0) ? 1 : -1) * (e+1) if p == 7, 13, 23, 37 (mod 40)
# a(n) is M.w. a(2^e) = a(5^e) = (-1)^e, a(p^e) = (1 + (-1)^e)/2 if p == 3, 17, 21, 27, 29, 31, 33, 39 (mod 40), a(p^e) = e+1 if p == 1, 9, 11, 19 (mod 40), a(p^e) = (-1)^e * (e+1) if p == 7, 13, 23, 37 (mod 40).

A260649	mul	0
# p.equals(Z.TWO) ? Z.valueOf(|e-1|, a(3^e) = a(5^e) = 1, Z.valueOf(e+1 if p == 1, 2, 4, 8 (mod 15), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1))/2 if p == 7, 11, 13, 14 (mod 15)
# a(n) is M.w. a(2^e) = |e-1|, a(3^e) = a(5^e) = 1, a(p^e) = e+1 if p == 1, 2, 4, 8 (mod 15), a(p^e) = (1 + (-1)^e)/2 if p == 7, 11, 13, 14 (mod 15).

A110399	mult	0
# p.equals(Z.TWO) ? Z.valueOf(e-1).abs() : (p.equals(Z.SEVEN) ? Z.ONE : (p.mod(Z.SEVEN).bitCount() == 1 ? Z.valueOf(e+1) : Z.valueOf((1+(((e & 1) == 0) ? 1 : -1))/2)))
# a(n) is M.w. a(2^e) = |e-1|, a(7^e)= 1, a(p^e) = e+1 if p == 1, 2, 4 (mod 7), a(p^e) = (1+(-1)^e)/2 if p == 3, 5, 6 (mod 7).

A226010	mul	0
# a(2^n) = (-64)^n, Z.valueOf(a(p) * a(p.pow(e-1)) - p^13 * a(p.pow(e-2)) if p>2
# a(n) is M.w. a(2^n) = (-64)^n, a(p^e) = a(p) * a(p^(e-1)) - p^13 * a(p^(e-2)) if p>2.

A226086	mul	0
# a(2^n) = 64^n, Z.valueOf(a(p) * a(p.pow(e-1)) - p^13 * a(p.pow(e-2)) if p>2
# a(n) is M.w. a(2^n) = 64^n, a(p^e) = a(p) * a(p^(e-1)) - p^13 * a(p^(e-2)) if p>2.

A229143	mult	0
# p.equals(Z.THREE) ? Z.valueOf(e == 1 ? -3 : 0) : (p.mod(Z.THREE).equals(Z.ONE) ? Z.valueOf(e+1) : Z.valueOf((1+(((e & 1) == 0) ? 1 : -1))/2))
# a(n) is M.w. a(3) = -3, a(3^e) = 0 if e>1, a(p^e) = e+1 if p == 1 (mod 3), a(p^e) = (1 + (-1)^e) / 2 if p == 2 (mod 3).

A136747	mul	0
# a(3^e) = (-27)^e, Z.valueOf(a(p) * a(p.pow(e-1)) - p^7 * a(p.pow(e-2)) unless p = 3
# a(n) is M.w. a(3^e) = (-27)^e, a(p^e) = a(p) * a(p^(e-1)) - p^7 * a(p^(e-2)) unless p = 3.

A115155	mul	0
# p.equals(Z.THREE) ? Z.THREE.negate().pow(e) : (p.equals(Z.FIVE) ? p.pow(e) : (....??? ))
# a(3^e) = (-3)^e, a(5^e) = 5^e, p^e if e even else 0 if p == 7, 11, 13, 14 (mod 15), Z.valueOf(a(p) * a(p.pow(e-1)) - p^2 * a(p.pow(e-2)) if p == 1, 2, 4, 8 (mod 15)
# a(n) is M.w. a(3^e) = (-3)^e, a(5^e) = 5^e, a(p^e) = p^e if e even else 0 if p == 7, 11, 13, 14 (mod 15), a(p^e) = a(p) * a(p^(e-1)) - p^2 * a(p^(e-2)) if p == 1, 2, 4, 8 (mod 15).

A113262	mult	0
# p.equals(Z.TWO) ? Z.ONE.shiftLeft(e+1).subtract(3) : (p.equals(Z.THREE) ? Z.ONE : p.pow(e+1).subtract(1).divide(p.subtract(1)))
# a(n) is M.w. a(3^e) = 1, a(2^e) = 2^(e+1) - 3, a(p^e) = (p^(e+1) - 1) / (p - 1) if p > 3.

A187846	mul	0
# a(3^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity
# a(n) is M.w. a(3^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) where a(p) = p+1 minus number of points of elliptic curve modulo p including point at infinity.

A103440	mul	0
# a(3^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - z * a(p.pow(e-2)) where z = Kronecker(-3, p) * p^2 : a(p) = z + 1
# a(n) is M.w. a(3^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - z * a(p^(e-2)) where z = Kronecker(-3, p) * p^2 and a(p) = z + 1.

A136549	mul	0
# a(3^e) = 3^e, a(5^e) = (-5)^e, p^e * (1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 7, 11, 13, 14 (mod 15), Z.valueOf(a(p) * a(p.pow(e-1)) - p^2 * a(p.pow(e-2)) if p == 1, 2, 4, 8 (mod 15)
# a(n) is M.w. a(3^e) = 3^e, a(5^e) = (-5)^e, a(p^e) = p^e * (1 + (-1)^e) / 2 if p == 7, 11, 13, 14 (mod 15), a(p^e) = a(p) * a(p^(e-1)) - p^2 * a(p^(e-2)) if p == 1, 2, 4, 8 (mod 15).

A116607	mult	0
# p.equals(Z.THREE) ? Z.FOUR : p.pow(e+1).subtract(1).divide(p.subtract(1))
# a(n) is M.w. a(3^e) = 4 if e>0, a(p^e) = (p^(e+1) - 1) / (p - 1) otherwise.

A332332	mul	0
# a(3^n) = (-1)^n, a(11^n) = 1
# a(n) is M.w. a(3^n) = (-1)^n, a(11^n) = 1. a(2^n) = A107920(n+1). a(7^n) = A168175(n).

A115672	mul	0
# a(5^e) = (((e & 1) == 0) ? 1 : -1), a(7^e) = 1, Z.valueOf(a(p) * a(p.pow(e-1)) - p * a(p.pow(e-2))
# a(n) is M.w. a(5^e) = (-1)^e, a(7^e) = 1, a(p^e) = a(p) * a(p^(e-1)) - p * a(p^(e-2)) otherwise.

A116073	mult	0
# p.equals(Z.FIVE) ? Z.ONE : p.pow(e+1).subtract(1).divide(p.subtract(1))
# a(n) is M.w. a(5^e) = 1, a(p^e) = (p^(e+1)-1)/(p-1) otherwise.

A129666	mul	0
# a(7^e) = (-7)^e, Z.valueOf(a(p) * a(p.pow(e-1)) - p^3 * a(p.pow(e-2))
# a(n) is M.w. a(7^e) = (-7)^e, a(p^e) = a(p) * a(p^(e-1)) - p^3 * a(p^(e-2)).

A114810	mul	0
# a(p)=phi(p), phi(p^e)-phi(p.pow(e-1)) : phi(n)=A000010(n)
# a(n) is M.w. a(p)=phi(p), a(p^k)=phi(p^k)-phi(p^(k-1)) and phi(n)=A000010(n).

A266288	mult	0
# { final int m = p.mod(Z.THREE).intValue(); final int s = (m == 0 ? 0 : (m == 1 ? 1 : -1)); return p.pow(4).pow(e+1).subtract(Z.valueOf(s).pow(e+1)).divide(p.pow(4).subtract(Z.valueOf(s))); }
# a(n) is M.w. a(p^e) = ((p^4)^(e+1) - s^(e+1)) / (p^4 - s) where s = 0 if p = 3, s = 1 if p == 1 (mod 3), s = -1 if p == 2 (mod 3).

A245485	mult	0
# p.equals(Z.SEVEN) ? Z.valueOf(((e & 1) == 0) ? 1 : -1) : Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2)
# a(n) is M.w. a(p^e) = (-1)^e if p = 7, a(p^e) = (1 + (-1)^e) / 2 otherwise.

A248003	mult	0
# p.subtract(1).multiply(p.pow(2*e-1)).divide2()
# a(n) is M.w. a(p^e) = (p-1)*p^(2e-1)/2.

A140782	mul	0
# p.pow(e+1).subtract(1).divide(p.subtract(1)) * Kronecker(13, p)^e
# a(n) is M.w. a(p^e) = (p^(e+1) - 1) / (p - 1) * Kronecker(13, p)^e.

A255647	mul	0
# Z.ONE if p = 2 or 11, Z.valueOf(e + 1 if Kronecker(-22, p) = +1, Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1))/2 if Kronecker(-22, p) = -1, : with a(0) = 1
# a(n) is M.w. a(p^e) = 1 if p = 2 or 11, a(p^e) = e + 1 if Kronecker(-22, p) = +1, a(p^e) = (1 + (-1)^e)/2 if Kronecker(-22, p) = -1, and with a(0) = 1.

A113063	mul	0
# Z.valueOf(2 if p = 3 : e>0, Z.valueOf(e+1 if p == 1 (mod 6), Z.valueOf((1 + (((e & 1) == 0) ? 1 : -1)) / 2 if p == 2, 5 (mod 6)
# a(n) is M.w. a(p^e) = 2 if p = 3 and e>0, a(p^e) = e+1 if p == 1 (mod 6), a(p^e) = (1 + (-1)^e) / 2 if p == 2, 5 (mod 6).

A226347	mul	0
# p.equals(Z.FIVE) ? p.pow(2*e) : ??? a(p) * a(p.pow(e-1)) - p^6 * a(p.pow(e-2))
# a(n) is M.w. a(p^e) = p^(2*e) if p=5, else a(p^e) = a(p) * a(p^(e-1)) - p^6 * a(p^(e-2)).

A226333	mul	0
# p.pow(3*e) if p=5, else p.pow(3*(e+1)).subtract(1).divide(p^3 - 1)
# a(n) is M.w. a(p^e) = p^(3*e) if p=5, else a(p^e) = (p^(3*(e+1)) - 1) / (p^3 - 1).

A099991	mul	0
# b(2^e) = 0, b(p) = -1 if p >= 3, 0
# b(n) = -a(n) is M.w. b(2^e) = 0, b(p) = -1 if p >= 3, 0 otherwise. - _David W. Wilson_, Jun 12 2005

A100008	mul	0
# b(2^e) = 1, b(p^e) = 2
# b(n) = a(n)/a(1) is M.w. b(2^e) = 1, b(p^e) = 2 otherwise. - _David W. Wilson_, Jun 12 2005

