#!perl

# Extract parameter m from A0351nn sequences
# 2020-09-02, Georg Fischer: copied from find_period.pl
#
#:# Usage:
#:#   perl dirichlet_product.pl [-d debug] input > output
# Generates the following callcodes:
#   diriprod	normal subclass with m = $(PARM1)
#	diriprod1	superclass A035143 for m = -47
#	diripronz	non-zero terms of $(PARM2)
#	diriproin	indices of non-zero terms of $(PARM2)
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
my ($aseqno, $m);
while (<>) {
    my $line = $_;
    if (0) {
    } elsif ($line =~ m{\A(A\d+)\s+Coefficients in (the )?expansion of Dirichlet series Product_p}) {
        $aseqno = $1;
        $line =~ m{for\s+m\s*\=\s*(\-?\d+)};
        $m = $1;
        &output("diriprod",  $aseqno1);
    } elsif ($line =~ m{\A(A\d+)\s+a\(n\)\s*=\s*Sum_\{[^\}]+\}\s*[Kk]ronecker\((\-?\d+)\,\s*[a-z]\)}) {
        # a(n) = Sum_{d|n} Kronecker(-36, d)
        $aseqno = $1;
        $m = $2;
        &output("diriprod",  $aseqno1);
    } elsif ($line =~ m{\A(A\d+)\s+(Also, )?[iI]nd(ices |exes )of (the )?nonzero terms in (the )?expansion of Dirichlet series Product_p}) {
        # Indices of the nonzero terms in expansion of Dirichlet series Product_p (1-(Kronecker(m,p)+1)*p^(-
        $aseqno = $1;
        $line =~ m{for\s+m\s*\=\s*(\-?\d+)};
        $m = $1;
        &output("diriproin", $aseqno1);
    } elsif ($line =~ m{\A(A\d+)\s+Nonzero terms in (the )?expansion of Dirichlet series Product_p}) {
        # Nonzero terms in expansion of Dirichlet series Product
        $aseqno = $1;
        $line =~ m{for\s+m\s*\=\s*(\-?\d+)};
        $m = $1;
        &output("diripronz", $aseqno1);
    }
} # while <>
#----
sub output {
    my ($callcode, $rseqno) = @_;
    print join("\t", $aseqno, $callcode . (($aseqno eq $aseqno1) ? "1" : ""), 0, $m, $rseqno). "\n";
} # output
#================================
__DATA__
