#!perl

# Prepare $@.gen for A183953 
# 2022-05-13, Georg Fischer
# 
use strict;
use integer;

my $rseqno = "A183953";
my $callcode = "parm3";
my %hash; # for mapping of exponent pairs to A-numbers of subclasses of A183953
while (<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    $rseqno = "???";
    if ($line =~ m{\AA\d}) {
        my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
        $name =~ s{of strings of numbers}{};
        $name =~ m{sum +i\^(\d+)\*x\(i\)\^(\d+) +};
        my ($exp1, $exp2) = ($1, $2);
        if (0) {
        } elsif ($name =~ m{\AT\(n}) {
            $hash{"$exp1,$exp2"} = $aseqno;
            $rseqno = "A183953";
            my $lambda = "(n, k) -> " . substr(" * n" x $exp1, 2) . (" * k" x $exp2);
            print join("\t", $aseqno, "parm2", 0, $rseqno, $lambda
                # , $exp1, $exp2
                , $name) . "\n";
        } elsif ($name =~ m{\ANumber}) {
            $rseqno = $hash{"$exp1,$exp2"};
            $name =~ m{x\(i\=\d\.\. *(\w+)\) +in +\w+\.\.(\w+)};
            my ($var1, $var2) = ($1, $2);
            ($var1, $var2) = map { s/n/mN/; $_ } ($var1, $var2);
            print join("\t", $aseqno, "arronk", 0, $rseqno, 1, $var1, $var2
                # , $exp1, $exp2
                , $name) . "\n";
        }
    } else {
        print "$line\n";
    }
} # while
__DATA__
A183953	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^2*x(i)^1 equal to n^2*k^1.	nonn,tabl,changed,	1..806	nyi
A184240	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^2*x(i)^2 equal to n^2*k^2	nonn,tabl,	1..393	nyi
A184257	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^3*x(i)^1 equal to n^3*k^1	nonn,tabl,	1..396	nyi
A184303	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^3*x(i)^2 equal to n^3*k^2	nonn,tabl,	1..267	nyi
A184318	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^2*x(i)^3 equal to n^2*k^3	nonn,tabl,	1..264	nyi
A184348	null	T(n,k)=number of strings of numbers x(i=1..n) in 0..k with sum i^4*x(i)^1 equal to n^4*k^1	nonn,tabl,,tard	1..268	nyi
A184441	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^2 equal to n^1*k^2	nonn,tabl,	1..643	nyi
A184703	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^1 equal to n^1*k^1	nonn,tabl,	1..2113	nyi
A184720	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^3 equal to n^1*k^3	nonn,tabl,	1..361	nyi
A184848	null	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^4 equal to n^1*k^4	nonn,tabl,	1..264	nyi

A183945	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^2*x(i)^1 equal to n^3	nonn,	1..23	nyi
A183946	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^2*x(i)^1 equal to n^2*2	nonn,	1..88	nyi
A183947	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^2*x(i)^1 equal to n^2*3	nonn,	1..75	nyi
A183948	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^2*x(i)^1 equal to n^2*4	nonn,	1..60	nyi
A183949	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^2*x(i)^1 equal to n^2*5	nonn,	1..54	nyi
A183950	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^2*x(i)^1 equal to n^2*6	nonn,	1..45	nyi
A183951	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^2*x(i)^1 equal to n^2*7	nonn,	1..52	nyi
A183952	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^2*x(i)^1 equal to n^2*8	nonn,	1..37	nyi
A183954	null	Number of strings of numbers x(i=1.. 3) in 0..n with sum i^2*x(i)^1 equal to n*9.	nonn,	1..200	nyi
A183955	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^2*x(i)^1 equal to n*16.	nonn,	1..200	nyi
A183956	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^2*x(i)^1 equal to n*25	nonn,	1..200	nyi
A183957	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^2*x(i)^1 equal to n*36	nonn,	1..200	nyi
A183958	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^2*x(i)^1 equal to n*49	nonn,	1..200	nyi
A183959	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^2*x(i)^1 equal to n*64	nonn,	1..200	nyi
A183960	null	Number of strings of numbers x(i=1.. 9) in 0..n with sum i^2*x(i)^1 equal to n*81	nonn,	1..200	nyi
A183961	null	Number of strings of numbers x(i=1..10) in 0..n with sum i^2*x(i)^1 equal to n*100	nonn,	1..121	nyi

A184232	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^2*x(i)^2 equal to n^4	nonn,synth	1..14	nyi
A184233	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^2*x(i)^2 equal to n^2*4	nonn,	1..75	nyi
A184234	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^2*x(i)^2 equal to n^2*9	nonn,	1..52	nyi
A184235	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^2*x(i)^2 equal to n^2*16	nonn,	1..39	nyi
A184236	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^2*x(i)^2 equal to n^2*25	nonn,	1..33	nyi
A184237	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^2*x(i)^2 equal to n^2*36	nonn,	1..27	nyi
A184238	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^2*x(i)^2 equal to n^2*49	nonn,	1..24	nyi
A184239	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^2*x(i)^2 equal to n^2*64	nonn,synth	1..22	nyi
A184241	null	Number of strings of numbers x(i=1.. 3) in 0..n with sum i^2*x(i)^2 equal to n^2*9	nonn,	1..200	nyi
A184242	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^2*x(i)^2 equal to n^2*16	nonn,	1..200	nyi
A184243	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^2*x(i)^2 equal to n^2*25	nonn,	1..168	nyi
A184244	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^2*x(i)^2 equal to n^2*36	nonn,	1..80	nyi
A184245	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^2*x(i)^2 equal to n^2*49	nonn,synth	1..37	nyi
A184246	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^2*x(i)^2 equal to n^2*64	nonn,	1..43	nyi

A184249	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^3*x(i)^1 equal to n^4*1	nonn,synth	1..15	nyi
A184250	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^3*x(i)^1 equal to n^3*2	nonn,	1..39	nyi
A184251	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^3*x(i)^1 equal to n^3*3	nonn,	1..36	nyi
A184252	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^3*x(i)^1 equal to n^3*4	nonn,	1..30	nyi
A184253	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^3*x(i)^1 equal to n^3*5	nonn,synth	1..27	nyi
A184254	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^3*x(i)^1 equal to n^3*6	nonn,synth	1..24	nyi
A184255	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^3*x(i)^1 equal to n^3*7	nonn,	1..28	nyi
A184256	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^3*x(i)^1 equal to n^3*8	nonn,synth	1..21	nyi
A184258	null	Number of strings of numbers x(i=1.. 3) in 0..n with sum i^3*x(i)^1 equal to n^1*27	nonn,	1..998	nyi
A184259	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^3*x(i)^1 equal to n^1*64	nonn,	1..200	nyi
A184260	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^3*x(i)^1 equal to n^1*125	nonn,	1..200	nyi
A184261	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^3*x(i)^1 equal to n^1*216	nonn,	1..200	nyi
A184262	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^3*x(i)^1 equal to n^1*343	nonn,	1..200	nyi
A184263	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^3*x(i)^1 equal to n^1*512	nonn,	1..200	nyi

A184295	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^3*x(i)^2 equal to n^5*1	nonn,changed,synth	1..12	nyi
A184296	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^3*x(i)^2 equal to n^3*4	nonn,changed,	1..100	nyi
A184297	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^3*x(i)^2 equal to n^3*9	nonn,synth	1..29	nyi
A184298	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^3*x(i)^2 equal to n^3*16	nonn,changed,	1..60	nyi
A184299	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^3*x(i)^2 equal to n^3*25	nonn,synth	1..21	nyi
A184300	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^3*x(i)^2 equal to n^3*36	nonn,synth	1..18	nyi
A184301	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^3*x(i)^2 equal to n^3*49	nonn,synth	1..17	nyi
A184302	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^3*x(i)^2 equal to n^3*64	nonn,changed,synth	1..15	nyi
A184304	null	Number of strings of numbers x(i=1.. 3) in 0..n with sum i^3*x(i)^2 equal to n^2* 27*	nonn,	1..200	nyi
A184305	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^3*x(i)^2 equal to n^2* 64*	nonn,	1..200	nyi
A184306	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^3*x(i)^2 equal to n^2*125*	nonn,	1..172	nyi
A184307	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^3*x(i)^2 equal to n^2*216*	nonn,	1..80	nyi
A184308	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^3*x(i)^2 equal to n^2*343*	nonn,	1..50	nyi
A184309	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^3*x(i)^2 equal to n^2*512*	nonn,	1..36	nyi

A184310	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^2*x(i)^3 equal to n^5*1	nonn,synth	1..11	nyi
A184311	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^2*x(i)^3 equal to n^2*8	nonn,	1..61	nyi
A184312	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^2*x(i)^3 equal to n^2*27	nonn,	1..40	nyi
A184313	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^2*x(i)^3 equal to n^2*64	nonn,	1..31	nyi
A184314	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^2*x(i)^3 equal to n^2*125	nonn,synth	1..23	nyi
A184315	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^2*x(i)^3 equal to n^2*216	nonn,synth	1..18	nyi
A184316	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^2*x(i)^3 equal to n^2*343	nonn,synth	1..17	nyi
A184317	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^2*x(i)^3 equal to n^2*512	nonn,synth	1..15	nyi
A184319	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^2*x(i)^3 equal to 16*n^3	nonn,	1..200	nyi
A184320	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^2*x(i)^3 equal to 25*n^3	nonn,	1..127	nyi
A184321	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^2*x(i)^3 equal to 36*n^3	nonn,	1..72	nyi
A184322	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^2*x(i)^3 equal to 49*n^3	nonn,synth	1..43	nyi
A184323	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^2*x(i)^3 equal to 64*n^3	nonn,synth	1..28	nyi

A184339	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^4*x(i)^1 equal to n^5	nonn,synth	1..13	nyi
A184340	null	Number of strings of numbers x(i=1.. n) in 0..1 with sum i^4*x(i)^1 equal to n^4*1	nonn,synth	1..47	nyi
A184341	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^4*x(i)^1 equal to n^4*2	nonn,synth	1..30	nyi
A184342	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^4*x(i)^1 equal to n^4*3	nonn,synth	1..26	nyi
A184343	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^4*x(i)^1 equal to n^4*4	nonn,synth	1..21	nyi
A184344	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^4*x(i)^1 equal to n^4*5	nonn,synth	1..20	nyi
A184345	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^4*x(i)^1 equal to n^4*6	nonn,synth	1..18	nyi
A184346	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^4*x(i)^1 equal to n^4*7	nonn,synth	1..18	nyi
A184347	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^4*x(i)^1 equal to n^4*8	nonn,synth	1..15	nyi
A184349	null	Number of strings of numbers x(i=1.. 3) in 0..n with sum i^4*x(i)^1 equal to 81*n.	nonn,	1..998	nyi
A184350	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^4*x(i)^1 equal to 256*n	nonn,	1..200	nyi
A184351	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^4*x(i)^1 equal to 625*n	nonn,	1..200	nyi
A184352	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^4*x(i)^1 equal to 1296*n	nonn,	1..200	nyi
A184353	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^4*x(i)^1 equal to 2401*n	nonn,	1..200	nyi
A184354	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^4*x(i)^1 equal to 4096*n	nonn,	1..139	nyi

A184433	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^1*x(i)^2 equal to n^3	nonn,synth	1..18	nyi
A184434	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^1*x(i)^2 equal to n*4	nonn,	1..200	nyi
A184435	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^1*x(i)^2 equal to n*9	nonn,	1..149	nyi
A184436	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^1*x(i)^2 equal to n*16	nonn,	1..106	nyi
A184437	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^1*x(i)^2 equal to n*25	nonn,	1..82	nyi
A184438	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^1*x(i)^2 equal to n*36	nonn,	1..63	nyi
A184439	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^1*x(i)^2 equal to n*49	nonn,	1..53	nyi
A184440	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^1*x(i)^2 equal to n*64	nonn,	1..44	nyi
A184442	null	Number of strings of numbers x(i=1.. 3) in 0..n with sum i^1*x(i)^2 equal to n*9	nonn,	1..200	nyi
A184443	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^1*x(i)^2 equal to n*16	nonn,	1..200	nyi
A184444	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^1*x(i)^2 equal to n*25	nonn,	1..170	nyi
A184445	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^1*x(i)^2 equal to n*36	nonn,	1..81	nyi
A184446	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^1*x(i)^2 equal to n*49	nonn,	1..58	nyi
A184447	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^1*x(i)^2 equal to n*64	nonn,	1..40	nyi
A184695	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^1*x(i)^1 equal to n^2	nonn,	1..35	nyi
A184696	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^1*x(i)^1 equal to n*2	nonn,	1..200	nyi
A184697	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^1*x(i)^1 equal to n*3	nonn,	1..200	nyi
A184698	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^1*x(i)^1 equal to n*4	nonn,	1..170	nyi
A184699	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^1*x(i)^1 equal to n*5	nonn,	1..163	nyi
A184700	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^1*x(i)^1 equal to n*6	nonn,	1..128	nyi
A184701	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^1*x(i)^1 equal to n*7.	nonn,	1..1000	nyi
A184702	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^1*x(i)^1 equal to n*8	nonn,	1..98	nyi
A184704	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^1*x(i)^1 equal to n*4.	nonn,	1..200	nyi
A184705	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^1*x(i)^1 equal to n*5.	nonn,	1..200	nyi
A184706	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^1*x(i)^1 equal to n*6	nonn,	1..200	nyi
A184707	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^1*x(i)^1 equal to n*7	nonn,	1..200	nyi
A184708	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^1*x(i)^1 equal to n*8	nonn,	1..200	nyi
A184709	null	Number of strings of numbers x(i=1.. 9) in 0..n with sum i^1*x(i)^1 equal to n*9	nonn,	1..200	nyi
A184710	null	Number of strings of numbers x(i=1..10) in 0..n with sum i^1*x(i)^1 equal to n*10	nonn,	1..200	nyi
A184711	null	Number of strings of numbers x(i=1..11) in 0..n with sum i^1*x(i)^1 equal to n*11	nonn,	1..129	nyi

A184712	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^1*x(i)^3 equal to n^4	nonn,synth	1..13	nyi
A184713	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^1*x(i)^3 equal to n*8	nonn,	1..190	nyi
A184715	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^1*x(i)^3 equal to n*64	nonn,	1..66	nyi
A184716	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^1*x(i)^3 equal to n*125	nonn,	1..49	nyi
A184717	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^1*x(i)^3 equal to n*216	nonn,	1..36	nyi
A184718	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^1*x(i)^3 equal to n*343	nonn,	1..28	nyi
A184719	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^1*x(i)^3 equal to n*512.	nonn,changed,	1..25	nyi
A184721	null	Number of strings of numbers x(i=1.. 4) in 0..n with sum i^1*x(i)^3 equal to 4*n^3	nonn,	1..200	nyi
A184722	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^1*x(i)^3 equal to 5*n^3	nonn,	1..140	nyi
A184723	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^1*x(i)^3 equal to 6*n^3	nonn,	1..74	nyi
A184724	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^1*x(i)^3 equal to 7*n^3	nonn,	1..43	nyi
A184725	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^1*x(i)^3 equal to 8*n^3	nonn,synth	1..31	nyi

A184840	null	Number of strings of numbers x(i=1.. n) in 0..n with sum i^1*x(i)^4 equal to n^5	nonn,synth	1..11	nyi
A184841	null	Number of strings of numbers x(i=1.. n) in 0..2 with sum i^1*x(i)^4 equal to n*16	nonn,	1..151	nyi
A184842	null	Number of strings of numbers x(i=1.. n) in 0..3 with sum i^1*x(i)^4 equal to n*81	nonn,	1..73	nyi
A184843	null	Number of strings of numbers x(i=1.. n) in 0..4 with sum i^1*x(i)^4 equal to n*256	nonn,	1..43	nyi
A184844	null	Number of strings of numbers x(i=1.. n) in 0..5 with sum i^1*x(i)^4 equal to n*625	nonn,	1..30	nyi
A184845	null	Number of strings of numbers x(i=1.. n) in 0..6 with sum i^1*x(i)^4 equal to n*1296	nonn,synth	1..21	nyi
A184846	null	Number of strings of numbers x(i=1.. n) in 0..7 with sum i^1*x(i)^4 equal to n*2401	nonn,synth	1..18	nyi
A184847	null	Number of strings of numbers x(i=1.. n) in 0..8 with sum i^1*x(i)^4 equal to n*4096	nonn,synth	1..16	nyi
A184849	null	Number of strings of numbers x(i=1.. 5) in 0..n with sum i^1*x(i)^4 equal to 5*n^4	nonn,	1..143	nyi
A184850	null	Number of strings of numbers x(i=1.. 6) in 0..n with sum i^1*x(i)^4 equal to 6*n^4	nonn,	1..75	nyi
A184851	null	Number of strings of numbers x(i=1.. 7) in 0..n with sum i^1*x(i)^4 equal to 7*n^4	nonn,synth	1..43	nyi
A184852	null	Number of strings of numbers x(i=1.. 8) in 0..n with sum i^1*x(i)^4 equal to 8*n^4	nonn,synth	1..29	nyi

# old version:
# A183953	parm3	1	A183953	2	1	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^2*x(i)^1 equal to n^2*k^1.	nonn,tabl,changed,	1..806	nyi
# A184240	parm3	1	A183953	2	2	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^2*x(i)^2 equal to n^2*k^2	nonn,tabl,	1..393	nyi
# A184257	parm3	1	A183953	3	1	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^3*x(i)^1 equal to n^3*k^1	nonn,tabl,	1..396	nyi
# A184303	parm3	1	A183953	3	2	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^3*x(i)^2 equal to n^3*k^2	nonn,tabl,	1..267	nyi
# A184318	parm3	1	A183953	2	3	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^2*x(i)^3 equal to n^2*k^3	nonn,tabl,	1..264	nyi
# A184348	parm3	1	A183953	4	1	T(n,k)=number of strings of numbers x(i=1..n) in 0..k with sum i^4*x(i)^1 equal to n^4*k^1	nonn,tabl,,tard	1..268	nyi
# A184441	parm3	1	A183953	1	2	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^2 equal to n^1*k^2	nonn,tabl,	1..643	nyi
# A184703	parm3	1	A183953	1	1	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^1 equal to n^1*k^1	nonn,tabl,	1..2113	nyi
# A184720	parm3	1	A183953	1	3	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^3 equal to n^1*k^3	nonn,tabl,	1..361	nyi
# A184848	parm3	1	A183953	1	4	T(n,k)=Number of strings of numbers x(i=1..n) in 0..k with sum i^1*x(i)^4 equal to n^1*k^4	nonn,tabl,	1..264	nyi

