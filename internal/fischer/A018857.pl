#!perl
# 2021-05-15: is smallest power ... also
# 2021-05-13, Georg Fischer
use strict;
use integer;

my $rseqno = "";
while (<DATA>) {
    next if ! m{\AA\d};
    s/\s+\Z//;
    my ($aseqno, $rseqno, $base, $name, @rest) = split(/\t/);
    print join("\t", $aseqno, "ibase", 0, $rseqno, $base, $name) . "\n";
} # while
__DATA__
A018859	A018857	4 	Smallest power of (\d+) that begins with n	4
A018861	A018857	5 	Smallest power of (\d+) that begins with n	5
A018863	A018857	6 	Smallest power of (\d+) that begins with n	6
A018865	A018857	7 	Smallest power of (\d+) that begins with n	7
A018867	A018857	8 	Smallest power of (\d+) that begins with n	8
A018869	A018857	9 	Smallest power of (\d+) that begins with n	9
A018802	A018857	2 	Smallest power of (\d+) that begins with n	2
A018857	A018857	3 	Smallest power of (\d+) that begins with n	3
A180689	A018857	11	Smallest power of (\d+) that begins with n	11
A180691	A018857	12	Smallest power of (\d+) that begins with n	12
A180693	A018857	13	Smallest power of (\d+) that begins with n	13
A180695	A018857	14	Smallest power of (\d+) that begins with n	14
A180697	A018857	15	Smallest power of (\d+) that begins with n	15
A180699	A018857	16	Smallest power of (\d+) that begins with n	16
A180701	A018857	17	Smallest power of (\d+) that begins with n	17
A180703	A018857	18	Smallest power of (\d+) that begins with n	18
A180705	A018857	19	Smallest power of (\d+) that begins with n	19
A180725	A018857	20	Smallest power of (\d+) that begins with n	20
A180727	A018857	21	Smallest power of (\d+) that begins with n	21
A180729	A018857	22	Smallest power of (\d+) that begins with n	22
A180731	A018857	23	Smallest power of (\d+) that begins with n	23
A018856	A018858	2	2^a(n) is smallest power of 2 beginning with n.	nonn,base,      1..32699        unkn
A018858	A018858	3	3^a(n) is smallest power of 3 beginning with n.	nonn,base,      1..32699        unkn
A018860	A018858	4	4^a(n) is smallest power of 4 beginning with n.	nonn,base,      1..32699        unkn
A018862	A018858	5	5^a(n) is smallest power of 5 beginning with n.	nonn,base,      1..32699        unkn
A018864	A018858	6	6^a(n) is smallest power of 6 beginning with n.	nonn,base,      1..32699        unkn
A018866	A018858	7	7^a(n) is smallest power of 7 beginning with n.	nonn,base,      1..32699        unkn
A018868	A018858	8	8^a(n) is smallest power of 8 beginning with n.	nonn,base,      1..32699        unkn
A018870	A018858	9	9^a(n) is smallest power of 9 beginning with n.	nonn,base,      1..32699        unkn
A180690	A018858	11	11^a(n) is smallest power of 11 beginning with n.	base,less,nonn, 1..32699        nyi
A180692	A018858	12	12^a(n) is smallest power of 12 beginning with n.	base,nonn,      1..32699        nyi
A180694	A018858	13	13^a(n) is smallest power of 13 beginning with n.	base,nonn,      1..32699        nyi
A180696	A018858	14	14^a(n) is smallest power of 14 beginning with n.	nonn,base,changed,      1..32699        nyi
A180698	A018858	15	15^a(n) is smallest power of 15 beginning with n.	base,nonn,      1..32699        nyi
A180700	A018858	16	16^a(n) is smallest power of 16 beginning with n.	base,nonn,      1..32699        nyi
A180702	A018858	17	17^a(n) is smallest power of 17 beginning with n.	base,nonn,      1..32699        nyi
A180704	A018858	18	18^a(n) is smallest power of 18 beginning with n.	base,nonn,      1..32699        nyi
A180706	A018858	19	19^a(n) is smallest power of 19 beginning with n.	base,nonn,      1..32699        nyi
A180726	A018858	20	20^a(n) is smallest power of 20 beginning with n.	base,nonn,      1..32699        nyi
A180728	A018858	21	21^a(n) is smallest power of 21 beginning with n.	base,nonn,      1..32699        nyi
A180730	A018858	22	22^a(n) is smallest power of 22 beginning with n.	base,nonn,      1..32699        nyi
A180732	A018858	23	23^a(n) is smallest power of 23 beginning with n.	nonn,base,changed,      1..32699        nyi
