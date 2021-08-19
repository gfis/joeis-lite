#!perl

# Extract sequences related to sums of like powers
# @(#) $Id$
# 2020-08-05, Georg Fischer
#
#:# Usage:
#:#   perl sumlipo.pl [-d debug] joeis_names.txt > sumlipo.gen
#-------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) < 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my %integers = qw(zero 0 one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9 ten 10 
    eleven 11 twelve 12  thirteen 13 fourteen 14 fifteen 15 sixteen 16 seventeen 17 eighteen 18 nineteen 19
    twenty 20);
    
my ($line, $aseqno, $superclass, $callcode, $name, $keyword, $range);
my   
        ($arenot, $base, $mquant, $distinct, $xquant , $least, $mult, $ordered, $wquant, $pow, $ways, $yquant)
    ;
# while (<DATA>) { # read inputfile
while (<>) { # read inputfile
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, $keyword, $range) = split(/\t/, $line);
    $callcode = "sumlipo";
    $name    =~ s{  +}{ }g;
    $name    =~ s{ of integers? }    { }g;
    $name    =~ s{ which }           { that }g;
    $name    =~ s{ a }               { the }g;
    $name    =~ s{[Ss]ums? }         {sum }g;
    $name    =~ s{\A(Numbers? )([nk] )?(that are )?(that have |with |(that can be written|writeable|expressible) as |having )?(the )?}{};
    $name    =~ s{ (\w+) but no more}{ at most $1};
    $name    =~ s{ in more than (one|1)}{ at least 2};
    $name    =~ s{ different ways? } { way};
    $name    =~ s{ (\d+) or more}    { at least $1};
    $name    =~ s{ squares?}         { pow_2}g;
    $name    =~ s{ cubes?}           { pow_3}g;
    $name    =~ s{ biquadrates?}     { pow_4}g;
    $name    =~ s{ second powers?}   { pow_2}g;
    $name    =~ s{ third powers?}    { pow_3}g;
    $name    =~ s{ fourth powers?}   { pow_4}g;
    $name    =~ s{ fifth powers?}    { pow_5}g;
    $name    =~ s{ sixth powers?}    { pow_6}g;
    $name    =~ s{ seventh powers?}  { pow_7}g;
    $name    =~ s{ eigth powers?}    { pow_8}g;
    $name    =~ s{ nineth powers?}   { pow_9}g;
    $name    =~ s{ tenth powers?}    { pow_10}g;
    $name    =~ s{ eleventh powers?} { pow_11}g;
    $name    =~ s{ (\d+)th powers?}  { pow_$1}g;
    $name    =~ s{ \(pow_\d+ 0 allowed\)}{ };
    $name    =~ s{exactly }          {quant_eq }g;
    $name    =~ s{at least }         {quant_ge }g;
    $name    =~ s{or more }          {quant_ge }g;
    $name    =~ s{at most }          {quant_le }g;
    $name    =~ s{positive }         {least_1 }g;
    $name    =~ s{non\-?vanishing}   {least_1 }g;
    $name    =~ s{non\-?zero }       {least_1 }g;
    $name    =~ s{non\-?negative }   {least_0 }g;
    $name    =~ s{(pow_..) ?\> ?1}   {least_2 $1}g;
    $name    =~ s{  +}{ }g;
    $keyword =~ s{\,synth}{};
    $keyword =~ s{\,changed}{};
    # $keyword =~ s{\Anonn}{};

        ($arenot, $base, $mquant, $distinct, $xquant , $least, $mult, $ordered, $wquant, $pow, $ways, $yquant)
    =   (""     , ""   , ""     , ""       , ""      , ""    , ""   , ""      , ""     , ""  , ""   , "");
    # print "$name\n";
    if (0) {
    #----------------
    # A025284  sum of 2 least_1 pow_2 in quant_eq 1 way.
    # A346326	LimitedSumOfLikePowersSequence	Numbers that are the sum of eight fifth powers in exactly one way.	nonn,changed,	1..10000	unkn
    } elsif ($name =~ 
        #   1                 2           3               4           5          6        7    8           9      10
        m{\A(not the )?sum of (quant_.. )?([a-ce-z0-9]+ )?(distinct )?(least_. )?(pow_\d+)( in (quant_.. )?(\w+)? (quant_.. )?ways?)?} ) {
#       m{\A(not the )?sum of (quant_.. )?([a-ce-z0-9]+ )?} ) {
        ($arenot , $mquant         , $mult   , $distinct, $least  , $pow    , $wquant , $ways   , $yquant) = 
        ($1 || "", $2 || "quant_eq", $3 || -1, $4 || "" , $5 || "", $6 || -1, $8 || "", $9 || -1, $10 || "");
        &normalize();
        if ($ways < 1) {
            if ($arenot =~ m{not}) {
                $callcode = "sumlino";
            }
            if (0) { # would be necessary for jOEIS
                if ($mquant eq "quant_ge" or ($aseqno =~ m{A001481})) {
                    $least = "0";
                } else {
                    $least = $mult;
                }
            }
        } else { # with ways
            $callcode = "sumway";
            if (0) {
            } elsif ($yquant ne "") {
                $wquant = $yquant;
          # } elsif ($wquant ne "") {
          #     $wquant = $wquant;
            }
        } # with ways
        &output();
    #----------------
    # of representations of n as sum of three least_1 pow_4, i.e., fourth powers. <- A193243    null    Number of representations of n as sum of three positive biquadrates, i.e., fourth powers.   nonn,   0..30000
    } elsif ($name =~ 
        #      1          2            3                                                       4             5           6              7           8          9
        m{\Aof (ordered )?(different )?(representations of|ways to write|ways of writing) n as (the )?sum of (quant_.. )?([a-ce-z0-9]*) (distinct )?(least_. )?(pow_\d+)} ) {
        ($ordered, $mult   , $mquant         , $distinct, $least  , $pow     ) = 
        ($1 || "", $6 || -1, $5 || "quant_eq", $7 || "" , $8 || "", $9 || -1 );
        if (1) {
            $callcode = "sumwan";
            &normalize();
        }
        &output();
    #----------------
    # A295150 Numbers that have exactly two representations as a sum of five nonnegative squares.
    # A295150 Numbers that have exactly two representations as a sum of five nonnegative squares.   nonn,fini,full,changed,synth    1..10
    # quant_eq one representation as the sum of six least_0 pow_2. <- A295484   FiniteSequence  Numbers that have exactly one representation as a sum of six nonnegative squares.   nonn,fini,full,synth    1..5
    # having quant_eq one representation as sum of pow_2>1. <- A078136  FiniteSequence  Numbers having exactly one representation as sum of squares>1.  nonn,fini,full,synth    1..15
    } elsif ($name =~ 
        #   1           2                      3       4             5           6              7           8          9
        m{\A(quant_.. )?(\w+) representations? (as|of) (the )?sum of (quant_.. )?([a-ce-z0-9]*) (distinct )?(least_. )?(pow_\d+)} ) {
        ($wquant,   $mquant         , $mult   , $distinct, $least  , $pow    , $ways   ) = 
        ($1  || "", $5 || "quant_eq", $6 || -1, $7 || "" , $8 || "", $9 || -1, $2 || -1);
        if (1) {
            $callcode = "sumway";
            &normalize();
        }
        &output();
    #----------------
    # representable in quant_ge two ways as sum of four distinct nonvanishing pow_2. <- A259058 LinearRecurrence    Numbers that are representable in at least two ways as sums of four distinct nonvanishing squares.  nonn,easy,synth 0..40
    # ?? of representations of n as sum of three least_1 pow_4, i.e., fourth powers. <- A193243 null    Number of representations of n as sum of three positive biquadrates, i.e., fourth powers.   nonn,   0..30000
    } elsif ($name =~ 
        #                    1           2          3       4             5           6              7           8          9
        m{\Arepresentable in (quant_.. )?(\w+) ways (as|of) (the )?sum of (quant_.. )?([a-ce-z0-9]*) (distinct )?(least_. )?(pow_\d+)} ) {
        ($wquant,   $mquant         , $mult   , $distinct, $least  , $pow    , $ways   ) = 
        ($1  || "", $5 || "quant_eq", $6 || -1, $7 || "" , $8 || "", $9 || -1, $2 || -1);
        if (1) {
            $callcode = "sumway";
            &normalize();
        }
        &output();
    #----------------
    # A051343 Number of ways of writing n as a sum of 3 nonnegative cubes (counted naively).
    # of ways of writing n as the sum of 4 nonnegative pow_3
    # of ways of writing n as the sum of two nonnegative pow_3. <- A173677  null    Number of ways of writing n as a sum of two nonnegative cubes.  nonn,easy,  0..10000
    # of ways of writing n as the sum of 4 nonnegative pow_3. <- A173678    null    Number of ways of writing n as a sum of 4 nonnegative cubes.    nonn,easy,  0..10000
    # of ways of writing n as the sum of 5 nonnegative pow_3. <- A173679    null    Number of ways of writing n as a sum of 5 nonnegative cubes.    nonn,   0..10000
    # of ways to write n as sum of least_2 pow_2 . <- A078134   null    Number of ways to write n as sum of squares > 1.    nonn,changed,   1..10000
    } elsif ($name =~ 
        #      1               2                           3             4           5              6           7          8
        m{\Aof (ordered )?ways (of writing |to write )n as (the )?sum of (quant_.. )?([a-ce-z0-9]*) (distinct )?(least_. )?(pow_\d+)} ) {
        ($mquant         , $mult   , $distinct, $least  , $pow    , $ordered) = 
        ($2 || "quant_eq", $5 || -1, $6 || "" , $7 || "", $8 || -1, $1 || "");
        if (1) {
            $callcode = "sumway";
            &normalize();
        }
        &output();
    #----------------
    # A117535 Number of ways of writing n as a sum of powers of 3, each power being used at most 4 times.
    # ?? that cannot be written as the sum of least_2 pow_2 . <- A078135    FiniteSequence  Numbers which cannot be written as a sum of squares > 1.    nonn,fini,full,synth    1..12
    } elsif ($name =~ 
        #                                                1    2                         3           4    
        m{\Aof ways of writing n as the sum of powers of (\w+)(\, each power being used (quant_.. )?(\w+) times)?} ) {
        ($base     , $mquant         , $mult   ) = 
        ($1 || "-1", $3 || "quant_eq", $4 || -1);
        if (1) {
            $callcode = "sumwab";
            &normalize();
        }
        &output();
    #----------------
    } elsif (($line =~ m{Number}) 
         and ($name =~ m{ sum of })
         and ($name =~ m{ pow_\d+})
         ) { # not catched -> $@.rest
        print STDERR "$name <- $line\n";
    #----------------
    } else { # ignore
        # print "? $line\n";
    }
} # while <>
#----
sub output {
    if ($name =~ m{ and |arithmetic| but |consecutive|primitive|progression}) {
        print STDERR "$name <- $line\n";
    } elsif ($callcode !~ m{\Asum}) {
        print STDERR "$callcode? $name <- $line\n";
    } else {
        if ($callcode eq "sumwab") {
            $pow = $base;
        }
        print join("\t", $aseqno, $callcode, 0, $pow, $mult, $mquant, $least, $distinct, $ways, $wquant
                    , substr($name, 0, 120), $superclass) . "\n";
    }
} # output  
#----
sub normalize { # bring all attributes into a normalized form suitable for column headers; digitize number words
    #   ($arenot, $base, $mquant, $distinct, $xquant , $least, $mult, $ordered, $wquant, $pow, $ways)
    $arenot   =  length($arenot  ) > 0 ? "not"  : "are";
    $base     =  &norm_number($base  );
    $mquant   =  &norm_quant($mquant);
    $wquant   =  &norm_quant($wquant);
    $xquant   =  &norm_quant($xquant);
    $yquant   =  &norm_quant($yquant);
    $distinct =  length($distinct) > 0 ? "dist" : "nondist";
    if (length($least) > 0) {
        $least  =~ s{\Aleast_(\w).*}{\&gt;\=$1};
    } else {
        $least  = "&gt;=0";
    }
    $mult     =  &norm_number($mult);
    $ordered  =  length($ordered ) > 0 ? "ord"  : "unord";
    $pow      =~ s{pow_(\d+)}{$1};
    $pow      =  ($pow =~ m{\A\d+\Z}) ? $pow : -1; # escape value
    $ways     =  &norm_number($ways);
} # normalize
#----
sub norm_number { # convert number words to integers, or -1 if unknown
    my ($num) = @_;
    $num =~ s{ }{}g;
    if (! length($num) > 0) {
        $num = -1; # escape
    } elsif ($num =~ m{[a-z]}) {
        if (defined($integers{$num})) {
            $num = $integers{$num};
        } else {
            $num = -1;
        }
    }
    return $num;
}
#----
sub norm_quant { # normalize a quantifier
    my ($quant) = @_;
    $quant =~ s{\s}{}g; 
    $quant =~ s{quant_eq}{\=};
    $quant =~ s{quant_ge}{\&gt\;\=};
    $quant =~ s{quant_le}{\&lt\;\=};
    return $quant;
} # norm_quant
my $dummy = <<"GFis";
A003332 sumpow  1   A003343 9   3   1                   Numbers that are the sum of 9 positive cubes.
A003333 sumpow  1   A003344 10  3   1                   Sum of 10 positive cubes.
A003337 sumpow  1   A003337 3   4   1                   Numbers n which are the sum of 3 nonzero 4th powers.
A022544 sumlino 0       2               2       false   Numbers that are not the sum of 2 squares.

