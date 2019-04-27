#!perl

# Run BatchTest.class in the background and survey the running time of a sequence
# @(#) $Id$
# 2019-04-14, Georg Fischer
#
#:# Usage:
#:#   perl naseqno.pl [-d debug] [-l logfile|-s start] instrip > outstrip
#:#       -d debugging level: 0 (none), 1 (some), 2 (more)
#:#       -l logfile with last tested aseqno at the end, default: batch.log
#:#       -a after first A-number to be tested is greater (if specified then logfile is ignored)
#:#       instrip   file containing all testcases (sorted A-numbers)
#:#       outstrip  file starting with next testcase (one higher than in logfile)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp  = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $logname = "batch.log";
my $start   = ""; # not specified so far
my $debug   = 0;

while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{l}) {
        $logname   = shift(@ARGV);
    } elsif ($opt  =~ m{s}) {
        $start     = shift(@ARGV);
        if ($start =~ m{(\d+)}) {
          $start = $1 + 1;
          $start = sprintf("A%06d", $start);
        }
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
if ($debug >= 1) {
}

if ($start eq "") { # read it from logfile
    $start = `grep -E "^A" $logname | tail -n1`; # last A-number
    $start =~ m{^A(\d+)};
    $start = $1 + 1; 
    $start = sprintf("A%06d", $start);
} # read from logfile
print STDERR "# next_aseqno.pl V1.06 " . join(" ", @ARGV) . ", $start = start\n";
print `echo $start = start >> $logname`;

my $state = 0;
while (<>) {
    s{\s+\Z}{}; # chompr
    my $line = $_;  
    if (0) {
    } elsif ($state == 0) { 
        if ($line =~ m{^(A\d+)}) {
            my $aseqno = $1;
            if ($aseqno ge $start) {
                print "$line\n";
                $state = 1;
            }
        }
    } elsif ($state == 1) {
        print "$line\n";
    } else {
        die "invalid state $state\n";
    }
} # while <>
#---------------------------------------
__DATA__
A002952 1       FAIL, took more than 2000 ms
A002953 15      FAIL, took more than 2000 ms
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
        at irvine.factor.factor.Cheetah.initLarge(Unknown Source)
        at irvine.factor.factor.Cheetah.doLarge(Unknown Source)
        at irvine.factor.factor.Cheetah.factor(Unknown Source)
        at irvine.factor.factor.AbstractFactorizer.factor(Unknown Source)
