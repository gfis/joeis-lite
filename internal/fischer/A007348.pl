#!perl
# 2021-05-13, Georg Fischer
use strict;
use integer;

while (<DATA>) {
    next if ! m{\AA\d};
    s/\s+\Z//;
    my ($aseqno, $superclass, $name, $numlist) = split(/\t/);
    my @numbers = split(/\,/, $numlist);
    print join("\t", $aseqno, "parm2", 0, "A007348", $numbers[0], $name) . "\n";
} # while
__DATA__
A007348	Sequence	Primes for which -(\d+) is a primitive root	10
A105874	ZZ      	Primes for which -(\d+) is a primitive root	2
A105875	ZZ      	Primes for which -(\d+) is a primitive root	3
A105876	ZZ      	Primes for which -(\d+) is a primitive root	4
A105877	ZZ      	Primes for which -(\d+) is a primitive root	5
A105878	ZZ      	Primes for which -(\d+) is a primitive root	6
A105879	ZZ      	Primes for which -(\d+) is a primitive root	7
A105880	ZZ      	Primes for which -(\d+) is a primitive root	8
A105881	ZZ      	Primes for which -(\d+) is a primitive root	9
A105883	ZZ      	Primes for which -(\d+) is a primitive root	11
A105884	ZZ      	Primes for which -(\d+) is a primitive root	12
A105885	ZZ      	Primes for which -(\d+) is a primitive root	13
A105886	ZZ      	Primes for which -(\d+) is a primitive root	14
A105887	ZZ      	Primes for which -(\d+) is a primitive root	15
A105889	ZZ      	Primes for which -(\d+) is a primitive root	17
A105890	ZZ      	Primes for which -(\d+) is a primitive root	18
A105891	ZZ      	Primes for which -(\d+) is a primitive root	19
A105892	ZZ      	Primes for which -(\d+) is a primitive root	20
A105893	ZZ      	Primes for which -(\d+) is a primitive root	21
A105894	ZZ      	Primes for which -(\d+) is a primitive root	22
A105895	ZZ      	Primes for which -(\d+) is a primitive root	23
A105896	ZZ      	Primes for which -(\d+) is a primitive root	24
A105897	ZZ      	Primes for which -(\d+) is a primitive root	25
A105898	ZZ      	Primes for which -(\d+) is a primitive root	26
A105900	ZZ      	Primes for which -(\d+) is a primitive root	28
A105901	ZZ      	Primes for which -(\d+) is a primitive root	29
A105902	ZZ      	Primes for which -(\d+) is a primitive root	30
A105903	ZZ      	Primes for which -(\d+) is a primitive root	31
A105904	ZZ      	Primes for which -(\d+) is a primitive root	32
A105905	ZZ      	Primes for which -(\d+) is a primitive root	33
A105906	ZZ      	Primes for which -(\d+) is a primitive root	34
A105907	ZZ      	Primes for which -(\d+) is a primitive root	35
A105908	ZZ      	Primes for which -(\d+) is a primitive root	36
A105909	ZZ      	Primes for which -(\d+) is a primitive root	37
A105910	ZZ      	Primes for which -(\d+) is a primitive root	38
A105911	ZZ      	Primes for which -(\d+) is a primitive root	39
A105912	ZZ      	Primes for which -(\d+) is a primitive root	40
A105913	ZZ      	Primes for which -(\d+) is a primitive root	41
A105914	ZZ      	Primes for which -(\d+) is a primitive root	42
