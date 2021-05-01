#!perl

# Extract parameters for "a(n) = sumdiv(....)"
# 2021-04-28, Georg Fischer: copied from numdiv.pl
#
#:# Usage:
#:#   make sumdiv0
#:#   perl sumdiv.pl [-d debug] sumdiv0.tmp > sumdiv.gen \
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

my $offset = 0;
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $name) = split(/\t/, $line);
    $callcode = "";
    $name =~ s{ *\\\\.*}{}; # remove comment
    if ($name =~ m{\A\{}) {
        $name =~ s{\A\{}{};
        $name =~ s{\} *\;? *\Z}{};
    }
    $name =~ s{\; *\Z}{}; # remove ";"
    if (0) {
    } elsif ($name =~ m{\A(lista|a|A\d+)\(n\) *\= *sumdiv\(n\, *d\, *(.*)}) {
        $name = $2;
        $name =~ s{\)}{}; # remove parenthesis of "sumdiv"
        $callcode = "sumdiv";
        print join("\t", $aseqno, $callcode, $offset, $name) . "\n"; 
    } elsif ($name =~ m{\Afor\(n *\= *\d+\, *\d+\, *print1\(sumdiv\(n\, *d\, *(.*)}) {
        $name = $1;
        $name =~ s{\)\, *\"\, *\"\)\)\;? *\Z}{}; # remove parenthesis of print1 and sumdiv
        $callcode = "sumdivp";
        print join("\t", $aseqno, $callcode, $offset, $name) . "\n"; 
    } elsif ($name =~ m{\Avector\(\d+\, *n\, *sumdiv\(n\, *\w\, *(.*)}) {
        $name = $1;
        $name =~ s{ *\) *\)\;? *\Z}{}; # remove parenthesis of vector and sumdiv
        $callcode = "sumdivv";
        print join("\t", $aseqno, $callcode, $offset, $name) . "\n"; 
    } 
} # while <>
__DATA__
A238952	sumdiv	0	A238952(n) = sumdiv(n, d, (d<n)*numdiv(d)); \\ _Antti Karttunen_, Mar 07 2018, after _Geoffrey Critzer_'s Mathematica-code.
A238981	sumdiv	0	a(n) = sumdiv(n, d, d^n*(gcd(d, n/d) == 1)); \\ _Michel Marcus_, Mar 19 2014
A239668	sumdiv	0	a(n) = sumdiv(n^2, d, d*(!isprime(d) && (d != 1))); \\ _Michel Marcus_, Mar 31 2014
A240086	sumdiv	0	A240086(n) = sumdiv(n,p,(isprime(p)*eulerphi(gcd(p, n/p)))); \\ _Antti Karttunen_, Sep 23 2017
A240471	sumdiv	0	a(n) = n*numdiv(n)\sigma(n); \\ _Michel Marcus_, Dec 02 2020

A284097	sumdiv	0	for(n=1, 82, print1(sumdiv(n, d, if(Mod(d, 5)==1, d, 0)), ", ")) \\ _Indranil Ghosh_, Mar 21 2017
A284098	sumdiv	0	for(n=1, 82, print1(sumdiv(n, d, if(Mod(d, 6)==1, d, 0)), ", ")) \\ _Indranil Ghosh_, Mar 21 2017

A062799 sumdiv	0	vector(100, n, sumdiv(n, k, omega(k))) \\ _Altug Alkan_, Oct 15 2015
