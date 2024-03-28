#!perl

use strict;

while(<DATA>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    my @anos = $line =~ m{(A\d+)}g;
    if (0) {
    } elsif ($anos[1] ne $anos[2] && $anos[1] eq $anos[3]) {
        my $temp = $anos[2]; $anos[2] = $anos[3]; $anos[3] = $temp;
        print join("\t", $anos[0], "gcd3an", 1, "new $anos[1]()", "new $anos[2]()", "new $anos[3]()") . "\n";
    } elsif ($anos[1] eq $anos[2]) {
        # my $temp = $anos[2]; $anos[2] = $anos[3]; $anos[3] = $temp;
        print join("\t", $anos[0], "gcd3an", 1, "new $anos[1]()", "new $anos[2]()", "new $anos[3]()") . "\n";
    } else {
        print STDERR "# $line\n";
    }
}
__DATA__
A342415 a(n) = A000010(n) / gcd(A000010(n), A003415(n))
A348048 a(n) = A000203(n) / gcd(A000203(n), A003959(n))
A349162 a(n) = A000203(n) / gcd(A000203(n), A003961(n))
A355934 a(n) = A000203(n) / gcd(A000203(n), A003973(n))
A295655 a(n) = A000203(n) / gcd(A000203(n), A005187(n))
A322656 a(n) = A000203(n) / gcd(A000203(n), A007429(n))
A348504 a(n) = A000203(n) / gcd(A000203(n), A034448(n))
A348979 a(n) = A000203(n) / gcd(A000203(n), A332993(n))
A342414 a(n) = A003415(n) / gcd(A000010(n), A003415(n))
A342919 a(n) = A003415(n) / gcd(A001615(n), A003415(n))
A344756 a(n) = A003415(n) / gcd(A003415(n), A069359(n))
A348049 a(n) = A003959(n) / gcd(A000203(n), A003959(n))
A348734 a(n) = A003959(n) / gcd(A003959(n), A034448(n))
A348974 a(n) = A003959(n) / gcd(A003959(n), A129283(n))
A349161 a(n) = A003961(n) / gcd(A000203(n), A003961(n))
A336849 a(n) = A003961(n) / gcd(A003961(n), A003973(n))
A336838 a(n) = A003973(n) / gcd(A000005(n), A003973(n))
A355933 a(n) = A003973(n) / gcd(A000203(n), A003973(n))
A341525 a(n) = A003973(n) / gcd(A003961(n), A003973(n))
A295656 a(n) = A005187(n) / gcd(A000203(n), A005187(n))
A322655 a(n) = A007429(n) / gcd(A000203(n), A007429(n))
A340677 a(n) = A007947(n) / gcd(A007947(n), A008472(n))
A340678 a(n) = A008472(n) / gcd(A007947(n), A008472(n))
A344970 a(n) = A011772(n) / gcd(A011772(n), A344875(n))
A348505 a(n) = A034448(n) / gcd(A000203(n), A034448(n))
A348735 a(n) = A034448(n) / gcd(A003959(n), A034448(n))
A354986 a(n) = A047994(n) / gcd(A047994(n), A344005(n))
A274448 a(n) = A051711(n) / gcd(A001662(n), A051711(n))
A354365 a(n) = A055615(n) / gcd(A055615(n), A064989(n))
A354366 a(n) = A064989(n) / gcd(A055615(n), A064989(n))
A344757 a(n) = A069359(n) / gcd(A003415(n), A069359(n))
A345059 a(n) = A129283(n) / gcd(A000203(n), A129283(n))
A348973 a(n) = A129283(n) / gcd(A003959(n), A129283(n))
A348978 a(n) = A332993(n) / gcd(A000203(n), A332993(n))
A336837 a(n) = A336841(n) / gcd(A000005(n), A336841(n))
A341526 a(n) = A341528(n) / gcd(A341528(n), A341529(n))
A341527 a(n) = A341529(n) / gcd(A341528(n), A341529(n))
A354987 a(n) = A344005(n) / gcd(A047994(n), A344005(n))
A344971 a(n) = A344875(n) / gcd(A011772(n), A344875(n))