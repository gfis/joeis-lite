#!perl

# Extract parameters for PrimePositionSubsequence 
# from names like "Numbers such that ... is prime"
# 2021-01-12, Georg Fischer: copied from suchprim.pl
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl prisub.pl [-d debug] [-e] [-f ofter_file] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -e  exclude most patterns
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $ex = "";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-e}  ) {
        $ex         = "xx";
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my ($parms, $letter, $expr);
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    # A123992	nyi pt	Numbers k such that 16*k+1, 16*k+3 and 16*k+13 are primes.
    $line = $_;
    $parms = "";
    $expr  = ""; 
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    $name =~ s{ all }{ }g;
    $name =~ s{ (are|is) primes?}{\; is prime};
    $name =~ s{\,? and }{\, };
    $name =~ s{ for which }{ such that };
    $name =~ s{ such that both }{ such that };
    $name =~ s{\bp\d+\=}{}g;
    $name =~ s{10\^(\d+)}{"1" . (0 x $1)}eg;
    my @pairs = ();
    my $ok = 1;
    if (0) {
    } elsif ($line =~ m{prime power}) {
        $ok = 0;
    #                       1     1                    2      2
    } elsif ($name =~ m{ers ([a-z]) such that [\[\{\(]?([^\;]+)[\]\}\)]?\; is prime}) {
        $letter = $1;
        $expr   = $2;
        $expr   =~ s{$letter}{k}g;
        $expr   =~ s{ }{}g; # remove spaces
        #              1   1   2      2        3          3
        if ($expr =~ m{(\d+)\*k([\+\-])[\[\{\(]([^\]\}\)]+)[\]\}\)]}) {
            my ($mul, $sign, $list) = ($1, $2, $3);
            @pairs = map {
                "$mul\*k$sign$_"
                } split(/\,/, $list);
            $expr = join(",", @pairs);
        }
        @pairs = map {
            my $pair = $_;
            $pair =~ s{k\*(\d+)}{$1\,}g;   # put constant in front
            $pair =~ s{\Ak}{1\*k};         # prefix with "1*"
            $pair =~ s{k\Z}{k\+0};         # append "+0"
            $pair =~ s{(\d)k}{$1\*k}g;     # insert "*"
            $pair =~ s{\*k}{\,}g;          # k -> ","
            $pair =~ s{(\d{6})\,}{${1}L\,}g; # force longer ints to long 
            if ($pair !~ m{\A\d+L?\,[\+\-]\d+\Z}) {
                $ok = 0;
            }
            $pair
            } split(/\, ?/, $expr);
    } else {
        $ok = 0;
    }
    $callcode = "prilist";
    if ($ok == 1) {
        print        join("\t", $aseqno, $callcode, 0, 1, join(", ", @pairs), $name, $superclass) . "\n";
    } else {
        print STDERR "$line\n";
    }
} # while <>
#================
__DATA__
A063799	nyi o	Numbers k such that (k+3, k+5, k+17, k+257, k+65537) are all primes.	easy,nonn,	1..1000	nyi	_Felice Russo_, Aug 20 2001
A123983	nyi pt	Numbers k for which 8*k+1, 8*k+5, 8*k+7 and 8*k+11 are primes.	nonn,changed,	1..10000	nyi	_Artur Jasinski_, Oct 30 2006
A123985	nyi to	Numbers n for which 12n+1, 12n+5, 12n+7 and 12n+11 are primes.	nonn,changed,	1..1000	nyi	_Artur Jasinski_, Oct 30 2006
A123987	nyi t	Numbers k for which 14*k+1, 14*k+5, 14*k+11 and 14*k+13 are primes.	nonn,changed,	1..10000	nyi	_Artur Jasinski_, Oct 30 2006
A123990	nyi t	Numbers k for which 16*k+1, 16*k+3, 16*k+7, 16*k+13 and 16*k+15 are primes.	nonn,changed,	1..10000	nyi	_Artur Jasinski_, Oct 30 2006
A123992	nyi pt	Numbers k such that 16*k+1, 16*k+3 and 16*k+13 are primes.	nonn,changed,	1..10000	nyi	_Artur Jasinski_, Oct 30 2006
A123997	nyi t	Numbers k for which 16*k+1, 16*k+3 and 16*k+15 are primes.	nonn,changed,	1..10000	nyi	_Artur Jasinski_, Oct 31 2006
A123998	nyi to	Numbers k such that 2k+1 and 4k+1 are primes.	nonn,easy,changed,	1..1000	nyi	_Artur Jasinski_, Oct 31 2006
A100418	nyi to	Numbers k such that 30*k + {1,11,13,17,19,23,29} are all prime.	easy,nonn,changed,	1..10309	nyi	Ferenc Adorjan (fadorjan(AT)freemail.hu), Nov 19 2004
