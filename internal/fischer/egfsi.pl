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

my ($aseqno, $callcode, $name, $nok, $offset, $abs);
my @fact = (1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880); # 0! .. 9!

while (<>) {
    if (0) {
    } elsif (s{\A(A\d+) +(Expansion of e|E|e)\.g\.f\.( ?\([^\)]+\) ?)?\:? *(\w\(\w\)\=|\=)? *}{$1\tegfsi\t0\t}) {
        s/\s+\Z//; # chompr
        ($aseqno, $callcode, $offset, $name) = split(/\t/);
        $name = " $name "; # shield for (\W)
        $abs  =  ($name =~ s{\,? *absolute( values)?}{}) ? ".abs()" : "";
        if ($name =~ s{(\(|\, )?(even|odd) (powers|indexed terms|terms) only\)?}{}) {
            $callcode .= substr($2, 0, 1); # "e" or "o"
        }
        $name     =~ s{(\D)(\d)\!}                {"$1" . $fact[$2]}eg; # replace small factorials
        $name     =~ s{Series_Reversion|Revert}   {reverse}ig;
        $nok  =  0;
        if ($name =~ m{(\!|for|of|satis|where|column|hypergeo|\dF\d|Lambert|Root|Sum|Prod|reversion|series|\^\^|\.\.\.)}i) {
            $nok = $1;
        } else {
            $name =~ s{[\.\;\:\_].*}{}; # remove all after a [.;:_]
            $name =~ s{\s+\Z}{}; # chompr
            $name =~ s{([^A-Za-z])e\^x([^A-Za-z])}{${1}exp(x)$2}g;   # e^x -> exp(x)
            $name =~ s{([^A-Za-z])e([^A-Za-z])}   {${1}exp(1)$2}g;   # e -> exp(1)
            $name =~ s{(\d+)([a-z])}              {$1\*$2}g;         # 2x -> 2*x
            $name =~ s{(\d+)\(}                   {$1\*\(}g;         # 2( -> 2*(
            $name =~ s{\)\(}                      {\)\*\(}g;         # )( -> )*(
            $name =~ tr{\{\[\]\}}                 {\(\(\)\)};        # [] {} -> ()
            my %hash = (); # for count of single letter variables
            my $last_var = "x";
            map { 
                $last_var = $_;
                $hash{$last_var} = 1;
                } "/$name/" =~ m{\W([a-z])\W}g; 
            if (scalar(%hash) > 1) { # count > 1
                $nok = join(",", sort(keys(%hash)));
            } else {
                $name =~ s{([^A-Za-z])$last_var([^A-Za-z])}{${1}x$2}g;  
            }
            $name =~ s{\A\s+}{}; # unshield
            $name =~ s{\s+\Z}{};
        }
        # if e.g.f.
    } elsif (0) {
    } else {
      $nok = -1; # irrelevant
    }
    if ($nok eq 0) {
        print        join("\t", $aseqno, $callcode       , $offset, $name, $abs, $name) . "\n";
    } elsif ($nok ne "-1") {
        print STDERR join("\t", $aseqno, "$callcode=$nok", $offset, $name) . "\n";
    }
} # while <>
__DATA__
A052296 E.g.f.: Sum(exp(y*((1+x)^n-1))*y^n/n!, n = 0 .. infinity). - _Vladeta Jovovic_, May 28 2004
A052316 E.g.f.: -x-LambertW(-2*x*exp(-x)). - _Vladeta Jovovic_, Sep 17 2003
A052317 E.g.f.: 1 + B(x) - x*B(x) - B(x)^2/2 where B(x) is g.f. of A052316.
A052318 E.g.f. satisfies A(x) = x*exp(A(x) - x^2).
A052318 E.g.f.: -LambertW(-x/exp(x^2)). - _Vaclav Kotesovec_, Jan 08 2014
A052319 E.g.f.: A(x) = 1/B(-x) where B'(x) is e.g.f. of A006882 and B(0) = 1.
A052319 E.g.f.: A(x) satisfies A'(x) = exp(A(x)-x^2/2).
