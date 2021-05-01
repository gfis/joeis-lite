#!perl
# 2021-04-26, Georg Fischer
use strict;
use integer;

while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    next if $line !~ m{\AA\d+\t};
    my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    my $callcode = "num1dig";
    $name =~ m{Number of (\d+)\'s in base (\d+) +representation of ([^\.]+)};
    my ($digit, $base, $formula) = ($1, $2, $3);
    if (0) {
    } elsif ($formula =~ m{(A\d+)}) {
        $formula = $1;
        $callcode = "num1dis";
    } elsif ($formula =~ m{\A2\^n}) {
        $formula = "Z.ONE.shiftLeft(mN)" . (($formula =~ m{\-1\Z}) ? ".subtract(Z.ONE)" : "");
    } elsif ($formula =~ m{\A(\d+)\^n\Z}) {
        $formula = "Z.valueOf($1).pow(mN)";
    } elsif ($formula =~ m{\An\Z}) {
        $formula = "Z.valueOf(mN)";
    } elsif ($formula =~ m{\An\^2\Z}) {
        $formula = "Z.valueOf(mN).square()";
    } elsif ($formula =~ m{\An\^(\d+)\Z}) {
        $formula = "Z.valueOf(mN).pow($1)";
    } elsif ($formula =~ m{\An\^n\Z}) {
        $formula = "Z.valueOf(mN).pow(mN)";
    } elsif ($formula =~ m{\A(\d+)n}) {
        $formula = "Z.valueOf(mN).multiply($1)" . (($formula =~ m{\+(\d)\Z}) ? ".add($1)" : "");;
    }
    print join("\t", $aseqno, $callcode, 0, $digit, $base, $formula) . "\n";
} # while <DATA>
__DATA__
A046818	null	Number of 1's in base 2  representation of 3n+1.    nonn,base,changed,  0..10000    nyi
A046819	null	Number of 1's in base 2  representation of 3n+2.    nonn,changed,synth  0..92   nyi
A046820	null	Number of 1's in base 2  representation of 5n.  nonn,base,  0..10000    nyi
A046821	null	Number of 1's in base 2  representation of 5n+1.    nonn,changed,synth  0..92   nyi
A046822	null	Number of 1's in base 2  representation of 5n+2.    nonn,changed,synth  0..92   nyi
A046823	null	Number of 1's in base 2  representation of 5n+3.    nonn,changed,synth  0..92   nyi
A046824	null	Number of 1's in base 2  representation of 5n+4.    nonn,synth  0..92   nyi
A059016	null	Number of 0's in base 2  representation of A000045(n).  nonn,base,  0..1000 nyi
A062756	null	Number of 1's in base 3  representation of n.   nonn,base,changed,  0..10000    nyi
A065710	null	Number of 2's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065712	null	Number of 1's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065714	null	Number of 3's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065715	null	Number of 4's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065716	null	Number of 5's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065717	null	Number of 6's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065718	null	Number of 7's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065719	null	Number of 8's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A065744	null	Number of 9's in base 10 representation of 2^n. nonn,base,changed,  0..1000 nyi
A073779	A000	Number of 0's in base 3  representation of A000040(n) n-th prime.   base,easy,nonn, 1..10000    nthprime
# A077267	null	Number of 0's in base 3  representation of n.   base,nonn,changed,  0..10000    nyi
A078565	null	Number of 0's in base 2  representation of A000142(n).  nonn,changed,   0..1000 nyi
A079099	null	Number of 0's in base 10 representation of A002110(n).  easy,nonn,synth 2..87   nyi
A079100	null	Number of 1's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
# A079108	null	Number of 1's in base 8  representation of A077722(n).  nonn,synth  1..105  nyi
# A079109	null	Number of 0's in base 8  representation of A077722(n).  nonn,synth  1..105  nyi
A079110	null	Number of 2's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079113	null	Number of 3's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079123	null	Number of 4's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079127	null	Number of 5's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079133	null	Number of 6's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079134	null	Number of 8's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079135	null	Number of 7's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079163	null	Number of 9's in base 10 representation of A002110(n).  easy,nonn,  2..1000 nyi
A079584	null	Number of 1's in base 2  representation of A000142(n).  nonn,changed,   1..10000    nyi
A079680	null	Number of 1's in base 10 representation of A000142(n).  easy,nonn,base,synth    0..94   nyi
A079684	null	Number of 3's in base 10 representation of A000142(n).  easy,nonn,synth 0..97   nyi
A079688	null	Number of 4's in base 10 representation of A000142(n).  easy,nonn,synth 0..93   nyi
A079690	null	Number of 5's in base 10 representation of A000142(n).  easy,nonn,synth 0..95   nyi
A079691	null	Number of 6's in base 10 representation of A000142(n).  easy,nonn,base,synth    0..95   nyi
A079692	null	Number of 7's in base 10 representation of A000142(n).  easy,nonn,synth 0..96   nyi
A079693	null	Number of 8's in base 10 representation of A000142(n).  easy,nonn,synth 0..94   nyi
A079694	null	Number of 9's in base 10 representation of A000142(n).  easy,nonn,synth 0..97   nyi
A079714	null	Number of 2's in base 10 representation of A000142(n).  easy,nonn,synth 0..93   nyi
A081603	null	Number of 2's in base 3  representation of n.   nonn,base,changed,  0..10000    nyi
A082481	null	Number of 1's in base 2  representation of A000984(n) C(2n,n).  nonn,base,  0..10000    nyi
A085854	null	Number of 0's in base 10 representation of A000045(n).  base,nonn,  0..10000    nyi
A085855	null	Number of 1's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085856	null	Number of 2's in base 10 representation of A000045(n).  base,nonn,changed,  0..10000    nyi
A085857	null	Number of 3's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085858	null	Number of 4's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085859	null	Number of 5's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085860	null	Number of 6's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085861	null	Number of 7's in base 10 representation of A000045(n).  base,nonn,changed,synth 0..104  nyi
A085862	null	Number of 8's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085863	null	Number of 9's in base 10 representation of A000045(n).  base,nonn,synth 0..104  nyi
A085974	null	Number of 0's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085975	null	Number of 1's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085976	null	Number of 2's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085977	null	Number of 3's in base 10 representation of A000040(n).  base,nonn,changed,  1..10000    nyi
A085978	null	Number of 4's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085979	null	Number of 5's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085980	null	Number of 6's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085981	null	Number of 7's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085982	null	Number of 8's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A085983	null	Number of 9's in base 10 representation of A000040(n).  base,nonn,  1..10000    nyi
A086008	null	Number of 0's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086009	null	Number of 1's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086010	null	Number of 2's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086011	null	Number of 3's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086012	null	Number of 4's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086013	null	Number of 5's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086014	null	Number of 6's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086015	null	Number of 7's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086016	null	Number of 8's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086017	null	Number of 9's in base 10 representation of n^2. base,nonn,  0..1000 nyi
A086071	null	Number of 0's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086072	null	Number of 1's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086073	null	Number of 2's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086074	null	Number of 3's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086075	null	Number of 4's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086076	null	Number of 5's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086077	null	Number of 6's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086078	null	Number of 7's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086079	null	Number of 8's in base 10 representation of A000217(n)   base,nonn,synth 0..104  nyi
A086080	null	Number of 9's in base 10 representation of A000217(n)   base,nonn,  0..65537    nyi
A086995	null	Number of 1's in base 2  representation of A000796(n) n-th decimal digit in representation of Pi.   nonn,base,synth 1..105  nyi
A086997	null	Number of 1's in base 2  representation of A001113(n) n-th decimal digit in representation of e.    nonn,base,synth 1..105  nyi
A097468	null	Number of 1's in base 10 representation of A001359(n).  base,nonn,synth 2..106  nyi
A097470	null	Number of 0's in base 10 representation of A001359(n).  base,nonn,synth 2..106  nyi
A097660	null	Number of 0's in base 10 representation of 1001^n.  nonn,base,synth 0..72   nyi
A104320	Sequ	Number of 0's in base 3  representation of 2^n. nonn,base,changed,  0..10000    unkn
A108850	null	Number of 1's in base 2  representation of A002275(n).  easy,nonn,base,synth    0..68   nyi
A118736	null	Number of 0's in base 2  representation of 3^n. base,nonn,changed,synth 0..73   nyi
A118737	null	Number of 0's in base 2  representation of 5^n. base,nonn,changed,  0..10000    nyi
A118738	null	Number of 1's in base 2  representation of 5^n. base,nonn,easy,changed, 0..10000    nyi
A126205	null	Number of 3's in base 10 representation of 3^n. nonn,base,synth 0..100  nyi
A126206	null	Number of 4's in base 10 representation of 4^n. nonn,base,changed,  0..10000    nyi
A126207	null	Number of 5's in base 10 representation of 5^n. nonn,base,synth 0..100  nyi
A126208	null	Number of 6's in base 10 representation of 6^n. nonn,base,synth 0..99   nyi
A126209	null	Number of 7's in base 10 representation of 7^n. base,nonn,synth 0..100  nyi
A126210	null	Number of 8's in base 10 representation of 8^n. base,nonn,synth 0..98   nyi
A126211	null	Number of 9's in base 10 representation of 9^n. base,nonn,synth 0..99   nyi
A132680	null	Number of 1's in base 2  representation of A000069(n) odious numbers.   nonn,easy,  1..10001    nyi
A139069	null	Number of 3's in base 10 representation of A020458(n).  nonn,base,synth 1..99   nyi
A159918	null	Number of 1's in base 2  representation of n^2. nonn,base,easy,changed, 0..10000    nyi
A160380	null	Number of 0's in base 4  representation of n.   nonn,base,easy,changed, 0..10000    nyi
A160381	null	Number of 1's in base 4  representation of n.   nonn,base,easy,changed,synth    0..104  nyi
A160382	null	Number of 2's in base 4  representation of n.   nonn,base,easy,changed,synth    0..104  nyi
A160383	null	Number of 3's in base 4  representation of n.   nonn,base,easy,changed,synth    0..104  nyi
A166266	null	Number of 1's in base 2  representation of A000110(n).  nonn,   1..1000 nyi
A166267	null	Number of 1's in base 2  representation of A000129(n).  nonn,base,easy,changed,synth    0..73   nyi
A178065	null	Number of 1's in base 2  representation of A001358(n) n-th semiprime.   nonn,base,easy,synth    1..105  nyi
A192085	null	Number of 1's in base 2  representation of n^3. nonn,base,easy,changed, 0..10000    nyi
A214560	null	Number of 0's in base 2  representation of n^2. base,nonn,  0..10000    nyi
A214561	null	Number of 1's in base 2  representation of n^n. nonn,   0..5000 nyi
A214562	null	Number of 0's in base 2  representation of n^n. nonn,base,synth 0..61   nyi
A240962	null	Number of 0's in base 10 representation of n^n. nonn,base,  1..1000 nyi
A253638	null	Number of 0's in base 10 representation of 5^n. nonn,base,  0..1000 nyi
A260683	null	Number of 2's in base 3  representation of 2^n. base,easy,nonn, 0..10000    nyi
A265157	null	Number of 2's in base 3  representation of 2^n-1.   nonn,base,  0..1000 nyi
A268643	null	Number of 1's in base 10 representation of n.   nonn,base,  0..10000    nyi
A320394	null	Number of 1's in base 2  representation of n^5. nonn,base,synth 0..71   nyi
