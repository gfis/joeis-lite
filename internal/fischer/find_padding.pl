#!perl

# Find parameters for Mathematica PadRight[] function or Java class irvine.oeis.PaddingSequence
# 2020-08-21, Georg Fischer: copied from find_repeat.pl
#
#:# Usage:
#:#   perl find_padding.pl input > output
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
my ($aseqno, $callcode, $offset, $seqtype, $prepend, $initer, $period, $perlen, $termlist, @rest); # in the record

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    next if $line !~ m{\AA\d{6}};
    if ($debug >= 1) {
        print "#--------------------------------\nline=$line\n";
    }
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
        if (substr($termlist, $start, 1) eq ",") { # check only at comma positions
            $period = substr($termlist, $start, $perlen); # up to the end
            $start -= $perlen;
            $count = 0;
            while ($start >= 0 && substr($termlist, $start, $perlen) eq $period) { 
                # works only if the period has a leading comma
                $start -= $perlen;
                $count ++;
            } # while counting
            if ($start <= length($termlist) / 4) {
                $busy = 0;
            }
        } # at comma positions
    } # while $busy
    $start += $perlen; # the last one did not match
    if ($debug >= 2) {
        print "# found period: count=$count, start=$start, period=$period, perlen=$perlen\n";
    }
    if ($busy == 0 && $count >= 2) {
        # now try to right-rotate the period:   hiklmnab,cdab -> hijklmn,abcd
        $busy = 1;
        my $initer = substr($termlist, 0, $start);
        while ($busy == 1) {
            $period =~ m{(\,\-?\d+)\Z};  # get the trailing term
            my $last = $1;
            if ($debug >= 1) {
                print "# try to rotate \"$last\", start=$start, period=$period, perlen=$perlen, prefix=$initer\n";
            }
            if ($initer =~ m{$last\Z}) {  # we can eat that one
                $initer =~ s{$last\Z}{};  # remove last from prefix
            } else { # last of period not found in prefix
                $busy = 0; # could not eat last of $initer
            }
        } # while
        $initer   =~ s{\A\,}{}; # remove leading comma
        $termlist =~ s{\A\,}{}; # remove leading comma

        # now right-rotate the period until it reaches the start of $initer
        my $inilen = scalar(split(/\,/, $initer)); 
        if ($debug >= 1) {
            print "# right-rotate by $inilen steps, ini=$initer, per=$period, perlen=$perlen\n";
        }
        while ($inilen > 0) {
            $period =~ m{(\,\-?\d+)\Z};  # get the trailing term
            my $last = $1;
            $period =~ s{$last\Z}{};  # remove last from period
            $period = "$last$period"; # prepend it to the period
            $inilen --;
        } # while $inilen
        
        $period   =~ s{\A\,}{}; # remove leading comma
        $perlen   = scalar(split(/\,/, $period)); # was characters, now elements
        print join("\t", $aseqno, $callcode, $offset, $seqtype, $prepend, "len=$perlen", "ini=$initer", "per=$period", "count=$count", $termlist) . "\n";
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