A025284 Numbers that are the sum of 2 nonzero squares in exactly 1 way.
A025293 Numbers that are the sum of 2 nonzero squares in exactly 10 ways.
A025301 Numbers that are the sum of 2 nonzero squares in 10 or more ways.
A025302 Numbers that are the sum of 2 distinct nonzero squares in exactly 1 way.
A025311 Numbers that are the sum of 2 distinct nonzero squares in exactly 10 ways.
A025312 Duplicate of A024508.
A025320 Numbers that are the sum of 2 distinct nonzero squares in 10 or more ways.
A025321 Numbers that are the sum of 3 nonzero squares in exactly 1 way.
A025330 Numbers that are the sum of 3 nonzero squares in exactly 10 ways.
A025338 Numbers that are the sum of 3 nonzero squares in 10 or more ways.
A025339 Numbers that are the sum of 3 distinct nonzero squares in exactly one way.
A025348 Numbers that are the sum of 3 distinct nonzero squares in exactly 10 ways.
A025356 Numbers that are the sum of 3 distinct nonzero squares in 10 or more ways.
A025366 Numbers that are the sum of 4 nonzero squares in exactly 10 ways.
A025367 Numbers that are the sum of 4 nonzero squares in 2 or more ways.
A025374 Numbers that are the sum of 4 nonzero squares in 9 or more ways.
A025375 Numbers that are the sum of 4 nonzero squares in 10 or more ways.
A025376 Numbers that are the sum of 4 distinct nonzero squares in exactly 1 way.
A025385 Numbers that are the sum of 4 distinct nonzero squares in exactly 10 ways.
A025394 Numbers that are the sum of 4 distinct nonzero squares in 10 or more ways.

