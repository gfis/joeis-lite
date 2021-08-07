#!perl

# @(#) $Id$
# 2021-08-06, Georg Fischer

use strict;
use integer;

my @inits;
my $startorg;
my $starting;
my $m;
my $n;
my $sign;
my $cond;
my $expr;
my $formula;
my $superclass;

# while (<DATA>) {
while (<>) {
    next if ! m{\AA\d};
    s/\s+\Z//;
    my ($aseqno, $superclass, $name, @rest) = split(/\t/);
    my $orgname = $name;
    my $nok = 0;
    $sign = "?";
    $superclass = "A049884";
    if (0) {
    } elsif ($name =~ m{a\(n\) *\= *a\(1\)}) {
        $superclass = "A049884";
    } elsif ($name =~ m{a\(n\) *\= *a\(n\-1\)}) {
        $superclass = "A050024";
    } elsif ($name =~ m{a\(n\) *\= *\| *a\(n\-1\)}) {
        $superclass = "A050072";
    } else {
        $nok = 1; # wrong name
    }
    if ($name =~ s{\A[^\-]*\-1\) *([\-\+]) *a\(m\) *}{}) {
        $sign = $1;
    }
    if ($name =~ s{(for *[mn] *\>\= *(\d+))}{}) {
        $n = $2 || 4;
    }
    if ($name =~s{\,? *(starting )?with (.*)}{}) {
        $startorg = $2;
        $starting = $startorg;
        $starting =~ s{a\(1\) *\= *a\(2\) *= *(\d+)}{a\(1\) \= $1 and a\(2\) = $1};
        $starting =~ s{a\(2\) *\= *a\(3\) *= *(\d+)}{a\(2\) \= $1 and a\(3\) = $1};
        my $len = ($starting =~ s{a\(\d\)}{ }g);
        @inits = ($starting =~ m{(\d+)}g);
        while (scalar(@inits) < $len) {
            my $in0 = $inits[0];
            unshift(@inits, $in0);
        }
        $n = scalar(@inits) + 1;
    } else { # no "starting" clause
        
    } # no "starting"
    $name =~ s{ and p is the (unique|smallest) \w+ such that (of *)?}{\t};
    if ($name =~ s{\,? * where m *\= *([np\(\)\+\-\*\^\d ]+)}{}) {
        $m = $1;
        $m =~ s{ }{}g;
        $m =~ s{(\d)n}{$1\*n}g;
        $name =~ s{ }{}g;
        ($expr, $cond) = split(/\t/, $name);
        $expr = $m;
        if ($aseqno eq 'A049971') {
           $expr = "2*n-2-2^(p+1)";
           $cond = "2^p<n-1<=2^(p+1)";
        }
        $formula = $expr;
        $formula =~ s{2\^\(p\+1\)}{p1\(n\)}g;
        $formula =~ s{2\^p}       {p0\(n\)}g;
        $formula =~ s{([\+\-])}{ $1 }g;
    } else { # no "such that" clause
        $nok = 2; # no m found
    }
    if ($nok == 0) {
        print        join("\t", $aseqno, "A049884" , 0, $superclass, join(",", $sign . "1", @inits), $formula, $expr, $cond, $startorg) . "\n";
    } else {
        print STDERR join("\t", $aseqno, "nok=$nok", 0, $orgname) . "\n";
    }
} # while
__DATA__
A049884	null	a(n) = a(1) + a(2) + ... + a(n-1) - a(m) for n >= 3, where m = 2*n - 3 - 2^(p+1) and p is the unique integer such that 2^p < n-1 <= 2^(p+1), with a(1) = a(2) = 1.	  nonn,changed,synth  1..34   nyi
A049885	null	a(n) = a(1) + a(2) + ... + a(n-1) - a(m) for n >= 4, where m = 2^(p+1) + 2 - n and p is the unique integer such that 2^p < n - 1 <= 2^(p+1), starting with a(1) = a(2) = a(3) = 1.	  nonn,changed,synth  1..34   nyi
A049886	null	a(n) = a(1) + a(2) + ... + a(n-1) - a(m) for n >= 4, where m = n - 1 - 2^p and p is the unique integer such that 2^p < n - 1 <= 2^(p+1), starting with a(1) = a(2) = a(3) = 1.	  nonn,changed,synth  1..34   nyi

A050024	null	a(n) = a(n-1) + a(m) for n >= 4, where m = 2*n - 3 - 2^(p+1) and p is the smallest integer such that 2^p < n - 1 <= 2^(p+1), starting with a(1) = a(2) = a(3) = 1.	nonn,changed,	1..8193	nyi
A050025	null	a(n) = a(n-1) + a(m) for n >= 4, where m = 2^(p+1) + 2 - n and p is the unique integer such that 2^p < n - 1 <= 2^(p+1), starting with a(1) = a(2) = a(3) = 1.	nonn,changed,	1..8193	nyi

A050072	null	a(n) = |a(n-1) - a(m)| for n >= 4, where m = 2^(p+1) + 2 - n and p is the unique integer such that 2^p < n - 1 <= 2^(p+1), starting with a(1) = a(2) = a(3) = 1.	nonn,changed,synth	1..90	nyi
A050073	null	a(n) = |a(n-1) - a(m)| for n >= 4, where m = n - 1 - 2^p and p is the unique integer such that 2^p < n - 1 <= 2^(p+1), starting with a(1) = a(2) = a(3) = 1.	nonn,changed,synth	1..90	nyi

