#!perl

# Extract g.f.s with product of (1-x^k)
# 2020-09-18, Georg Fischer
#
#:# Usage:
#:#   grep -iE "prod" $(COMMON)/cat25.txt \
#:#   | perl prod1_xk.pl [-d debug] input > output
# Generates the following callcodes:
#   prod1_xk
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $nparm = 5; # counted from 0
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $nparm     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $aseqno1  = "A035143"; # superclass for all following
my $aseqno;
my $form = "";
my $exp = "";
my $callcode = "prod1_xk";
my $tcode;
my $name;

while (<>) {
    my $line = $_;
    if ($line =~ m{\A\%(\w)\s+(A\d+)\s+(.*)}) {
        ($tcode, $aseqno, $name) = ($1, $2, $3);
        # $name =~ s{\..*}{};
        $form = "";
        $exp = "";
        if (0) {
        } elsif ($name =~ m{\A(G\.f\.\s*\:?|Expansion of|)\s*([Pp]rod(uct)?\_\{(\w)[\>\=01 ]+\}\s*[^\.\=\;]*)}) {
            # %F A160974 G.f.: Product_{j>=1} (1+x^(4*j)/(1-x^j)). - _Emeric Deutsch_, Jun 24 2009
            $exp = $4;
            $form = $2;
            # $form =~ s{\..*}{};
            &output();
        } elsif ($name =~ m{\A(G\.f\.\s*\:?|Expansion of|)\s*([Pp]rod(uct)?\_\{(\w)[\>\=01 ]+\}\s*[^\.\=\;]*)}) {
            # %N A047638 Expand {Product_{j>=1} (1-(-x)^j) - 1}^13 in powers of x.
            # %N A047639 Expand (Product_{j>=1} (1-x^j) - 1)^14 in powers of x.

            # %F A075511 G.f.: 1/Product_{k=1..6} (1 - 2*k*x).
            # %F A075512 G.f.: 1/Product_{k=1..7} (1 - 2*k*x).
            # %F A075515 G.f.: 1/Product_{k=1..5} (1 - 3*k*x).
            # %F A075516 G.f.: 1/Product_{k=1..6} (1 - 3*k*x).
            # grep -E "G\.f\.\: 1\/Product_\{k\=1\.\." cat25.txt | wc -> 37
            # 
            # %F A112502 G.f.: 1/product((1-j*x)^(4-j), j=1..3) = 1/(((1-x)^3)*((1-2*x)^2)*(1-3*x)).
            # %F A112503 G.f.: 1/product((1-j*x)^(5-j), j=1..4) = 1/(((1-x)^4)*((1-2*x)^3)*((1-3*x)^2)*(1-4*x)).
            # %F A112504 G.f.: 1/product((1-j*x)^(6-j), j=1..5) = 1/(((1-x)^5)*((1-2*x)^4)*((1-3*x)^3)*((1-4*x)^2)*(1-5*x)).
            # 
            print STDERR "$line";
        } else {
            print STDERR "$line";
        }
    }
} # while <>
#----
sub output {
    print join("\t", $aseqno, $callcode, 0, $exp, $form). "\n";
} # output
#================================
__DATA__
