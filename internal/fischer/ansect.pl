 #!perl

# Determine bi-/tri-/...sections
# @(#) $Id$
# 2022-12-29, Georg Fischer: copied from bisect0.pl
#
#:# Usage:
#:# grep -P "a\(n\) *\= *A\d+\(\d+\*?n([\+\-]\d+)\)" $(COMMON)/jcat25.txt | grep -E "^\%[NFCY] A[0-9]" \
#:# | perl ansect.pl \
#:# 2>       $@.rest.tmp \
#---------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $line;
my ($aseqno, $callcode, $offset, $superclass, $rseqno, $polar, $lista, $listr, $name);
my $cc = "ansect";
my $rest;
my $COMMON = "../../../OEIS-mat/common";
my $ofter_file = "$COMMON/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = $offset; # "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = substr($_, 3);
    $line =~ s{\. \- _.*}{}; # remove all behind signature
    $line =~ s{ }{\t};
    ($aseqno, $name) = split(/\t/, $line);
    if (! defined($ofters{$aseqno})) { # nyi in jOEIS
        my $aai = 1; # all already implemented
        foreach $rseqno ($name =~ m{(A\d+)}g) { 
            if (!defined($ofters{$rseqno})) {
                $aai = 0;
            }
        }
        if ($aai == 1) {
            $polar = -2; 
            print        join("\t", $aseqno, $cc, -2, $rseqno, $polar, "",   "",   substr($name, 0, 128)) . "\n";
            #                                         parm1    parm2   parm3 parm4 parm5 
        } else {
            print STDERR join("\t", $aseqno, "?rseqno", -2, $rseqno, $name) . "\n";
        }
    } # nyi
} # while <>
#--------
__DATA__
%F A062739 It is not true that a(n) = A001694(2n-1).
%F A067321 a(n) = A067297(2n+1)/2.
%F A067322 a(n) = A067302(2n+1) = (2*n+3)*A067297(2*n+1)/2.
%F A068181 a(n)=A007661(6n+1)=A032031(3n+1)
%C A071628 When 2n-1 is the k-th prime, then a(n) = A040076(2n-1) = A046067(n) = A057192(k). [This is only partially correct. If 2n-1 = 2^2^m + 1 is a Fermat prime, then a(n) = min{2^m, A040076(2n-1)} if 2n-1 is not a Sierpiński number and a(n) = 2^m otherwise, since phi((2n-1)^2) = (2n-1)*2^m. For example, a(129) = 8 < A040076(257) = 279, a(32769) = 16 < A040076(65537) = 287. - _Jianing Song_, Dec 14 2021]
%F A071635 a(n) = A002375(2*n+1) - A156642(n). - _Vladimir Shevelev_, Feb 12 2009
%F A072451 a(n) = A055034(2*n-1), n >= 1. - _Wolfdieter Lang_, Feb 07 2020
