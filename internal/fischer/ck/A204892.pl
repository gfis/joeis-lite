#!perl

# A204892.pl: evaluate guide in A204892
# @(#) $Id$
# 2022-05-01, Georg Fischer
#
#:# Usage:
#:#   perl A204892.pl > output.seq4
#:#       (generate from internal DATA section)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $callcode = "parm4";
my $offset   = 1;
my $qseqno   = "A204892";
my $rseqno; # underlying sequence
my $variant;
my $dist;
my ($a1, $a2);

while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if (0) {
    } elsif ($line =~ m{\A(\d+)\s+(.*)}) {
        ($dist, $rseqno) = ($1, $2);
    } elsif ($line =~ m{\A\W+k\(n\)[^\:]+\:\s*(A\d+)(\([^\)*]\))*\,\s*(A\d+)}) {
        ($a1, $a2) = ($1, $3);
        &output($a1, 1);
        &output($a2, 2);
    } elsif ($line =~ m{\A\W+s\(k\(n\)\)\,[^\:]+\:\s*(A\d+)(\([^\)*]\))*\,\s*(A\d+)}) {
        ($a1, $a2) = ($1, $3);
        &output($a1, 3);
        &output($a2, 4);
    } elsif ($line =~ m{\A\W+s\(k\(n\)\)\-[^\:]+\:\s*(A\d+)(\([^\)*]\))*\,\s*(A\d+)}) {
        ($a1, $a2) = ($1, $3);
        &output($a1, 5);
        &output($a2, 6);
    } elsif ($line =~ m{\As\(n\)\=}) {
        # ignore leading line
    }
} # while
my $dummy = <<'GFis';
A204892	parm4	1	A204892	new A000040()	1	1	name
A204893	parm4	1	A204892	new A000040()	1	2	name
A204894	parm4	1	A204892	new A000040()	1	3	name
A204895	parm4	1	A204892	new A000040()	1	4	name
A204896	parm4	1	A204892	new A000040()	1	5	name
A204897	parm4	1	A204892	new A000040()	1	6	name
GFis
#----
sub output {
    my ($aseqno, $var) = @_;
    print join("\t", $aseqno, $callcode, $offset, $qseqno, $rseqno, $dist, $var) . "\n";
}
#----
__DATA__
s(n)=prime(n), primes	
1 new A000040()
... k(n), j(n): A204892, A204893
... s(k(n)),s(j(n)): A204894, A204895
... s(k(n))-s(j(n)): A204896, A204897
s(n)=prime(n+1), odd primes
0 new A000040()
... k(n), j(n): A204900, A204901
... s(k(n)),s(j(n)): A204902, A204903
... s(k(n))-s(j(n)): A109043(?), A000034(?)
s(n)=prime(n+2), primes >=5
0 new SkipSequence(new A000040(), 1)
... k(n), j(n): A204908, A204909
... s(k(n)),s(j(n)): A204910, A204911
... s(k(n))-s(j(n)): A109043(?), A000034(?)
s(n)=p(n)*p(n+1) product of consecutive primes
1 new A006094()
... k(n), j(n): A205146, A205147
... s(k(n)),s(j(n)): A205148, A205149
... s(k(n))-s(j(n)): A205150, A205151
s(n)=(p(n+1)+p(n+2)/2: averages of odd primes
1 new A024675()
... k(n), j(n): A205153, A205154
... s(k(n)),s(j(n)): A205372, A205373
... s(k(n))-s(j(n)): A205374, A205375
s(n)=2^(n-1), powers of 2
1 new A000079()
... k(n), j(n): A204979, A001511(?)
... s(k(n)),s(j(n)): A204981, A006519(?)
... s(k(n))-s(j(n)): A204983(?), A204984
s(n)=2^n, powers of 2
0 new A000079()
... k(n), j(n): A204987, A204988
... s(k(n)),s(j(n)): A204989, A140670(?)
... s(k(n))-s(j(n)): A204991, A204992
s(n)=C(n+1,2), triangular numbers
0 new A000217()
... k(n), j(n): A205002, A205003
... s(k(n)),s(j(n)): A205004, A205005
... s(k(n))-s(j(n)): A205006, A205007
s(n)=n^2, squares
0 new A000290()
... k(n), j(n): A204905, A204995
... s(k(n)),s(j(n)): A204996, A204997
... s(k(n))-s(j(n)): A204998, A204999
s(n)=(2n-1)^2, odd squares
1 new A016754()
... k(n), j(n): A205378, A205379
... s(k(n)),s(j(n)): A205380, A205381
... s(k(n))-s(j(n)): A205382, A205383
s(n)=n(3n-1), pentagonal numbers
0 new A000326()
... k(n), j(n): A205138, A205139
... s(k(n)),s(j(n)): A205140, A205141
... s(k(n))-s(j(n)): A205142, A205143
s(n)=n(2n-1), hexagonal numbers
0 new A000384()
... k(n), j(n): A205130, A205131
... s(k(n)),s(j(n)): A205132, A205133
... s(k(n))-s(j(n)): A205134, A205135
s(n)=C(2n-2,n-1), central binomial coefficients
1 new A000984()
... k(n), j(n): A205010, A205011
... s(k(n)),s(j(n)): A205012, A205013
... s(k(n))-s(j(n)): A205014, A205015
s(n)=(1/2)C(2n,n), (1/2)*(central binomial coefficients)
1 new A001700()
... k(n), j(n): A205386, A205387
... s(k(n)),s(j(n)): A205388, A205389
... s(k(n))-s(j(n)): A205390, A205391
s(n)=n(n+1), oblong 
0 new A002378()
... k(n), j(n): A205018, A205028
... s(k(n)),s(j(n)): A205029, A205030
... s(k(n))-s(j(n)): A205031, A205032
s(n)=n!, factorials
0 new A000142()
... k(n), j(n): A204932, A204933
... s(k(n)),s(j(n)): A204934, A204935
... s(k(n))-s(j(n)): A204936, A204937
s(n)=n!!, double factorials
0 new A006882()
... k(n), j(n): A204982, A205100
... s(k(n)),s(j(n)): A205101, A205102
... s(k(n))-s(j(n)): A205103, A205104
s(n)=3^n-2^n
0 new A001047()
... k(n), j(n): A205000, A205107
... s(k(n)),s(j(n)): A205108, A205109
... s(k(n))-s(j(n)): A205110, A205111
s(n)=Fibonacci(n+1)
0 new SkipSequence(new A000045(), 1)
... k(n), j(n): A204924, A204925
... s(k(n)),s(j(n)): A204926, A204927
... s(k(n))-s(j(n)): A204928, A204929
s(n)=Fibonacci(2n-1)
0 new A001519()
... k(n), j(n): A205442, A205443
... s(k(n)),s(j(n)): A205444, A205445
... s(k(n))-s(j(n)): A205446, A205447
s(n)=Fibonacci(2n)
0 new A001906()
... k(n), j(n): A205450, A205451
... s(k(n)),s(j(n)): A205452, A205453
... s(k(n))-s(j(n)): A205454, A205455
s(n)=Lucas(n)
0 new A000032()
... k(n), j(n): A205114, A205115
... s(k(n)),s(j(n)): A205116, A205117
... s(k(n))-s(j(n)): A205118, A205119
s(n)=n*(2^(n-1))
0 new A001787()
... k(n), j(n): A205122, A205123
... s(k(n)),s(j(n)): A205124, A205125
... s(k(n))-s(j(n)): A205126, A205127
s(n)=ceiling[n^2/2]
0 new A000982()
... k(n), j(n): A205394, A205395
... s(k(n)),s(j(n)): A205396, A205397
... s(k(n))-s(j(n)): A205398, A205399
s(n)=floor[(n+1)^2/2]
0 new SkipSequence(new A002620(), 1)
... k(n), j(n): A205402, A205403
... s(k(n)),s(j(n)): A205404, A205405
... s(k(n))-s(j(n)): A205406, A205407
