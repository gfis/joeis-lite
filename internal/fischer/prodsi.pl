#!perl

# prodsi.pl - a(n) = Product_{k=0..n} (3*k + 1)!.
# 2021-11-18, Georg Fischer
# E.g. A323545 a(n) = Product_{k=0..n} (k^7 + (n-k)^7). nonn 0..79
#
use strict;
use integer;

my ($aseqno, $cc, $offset, $name, @rest);
my ($var1, $beg1, $end1, $form, $cond, $ok, $offset);
while (<>) {
    s{\s+\Z}{}; # chompr
    ($aseqno, $cc, $offset, $name, @rest) = split(/\t/);
    $ok = 0;
    if (0) {
    } elsif ($name =~ m{Product_\{([\w\+\-]+) *\= *(\d+)\.\.([\w\+\-]+)\} *(.*)}) {
        $cc   = "prodsi";
        $var1 = $1;
        $beg1 = $2;
        $end1 = $3;
        $form = $4;
        &polish();
        $ok = 1;
        print        join("\t", $aseqno, $cc, $offset, "sum($beg1, $end1, $var1 -> $form)", "|", $name) . "\n";
        # Product_{i=0..
    } elsif ($name =~ m{[sS]um_\{(\w+) *\= *(\d+) *(\.\.|to) *([\w\+\-]+)\} *(.*)}) {
        $cc   = "sumsi";
        $var1 = $1;
        $beg1 = $2;
        $end1 = $4;
        $form = $5;
        &polish();
        $ok = 1;
        if (length($end1) < 1024) {
            print        join("\t", $aseqno, $cc, $offset, $beg1, $end1, $var1, $form, $cond, "", "| $name") . "\n";
        }
        # Product_{i=0..
    } else {
        ($var1, $beg1, $end1, $form) = ("k", 1, "mN", "??");
    }
    # return Integers.SINGLETON.sum(1, mN, j -> Binomial.binomial(mN, j - 1).multiply(Binomial.binomial(3 * mN - 2 * j - 1, mN - j)).divide(2 * mN - j));
    if ($ok == 0) {
        print STDERR join("\t", $aseqno, $cc, $offset, "sum($beg1, $end1, $var1 -> $form)", "|", $name) . "\n";
    }
} # while <>
#----
sub polish {
    $name =~ s{\. - .*}{};
    $var1 =~ s{\bn\b}{mN}g;
    $beg1 =~ s{\bn\b}{mN}g;
    $end1 =~ s{\bn\b}{mN}g;
    $end1 =~ s{\-}{ \- }g;
    $end1 =~ s{(\d+)([i-n]+)}{$1 \* $2}g;
    $form =~ s{\..*}{};
    $cond = "";
    if ($form =~ s{ for (.+)}{}) {
        $cond = $1;
    }
    if ($form =~ s{\,? *where (.+)}{}) {
        $cond = $1;
    }
    if ($form =~ s{\;(.*)}{}) {
        $cond = $1;
    }
    $form =~ s{([i-n])\^2}{$1\*$1}g;
    $form =~ s{\^(\w)}{\.pow\($1\)}g;
    $form =~ s{(\d+)([i-n]+)}{$1 \* $2}g;
    $form =~ s{\bn\b}{mN}g;
    if ($form =~ m{\A(\(.*\))\!}) {
        $form = "FACTORIAL.factorial$1";
        $cc .= "f";
    }
    $form =~ s{binomial}{Binomial.binomial}g;
    $form =~ s{C(\([^\)]+\))}{Binomial.binomial$1}g;
    $beg1 =~ s{ }{}g;
    $end1 =~ s{ }{}g;
    $form =~ s{ }{}g;
    $ok = 1;
} # polish
__DATA__
A294318 prodsi  0   for (int k = 0; k <= mN; ++k) { (3*k + 1)!      a(n) = Product_{k=0..n} (3*k + 1)!.
