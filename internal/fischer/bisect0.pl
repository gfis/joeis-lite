#!perl

# Determine polarity for bisections
# @(#) $Id$
# 2021-05-28, Georg Fischer
#
#:# Usage:
#:#  grep -Ei "section of A[0-9]+" $(COMMON)/joeis_names.txt \
#:# | perl bisect0.pl > seq4-format
#---------------------------------
use strict;
use integer;
use warnings;

my $line;
my ($aseqno, $callcode, $offset, $rseqno, $polar, $lista, $listr, $name);
my $cc = "bisect";

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    $aseqno = substr($line, 0,7);
    $line =~ m{^..*(A\d+)}; 
    my $rseqno = $1;
    my $polar = -2; 
    if ($line =~ m{(even |odd |first |second |third |)bisection}i) { 
        $polar = substr(lc($1), 0, 1); 
        $polar =~ tr{eofst}{01102}; 
    }
    print join("\t", $aseqno, "bisect", -2, $rseqno, $polar, "", "", substr($line, 8)) . "\n";
} # while <>
#--------
__DATA__
