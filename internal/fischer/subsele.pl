#!perl

# subsele.pl subsets ... le
# 2021-04-29, Georg Fischer

use strict;
use integer;

my @parms = ("rseqno", "num", "den", "add", "div");
while (<>) {
    my ($aseqno, $callcode, $name, @rest) = split(/\t/);
    $callcode = "subsele";
    if ($name =~ m{exactly (\d+)\/(\d+) of the elements are \<\= ([^\.]+)\.}) { # match
        $parms[0] = "A047161";
        $parms[1] = $1; # num
        $parms[2] = $2; # den
        my $max   = $3;
        if (0) {
        } elsif ($max =~ m{n\/(\d+)\Z}) {
            $parms[4] = $1; # div
            $parms[3] = 0;  # add
        } elsif ($max =~ m{\A\(n([\+\-]\d+)\)\/(\d+)\Z}) {
            $parms[4] = $2; # div
            $parms[3] = $1; # add
        } elsif ($max =~ m{\Asqrt\(n\)\Z}) {
            $parms[0] = "A048093";
            $parms[4] = 0; # div
            $parms[3] = 0; # add
        } else {
            $callcode = "";
            print "# $name\n";
        }
        if ($callcode ne "") {
            print join("\t", $aseqno, $callcode, 0, @parms, "", $max) . "\n";
        }
    } # if match
} # while
#--------
__DATA__
A047161 1/3 a(n) = {my(m=n\2); sum(k=1, (n+1)\4, binomial(m,   k)*binomial(n-m, 2*k))} \\ Andrew Howroyd, Apr 11 2021
A047162 2/3 a(n) = {my(m=n\2); sum(k=1, n\4,     binomial(m, 2*k)*binomial(n-m,   k))}
A047163 1/4 a(n) = {my(m=n\2); sum(k=1, (n-m)\3, binomial(m,   k)*binomial(n-m, 3*k))}
A047164 3/4 a(n) = {my(m=n\2); sum(k=1, m\3,     binomial(m, 3*k)*binomial(n-m,   k))}
A047165 1/5 a(n) = {my(m=n\2); sum(k=1, (n-m)\4, binomial(m,   k)*binomial(n-m, 4*k))}
A047166 2/5 a(n) = {my(m=n\2); sum(k=1, (n-m)\3, binomial(m, 2*k)*binomial(n-m, 3*k))}
A047167 3/5 a(n) = {my(m=n\2); sum(k=1, m\3,     binomial(m, 3*k)*binomial(n-m, 2*k))}
A047168 4/5 a(n) = {my(m=n\2); sum(k=1, m\4,     binomial(m, 4*k)*binomial(n-m,   k))}
A047169 1/6 a(n) = {my(m=n\2); sum(k=1, (n-m)\5, binomial(m,   k)*binomial(n-m, 5*k))}
A047170 5/6 a(n) = {my(m=n\2); sum(k=1, m\5,     binomial(m, 5*k)*binomial(n-m,   k))}

A048046		Number of nonempty subsets of {1,2,...,n} in which exactly 4/5 of the elements are <= (n+1)/3.
f:= proc(n) local k, j;
  k:= floor((n+1)/3);
  add(binomial(k, 4/5*j)*binomial(n-k, 1/5*j), j=5..n, 5)
end proc:
map(f, [$1..100]); 

A048060		Number of nonempty subsets of {1,2,...,n} in which exactly 1/2 of the elements are <= (n-4)/2.
            a(n) = binomial(n, ceiling(n/2)+2) - 1 for n >= 4.
https://oeis.org/A048062 with many hypergeom() from Robert Israel
