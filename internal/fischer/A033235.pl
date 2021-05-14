#!perl
# 2021-05-13, Georg Fischer
use strict;
use integer;

while (<DATA>) {
    next if ! m{\AA\d};
    my ($aseqno, $superclass, $name, $numlist) = split(/\t/);
    my @numbers = split(/\,/, $numlist);
    print join("\t", $aseqno, "parm2", 0, "A033235", $numbers[1], $name) . "\n";
} # while
__DATA__
A033201	A000040 	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,10,2
A033235	A000040 	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,55,2
A107008	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,24,2
A139644	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,105,2
A139645	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,112,2
A139646	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,130,2
A139647	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,133,2
A139648	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,165,2
A139649	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,177,2
A139650	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,190,2
A139651	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,210,2
A139652	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,232,2
A139653	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,253,2
A139655	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,280,2
A139656	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,312,2
A139657	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,330,2
A139658	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,345,2
A139659	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,357,2
A139660	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,385,2
A139661	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,408,2
A139662	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,462,2
A139663	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,520,2
A139664	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,760,2
A139665	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,840,2
A139666	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,1320,2
A139667	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,1365,2
A139668	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,1848,2
A173274	ZZ      	Primes of the form x^(\d+)+ (\d+)*y^(\d+)	2,18480,2
---- joeis:  1 nyi:    23
A014752	Sequence	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,27,2
A106950	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,18,2
A107142	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,36,2
A107145	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,40,2
A107150	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,44,2
A107152	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,45,2
A107155	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,49,2
A107157	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,50,2
A107160	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,52,2
A107162	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,54,2
A107164	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,56,2
A107176	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,68,2
A107184	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,75,2
A107186	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,76,2
A107192	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,80,2
A107193	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,81,2
A107198	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,84,2
A107202	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,88,2
A107206	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,90,2
A107209	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,92,2
A107213	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,96,2
A107215	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,98,2
A107217	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,99,2
A107219	ZZ      	Primes of the form x^(\d+)+ (\d+)y^(\d+)	2,100,2
