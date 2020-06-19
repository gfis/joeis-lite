#!perl

# Kill running java process BatchTest
# @(#) $Id$
# 2020-06-19, Georg Fischer
#
#:# Usage:
#:#   perl batchdog.pl 
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

my $monname   = "seekpos.mon";
my $debug     = 0;
my $interrupt = 1;

my $is_unix = ($^O =~ m{win}i ? 0 : 1);
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{h}) {
        print `grep -E "^#:#" $0 | cut -b3-`;
        exit;
    } elsif ($opt  =~ m{[ki]}) {
        $interrupt = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my @lines = split(/\r?\n/, `jps` . "\n");
if ($debug >= 2) {
    print join("\n", @lines) . "\n";
}

my @bt_line = grep { $_ =~ m{BatchTest}i } @lines;
if (scalar(@bt_line) == 1) {
    my ($pid, $rest) = split(/\s+/, $bt_line[0]);
    if ($debug >= 1) {
        print "bt_line=\"$bt_line[0]\", pid=$pid, rest=$rest\n";
    }
    if ($is_unix == 1) {
        print `kill -9 $pid`;
    } else { # Windows
        print `TaskKill /F /PID $pid`;
    }
} else {
    if ($debug >= 1) {
        print "BatchTest process not found\n";
    }
}

#---------------------------------------
__DATA__
