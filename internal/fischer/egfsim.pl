#!perl
__DATA__
A009321	egfsi	0	RING.log1p(RING.multiply(RING.log1p(RING.x(), mN), RING.exp(RING.x(), mN), mN), mN)	log(1 + log(1+x)*exp(x)).
A081443	egfsi	0	RING.multiply(RING.exp(RING.x(), mN), RING.cosh(RING.sinh(RING.x(), mN), mN), mN)	exp(x)*cosh(sinh(x))
A081444	egfsi	0	RING.multiply(RING.exp(RING.monomial(new Q(2), 1), mN), RING.cosh(RING.sinh(RING.x(), mN), mN), mN)	exp(2*x)*cosh(sinh(x))
A060905	egfsi	0	RING.exp(RING.add(RING.multiply(RING.x(), RING.exp(RING.x(), mN), mN), RING.multiply(RING.monomial(new Q(1, 2), 2), RING.pow(RING.exp(RING.x(), mN), 2, mN), mN)), mN)	exp(x*exp(x)+1/2*x^2*exp(x)^2)
A060906	egfsi	0	RING.exp(RING.add(RING.multiply(RING.x(), RING.exp(RING.x(), mN), mN), RING.multiply(RING.monomial(new Q(1, 3), 3), RING.pow(RING.exp(RING.x(), mN), 3, mN), mN)), mN)	exp(x*exp(x)+1/3*x^3*exp(x)^3)
A215347	egfsi	0	RING.exp(RING.multiply(RING.log(RING.cos(RING.x(), mN),  mN), RING.x(), mN), mN)	cos(x)^x                                       
A215519	egfsi	0	RING.exp(RING.multiply(RING.log(RING.cosh(RING.x(), mN), mN),  RING.sinh(RING.x(), mN), mN), mN)	cosh(x)^sinh(x)
A215583	egfsi	0	RING.exp(RING.multiply(RING.log(RING.cosh(RING.x(), mN), mN),  RING.sin(RING.x(), mN), mN), mN)	cosh(x)^sin(x)
A215586	egfsi	0	RING.exp(RING.multiply(RING.log(RING.cos(RING.x(), mN),  mN), RING.tan(RING.x(), mN), mN), mN)	cos(x)^tan(x)
A215588	egfsi	0	RING.exp(RING.multiply(RING.log(RING.cosh(RING.x(), mN), mN),  RING.tanh(RING.x(), mN), mN), mN)	cosh(x)^tanh(x)
A215678	egfsi	0	RING.exp(RING.multiply(RING.log(RING.sec(RING.x(), mN),  mN), RING.sinh(RING.x(), mN), mN), mN)	sec(x)^sinh(x)
A215679	egfsi	0	RING.exp(RING.multiply(RING.log(RING.sech(RING.x(), mN), mN),  RING.sinh(RING.x(), mN), mN), mN)	sech(x)^sinh(x)
A215680	egfsi	0	RING.exp(RING.multiply(RING.log(RING.sec(RING.x(), mN),  mN), RING.tan(RING.x(), mN), mN), mN)	sec(x)^tan(x)
A215681	egfsi	0	RING.exp(RING.multiply(RING.log(RING.sech(RING.x(), mN), mN),  RING.tan(RING.x(), mN), mN), mN)	sech(x)^tan(x)
A215682	egfsi	0	RING.exp(RING.multiply(RING.log(RING.sec(RING.x(), mN),  mN), RING.tanh(RING.x(), mN), mN), mN)	sec(x)^tanh(x)
A215683	egfsi	0	RING.exp(RING.multiply(RING.log(RING.sech(RING.x(), mN), mN),  RING.tanh(RING.x(), mN), mN), mN)	sech(x)^tanh(x)

