#!perl
# from https://oeis.org/wiki/Index_to_OEIS:_Section_Con#constant
# 2020-03-06, Georg Fischer

use strict;
use integer;

my @aseqs = ();
while (<DATA>) {
	push(@aseqs, m{(A\d\d\d\d+)}g);
}
map {
	print join("\t", $_, "evconst", 0) . "\n"; 
} sort(@aseqs);

__DATA__
eventually 0: A000007 (0^n: 1,0,0,...), A063524 (0,1,0,0,...), A159075 (0,-1,0,0,...), A020761 (1/2 = .5000...), A003245, A008461, ...
(includes the characteristic function of any finite set: A000007: {0}, A063524: {1}, A178333: mountain numbers {1, 121, 131, ..., 12...9...21}, ...)
eventually +-1: A057427 (sgn(n): 0, 1, 1,...), A057428 (sgn(-n): 0, -1, -1,...), A060576 (1,0,1,1,1...), A157928 (0,0,1,1,...)
(includes the characteristic function of any co-finite set, as, e.g., the 1st, 3rd and 4th example above, which equal 1 - the characteristic function of the finite sets {0}, {1}, {0,1}.)
of the form (a,2a,2a,2a,...) = continued fraction of sqrt(a²+1): A040000 (a=1), A040002 (a=2), A040006 (a=3), A040012 (a=4), A040020 (a=5), A040030, A040042, A040056, A040072, A040090, A040110 (contfrac(122) = (11,22,22,...)), A040132, A040156, A040182, A040210, A040240, A040272, A040306, A040342, A040380, A040420 (contfrac(sqrt(442)) = (21,42,42,...)), A040462, A040506, A040552, A040600, A040650, A040702, A040756, A040812, A040870, A040930 (contfrac(sqrt(962)) = (31,62,62,...)),
A021040 (0,2,7,7,...), A035613 (7 in base n), A255910 (16/9 = 1.77777),
A036058 (describe previous term: 0,10,1110,...), A056064 (1,2,...,39,39,...), A060296, A063524, A100401, A100476, A101101 (1,5,6,6,...), A101104 (1,12,23,24,24...), A108692, A112667, A113311, A115291, A122553, A123932, A128999, A129810 (9^9^9 mod n), A130130, A130779, A134824, A137261, A141044, A153881, A159075, A171386, A171418, A171440, A171441, A171442, A171443, A177022, A181402, A181404, A185437, A186684, A189071, A214128 (6^6^6 mod n), A244328, A255176, A260196, A261012, A267884, A278105, A291092