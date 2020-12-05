#!perl

# Extract parameters for product formulas 1/(1 - x^k)^(abc) and similiar
# 2020-12-04: (1 +- ax^k)^(b*k) etc.
# 2020-10-10, Georg Fischer
#
#:# Usage:
#:#   perl prodet.pl [-d debug] [-f ofter_file] prod1_xk.gen > prodet.gen
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my $negate = 0; # whether "not modulo ..."
my $VOID = "A000000";
my ($aseqno, $callcode, $offset, $var, $name, @rest);
my $rseqno;
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $debug   = 0;
my $pseudo  = 0;
my $prepend = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } elsif ($opt   =~ m{\-prep} ) {
        $prepend    = 1;
    } elsif ($opt   =~ m{\-pseudo} ) {
        $pseudo     = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------
while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $var, $name, @rest) = split(/\t/, $line);
    $name =~ s{\>\=1\}}{\>0\}};
    $name =~ s{\^\((A\d+\([i-n]\))\)}{\^$1}g;
    $rseqno = $VOID;
    if (0) {

    } elsif ($name =~ m{Prod(uct)?_\{([i-n])\>0\}\s*1\/\(1\s*\-\s*[xq]\^\2\)\^(A\d+)\(\2\)}) {
        # Product_{k>0} 1/(1 - x^k)^A056924(k)
        $rseqno = $3;
        $callcode = "prodet";
        &output();

    } elsif ($name =~ m{Prod(uct)?_\{([i-n])\>0\}\s*\(1\s*\-\s*][xq]\^\2\)\^(A\d+)\(\2\)}) {
        # Product_{k>0} (1 - x^k)^A038548(k)
        $rseqno = $3;
        $callcode = "prodetn";
        &output();

    } elsif ($name =~ m{Prod(uct)?_\{([i-n])\>0\}\s*1\/\(1\s*\+\s*[xq]\^\2\)\^(A\d+)\(\2\)}) {
        # Product_{k>0} 1/(1 + x^k)^A056924(k)
        $rseqno = $3;
        $callcode = "prodetq";
        &output();

    } elsif ($name =~ m{Prod(uct)?_\{([i-n])\>0\}\s*\(1\s*\+\s*][xq]\^\2\)\^(A\d+)\(\2\)}) {
        # Product_{k>0} (1 + x^k)^A038548(k)
        $rseqno = $3;
        $callcode = "prodetp";
        &output();

    #--------
    # %N A116377 Number of partitions of n into parts with digital root = 7.
    # %N A147787 Number of partitions of n into parts divisible by 4,6 or 9.
    # etc.
    } else {
        # print STDERR "$aseqno\t$name\n";
    }
} # while <>
#================================
sub output { # global $line, @periods, $reason
    if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
        print join("\t", $aseqno, $callcode, $offset, $rseqno, 1, '', '', $name) . "\n";
    }
} # output
#--------
__DATA__
A319669 prod1_xk.pl 0   k   Product_{k>=1} (1 - x^k)^(2*k-1)

A321285 prod1_xk.pl 0   k   Product_{k>0} 1/(1 - x^k)^A056924(k)
A321286 prod1_xk.pl 0   k   Product_{k>0} (1 + x^k)^A056924(k)
A321299 prod1_xk.pl 0   k   Product_{k>0} (1 - x^k)^A038548(k)
A321300 prod1_xk.pl 0   k   Product_{k>0} (1 - x^k)^A056924(k)
A321302 prod1_xk.pl 0   k   Product_{k>=1} ((1 - x^k)/(1 + x^k))^A007426(k)
A321317 prod1_xk.pl 0   k   Product_{k>=1} (1 - x^k)^A074206(k) where A074206(n) is the number of ordered factorizations of n
A321325 prod1_xk.pl 0   k   Product_{k>0} (1 + x^k)^A067856(k)
A321326 prod1_xk.pl 0   k   Product_{k>0} (1 - x^k)^A067856(k)
A321327 prod1_xk.pl 0   k   Product_{k>=0} (1 - x^(2^k))^(2^k)
A321336 prod1_xk.pl 0   k   Product_{k>=0} (1 - x^(2^k))^(2^(k+1))
A321354 prod1_xk.pl 0   k   Product_{k>=0} (1 + x^(3^k))^(3^(k+1))
A321355 prod1_xk.pl 0   k   Product_{k>=0} (1 + x^(4^k))^(4^(k+1))
A321357 prod1_xk.pl 0   k   Product_{k>=0} (1 + x^(5^k))^(5^(k+1))
A321359 prod1_xk.pl 0   k   Product_{k>0} (1 + x^k)^A034836(k)
