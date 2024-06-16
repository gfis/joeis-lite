#!perl

# Reinsert the digit sequences
# @(#) $Id$
# 2024-05-11, Georg Fischer

use strict;
use integer;

while(<DATA>) {
    s/\s+\Z//;
    my ($aseqno, $form, @nums) = split(/\t/);
    foreach my $num (@nums) {
        $form =~ s{\(\\d\+\)}{$num};
    }
    my $old_form = $form;
    $form =~ s{([\+\-\*\/\^])}{\.$1\(}g;
    $aseqno =~ s{^[^A]*}{};
    $form =~ s{([^\)])\.}{$1\)\.}g;
    $form =~ s{isprime}{filnum\t0\t0\tn -> ZV};
    print join("\t", $aseqno, "$form.IPP()", "", $old_form) . "\n";
}
__DATA__
# = A111517	isprime(((\d+)*n+(\d+))/(\d+))	7	1	2
# = A107306	isprime(((\d+)*n-(\d+)))	17	19
# = A107308	isprime(((\d+)*n-(\d+)))	29	31
# = A113542	isprime(((\d+)*n^(\d+)+(\d+))/(\d+))	18	2	1	19
# = A347138	isprime(((\d+)^n+(\d+))/(\d+))	100	1	101
# = A350036	isprime(((\d+)^n+(\d+))/(\d+))	81	1	82
# = A348170	isprime(((\d+)^n-(\d+))/(\d+))	35	1	34
# = A345402	isprime(((\d+)^n-(\d+))/(\d+))	42	1	41
# = A101471	isprime((\d+)*n+(\d+))	100	11
# = A102624	isprime((\d+)*n+(\d+))	100	23
# = A101472	isprime((\d+)*n+(\d+))	100	33
# = A102611	isprime((\d+)*n+(\d+))	100	77
# = A102339	isprime((\d+)*n+(\d+))	1000	333
# = A138632	isprime((\d+)*n+(\d+))	17	9
# = A372188	isprime((\d+)*n+(\d+))&&isprime((\d+)*n+(\d+))&&isprime((\d+)*n+(\d+))&&isprime((\d+)*n+(\d+))	18	1	36	1	108	1	162	1
# = A372186	isprime((\d+)*n+(\d+))&&isprime((\d+)*n+(\d+))&&isprime((\d+)*n+(\d+))&&isprime((\d+)*n+(\d+))	20	1	80	1	100	1	200	1
# = A110912	isprime((\d+)*n^(\d+)-(\d+))	23	2	36
# = A283867	isprime((\d+)*n^(\d+)-(\d+))&&isprime((\d+)*n^(\d+)+(\d+))	30	2	1	30	2	1
# = A138578	isprime((\d+)^((\d+)*n-(\d+))-(\d+))	2	2	7	7
# = A128161	isprime((\d+)^n%fibonacci(n))	2
# = A339923	isprime((\d+)^n+(\d+))	14	3
# = A339921	isprime((\d+)^n+(\d+))	20	3
# = A089379	isprime((\d+)^n+n)	10
# = A370657	isprime((\d+)^n+n)	7
# = A172413	isprime((\d+)^n+n+(\d+))	11	1
# = A075898	isprime((\d+)^n+n^(\d+))	3	2
# = A253471	isprime((\d+)^n+n^(\d+))	3	3
# = A219616	isprime((\d+)^n+n^(\d+))	5	4
# = A216618	isprime((\d+)^n+n^(\d+)+(\d+))	10	10	1
# = A216375	isprime((\d+)^n+n^(\d+)+(\d+))	11	11	1
# = A216421	isprime((\d+)^n+n^(\d+)+(\d+))	13	13	1
# = A177070	isprime((\d+)^n+n^(\d+)+(\d+))	2	2	2
# = A215441	isprime((\d+)^n+n^(\d+)+(\d+))	3	3	1
# = A216423	isprime((\d+)^n+n^(\d+)+(\d+))	4	4	1
# = A215442	isprime((\d+)^n+n^(\d+)+(\d+))	5	5	1
# = A243934	isprime((\d+)^n+n^(\d+)+(\d+))	6	6	1
# = A215444	isprime((\d+)^n+n^(\d+)+(\d+))	7	7	1
# = A339924	isprime((\d+)^n-(\d+))	14	3
# = A339922	isprime((\d+)^n-(\d+))	20	3
# = A095906	isprime((\d+)^n-(\d+)^(n-(\d+)))	3	2	1
# = A188051	isprime((\d+)^n-(\d+)^n)	18	17
# = A224506	isprime((\d+)^n-n)	9
# = A208293	isprime((n^(\d+)+(\d+))/(\d+))	2	1	26
# = A240878	isprime((n^(\d+)+(\d+))/(\d+))	2	2	3
# = A110480	isprime((n^(\d+)+(\d+))/(\d+))	2	6	5
# = A181112	isprime((n^(\d+)+(\d+))/(\d+))	6	1091	4
# = A217001	isprime((n^(\d+)+n+(\d+))/(\d+))	2	2	4
# = A185657	isprime((n^(\d+)+n+(\d+))/(\d+))	2	41	43
# = A110016	isprime((n^(\d+)-(\d+))/(\d+))	2	7	6
# = A160022	isprime(n)&&isprime(n^(\d+)+(\d+))	4	706
# = A257362	isprime(n)&&issquare(Mod(-(\d+)	n))	163
# = A214360	isprime(n)&&n%(\d+)==(\d+)	3120613860	23
# = A274045	isprime(n)&&nextprime(n+(\d+))-n==(\d+)	1	72
# = A102343	isprime(n*(\d+)^(\d+)+(\d+))	10	3	777
# = A242196	isprime(n*(\d+)^n+(\d+))	12	1
# = A242197	isprime(n*(\d+)^n+(\d+))	14	1
# = A242198	isprime(n*(\d+)^n+(\d+))	15	1
# = A242199	isprime(n*(\d+)^n+(\d+))	16	1
# = A242176	isprime(n*(\d+)^n+(\d+))	6	1
# = A242178	isprime(n*(\d+)^n+(\d+))	8	1
# = A139220	isprime(n*(n+(\d+))/(\d+)+(\d+))	1	2	41
# = A239347	isprime(n^(\d+)+(\d+))	10	10
# = A125264	isprime(n^(\d+)+(\d+))	10	9
# = A125265	isprime(n^(\d+)+(\d+))	11	10
# = A126894	isprime(n^(\d+)+(\d+))	12	4094
# = A122131	isprime(n^(\d+)+(\d+))	12	488669
# = A178177	isprime(n^(\d+)+(\d+))	4	706
# = A125262	isprime(n^(\d+)+(\d+))	7	6
# = A239344	isprime(n^(\d+)+(\d+))	7	7
# = A125263	isprime(n^(\d+)+(\d+))	8	7
# = A239345	isprime(n^(\d+)+(\d+))	8	8
# = A239346	isprime(n^(\d+)+(\d+))	9	9
# = A129412	isprime(n^(\d+)+(\d+)*n+(\d+))	2	6	13
# = A075982	isprime(n^(\d+)+(\d+)^n)	5	4
# = A075985	isprime(n^(\d+)+(\d+)^n)	5	6
# = A128958	isprime(n^(\d+)+(n+(\d+))^(\d+))	2	1	3
# = A239418	isprime(n^(\d+)-(\d+))	10	10
# = A154935	isprime(n^(\d+)-(\d+))	7	2
# = A239416	isprime(n^(\d+)-(\d+))	8	8
# = A112405	isprime(n^(\d+)-(\d+))	9	3
# = A114452	isprime(n^(\d+)-(\d+))	9	7
# = A239417	isprime(n^(\d+)-(\d+))	9	9
# = A173975	isprime(n^n+(\d+))	115
# = A100407	isprime(n^n+(\d+))	2
# = A173974	isprime(n^n+(\d+))	43
#
