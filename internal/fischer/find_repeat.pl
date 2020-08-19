#!perl

# Find periods in sequences
# 2020-08-18, Georg Fischer
#
#:# Usage:
#:#   perl find_repeat.pl input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $termlist); # in the record
my $perlen; # length of period, counted from the end

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    next if $line !~ m{\AA\d{6}};
    ($aseqno, $termlist) = split(/\s/, $line);
    $termlist =~ s{\s}{}g; # remove all whitespace
    $termlist = ",$termlist"; # prefix a comma
    $perlen = 0;
    my $period;
    my $start;
    my $busy = 1;
    my $count;
    while ($busy) {
        $perlen ++;
        $start = length($termlist) - $perlen;
        $period = substr($termlist, $start, $perlen);
        $start -= $perlen;
        $count = 0;
        while ($start >= 0 && substr($termlist, $start, $perlen) eq $period) {
            $start -= $perlen;
            $count ++;
        } # while
        if ($start <= length($termlist) / 4) {
            $busy = 0;
        }
    } # while $busy
    if ($busy == 0 && $count >= 2) {
        $period = substr($period, 1);
        $perlen = scalar(split(/\,/, $period));
        print join("\t", $aseqno, $count, $perlen, $period, substr($termlist, 1)) . "\n";
    }
} # while <>
#================================
__DATA__
A112142 12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12
A112209 1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0

