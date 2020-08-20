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

my $line = "";
my ($aseqno, $callcode, $offset, $seqtype, $prepend, $preper, $period, $perlen, $termlist, @rest); # in the record

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    if ($debug >= 1) {
        print "line=$line\n";
    }
    next if $line !~ m{\AA\d{6}};
    ($aseqno, $callcode, $offset, $seqtype, $prepend, $termlist, @rest) = split(/\s/, $line);
    $termlist =~ s{\s}{}g; # remove all whitespace
    $termlist = ",$termlist"; # prefix a comma
    $perlen = 0;
    my $start = length($termlist);
    my $busy = 1;
    my $count;
    while ($busy && $start > 0) {
        $perlen ++;
        $start = length($termlist) - $perlen;
        if (substr($termlist, $start, 1) eq ",") {
            $period = substr($termlist, $start, $perlen);
            $start -= $perlen;
            $count = 0;
            while ($start >= 0 && substr($termlist, $start, $perlen) eq $period) { 
                # works only if the period has a leading comma
                $start -= $perlen;
                $count ++;
            } # while
            if ($start <= length($termlist) / 4) {
                $busy = 0;
            }
        } 
    } # while $busy
    $start += $perlen;
    if ($debug >= 2) {
        print "found period: count=$count, start=$start, period=$period, perlen=$perlen\n";
    }
    if ($busy == 0 && $count >= 3) {
        # now try to rotate the period:   hiklmnab,cdab -> hijklmn,abcd
        $busy = 1;
        my $preper = substr($termlist, 0, $start);
        while ($busy == 1) {
            $period =~ m{(\,\-?\d+)\Z};  # get the trailing term
            my $last = $1;
            if ($debug >= 1) {
                print "try to rotate \"$last\", start=$start, period=$period, perlen=$perlen, prefix=$preper\n";
            }
            if ($preper =~ m{$last\Z}) {  # we can eat that one
                $preper =~ s{$last\Z}{};  # remove last from prefix
                $period =~ s{$last\Z}{};  # remove last from period
                $period = "$last$period"; # prepend it to the period
            } else { # last of period not found in prefix
                $busy = 0; # finished
            }
        } # while
        $period =~ s{\A\,}{}; # remove leading comma
        $preper =~ s{\A\,}{}; # remove leading comma
        if (length($preper) > 0) {
        	$preper .= ",";
        }
        $perlen = scalar(split(/\,/, $period)); # was characters, now elements
        print join("\t", $aseqno, $callcode, $offset, 3, $prepend, "$preper $period", $perlen, $count, substr($termlist, 1, 64)) . "\n";
    } # found a period
} # while <>
#================================
__DATA__
A112142	evtlper	0	3	3	-12,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12
A112209	evtlper	0	3	3	1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0
A001503	evtlper	0	3	3	12,90,12000000000000000000
