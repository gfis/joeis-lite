#!perl

# Preprocess FORMULA section lines for expr_pari.pl (PARI)
# @(#) $Id$
# 2023-08-27: was for sumpari.pl
# 2023-08-20, Georg Fischer; CC=67
#
#:# Usage:
#:#   perl expr_oeis.pl input.cat25-type > output.cat25-type
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 && scalar(@ARGV) == 0) {
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

#   | perl -ne 's{^(A\d+ )\(\d+\)\s+(.*)}{$1$3}; print;' \
#   | grep -P "^A\d+ *a\(n\) *\=" \
#   | grep -iP "Sum_\{\w *\=" | grep -viP "prime|partition|Numerator|Denominator|Moebius" \
#   | tee    $@.tmp

my $line;
# while (<DATA>) {
while (<>) {
    my $nok = 1;
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $line =~ s{ for .*|(\, )?where.*}{}; # remove conditions
    $line =~ s{^(A\d+) +\(\d+\) +(.*)}{$1$2}; # remove formular numbering
    #               1    1              2  2
    if ($line =~ m{^(A\d+) +a\(n\) *\= *(.*)}) {
        my ($aseqno, $name) = ($1, $2);
        if ($debug >= 1) {
            print "aseqno=$aseqno, name=$name\n";
        }
        $nok = 0;
        if ($name =~ m{(A\d{6})}) { # if there is a underlying sequence
            $nok = "2/$1";
        }
        $name =~ s{\bC\(}                                                               {binomial\(}g;
        $name =~ s{\bphi\(}                                                             {eulerphi\(}g;
        #                           1  1 
        $name =~ s{Stirling[a-zA-Z]*(\d)\(}                                             {(($1 eq "1") ? "stirling" : "Stirling2") . "("}g;
        #                 1   1   2  2      3      3        4      4    5  5
        while ($name =~ m{(Sum)_\{(\w) *\= *([^\.]+) *\.\. *([^\}]+)\} *(.*)}i) {
            my ($var, $min, $max, $expr) = ($2, $3, $4, $5);
            $expr    =~ s/\..*//g; # remove tail
            $name    =~ s{Sum_\{(\w) *\= *([^\.]+) *\.\. *([^\}]+)\} *(.*)}i}           {sum\($var\=$min\,$max\,$expr\)}i;
        }
        #                     1   1    2  2      3      3        4      4    5  6
        while ($name =~ m{Prod(uct)?_\{(\w) *\= *([^\.]+) *\.\. *([^\}]+)\} *(.*)}i) {
            my ($var, $min, $max, $expr) = ($2, $3, $4, $5);
            $expr    =~ s/\..*//g; # remove tail
            $name    =~ s{Prod(uct)?_\{(\w) *\= *([^\.]+) *\.\. *([^\}]+)\} *(.*)}      {prod\($var\=$min\,$max\,$expr\)}i;
        }
        #                 1   1   2  2  3  3    4  4
        while ($name =~ m{(sum)_\{(\w)\|(\w)\} *(.*)}i) {
            my ($d, $n, $expr) = ($2, $3, $4);
            $expr    =~ s/\..*//g; # remove tail
            $name    =~ s{(sum)_\{(\w)\|(\w)\} *(.*)}                                   {sumdiv\($n\,$d\,$expr\)}i;
        }
    } # while sum
    if ($nok eq "0") {
        print "$aseqno a(n)=$name\n";
    } else {
        print STDERR "# $nok: $line\n";
    }
} # while <>
#--------------------------------------------
__DATA__
A364980 a(n) = n! * Sum_{k=0..n} k^(n-k) * binomial(2*n-k+1,k)/( (2*n-k+1)*(n-k)! ).
A364981 a(n) = n! * Sum_{k=0..n} k^(n-k) * binomial(3*n-2*k+1,k)/( (3*n-2*k+1)*(n-k)! ).
A364982 a(n) = (n!/(2*n+1)) * Sum_{k=0..n} k^(n-k) * binomial(2*n+1,k)/(n-k)!.
A364983 a(n) = n! * Sum_{k=0..n} k^(n-k) * binomial(3*k+1,k)/( (3*k+1)*(n-k)! ) = n! * Sum_{k=0..n} k^(n-k) * A001764(k)/(n-k)!.
A364984 a(n) = n! * Sum_{k=0..n} k^(n-k) * binomial(n+2*k+1,k)/( (n+2*k+1)*(n-k)! ).