#!perl

# Extract parameters for MorphismFixedPointSequence
# @(#) $Id$
# 2021-05-26, Georg Fischer
#
#:# Usage:
#:#   perl morfps.pl $(COMMON)/jcat25.txt > output.tmp
#
# A288596 Fixed point of the mapping 00->0101, 1->1000, starting with 00. nonn,easy,      1..10000
# A104521 Fixed point of the morphism 0->{1}, 1->{1,0,1}. nonn,synth      0..104
# A159689 Fixed point of the morphism 0 -> 0,1,0; 1 -> 1,1; starting from a(0)=0.
# A286937 {111->null}-transform of the Sturmian word A080764.     nonn,easy,      1..10000
# A286987 {111->1}-transform of the Sturmian word A080764.        nonn,easy,      1..10000morfix:
# A286804 {000->null}-transform of the Pell word, A171588.        nonn,easy,      1..10000
# A285952 {0->1, 1->10}-transform of the Thue-Morse word A010060. nonn,easy,synth 1..86 perl -ne \
# A285589 {00->0, 11->1}-transform of A285565.    nonn,easy,      1..10000
# A284387 {010->2}-transform of the infinite Fibonacci word A003849.      nonn,easy,changed,      1..10000
# A105203 Trajectory of 1 under the morphism f: 1->{1,2,1}, 2->{2,3,2}, 3->{3,1,3}.
# A212810 Iterate the morphism 1->122, 2->1112 starting with 1.
# A284388 0-limiting word of the morphism 0 -> 1, 1 -> 001.
#---------------------------------
use strict;
use integer;
use warnings;

my $line;
my $aseqno;
my $start;
my $map;
my $cc = "morfps";

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    $start = "";
    if (0) {
    } elsif ($line =~ m{^(A\d+)\s+.*([Ff]ixed (point )?(under |of )|Iterate |Substitution |generated by |[Rr]esult of |closed under )(the )?(mapping |map |morphism |morphing |\:|)([ 0-9\-\>\,\;\{\}\(\)\[\]]+)}i ) {
        ($aseqno, $map) = ($1, $7);
        &polish_map();
        print join("\t", $aseqno, $cc, 0, $start, "", $map, "", "", substr($line, 8)) . "\n";
    } elsif ($line =~ m{^(A\d+)\s+.*([Tt]rajectory of (\d+) |Image of (\d+) |(\d+)\-limiting word |[Ll]imiting (\d+)\-word )(under (repeated applications? of )?|of )(the )?(mapping|map|morphism)\:? ([ 0-9\-\>\,\;\{\}\(\)\[\]]+)}i) {
        ($aseqno, $map) = ($1, $11); 
        &polish_map();
        print join("\t", $aseqno, $cc, 0, $start, "", $map, "", "", substr($line, 8)) . "\n";
    } else {
        # ignore
    }
} # while <>
#--------
sub polish_map {
    $map =~ s{\,(\d)}{$1}g; # comma-list without spaces
    $map =~ s{\s}{}g; 
    $map =~ tr{\[\]\(\)}{\{\}\{\}};
    $map =~ s{\}\,}{\}\;}g;
    $map =~ s{[\,\;]\Z}{};
    if ($map =~ m{[\}\;]}) {
        $map =~ s{[\{\}\,]}{}g;
    }
    $map =~ s{\;}{\,}g;
    $map =~ m{\A(\d+)};
    if (! defined($start)) {
    	print STDERR "?? start? $line\n";
    } elsif ($start eq "") {
        if ($line =~ m{(start |starting |started |apply |applied )(with |from |to |at )([a-z]\(\d\)\D*)?(\d+)}i) {
            $start = $4;
        } else {
            if ($map =~ m{\A(\d+)}) {
                $start = $1;
            }
        }
    }
    while ($map =~ m{\-\>((\d\,){2,})(\d+)\-\>}) {
        my ($p1, $p2, $p3) = ($1, $2, $3);
        my $o1 = $p1;
        $p1 =~ s{\,}{}g;
        $map =~ s{\-\>$o1$p3\-\>}{\-\>$p1,$p3\-\>};
    } # while map
    $start =~ s{\D}{}g;
} # polish_map
#--------
__DATA__
# A316329 (b-file synthesized from sequence entry)
0 3
1 312
2 313112
3 31211211112
4 31211211112111111112
5 3121121111211111111211111111111111112
6 3121121111211111111211111111111111112111111111111111111111111111111112

# Table of n, a(n) for n = 0..6
# Generated by Georg Fischer with jOEIS, Mai 26 2021
0 3
1 312
2 312112
3 31211211112
4 31211211112111111112
5 3121121111211111111211111111111111112
6 3121121111211111111211111111111111112111111111111111111111111111111112
