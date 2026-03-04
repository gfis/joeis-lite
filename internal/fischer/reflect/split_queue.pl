#!perl

# Read a *.pack file and patch all members
# @(#) $Id$
# 2026-02-16, Georg Fischer: copied from patch_queue.pl; *WP=80
#
#:# Usage:
#:#   perl split_queue.pl [-d debug] [-m mode] infile > outfile
#:m        -m abstract  AbstractSequence, (this|super)\(\d[\)\,]\)
#:#        -m sequencei Sequence0/1
#:m        -m super     (ContinuedFraction|Filter|...)Sequence
#
# separate changed blocks -> STDOUT and unchanged blocks -> STDERR
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $mode  = "u";
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $pack_count = 0;
my $aseqno = "";
my $offset = 0;
my @rest;
my $separator = "#!queue";
my $sep;   # separator line: ($separator, $aseqno, oldoff, arrow, newoff, superclass), for example: "#!queue\tA006083\t0\t->\t1\tContinuedFractionSequence
my $block; # a separator line and the content of a jOEIS Java program
my $chan_count = 0;
my $unch_count = 0;

$block = "";
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if ($line =~ m{\A$separator}) {
        &patch1($aseqno, $block, @rest);
        $block = "$line\n";
        ($sep, @rest) = split(/\t/, $line);
    } else {
        $block .= "$line\n";
    }
} # while <>
print        join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
print STDERR join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
print        "# $chan_count files patched -> ../../src\n";
print STDERR "# $unch_count files unchanged\n";
# end main
#----
sub patch1 {
    my ($aseqno, $block, @rest) = @_;
    my ($bseqno, $oldoff, $arrow, $newoff, $superclass) = @rest;
    $block =~ s{\n\/\/ *DO NOT EDIT[^\n]*}{};
    $block =~ s{\n\n\n}{\n\n}mg;
    if ($debug >= 1) {
        print STDERR "# $aseqno written\n";
    }
    #--------------------------------
    if ($mode =~ m{abstract}i) {
        if(0) {
        } elsif ($superclass =~ m{(Abstract)Sequence}) {
            $chan_count ++;
            #           1          1         2      2
            $block =~ s{(this|super)\($oldoff([\)\,])}
                                 {$1\($newoff$2}m;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }                      
    }
    #--------------------------------
    if ($mode =~ m{sequencei}i) {
        if(0) {
        } elsif ($superclass eq "Sequence$oldoff" && $newoff <= 3) {
            $chan_count ++;
            $block =~ s[Sequence$oldoff][Sequence$newoff]mg;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        } 
    }
    #--------------------------------
    if ($mode =~ m{setoffset}i) {
        if(0) {
        } elsif ($block =~ m{setOffset\($oldoff\)}m) {
            $chan_count ++;
            $block =~ s[setOffset\($oldoff\)][setOffset\($newoff\)]mg;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        } 
    }
    #--------------------------------
    if ($mode =~ m{super}i) {
        if(0) {
        } elsif ($superclass =~ m{(Antidiagonal|Brief|Cached|ContinuedFraction|DecimalExpansion|Difference|EulerTransform|Filter|FilterNumber|FilterPosition|Finite|Gf|DenominatorGf|GeneratingFunction|Inverse|Lambda|Padding|Partial(Sum|Product)|Periodic|Prepend|RecordPosition|RowSum|(Single|Simple)Transform)Sequence|BaseTriangle|Combiner|EulerTransform|(Linear|Holonomic)Recurrence|LambdaTable|LambdaTriangle|PrependColumn|(Vector)?Product}) {
            $chan_count ++;
            if ($block =~ m[super\(\d+\,]m) {
                $block =~ s[super\(\d+][super($newoff]m;
            } else {
                $block =~ s[super\(][super($newoff\, ]m;
            }
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        } 
    }
    #--------------------------------
} # patch1
__DATA__
# Starting report at 2022-08-16 15:32:35
A002162 1 -> 0  DecimalExpansionSequence
A002285 1 -> 0  DecimalExpansionSequence
A002389 1 -> 0  DecimalExpansionSequence
A002390 1 -> 0  DecimalExpansionSequence
A002580 0 -> 1  DecimalExpansionSequence
A002794 1 -> 0  A030125
A002795 1 -> 0  A002794
A003077 1 -> 0  DecimalExpansionSequence
A003676 1 -> -33    DecimalExpansionSequence

#!queue A019067 2   ->  3   A018940 --------------------------------
package irvine.oeis.a019;

import java.io.BufferedReader;
...