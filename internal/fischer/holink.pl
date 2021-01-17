#!perl

# Prepare parameters for HolonomicRecurrenceSequence
# 2020-10-24, Georg Fischer
#
#:# Usage:
#:#   perl holink.pl [-d debug] [-a maxadd] input > output 2> rest
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
my $timestamp = sprintf("%04d-%02d-%02d %02d:%02d:%02d"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

my $maxadd = 16; # number of additional terms
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt =~ m{a}) {
        $maxadd   = shift(@ARGV);
    } elsif ($opt =~ m{d}) {
        $debug    = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line = "";
my ($aseqno, $callcode, $offset, $sigorder, $nadd, $signature);
my $rest; # behind initterms
my @terms; # initterms as array
my $oldlist;
my $newlist; # for INIT=
my $matrix;

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $sigorder, $nadd, $signature, $oldlist) = split(/\t/, $line);
    my $orig_signature = $signature;
    $signature = join(",", map { "[$_]" } reverse(split(/\, ?/, $signature)));
    @terms  = split(/\,/, $oldlist);
    pop(@terms); # last may have been trunctated by SQL substr()
    if (scalar(@terms) < $sigorder + &max($maxadd, $nadd)) {
        @terms = &read_b_file($aseqno);
        $oldlist = join(",", @terms);
    }
    if (scalar(@terms) < $sigorder + &max($maxadd, $nadd)) {
        print STDERR "$line\n";
    } else {
        $matrix = "[[0],$signature,[-1]]";
        if ($sigorder > 8 && ($orig_signature =~ m{\A((0\,)+1|1(\,0)+\,1\,\-1)\Z})) { # 0,0,0,0,0,0,0,0,1 or 1,0,0,0,0,0,0,0,1,-1
            $callcode = "period";
            print STDERR join("\t", $aseqno, $callcode, $offset, $matrix, $newlist, 0, $sigorder, $sigorder        ) . "\n";
        } else {
            if ($nadd < 0) { # not know how many additional terms - try all up to $maxadd
                my $iadd = &runholo();
                print    join("\t", $aseqno, $callcode, $offset, $matrix, $newlist, 0, $sigorder, $sigorder + $iadd) . "\n";
            } else {
                @terms  = split(/\,/, $oldlist);
                $newlist  = join(",", splice(@terms, 0, $nadd));
                print    join("\t", $aseqno, $callcode, $offset, $matrix, $newlist, 0, $sigorder, $nadd            ) . "\n";
            }
        }
    }
} # while <>
#================================
sub max {
    my ($a, $b) = @_;
    return $a > $b ? $a : $b;
}
#----
sub runholo {
    my $iadd = 0;
    my $busy = 1;
    if ($debug >= 1) {
        print "#----------------\n";
    }
    while ($busy && $iadd < $maxadd) {
        @terms   = split(/\,/, $oldlist);
        $newlist = join(",", splice(@terms, 0, $sigorder + $iadd));
        @terms   = split(/\,/, $oldlist);
        my $cmd  = "" # "cd ../../joeis-lite/internal/fischer; "
                . "make runholo MATRIX=\"$matrix\" INIT=\"$newlist\" MAXT=" . ($sigorder + $iadd + 4);
        my @results = split(/\r?\n/, `$cmd`);
        my $result = $results[2];
        my @computed = split(/\,/, $result);
        if ($debug >= 1) {
            print "# $aseqno $cmd\n";
            print "# $aseqno iadd=$iadd, computed[" . ($sigorder + $iadd) 
                . "]=$computed[$sigorder + $iadd], result=\n# $result\n";
            print "# " . join(",", @terms) . "\n";
        }
        if  (  $computed[$sigorder + $iadd    ] == $terms[$sigorder + $iadd    ]
            && $computed[$sigorder + $iadd + 1] == $terms[$sigorder + $iadd + 1]
            && $computed[$sigorder + $iadd + 2] == $terms[$sigorder + $iadd + 2]
            ) {
            $busy = 0;
        } else {
            $iadd ++;
        }
    } # while busy
    return $iadd < $maxadd ? $iadd : "failed";
} # runholo
#----
sub read_b_file { # returns @terms
    my ($aseqno) = @_;
    my $filename = "../../../OEIS-mat/common/bfile/b" . substr($aseqno, 1) . ".txt";
    my $read_len = 100000000; # 100 MB
    my $buffer;
    open(FIL, "<", $filename) or die "cannot read $filename\n";
    read(FIL, $buffer, $read_len); # 100 MB, should be sufficient
    close(FIL);
    my @terms = ();
    foreach my $line (split(/\r?\n/, $buffer)) {
        $line =~ s{\#.*}{};
        $line =~ s{\A\s+}{};
        next if length($line) == 0; # skip comments and empty lines
        if ($debug >= 2) {
            print "# b-file $aseqno: $line\n";
        }
        if ($line =~ m{\A\-?\d+\s+(\-?\d+)}) {
            push(@terms, $1);
        }
    } # foreach line
    if ($debug >= 2) {
        print "# " . scalar(@terms) . " terms: " . join(",", @terms) . "\n";
    }
    return @terms;
} # read_b_file
#--------
__DATA__
A018240 holink  0   7   -1,5,5,-2,-2,-8,-8  1,1,2,3,7,12,24,45,91,176,352,693,1387,2752,5504,10965,21931,437
A036562 holink  0   3   7,-14,8 1,8,23,77,281,1073,4193,16577,65921,262913,1050113,4197377,16783
A038619 holink  0   8   1,0,0,0,0,0,10,-10  1,2,6,8,10,18,20,28,68,88,108,188,200,208,288,688,888,1088,1888,
A038709 holink  0   10  2,-1,0,0,0,0,0,1,-2,1   0,0,1,2,4,6,9,13,17,21,26,31,37,43,50,58,66,74,83,92,102,112,123
A039946 holink  0   45  1,1,1,-2,-1,0,1,-1,1,0,0,-1,1,2,1,-3,-2,0,2,1,-1,0,0,-1,1,2,0,-2,-3,1,2,1,-1,0,0,1,-1,1,0,-1,-2,1,1,1,-1    1,1,2,5,9,16,31,53,89,152,245,384,601,911,1351,1986,2856,4037,56
A045804 holink  0   5   1,0,0,1,-1  9,41,63,87,109,141,163,187,209,241,263,287,309,341,363,387,409,4
