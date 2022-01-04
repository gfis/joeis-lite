#!perl

# prijacob.pl - extract parameters for primes that have some value of the Jacobi or Kronecker symbol
# 2022-01-03, Georg Fischer
#
#:# Usage:
#:#     grep -i prime jcat25.txt | grep mod | cut -b4- \
#:#     | perl prikronf.pl > output.seq4
#-----------------------------------------------
use strict;
use integer;

my ($line, $aseqno, $catype, $callcode, $name, $ok, $offset, $polar, $mod, $inits, $inilen);
$callcode = "prikronf";
# while (<>) {
while (<DATA>) {
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
    } elsif (($aseqno ge 'A191017') && ($aseqno le 'A191087')) {
        if (0) {
        #                   1      12          3     32
        } elsif ($name =~ m{(\-?\d+)([^\=]*\= *(\-?\d))?}) {
            $polar = $3 || 1;
            $mod   = $1;
            $ok    = 1;
            if ($name =~ m{are not}) {
                $polar = -1;
            }
        } else {
            print join("\t", $aseqno, "unkn?", $name) . "\n";
        }
    #                            1                                                1 2                2   3   3      4     4
    } elsif ($name =~ m{\APrimes (p |that |such |whose |which |with |have |are |a )+(Kronecker|Jacobi)\D+(\d+) *\= *(\-?\d)}i) {
        $polar = $4;
        $mod   = $3;
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
%N A191017 Primes with Kronecker symbol (p|14) = 1. nonn,easy,changed,  1..1000 prikron
%N A191018 Primes p with Jacobi symbol (p|3*5) = 1. nonn,easy,changed,  1..1000 nyi
%N A191019 Rational primes that decompose in the quadratic field Q(sqrt(-19)).  nonn,easy,  1..1000 nyi
%N A191020 Primes p with Kronecker symbol (p|2*11) = 1. nonn,easy,  1..10000    prikron
%N A191021 Primes that are squares mod 23.  nonn,easy,  1..1000 nyi
%N A191022 Primes that are squares mod 29.  nonn,easy,  1..1000 nyi
%N A191023 Primes p which have Kronecker symbol (p|30) = 1. nonn,easy,  1..1000 prikron
%N A191024 Primes that are squares mod 31.  nonn,easy,  1..1000 nyi
%N A191025 Primes p which have Kronecker symbol (p|34) = 1. nonn,easy,  1..1000 prikron
%N A191026 Primes p that have Jacobi symbol (p|35) = 1. nonn,easy,  1..1000 nyi
%N A191027 Primes that are nonzero squares mod 37.  nonn,easy,  1..1000 nyi
%N A191028 Primes p with Kronecker symbol (p|38) = 1.   nonn,easy,  1..1000 prikron
%N A191029 Primes p with Jacobi symbol (p|39) = 1.  nonn,easy,  1..1000 nyi
%N A191030 Primes that are quadratic residues mod 41.   nonn,easy,  1..1000 nyi
%N A191031 Primes that are squares mod 43.  nonn,easy,  1..1000 nyi
%N A191032 Primes p with Kronecker symbol (p|46) = 1.   nonn,easy,  1..1000 prikron
%N A191033 Primes that are squares mod 47.  nonn,easy,  1..1000 nyi
%N A191034 Primes p with Jacobi symbol (p|51) = 1.  nonn,easy,  1..1000 nyi
%N A191035 Primes that are squares mod 53.  nonn,easy,synth 1..54   nyi
%N A191036 Primes p that have Jacobi symbol (p|55) = 1. nonn,easy,  1..1000 nyi
%N A191037 Primes p that have Jacobi symbol (p|58) = 1. nonn,easy,  1..1000 nyi
%N A191038 Primes that are squares mod 59.  nonn,easy,  1..1000 nyi
%N A191039 Primes that are squares mod 61.  nonn,easy,  1..1000 nyi
%N A191040 Primes p that have Kronecker symbol (p|62) = 1.  nonn,easy,  1..1000 prikron
%N A191041 Primes that are squares mod 67.  nonn,easy,changed,  1..1000 nyi
%N A191042 Primes p that have Jacobi symbol (p|69) = 1. nonn,easy,  1..1000 nyi
%N A191043 Primes p that have Kronecker symbol (p|70) = 1.  nonn,easy,  1..1000 prikron
%N A191044 Primes that are squares mod 71.  nonn,easy,  1..1000 nyi
%N A191045 Primes that are squares mod 73.  nonn,easy,  1..1000 nyi
%N A191046 Primes p that have Kronecker symbol (p|74) = 1.  nonn,easy,  1..1000 prikron
%N A191047 Primes p that have Kronecker symbol (p|78) = 1.  nonn,easy,  1..1000 prikron
%N A191048 Primes that are squares mod 79.  nonn,easy,  1..1000 nyi
%N A191049 Primes p that have Kronecker symbol (p|82) = 1.  nonn,easy,  1..1000 prikron
%N A191050 Primes that are squares mod 83.  nonn,easy,  1..1000 nyi
%N A191051 Primes p that have Kronecker symbol (p|86) = 1.  nonn,easy,  1..1000 prikron
%N A191052 Primes that are squares mod 87.  nonn,easy,  1..1000 nyi
%N A191053 Primes that are squares mod 89.  nonn,easy,  1..1000 nyi
%N A191054 Primes p such that Jacobi(p,91) = 1. nonn,easy,  1..1000 nyi
%N A191055 Primes that are squares mod 93.  nonn,easy,  1..1000 nyi
%N A191056 Primes p that have Kronecker symbol (p|94) = 1.  nonn,easy,  1..1000 prikron
%N A191057 Primes p that have Kronecker symbol (p|95) = 1.  nonn,easy,  1..1000 prikron
%N A191058 Primes that are squares mod 97.  nonn,easy,  1..1000 nyi
%N A191059 Primes p that have Kronecker symbol (p|6) = -1.  nonn,easy,  1..1000 prikron
%N A191060 Primes that are not squares mod 11.  nonn,easy,  1..1000 nyi
%N A191061 Primes p that have Kronecker symbol (p|14) = -1. nonn,easy,changed,  1..1000 prikron
%N A191062 Primes p that have Kronecker symbol (p|15) = -1. nonn,easy,changed,  1..1000 prikron
%N A191063 Primes that are not squares mod 19.  nonn,easy,  1..1000 nyi
%N A191064 Primes p that have Kronecker symbol (p|22) = -1. nonn,easy,  1..1000 prikron
%N A191065 Primes that are not squares mod 23.  nonn,easy,  1..1000 nyi
%N A191066 Primes p that have Kronecker symbol (p|30) = -1. nonn,easy,changed,  1..1000 prikron
%N A191067 Primes that are not squares mod 31.  nonn,easy,  1..1000 nyi
%N A191068 Primes p that have Kronecker symbol (p|35) = -1. nonn,easy,  1..1000 prikron
%N A191069 Primes p that have Kronecker symbol (p|38) = -1. nonn,easy,  1..1000 prikron
%N A191070 Primes p that have Kronecker symbol (p|39) = -1. nonn,easy,  1..1000 prikron
%N A191071 Primes p that have Kronecker symbol (p|46) = -1. nonn,easy,  1..1000 prikron
%N A191072 Primes that are not squares mod 47.  nonn,easy,  1..1000 nyi
%N A191073 Primes that are not squares mod 51.  nonn,easy,  1..1000 nyi
%N A191074 Primes p that have Kronecker symbol (p|55) = -1. nonn,easy,  1..1000 prikron
%N A191075 Primes that are not squares mod 59.  nonn,easy,  1..1000 nyi
%N A191076 Primes p that have Kronecker symbol (p|62) = -1. nonn,easy,  1..1000 prikron
%N A191077 Primes that are not squares mod 67.  nonn,easy,  1..1000 nyi
%N A191078 Primes p that have Kronecker symbol (p|70) = -1. nonn,easy,  1..1000 prikron
%N A191079 Primes that are not squares mod 71.  nonn,easy,  1..1000 nyi
%N A191080 Primes p that have Kronecker symbol (p|78) = -1. nonn,easy,  1..1000 prikron
%N A191081 Primes that are not squares mod 79.  nonn,easy,  1..1000 nyi
%N A191082 Primes that are not squares mod 83.  nonn,easy,  1..1000 nyi
%N A191083 Primes p that have Kronecker symbol (p|86) = -1. nonn,easy,  1..1000 prikron
%N A191084 Primes that are not squares mod 87.  nonn,easy,  1..1000 nyi
%N A191085 Primes p that have Kronecker symbol (p|91) = -1. nonn,easy,  1..1000 prikron
%N A191086 Primes p that have Kronecker symbol (p|94) = -1. nonn,easy,  1..1000 prikron
%N A191087 Primes p that have Kronecker symbol (p|95) = -1. nonn,easy,  1..1000 prikron
