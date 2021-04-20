#!perl

# Extract parameters for "Numbers with exactly 9 divisors"
# 2021-04-20, Georg Fischer: copied from sumlipo.pl
#
#:# Usage:
#:#   perl numdiv.pl [-d debug] $(COMMON)/joeis_names.txt > numdiv.gen\
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my %primes; # from https://oeis.org/A000040:
map { $primes{$_} = 1 } 
    (  2, 3, 5, 7, 11, 13, 17, 19
    , 23, 29, 31, 37, 41, 43, 47, 53, 59
    , 61, 67, 71, 73, 79, 83, 89, 97, 101
    , 103, 107, 109, 113, 127, 131, 137, 139
    , 149, 151, 157, 163, 167, 173, 179, 181
    , 191, 193, 197, 199, 211, 223, 227, 229
    , 233, 239, 241, 251, 257, 263, 269, 271
    );
my $offset = 1;
my $rseqno = "";
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    # next if $superclass ne "null";
    $callcode = "";
    my $k = 3;
    if (0) {
    } elsif ($name =~ m{Numbers with (exact(ly) )?(\d+) divisors}) {
        #                            1     2      3
        $k = $3;
        $callcode = "parm2";
    } elsif ($name =~ m{ *a\(n\) *\= *prime\(n\)\^(\d+)\.}i) {
        #                                            1
        $k = $1 + 1; # A030514 a(n) = prime(n)^4. Numbers with 5 divisors (1, p, p^2, p^3, p^4, where p is the n-th prime).
        $callcode = "parm2" if $k <= 5; # the others are all non-prime
    } # if proper name
    if ($callcode ne "") {
        $rseqno = defined($primes{$k}) ? "A030516" : "A030515";
        print join("\t", $aseqno, $callcode, $offset, join("\t", $rseqno, $k)) . "\n"; 
    }
} # while <>
__DATA__
A030513 A007422 Numbers with 4 divisors.        nonn,easy,nice, 1..1000 unkn
A030515 Sequence        Numbers with exactly 6 divisors.        nonn,easy,changed,      1..1000 unkn
A030516 A000040 Numbers with 7 divisors. 6th powers of primes.  nonn,easy,changed,      1..1000 unkn
A030626 Sequence        Numbers with exactly 8 divisors.        nonn,   1..1000 unkn
A030627 Sequence        Numbers with 9 divisors.        nonn,   1..1000 unkn
A030629 A000040 Numbers with 11 divisors.       nonn,easy,changed,      1..1000 unkn
A030630 Sequence        Numbers with 12 divisors.       nonn,changed,   1..1000 unkn
A030631 A000040 Numbers with 13 divisors.       nonn,easy,changed,      1..1000 unkn
A030632 Sequence        Numbers with 14 divisors.       nonn,   1..1000 unkn
A030633 Sequence        Numbers with 15 divisors.       nonn,   1..1000 unkn
A030634 Sequence        Numbers with 16 divisors.       nonn,   1..1000 unkn
A030635 A000040 Numbers with 17 divisors.       nonn,easy,      1..1000 unkn
A030636 Sequence        Numbers with 18 divisors.       nonn,changed,   1..1000 unkn
A030637 A000040 Numbers with 19 divisors.       nonn,easy,      1..1000 unkn
A030638 Sequence        Numbers with 20 divisors.       nonn,   1..1000 unkn
