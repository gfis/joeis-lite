#!perl

# convert to hex
# 2020-07-24, Georg Fischer

use strict;
while (<DATA>) {
    s{\s+\Z}{}; # chompr
    my @parms = split(/\t/, $_);
    my $aseqno = shift(@parms);
    print join("\t", $aseqno, map { sprintf("\'%x", $_) } @parms) . "\n";
} # while <DATA>
__DATA__
A035878	1	0	36	32	118	32	36	0	1																
A035879	1	0	66	32	687	480	1564	480	687	32	66	0	1												
A035880	1	0	120	0	1948	1024	11592	7168	21830	7168	11592	1024	1948	0	120	0	1								
A035881	1	0	190	0	4845	512	43880	23040	187410	107520	313780	107520	187410	23040	43880	512	4845	0	190	0	1				
A035882	1	0	276	0	10626	0	136644	24576	870639	450560	2975016	1622016	4596508	1622016	2975016	450560	870639	24576	136644	0	10626	0	276	0	1
