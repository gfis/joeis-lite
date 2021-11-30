#!perl

# egfsi.pl - extract and prepare simple e.g.f.s 
# 2021-11-30, Georg Fischer
#
#:# Usage: 
#:#     grep ... jcat25.txt | cut -b4- \
#:#     | perl egfsi.pl > output.seq4
#-----------------------------------------------
use strict;
use integer;

my ($aseqno, $cc, $name);
my ($ok, $offset);

while (<>) {
    s{ (Expansion of e|E)\.g\.f\.\:? *}{\tegfsi\t0\t};
    ($aseqno, $cc, $offset, $name) = split(/\t/);
    next if ($name =~ m{for|of|satis|where|column|Lambert|Root|Sum|Prod|[EPRIjklmy\!\;\:]|A\(|\^\^|e\^|\.\.\.|\)\=});
    $name =~ s{\..*}{}; # remove all after a dot
    $name =~ s{\s+\Z}{}; # chompr
    $ok = 0;
    if (1) {
        $name =~ s{(\d+)([t-z])}{$1\*$2}g;
        $ok = 1;
        if ($ok) {
            print        join("\t", $aseqno, $cc, $offset, $name, $name) . "\n";
        } else {
            print STDERR join("\t", $aseqno, $cc, $offset, $name) . "\n";
        }
    } # null
} # while <>
__DATA__
A052296 E.g.f.: Sum(exp(y*((1+x)^n-1))*y^n/n!, n = 0 .. infinity). - _Vladeta Jovovic_, May 28 2004
A052316 E.g.f.: -x-LambertW(-2*x*exp(-x)). - _Vladeta Jovovic_, Sep 17 2003
A052317 E.g.f.: 1 + B(x) - x*B(x) - B(x)^2/2 where B(x) is g.f. of A052316.
A052318 E.g.f. satisfies A(x) = x*exp(A(x) - x^2).
A052318 E.g.f.: -LambertW(-x/exp(x^2)). - _Vaclav Kotesovec_, Jan 08 2014
A052319 E.g.f.: A(x) = 1/B(-x) where B'(x) is e.g.f. of A006882 and B(0) = 1.
A052319 E.g.f.: A(x) satisfies A'(x) = exp(A(x)-x^2/2).
