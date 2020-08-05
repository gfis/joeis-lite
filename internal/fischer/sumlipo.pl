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
my %integers = qw(zero 0 one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9 ten 10 eleven 11 twelve 12);

while (<>) { # read inputfile
    s/\s+\Z//; # chompr
    my $line = $_;
    my ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    my $callcode = "sumlipo";
    my ($pow, $min, $max, $dist, $atmost, $arenot);
    if (0) { #            1          2       3                                                            4          5            6           7                                       8
    } elsif ($name =~ m{\A(Numbers )?([nk] )?(that are the |which are the |that are not the )?[Ss]ums? of (at most )?(\d+|[a-z]+) (distinct )?(positive |non\-?zero |non\-?negative )?(cubes|squares|\d+th powers)(in 1 or more way)?[\.\:\;]} ) {
        ($arenot , $atmost , $max, $dist        , $min    , $pow) = 
        ($3 || "", $4 || "", $5  , $6 || "false", $7 || "", $8  );
        if ($dist =~ m{distinct *}) {
            $dist = "true";
            if ($min eq "") {
                $min  = 0;
            }
        }
        if ($arenot =~ m{not}) {
        	$callcode = "sumlino";
            if ($min eq "") {
                $min  = 0;
            }
            # $aseqno = ""; 
        }
        if ($max =~ m{[a-z]}) {
            if (defined($integers{$max})) {
                $max = $integers{$max};
            } else {
                $aseqno = ""; 
            }
        }
        $min  =~ s{(positive|nonzero) *}{$max};
        $min  =~ s{(non\-?negative) *}{0};
        if (length($atmost) > 4 or ($aseqno =~ m{A001481})) {
            $min = 0;
        }
        $pow  =~ s{(\d+)th powers}{$1};
        $pow  =~ s{squares}{2};
        $pow  =~ s{cubes}{3};
    } else {
        $aseqno = "";
    }
    if (length($aseqno) > 0) {
        print join("\t", $aseqno, $callcode, 0, $pow, $min, $max, $dist, $name) . "\n";
    }
} # while <>
__DATA__
A003332 sumpow  1   A003343 9   3   1                   Numbers that are the sum of 9 positive cubes.
A003333 sumpow  1   A003344 10  3   1                   Sum of 10 positive cubes.
A003337 sumpow  1   A003337 3   4   1                   Numbers n which are the sum of 3 nonzero 4th powers.
A022544 sumlino 0       2               2       false   Numbers that are not the sum of 2 squares.
