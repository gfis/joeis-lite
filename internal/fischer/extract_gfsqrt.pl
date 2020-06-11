#!perl

# Grep generating functions with sqrt() for JoeisPreparer 
# @(#) $Id$
# 2020-01-05: $factor
# 2020-04-06, Georg Fischer: copied from holrec/gfsqrt_grep.pl
#
#:# Usage:
#:#   perl extract_gfsqrt.pl $(COMMON)/cat25.txt > gfsqrt1.tmp
#:#   $(RAMATH).sequence.JoeisPreparer -f          gfsqrt1.tmp
#--------------------------------------------------------------
use strict;
use integer;
use warnings;

my $line;
my $aseqno;
my $expr;
my $factor; # $factor/sqrt()
my $gftype; # "e" if e.g.f, "o" otherwise
my $callcode;

while(<>) {
    s{\s+\Z}{}; # chompr
    $line   = $_;
    $gftype = "o";
    $callcode = "gfsqrt";
    if (0) {
    #                              1        2                 34                      5                    6           
    } elsif ($line =~ m{\A\%[NF]\s+(A\d+)\s+(Expansion of\s*)?(([EO]\.)?G\.f\.\:?\s*)?(A\([t-z]\)\s*\=\s*)?([^\.\;]+)}i) { 
        $aseqno  = $1;
        $gftype  = $4 || "o";
        $expr    = $6;
        $expr =~ s{\s}{}g;
        if ($expr =~ m{[Ss]qrt[\(\[]}) {
        	print join("\t", $aseqno, $callcode, 0, $expr, $gftype) . "\n";
        }
    }
} # while <>
__DATA__
