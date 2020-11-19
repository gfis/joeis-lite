#!perl

# Extract parameters for EgyptianFractionSequence
# @(#) $Id$
# 2020-11-19, Georg Fischer: copied from nisolut.pl
#
#:# Usage:
#:#     grep -E "Egyptian fraction " $(COMMON)/joeis_names.txt \
#:#     | perl egypfr.pl [-d debug] > egypfr.gen
#:#         -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $CC = "egypfr";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $line;
my @parms; # records in joeis_names.txt
my $matrix;
my $offset = 0;
my $callcode;
my ($aseqno, $superclass, $name);
my ($rest, $base);

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $line =~ m{\A(A\d+) +([^\.]*)};
    ($aseqno, $superclass, $name, my @dummy) = split(/\t/, $line);
    $callcode = $CC;
    @parms = ("", "");
#   if ($name =~ m{enominators}) {
#       $parms[1] = ",1";
#   }
    if (0) {
    
    } elsif ($name =~ m{r\-Egyptian fraction (.*)}i) {
        $rest = $1;
        # ignore r-ef.s for the moment
    } elsif ($name =~ m{Egyptian fraction (.*)}i) {
        $rest = $1;
        if (0) {
        #----
        } elsif ($rest =~ m{(the )?(sqrt|square root)\D*(\d+)\/(\d+)}i) {
            my ($num, $den) = ($3, $4);
            if (0) {
            } elsif ($num == 1) {
                $parms[0] = "CR.valueOf($den).inverse().sqrt()";
            } else {
                $parms[0] = "CR.valueOf($num).divide(CR.valueOf($den)).sqrt()";
            }
        #----
        } elsif ($rest =~ m{ 1\/sqrt\D*(\d+)}i) {
            $base = $1;
            $parms[0]     = "CR.valueOf($base).inverse().sqrt()";
        #----
        } elsif ($rest =~ m{(sqrt|square root)\D*(\d+)\s*([\-\+]\s*\d+)?}i) {
            $base = $2;
            my $add = $3 || "";
            $parms[0]     = "CR.valueOf($base).sqrt()";
            if ($add ne "") {
                $add =~ s{ }{}g;
                $add =~ s{(\D)1\Z}{${1}CR.ONE};
                $add =~ s{\+(.*)}     {.add\($1\)};
                $add =~ s{\-(.*)}{.subtract\($1\)};
                $parms[0] .= $add;
            }
        #----
        } elsif ($rest =~ m{(the )?cube root\D*(\d+)}i) {
            $base = $2;
            $parms[0]     = "CR.valueOf($base).log().divide(CR.THREE).exp()";
            $parms[1]     = ",1";
        #----
        } else { 
            # $parms[0] eq ""
        }
    } # if "Egyptian fraction"
 
    if ($parms[0] ne "") {
        print        join("\t", $aseqno, $callcode, $offset, @parms, "", "", $name) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $callcode, $offset, @parms, "", "", $name) . "\n";
    }
} # while <>
#----------------
__DATA__
A006487 Sequence    Denominators of greedy Egyptian fraction for square root of 2.  nonn,   0..11
A006524 Sequence    Egyptian fraction for 1/ Pi.    nonn,frac,changed,  1..11
A069139 null    Egyptian fraction for square root of 1/2.   nonn,changed,   0..10
A129702 null    Egyptian Fraction representation for the cube root of 2.    frac,nonn,synth 1..7
A132480 null    Egyptian fraction representation for the cube root of 3.    frac,nonn,synth 1..8
A142725 null    Denominators of an Egyptian fraction for 1/Sqrt[17] = 0.242535625...    frac,nonn,synth 1..8
A142726 null    Denominators of an Egyptian fraction for 1/Sqrt[20] = 0.2236067977...   frac,nonn,synth 1..8
A144983 null    Denominators of greedy Egyptian fraction for 1/sqrt(3) (A020760).   nonn,frac,changed,synth 1..7
A144984 null    Denominators of an Egyptian fraction for 1/sqrt(5) (A020762).   nonn,frac,changed,  1..11
A144985 null    Denominators of an Egyptian fraction for 1/Sqrt[6]=0.408248290463863... frac,nonn,synth 1..8

A030541	FiniteSequence	Remainder-numerators from Egyptian fraction expansion of 2/588391 using odd greedy algorithm.	nonn,fini,full,synth	0..26
A030542	FiniteSequence	Remainder-numerators from Egyptian fraction expansion of 4/538199 using odd greedy algorithm.	nonn,fini,full,synth	0..27
A030543	FiniteSequence	Remainder-numerators from Egyptian fraction expansion of 3/46547 using odd greedy algorithm.	nonn,fini,full,synth	0..27
A030544	FiniteSequence	Remainder-numerators from Egyptian fraction expansion of 2/24631 using odd greedy algorithm.	nonn,fini,full,synth	0..28
A030545	FiniteSequence	Remainder-numerators from Egyptian fraction expansion of 6/104651 using odd greedy algorithm.	nonn,fini,full,synth	0..29
A030546	FiniteSequence	Remainder-numerators from Egyptian fraction expansion of 5/5809 using odd greedy algorithm.	nonn,fini,full,synth	0..29