A337038	egfsi	0	RING.exp(RING.subtract(RING.divide(RING.subtract(RING.exp(RING.monomial(new Q(2, 1), 1), mN), RING.one()), new Q(2, 1)), RING.x()), mN)	exp((exp(2*x)-1)/2-x)
A337039	egfsi	0	RING.exp(RING.subtract(RING.divide(RING.subtract(RING.exp(RING.monomial(new Q(3, 1), 1), mN), RING.one()), new Q(3, 1)), RING.x()), mN)	exp((exp(3*x)-1)/3-x)
A337040	egfsi	0	RING.exp(RING.subtract(RING.divide(RING.subtract(RING.exp(RING.monomial(new Q(4, 1), 1), mN), RING.one()), new Q(4, 1)), RING.x()), mN)	exp((exp(4*x)-1)/4-x)
A337041	egfsi	0	RING.exp(RING.subtract(RING.divide(RING.subtract(RING.exp(RING.monomial(new Q(5, 1), 1), mN), RING.one()), new Q(5, 1)), RING.x()), mN)	exp((exp(5*x)-1)/5-x)
A337042	egfsi	0	RING.exp(RING.subtract(RING.divide(RING.subtract(RING.exp(RING.monomial(new Q(6, 1), 1), mN), RING.one()), new Q(6, 1)), RING.x()), mN)	exp((exp(6*x)-1)/6-x)

A337749	egfsi	0	RING.series(RING.exp(RING.x(), mN), RING.onePlusXToTheN(2))	exp(x)/(1+x^2)
A337750	egfsi	0	RING.series(RING.exp(RING.x(), mN), RING.onePlusXToTheN(3))	exp(x)/(1+x^3)
A337751	egfsi	0	RING.series(RING.exp(RING.x(), mN), RING.onePlusXToTheN(4))	exp(x)/(1+x^4)

# A215522	egfsi	0	RING.exp(x+1)^((x+1)^(x+2))	(x+1)^((x+1)^(x+2))
# A215524	egfsi	0	RING.exp((x+1)^(x+1))^(x+1)	((x+1)^(x+1))^(x+1)
# A215643	egfsi	0	RING.exp(x+1)^(((x+1)^((x+1)^(x+1)))^(x+1))	(x+1)^(((x+1)^((x+1)^(x+1)))^(x+1))

A227544	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.sin (RING.monomial(new Q(6), 1), mN)), mN), RING.monomial(new Q(6), 0), mN), mN), mN)	1/(1-sin (6*x))^(1/6)
A230114	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.sin (RING.monomial(new Q(8), 1), mN)), mN), RING.monomial(new Q(8), 0), mN), mN), mN)	1/(1-sin (8*x))^(1/8)
A230134	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.sin (RING.monomial(new Q(5), 1), mN)), mN), RING.monomial(new Q(5), 0), mN), mN), mN)	1/(1-sin (5*x))^(1/5)
A235128	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.sin (RING.monomial(new Q(7), 1), mN)), mN), RING.monomial(new Q(7), 0), mN), mN), mN)	1/(1-sin (7*x))^(1/7)
A235131	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.tan (RING.monomial(new Q(2), 1), mN)), mN), RING.monomial(new Q(2), 0), mN), mN), mN)	1/(1-tan (2*x))^(1/2)
A235132	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.tan (RING.monomial(new Q(3), 1), mN)), mN), RING.monomial(new Q(3), 0), mN), mN), mN)	1/(1-tan (3*x))^(1/3)
A235134	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.sinh(RING.monomial(new Q(2), 1), mN)), mN), RING.monomial(new Q(2), 0), mN), mN), mN)	1/(1-sinh(2*x))^(1/2)
A235135	egfsi	0	RING.series(RING.one(), RING.exp(RING.series(RING.log(RING.subtract(RING.one(), RING.sinh(RING.monomial(new Q(3), 1), mN)), mN), RING.monomial(new Q(3), 0), mN), mN), mN)	1/(1-sinh(3*x))^(1/3)
A238464	egfsi	0	RING.series(RING.one(), RING.subtract(RING.monomial(new Q(8), 0), RING.multiply(RING.monomial(new Q(7), 0), RING.exp(RING.x(), mN), mN)), mN)	1/(8-7*exp(x))
A238465	egfsi	0	RING.series(RING.one(), RING.subtract(RING.monomial(new Q(9), 0), RING.multiply(RING.monomial(new Q(8), 0), RING.exp(RING.x(), mN), mN)), mN)	1/(9-8*exp(x))
A238466	egfsi	0	RING.series(RING.one(), RING.subtract(RING.monomial(new Q(10), 0), RING.multiply(RING.monomial(new Q(9), 0), RING.exp(RING.x(), mN), mN)), mN)	1/(10-9*exp(x))
A238467	egfsi	0	RING.series(RING.one(), RING.subtract(RING.monomial(new Q(11), 0), RING.multiply(RING.monomial(new Q(10), 0), RING.exp(RING.x(), mN), mN)), mN)	1/(11-10*exp(x))
A213129	egfsi	0	RING.series(RING.monomial(new Q(7), 0), RING.add(RING.monomial(new Q(6), 0), RING.exp(RING.monomial(new Q(7), 1), mN)), mN)	7/(6+exp(7*x))
A213131	egfsi	0	RING.series(RING.monomial(new Q(9), 0), RING.add(RING.monomial(new Q(8), 0), RING.exp(RING.monomial(new Q(9), 1), mN)), mN)	9/(8+exp(9*x))
A213132	egfsi	0	RING.series(RING.monomial(new Q(10), 0), RING.add(RING.monomial(new Q(9), 0), RING.exp(RING.monomial(new Q(10), 1), mN)), mN)	10/(9+exp(10*x))

