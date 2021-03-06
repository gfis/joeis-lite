#!perl

# Find parameters for Mathematica PadRight[] function or Java class irvine.oeis.PaddingSequence
# 2020-08-21, Georg Fischer: copied from find_repeat.pl
#
#:# Usage:
#:#   perl find_pad.pl input > output
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

while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    next if $line !~ m{\AA\d{6}};
    if ($debug >= 1) {
        print "#--------------------------------\nline=$line\n";
    }
    my ($aseqno, $callcode, $offset, $seqtype, $prepend, $termlist, @rest) = split(/\s/, $line);
    $termlist =~ s{\s}{}g; # remove all whitespace
    my @ts = split(/\,/, "undef," . $termlist); # "undef" is never matched
    my $ints = scalar(@ts) - 1; # index of last element
    my $perlen = 0;
    my $count;
    my $start;
    my $busy = 1;
    while ($busy == 1&& $perlen < $ints / 4) { # no longer periods desired
        $perlen ++;
        $count = 0;
        $start = $ints - $perlen;
        while ($ts[$start] eq $ts[$start + $perlen]) { # right-rotate the period and eat-up to the left
            $count ++;
            $start --;
        } # while matching
        if ($start <= $ints / 4) { # could run far enough
            $busy = 0;
        } else { # try longer
            $perlen ++;
        }
    } # while busy
    # $start is now on the first element which could not be eaten-up by the period ([0] at least)
    if ($busy == 0) { # found a period
        my $pstart = 1;
        while ($pstart < $start) {
            $pstart += $perlen;
        }
        my $period =               join(",", splice(@ts, $pstart, $perlen));
        my $initer = $start >= 1 ? join(",", splice(@ts, 1,       $start )) : "";
        if ($debug >= 2) {
            print "# found period $period, length $perlen, $count x repeated, prefix $initer, start=$start\n";
        }
        print join("\t", $aseqno, $callcode, $offset, $seqtype, $prepend, "len=$perlen", "ini=$initer", "per=$period", "count=$count", $termlist) . "\n";
    } else {
        if ($debug >= 1) {
            print "# could not find a period in $termlist\n";
        }
    } # found a period
} # while <>
#================================
__DATA__
A112142	evtlper	0	seqtype	prepend	-12,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12
A112209	evtlper	0	seqtype	prepend	1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0
A001503	evtlper	0	seqtype	prepend	12,90,12000000000000000000
A036837	euguess	0	seqtype	prepend	4,1,1,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
A038835	euguess	0	seqtype	prepend	4,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3
A058484	euguess	0	seqtype	prepend	6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,
A058514	euguess	0	seqtype	prepend	4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,
