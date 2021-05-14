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
        $rseqno = $superclass;
    }
    my @numbers = split(/\,/, $numlist);
    print join("\t", $aseqno, "ibase", 0, $rseqno, $numbers[0], $name) . "\n";
} # while
__DATA__
A018859	A018857 	Smallest power of (\d+) that begins with n	4
A018861	A018857 	Smallest power of (\d+) that begins with n	5
A018863	A018857 	Smallest power of (\d+) that begins with n	6
A018865	A018857 	Smallest power of (\d+) that begins with n	7
A018867	A018857 	Smallest power of (\d+) that begins with n	8
A018869	A018857 	Smallest power of (\d+) that begins with n	9
A018802	Sequence	Smallest power of (\d+) that begins with n	2
A018857	Sequence	Smallest power of (\d+) that begins with n	3
A180689	ZZ      	Smallest power of (\d+) that begins with n	11
A180691	ZZ      	Smallest power of (\d+) that begins with n	12
A180693	ZZ      	Smallest power of (\d+) that begins with n	13
A180695	ZZ      	Smallest power of (\d+) that begins with n	14
A180697	ZZ      	Smallest power of (\d+) that begins with n	15
A180699	ZZ      	Smallest power of (\d+) that begins with n	16
A180701	ZZ      	Smallest power of (\d+) that begins with n	17
A180703	ZZ      	Smallest power of (\d+) that begins with n	18
A180705	ZZ      	Smallest power of (\d+) that begins with n	19
A180725	ZZ      	Smallest power of (\d+) that begins with n	20
A180727	ZZ      	Smallest power of (\d+) that begins with n	21
A180729	ZZ      	Smallest power of (\d+) that begins with n	22
A180731	ZZ      	Smallest power of (\d+) that begins with n	23