A117437	egfsi	0	RING.multiply(RING.exp(RING.x(), mN), RING.sec(RING.monomial(Q.TWO, 1), mN), mN)	exp(x)*sec(2*x) 
A117443	egfsi	0	RING.series(RING.exp(RING.x(), mN), RING.add(RING.cos(RING.x(), mN), RING.sin(RING.x(), mN)), mN)	exp(x)/(cos(x)+sin(x))
A119880	egfsi	0	RING.multiply(RING.exp(RING.monomial(Q.TWO, 1), mN), RING.sech(RING.x(), mN) , mN)	exp(2x)*sech(x) 
A119881	egfsi	0	RING.multiply(RING.exp(RING.monomial(Q.THREE, 1), mN), RING.sech(RING.x(), mN) , mN)	exp(3*x)*sech(x) 
A119882	egfsi	0	RING.multiply(RING.onePlusXToTheN(1), RING.sech(RING.x(), mN), mN)	(1+x)*sech(x) 
A119884	egfsi	0	RING.series(RING.sech(RING.x(), mN), RING.oneMinusXToTheN(1), mN)	sech(x)/(1-x) 
A122045	egfsi	0	RING.sech(RING.x(), mN)	sech(x)

A108124	egfsi	0	RING.series(RING.x(), RING.add(RING.one(), RING.sin(RING.x(), mN)), mN)	x/(1+sin(x)) 
A108124	egfsi	0	RING.series(RING.x(), RING.add(RING.one(), RING.sin(RING.x(), mN)), mN)	x/(1+sin(x)) 
A109570	egfsi	0	RING.series(RING.x(), RING.subtract(RING.one(), RING.sinh(RING.x(), mN)), mN)	x/(1-sinh(x))
A109570	egfsi	0	RING.series(RING.x(), RING.subtract(RING.one(), RING.sinh(RING.x(), mN)), mN)	x/(1-sinh(x))
A109572	egfsi	0	RING.series(RING.x(), RING.subtract(RING.one(), RING.tan(RING.x(), mN)), mN)	x/[1-tan(x)] 

A052882	egfsi	0	RING.series(RING.x(), RING.subtract(RING.monomial(new Q(2), 0), RING.exp(RING.x(), mN)), mN)	x/(2-exp(x))