A173676 Number of ways of writing n as a sum of seven nonnegative cubes.
A173677 Number of ways of writing n as a sum of two nonnegative cubes.
A173678 Number of ways of writing n as a sum of 4 nonnegative cubes.

A294524 FiniteSequence  Numbers that have a unique partition into a sum of five nonnegative squares.    nonn,fini,full,changed,synth    1..7
A294577 null    Numbers that are the sum of three squares (square 0 allowed) in exactly four ways.  nonn,changed,   1..1030
A294578 null    Numbers which can be expressed as an ordered sum of 3 squares in 6 or more different ways.  nonn,changed,   1..80080
A294594 null    Numbers that are the sum of three squares (square 0 allowed) in exactly five ways.  nonn,changed,   1..843
A294595 null    Numbers that are the sum of three squares (square 0 allowed) in exactly six ways.   nonn,changed,   1..1400

Numbers that have exactly two representations as the sum of five nonnegative squares. <- A295150    FiniteSequence  Numbers that have exactly two representations as a sum of five nonnegative squares. nonn,fini,full,changed,synth    1..10
Numbers that have exactly three representations as the sum of five nonnegative squares. <- A295151  FiniteSequence  Numbers that have exactly three representations as a sum of five nonnegative squares.   nonn,fini,full,synth    1..11

A173678 null    Number of ways of writing n as a sum of 4 nonnegative cubes.
A089050 Number of ways of writing n as a sum of exactly 5 powers of 2.
A117535 Number of ways of writing n as a sum of powers of 3, each power being used at most 4 times.

A008451 Number of ways of writing n as a sum of 7 squares.
A051343 Number of ways of writing n as a sum of 3 nonnegative cubes (counted naively).
GFis
#----------------
__DATA__
A346326	LimitedSumOfLikePowersSequence	Numbers that are the sum of eight fifth powers in exactly one way.	nonn,changed,	1..10000	unkn
