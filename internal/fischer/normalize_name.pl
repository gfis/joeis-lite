#!perl

# Convert names to regular expressions
# @(#) $Id$
# 2019-08-29: read jnames.txt
# 2019-04-06, Georg Fischer
#
#:# Usage:
#:#   perl normalize_name.pl [-d debug] $(COMMON)/jnames.txt > analog1.tmp
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) { # read inputfile
    next if m{\A\s*\#}; # skip comment lines
    next if m{\A\s*\Z}; # skip empty lines
    s/\s+\Z//; # chompr
    my ($aseqno, $superclass, $name, $keyword, $range) = split(/\t/);
    # $superclass =~ s{\Anull\Z}{\{\}      };
    $superclass =~ s{\Anull\Z}{ZZ      };
    $superclass .= "    "; # for class A123456 
    $name =~ s/\s*\Z//; # remove trailing spaces
    $name =~ s/\.\Z//;  # remove trailing dot
    $name =~ s/\s*\Z//; # remove trailing spaces
    # $name =~ s{\s+([\-\+\=\*\/\^])\s+}{$1}g; # remove space around operators
    if ($name =~ m{zero|one|two|three|four|fiv|six|seven|eight|nin|ten|eleven|twelv|first|second|third}i) { 
        # number words 0-12
        $name =~ s{Zeroe?(s|th|) }  {0$1 };
        $name =~ s{One(s|th|) }     {1$1 };
        $name =~ s{First }          {1st };
        $name =~ s{Two(s|th|) }     {2$1 };
        $name =~ s{Second }         {2st };
        $name =~ s{Three(s|th|) }   {3$1 };
        $name =~ s{Third }          {3st };
        $name =~ s{Four(s|th|) }    {4$1 };
        $name =~ s{Five(s|th|) }    {5$1 };
        $name =~ s{Six(s|th|) }     {6$1 };
        $name =~ s{Seven(s|th|) }   {7$1 };
        $name =~ s{Eight(s|th|) }   {8$1 };
        $name =~ s{Nine(s|th|) }    {9$1 };
        $name =~ s{Ten(s|th|) }     {10$1 };
        $name =~ s{Eleven(s|th|) }  {11$1 };
        $name =~ s{Twelve(s|th|) }  {12$1 };

        $name =~ s{ zeroe?(s|th|) } { 0$1 }g;
        $name =~ s{ one(s|th|) }    { 1$1 }g;
        $name =~ s{ first }         { 1st }ig;
        $name =~ s{ two(s|th|) }    { 2$1 }g;
        $name =~ s{ second }        { 2st }ig;
        $name =~ s{ three(s|th|) }  { 3$1 }g;
        $name =~ s{ third }         { 3st }ig;
        $name =~ s{ four(s|th|) }   { 4$1 }g;
        $name =~ s{ five?(s|th|) }   { 5$1 }g;
        $name =~ s{ six(s|th|) }    { 6$1 }g;
        $name =~ s{ seven(s|th|) }  { 7$1 }g;
        $name =~ s{ eight(s|th|) }  { 8$1 }g;
        $name =~ s{ nine?(s|th|) }   { 9$1 }g;
        $name =~ s{ ten(s|th|) }    { 10$1 }g;
        $name =~ s{ eleven(s|th|) } { 11$1 }g;
        $name =~ s{ twelve?(s|th|) } { 12$1 }g;
    } # number words 0-12
    $name =~ s{(\d+)}{\(\\d+\)}g; # generalize numbers
    $name =~ s{([^a-zA-Z])\s+([^a-zA-Z])}{$1$2}g;  # remove space around operators
    $name =~ s{(\W)k(\W)}  {$1n$2}g; # single k -> n
    # $name =~ s{A\(\\d\+\)}{Annnnnn}g;
    if ($name !~ m{A\(\\d\+\)}) {
        if (0) {
            print join("\t", $aseqno, substr($superclass, 0, 8) # cc
                , 'X'       # offset
                , 'X'       # p1
                , 'X'       # p2
                , $keyword  # p3
                , $range    # p4
                , 'X'       # p5
                , 'X'       # p6
                , 'X'       # p7
                , 'X'       # p8
                , substr($name, 0, 512) # name
                ) . "\n";
        } else {
            print join("\t", $aseqno, substr($superclass, 0, 8) # cc        }
                , substr($name, 0, 512) # name
                ) . "\n";
        }
    }
} # while <>
#---------------------------------------
__DATA__
A000014 Sequence    Number of series-reduced trees with n nodes.    nonn,easy,core,nice,    0..500
A000015 Sequence    Smallest prime power >= n.  nonn,easy,  1..10000
A000016 Sequence    a(n) = number of distinct (infinite) output sequences from binary n-stage shift register which feeds back the complement of the last stage. E.g., for n=6 there are 6 such sequences.   nonn,nice,easy,changed, 0..3334
A000017 null    Erroneous version of A032522.   dead,synth  1..19
A000018 Sequence    Number of positive integers <= 2^n of form x^2 + 16y^2. nonn,synth  0..36
A000019 null    Number of primitive permutation groups of degree n. nonn,core,nice,changed, 1..2499
A000020 PrependS    Number of primitive polynomials of degree n over GF(2). nonn,   1..400
A000021 A000018 Number of positive integers <= 2^n of form x^2 + 12 y^2.    nonn,synth  0..36
A000022 A000678 Number of centered hydrocarbons with n atoms.   nonn,easy,nice, 0..60
A000023 Sequence    Expansion of e.g.f. exp(-2*x)/(1-x).    sign,easy,  0..250
A000024 A000018 Number of positive integers <= 2^n of form x^2 + 10 y^2.    nonn,synth  0..36
A000025 Sequence    Coefficients of the 3rd order mock theta function f(q). sign,easy,nice,changed, 0..10000
A000026 Sequence    Mosaic numbers or multiplicative projection of n: if n = Product (p_j^k_j) then a(n) = Product (p_j * k_j). nonn,easy,nice,mult,    1..10000
A000027 Sequence    The positive integers. Also called the natural numbers, the whole numbers or the counting numbers, but these terms are ambiguous.   core,nonn,easy,mult,tabl,changed,   1..500000
