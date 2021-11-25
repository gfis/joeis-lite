#!perl

# prodsi.pl - a(n) = Product_{k=0..n} (3*k + 1)!.
# 2021-11-18, Georg Fischer
# E.g. A323545 a(n) = Product_{k=0..n} (k^7 + (n-k)^7). nonn 0..79
#
use strict;
use integer;

my ($aseqno, $cc, $name, $keyword, $bfrange, @rest);
my ($var1, $start1, $end1, $form, $ok, $offset);
while (<>) {
    ($aseqno, $cc, $name, $keyword, $bfrange, @rest) = split(/\t/);
    $bfrange =~ m{\A(\d+)};
    $offset = $1;
    $ok = 0;
    if ($cc eq "null") {
        if ($name =~ m{Product_\{([\w\+\-]+) *\= *(\d+)\.\.([\w\+\-]+)\} *(.*)}) {
            $cc = "prodsi";
            $var1 = $1;
            $start1 = $2;
            $end1 = $3;
            $form = $4;

            $end1 =~ s{n}{mN}g;
            $end1 =~ s{\-}{ \- }g;
            $end1 =~ s{(\d+)mN}{$1 \* mN}g;

            $form =~ s{\.\Z}{};
            $form =~ s{([nk])\^2}{$1\*$1}g;
            $form =~ s{\^}{\.pow\(}g;
            $form =~ s{(\d+)([i-n]+)}{$1 \* $2}g;
            $form =~ s{\bn\b}{mN}g;
            if ($form =~ m{\A(\(.*\))\!}) {
                $form = "FACTORIAL.factorial$1";
                $cc .= "f";
            }
            if ($form =~ s{binomial}{Binomial.binomial}g) {
                $cc .= "b";
            }
        #   $form =~ s{(\A|\W)n(\W|\Z)}{"$1" . mN . "$2"}eg;
            $ok = 1;
            # Product_{i=0..
        } else {
            ($var1, $start1, $end1, $form) = ("k", 1, "mN", "??");
        }
        if ($ok) {
            print        join("\t", $aseqno, $cc, $offset, $form, "for (int $var1 = $start1; $var1 <= $end1; ++$var1) {", "", $name) . "\n";
        } else {
            print STDERR join("\t", $aseqno, $cc, $offset, $form, "for (int $var1 = $start1; $var1 <= $end1; ++$var1) {", "", $name) . "\n";
        }
    } # null
} # while <>
__DATA__
A294318 prodsi  0   for (int k = 0; k <= mN; ++k) { (3*k + 1)!      a(n) = Product_{k=0..n} (3*k + 1)!.
