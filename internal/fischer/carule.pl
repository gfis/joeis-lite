#!perl

# Extract parameters for sequences with cellular automaton rules
# @(#) $Id$
# 2019-07-24, Georg Fischer
#
#:# Usage:
#:#   perl gen_linrec.pl [-d debug] [-t] infile > outfile
#:#       infile has the format: A-number tab name 
#:#       -t test mode, check which patterns where found
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $max_term = 16;
my $max_size = 16; 
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $test_mode = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $test_mode = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

# print `head -n16 $namesfile`;    
my $line;
my $aseqno;
my $rest;
my $gen_count = 0;
my $rule;
my $dim; # dimension: 1 or 2
my $color; # 1 = (ON,black), 0 = (OFF,white)
my $code; 

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $line =~ s{ }{\t}; # only the first
    ($aseqno, $rest) = split(/\t/, $line);
    if (($rest =~ m{cellular automat}) and ($rest =~ m{\"?Rule (\d+)\"?}i)) {
        $rule = $1;
        $dim = 0;
        if (0) {
        } elsif ($rest =~ m{(two\-?dim|odd\-?rule)}i) {
            $dim = 2;
        } elsif ($rest =~ m{(one\-?dim|elementary)}) {
            $dim = 1;
        }
        if ($test_mode == 0) {
            $rest =~ s{\"?Rule (\d+)\"?}{Rule 17}i;
        }
        $rest =~ s{^a\(n\)\s*\=\s*}{};

        $rest =~ s{\(ON\,\s*black\)}{\(ON,black\)}ig;
        $rest =~ s{ON\s*\(black\)}{\(ON,black\)}ig;
        $rest =~ s{ON\s*cell}{\(ON,black\) cell}ig;
        $rest =~ s{black\s*(\(1\) )?cell}{\(ON,black\) cell}ig;

        $rest =~ s{\(OFF\,\s*white\)}{\(ON,white\)}ig;
        $rest =~ s{OFF\s*\(white\)}{\(OFF,white\)}ig;
        $rest =~ s{OFF\s*cell}{\(OFF,white\) cell}ig;
        $rest =~ s{white\s*(\(0\) )?cell}{\(OFF,white\) cell}ig;

        $rest =~ s{\,? starting with| when started with| initiated with}{ starting with}g;
        $rest =~ s{of number}{of the number}g;
        $rest =~ s{Partial Sums}{Partial sums}ig;
        $rest =~ s{of n\-th iteration}{of the n\-th iteration}g;
        $rest =~ s{differences? of (the )?numbers?}{differences of the numbers}g;
        $rest =~ s{\(and also [^\)]+\) |\, or (from|of) [^\,]+\,|\(or [^\)]+\) }{}g;
        $rest =~ s{(corner|edge|origin) of the n\-}{$1\, of the n\-}g;
        $color = 2;
        if (0) {
        } elsif ($rest =~ m{\(ON,black\)}) {
            $color = 1;
        } elsif ($rest =~ m{\(OFF,white\)}) {
            $color = 0;
        }
        $code = "UNSPEC";
        if (0) {
        } elsif ($rest =~ m{Triangle read by rows giving successive}) {
            $code = "TRI1";
        }
        if ($test_mode == 1) {
            print join("\t", $rest) . "\n";
            $gen_count ++;
        } else {
            ($aseqno, $rest) = split(/\t/, $line);
            print join("\t", $aseqno, $code, $rule, $dim, $color, $rest) . "\n";
        }
    } # m automaton, RUle
} # while <>
#--------------------------------------------
sub output {

} # output
__DATA__
