#!perl

# prijacob.pl - extract parameters for primes that are (not) a square mod k.
# 2022-01-02, Georg Fischer
#
#:# Usage:
#:#     grep -i prime jcat25.txt | grep mod | cut -b4- \
#:#     | perl prijacob.pl > output.seq4
#-----------------------------------------------
use strict;
use integer;

my ($line, $aseqno, $catype, $callcode, $name, $ok, $offset, $polar, $mod, $inits, $inilen);
$callcode = "prijacob";
while (<>) {
# while (<DATA>) {
    $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    $line =~ s{\_.+}{}; # remove author name (may contain foreign characters)
    $line =~ s{\|}{\,}g;
    $inits = "";
    $inilen = 0;
    $ok   = 0; # assume failure
    $line =~ m{\A(..) (A\d+) +(.*)};
    ($catype, $aseqno, $name) = ($1, $2, $3);
    next if $name =~ m{Originally incorrectly};
    $name =~ s{(\, )?or}{\,}g;
    if (0) {
    #                            1                                             1          2   2
    } elsif ($name =~ m{\APrimes (p |that |such |whose |which |with |have |are )+Jacobi\D+(\d+)}i) {
        $polar = 1;
        $mod   = $2;
        $ok    = 1;
    #                     1        1        2            2    3        3                   4   4
    } elsif ($name =~ m{\A(Also\,? )?Primes (that |which )are (not |a |)squares?[^m]*mod\D+(\d+)}i) {
        $polar = $3;
        $mod   = $4;
        $polar = ($polar =~ m{not}) ? -1 : 1;
        $ok    = 1;
    }
    if ($ok == 0) {
        if ($catype =~ m{\A.[NCF]}) {
            print STDERR "$line\n";
        }
    } else {
        print join("\t", $aseqno, $callcode, 0, $mod, $polar, "", "$ok", substr($line, 11)) . "\n";
    }
} # while <>
__DATA__
#C A191020 Originally incorrectly named "primes which are squares (mod 22)", which is sequence A056874. - _M. F. Hasler_, Jan 15 20
%N A191021 Primes that are squares mod 23.
%N A191022 Primes that are squares mod 29.
#C A191023 Originally incorrectly named "primes which are squares (mod 30)", which is sequence A033212. - M. F. Hasler, Jan 15 2016
%N A191024 Primes that are squares mod 31.
#C A191025 Originally incorrectly named "primes which are squares (mod 34)", which is sequence A038889. - M. F. Hasler, Jan 15 2016
%C A191026 Originally incorrectly named "Primes which are squares (mod 35)", which is subsequence A106881. - M. F. Hasler, Jan 15 26
%N A191027 Primes that are nonzero squares mod 37.
#C A191028 Originally incorrectly named "primes which are squares (mod 38)", which is sequence A106863. - _M. F. Hasler_, Jan 15 20
%C A191029 Originally incorrectly named "primes which are squares (mod 39)", which is subsequence A267455 \ {3, 13}. - _M. F. Hasle, Jan 15 2016
%N A191031 Primes that are squares mod 43.
#C A191032 Originally incorrectly named "primes which are squares (mod 46)". - _M. F. Hasler_, Jan 15 2016
%N A191033 Primes that are squares mod 47.
%C A191034 Originally incorrectly named "primes which are squares (mod 51)", which is subsequence A106904. - M. F. Hasler, Jan 15 26
%N A191035 Primes that are squares mod 53.
%C A191036 Originally incorrectly named "primes which are squares mod 55", which is sequence A267478, a subsequence whose terms hav(p|5) = (p|11) = 1 except for the two initial terms 5 and 11. - _M. F. Hasler_, Jan 15 2016
%C A191037 Originally incorrectly named "Primes which are squares mod 58", which is sequence A038901. - _M. F. Hasler_, Jan 15 2016
%N A267455 Primes which are a square (mod 39).
%N A267478 Primes which are squares (mod 55).
%N A267481 Primes which are squares (mod 31).
%N A267601 Primes which are squares (mod 47).
%N A267603 Primes that are squares (mod 95).
%N A268155 Primes which are squares (mod 229).
%N A191034 Primes p with Jacobi symbol (p|51) = 1.	nonn,easy,	1..1000	nyi
%N A191035 Primes that are squares mod 53.	nonn,easy,synth	1..54	nyi
%N A191036 Primes p that have Jacobi symbol (p|55) = 1.	nonn,easy,	1..1000	nyi
%N A191037 Primes p that have Jacobi symbol (p|58) = 1.	nonn,easy,	1..1000	nyi
