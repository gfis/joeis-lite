#!perl
# 2021-05-13, Georg Fischer
use strict;
use integer;

my $rseqno = "";
while (<DATA>) {
    next if ! m{\AA\d};
    s/\s+\Z//;
    my ($aseqno, $superclass, $name, $numlist) = split(/\t/);
    if ($rseqno eq "") {
        $rseqno = $aseqno;
    }
    my @numbers = split(/\,/, $numlist);
    print join("\t", $aseqno, "parm2", 0, $rseqno, $numbers[0], $name) . "\n";
} # while
__DATA__
A033633	A000040 	Primes modulo (\d+)	19
A039715	A000040 	Primes modulo (\d+)	17
A095959	ZZ      	Primes modulo (\d+)	30
A229786	ZZ      	Primes modulo (\d+)	23
A229787	ZZ      	Primes modulo (\d+)	24
A242119	ZZ      	Primes modulo (\d+)	18
A242120	ZZ      	Primes modulo (\d+)	20
A242121	ZZ      	Primes modulo (\d+)	21
A242122	ZZ      	Primes modulo (\d+)	22
A242123	ZZ      	Primes modulo (\d+)	25
A242124	ZZ      	Primes modulo (\d+)	26
A242125	ZZ      	Primes modulo (\d+)	27
A242126	ZZ      	Primes modulo (\d+)	28
A242127	ZZ      	Primes modulo (\d+)	29
