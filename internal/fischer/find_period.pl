#!perl

# Find parameters for Mathematica PadRight[] function or Java class irvine.oeis.PaddingSequence
# 2021-10-21: for traits, -g
# 2020-08-21, Georg Fischer: copied from find_repeat.pl
# This is the last variant.
#
#:# Usage:
#:#   perl find_period.pl [-d debug] [-n 5] [-g] input > output
#:#     -n field number (counted from 0, default 5)
#:#     -g generate sequence calls
#:# The field is expanded into 3 fields (left-init, right-pad, original).
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $nparm = 5; # counted from 0
my $generate = 0; # do not generate sequence calls
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{g}) {
        $generate  = 1;
    } elsif ($opt  =~ m{n}) {
        $nparm     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\AA\d{6}}) {
        if ($debug >= 2) {
            print "#--------------------------------\n";
            print "#line=$line\n";
        }
        my @parms = split(/\s/, $line);
        if (scalar(@parms) > $nparm) {
            my $termlist = $parms[$nparm];
            $termlist =~ s{\s}{}g; # remove all whitespace
            $termlist =~ s{\,+\Z}{}; # remove trailing comma(s)
            my @ts = split(/\,/, "undef," . $termlist); # "undef" is never matched
            my $ints = scalar(@ts) - 1; # index of last element
            my $perlen = 0;
            my $count;
            my $start;
            my $busy = 1;
            while ($busy == 1&& $perlen < $ints / 3) { # no longer periods desired
                $perlen ++;
                $count = 0;
                $start = $ints - $perlen;
                while ($ts[$start] eq $ts[$start + $perlen]) { # right-rotate the period and eat-up to the left
                    $count ++;
                    $start --;
                } # while matching
                if ($start <= $ints / 3) { # could run far enough
                    $busy = 0;
                } else { # try longer
                }
                if ($debug >= 3) {
                    print "# tried length $perlen, busy=$busy, $count x repeated, start=$start\n";
                }
            } # while busy
            # $start is now on the first element which could not be eaten-up by the period ([0] at least)
            if ($busy == 0) { # found a period
                $count /= $perlen;
                my $pstart = 1;
                while ($pstart <= $start) {
                    $pstart += $perlen;
                }
                if ($debug >= 4) {
                    my $ind = -1;
                    print "# pstart=$pstart, start=$start, \@ts: " . join(" ", map { $ind ++; "[$ind]=$_" } @ts) . "\n";
                }
                # range of Java int: 2,147,483,647
                my $period = join(",", map { $_ .= "L" if length($_) >= 9; $_ } splice(@ts, $pstart, $perlen));
                my $initer = $start >= 1 
                           ? join(",", map { $_ .= "L" if length($_) >= 9; $_ } splice(@ts, 1      , $start )) 
                           : "";
                if ($debug >= 1) {
                    print "# found period \"$period\", length $perlen, $count x repeated, prefix=\"$initer\", start=$start\n";
                }
                if ($generate) {
                    if (length($initer) == 0) { # pure periodic
                        $parms[$nparm] = "new PeriodicSequence($period)";
                    } else {
                        $parms[$nparm] = "new PaddingSequence(\"$initer\", \"$period\")";
                    }
                    print        join("\t", @parms) . "\n";
                } else {
                    $parms[$nparm] = join("\t", $initer, $period, $termlist);
                    if ($parms[$nparm] !~ m{\d{19}}) { # in range of Java long 9,223,372,036,854,775,807
                        print        join("\t", @parms) . "\n";
                    } else { # not in long range
                        print STDERR join("\t", @parms) . "\n";
                    }
                }
            } else {
                if ($debug >= 2) {
                    print "# could not find a period in $termlist\n";
                }
                print "$line\n";
            } # found a period
        } # if enough fields in record
    } else {
        print "$line\n";
    }
} # while <>
#================================
__DATA__
A112142	evtlper	0	seqtype	prepend	-12,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12,12,0,12,-12
A112209	evtlper	0	seqtype	prepend	1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0
A001503	evtlper	0	seqtype	prepend	12,90,12000000000000000000
A036837	euguess	0	seqtype	prepend	4,1,1,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
A038835	euguess	0	seqtype	prepend	4,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3
A058484	euguess	0	seqtype	prepend	6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0
A058514	euguess	0	seqtype	prepend	4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,4,0,4,0,4,-4,4,0
A225956	eulerix	0	seqtype	prepend	1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-2,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-2,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1
A161458	eulerix	0	seqtype	prepend	10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
A108482	eulerix	0	seqtype	prepend	1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1,-1,0,1,0,1,0,-1	Expansion of a modular function for Gamma(7).
A157673	eulerix	0	seqtype	prepend	220,221,220,224,220,221,220,225,220,221,220,224,220,221,220,234,220,221,220,224,220,221,220,225,220,221,220,224,220,221,220,238,220,221,220,224,220,221,220,225,220,221,220,224,220,221,220,234,220,221,220,224,220,221,220,225,220,221,220,224,220,221,220,42,42,221,220,221,220,224,220,221,220,225,220,221,220,224,220,221,220,234,220,221,220,224,220