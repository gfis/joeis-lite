#!perl

# pricongr.pl - extract conguence conditions for primes
# 2022-01-01, Georg Fischer
#
#:# Usage:
#:#     grep -i prime jcat25.txt | grep mod | cut -b4- \
#:#     | perl pricongr.pl > output.seq4
#-----------------------------------------------
use strict;
use integer;

my ($line, $aseqno, $catype, $callcode, $name, $ok, $offset, $list, $mod, $inits, $inilen);
$callcode = "pricongr";
while (<>) {
    $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    $line =~ s{\_.+}{}; # remove author name (may contain foreign characters)
    $inits = "";
    $inilen = 0;
    $ok   = 0; # assume failure
    $line =~ m{\A(..) (A\d+) +(.*)};
    ($catype, $aseqno, $name) = ($1, $2, $3);
    #                         1   2       2 1
    if ($name =~ s{Except for (\d+(\, *\d+)*)\, *}{}) {
        $inits = $1;
        $inits =~ s{ }{}g;
        $inilen = scalar(split(/\,/, $inits));
        $inits .= ",";
    }
    $name =~ s{(\, )?or}{\,}g;
    if (0) {
    #                     1          1        2                                   2 3     4         4 3                5   5
    } elsif ($name =~ m{\A(the |also )?primes (that|which|are|congruent|to|[ \(\{])+(\d+ *(\, *\d+ *)*)[^m]*mod[a-z]* *(\d+)}i) {
        $list = $3;
        $mod  = $5;
        $list =~ s{ }{}g;
        $ok   = 1;
    #                          1          1        2     3         3 2                4   4
    } elsif ($name =~ m{\APrime(s| numbers) *\=\= *(\d+ *(\, *\d+ *)*)[^m]*mod[a-z]* *(\d+)}) {
        $list = $2;
        $mod  = $4;
        $list =~ s{ }{}g;
        $ok   = 2;
    } elsif ($name =~ m{\APrime(s| numbers) *\=\= *(\d+ *(\, *\d+ *)*)[^m]*mod[a-z]* *(\d+)}) {
        $list = $2;
        $mod  = $4;
        $list =~ s{ }{}g;
        $ok   = 3;
    }
    if ($ok == 0) {
        if ($catype =~ m{\A.[NCF]}) {
            print STDERR "$line\n";
        }
    } else {
        print join("\t", $aseqno, $callcode, 0, $mod, $inilen, "$inits$list", "", "$ok", substr($line, 11)) . "\n";
    }
} # while <>
__DATA__
%N A139830 The primes are congruent to {7, 23} (mod 40).
%N A139831 Except for 2, the primes are congruent to {23, 47} (mod 60).
%N A139832 The primes are congruent to {7, 43} (mod 60).
%N A139833 The primes are congruent to {2, 29, 41, 53, 65, 89, 113, 173, 185, 221} (mod 228).
%N A139834 The primes are congruent to {11, 23, 35, 47, 83, 119, 131, 191, 215} (mod 228).
%N A142077 Primes congruent to 2 mod 35.
%N A061238 Prime numbers == 2 (mod 9).
%N A061239 Prime numbers == 4 (mod 9).
%N A061240 Prime numbers == 5 (mod 9).
%C A139643 The primes are congruent to {1, 25, 49, 55, 103, 121, 127, 145, 151, 169, 217, 223, 247, 271, 319, 361} (mod 408).
%F A139654 The primes are congruent to {1, 25, 121, 205, 277, 289, 337, 361, 373, 445, 529, 589, 625, 673, 757, 781, 841, 961} (mod 1092).
%C A191019 Primes which are 1, 5, 7, 9, 11, 17, 23, 25, or 35 mod 38. - _Charles R Greathouse IV_, Mar 18 2018
