#!perl

# Extract parameters for numbers derived from primes
# 2022-03-26, Georg Fischer: copied from prisub.pl
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl primen.pl [-d debug] [-e] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, $name, @rest);
my ($parms, $letter, $expr);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ex = "";
my $ok;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    $line =~ s{(\,? where .*|\(where .*)}{\t$1};
    $parms = "";
    $expr  = "";
    $callcode = "";
    $ok = 1; # assume success
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    next if ($aseqno le "A054000"); # Mar 2022
    next if ($name =~ m{for which | such that |Primes });
    if (0) {
    } elsif ($name =~ s{(\W)prime\(n\)}{${1}P}g) {
        if ($name =~ m{\Wprime\(n[^\)]}) { # prime(n+1)
            $callcode = "primen?1";
            $ok = 0;
        } else {
            if ($name =~ m{a\(n\) *\= *(.*)}) {
                $expr = $1;
                $callcode = "primen";
                &test_words();
            }
        }
    } elsif ($name =~ m{\A *a\(n\) *\= *(.*)}) {
            if (1) {
                $expr = $1;
                $callcode = "primes";
                &test_words();
            }
    } # if proper name
    
    if (length($callcode) > 0) {
        if ($ok > 0) {
        	$expr =~ s{\bP\b}{p}g;
            print        join("\t", $aseqno, $callcode, 1, $expr, "", "", $name) . "\n";
        } else {
            print STDERR join("\t", $aseqno, $callcode, 1,        "", "", $name) . "\n";
        }
    }
} # while <>
#--------
sub test_words {
                $expr =~ s{\. *\Z}{};
                $expr =~ s{ mod }{\%}g;
                foreach my $word ($expr =~ m{([a-zA-Z]+)}g) {
                    if ($word !~ m{\A(n|p|P|gcd|lcm|floor|abs|mod|phi)\Z}) {
                        $ok = 0;
                        $callcode = "nok?$word";
                    } else {
                        $expr =~ s{ }{}g;
                    }
                } # foreach
} # test_words
#================
__DATA__
A083241 null    a(n) + a(n-1) + a(n-2) + a(n-3) = prime(n), n>2, a(0)=a(1)=a(2)=0;.     nonn,   0..1000 nyi
A083242 null    For n >= 3, a(n-3) + a(n-2) + a(n-1) + a(n) = prime(n); a(0) = 0, a(1) = 1, a(2) = 1.   nonn,synth      0..47   nyi
A083375 null    n appears prime(n) times.       nonn,synth      1..100  nyi
A083554 null    Least common multiple of prime(n+1)-1 and prime(n)-1.   nonn,changed,   1..10000        nyi
A083555 null    Quotient of LCM of prime(n+1)-1 and prime(n)-1 and GCD of the same two numbers. nonn,   1..10000        nyi
A083723 null    a(n) = (prime(n)+1)*n - 1.      nonn,changed,synth      1..47   nyi
A083726 null    a(n) = (prime(n)+1)*n.  nonn,   0..1000 nyi
A083876 null    Least pseudoprime to base 2 through base prime(n).      nonn,   1..1000 nyi
A084200 null    LeastCommonMultiple{q+1: q prime, q+1 divides prime(n)+1}.      nonn,synth      1..76   nyi
A084309 null    a(n) = gcd(prime(n)-1, n).      nonn,easy,      1..10000        nyi
A084310 null    a(n) = gcd(prime(n)+1, n).      nonn,easy,      1..10000        nyi
A084311 null    a(n) = gcd(prime(n)-1,n-1).     nonn,   1..10000        nyi
A084538 null    Least primitive root mod 2*prime(n)^2.  nonn,synth      2..98   nyi
A084667 null    Primes which are a concatenation of n and prime(n).     nonn,base,changed,      1..20000        nyi
A084669 null    Primes which are a concatenation of prime(n) and n.     nonn,base,synth 1..28   nyi