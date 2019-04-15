#!perl

# Run BatchTest.class in the background and survey the running time of a sequence
# @(#) $Id$
# 2019-04-14, Georg Fischer
#
#:# Usage:
#:#   perl timeguard [-d debug] [-l infile] [-s aseqno] [-t timeout] > outfile
#:#       -d debugging level: 0 (none), 1 (some), 2 (more)
#:#       -l logfile to be monitored, default: batch.tmp
#:#       -s start with this A-number (default: last + 1)
#:#       -t timeout in seconds (default: 4 s)
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
print "timeguard V1.06 " . join(" ", @ARGV) . "\n";
my $logname = "batch.log";
my $start   = "";
my $millis  = 2;
my $timeout = 4;
my $debug   = 1;

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
          $start = $1;
          $start = sprintf("A%06d", $start);
        }
    } elsif ($opt  =~ m{t}) {
        $timeout   = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
if ($debug >= 2) {
    print "options read: start=$start, logname=\"$logname\", timeout=$timeout\n";
}
my $line;
my $cmd;
my $process;

my $busy = 1;
while ($busy == 1) { # forever
    if ($start eq "") { # read from batch.tmp
        $start = &get_lasta();
    }  
    if ($start eq "") { #did not find it in logfile
        print STDERR "could not get last A-number, please specify with \"-s\"\n";
        $busy = 0; # do not restart
    } else {
        $start = sprintf("A%06d", substr($start, 1) + 1);
    }
    if ($debug >= 1) {
        print "while $busy: start=$start, logname=\"$logname\", timeout=$timeout\n";
    }
    if ($busy == 1) {
        my $prepare = "grep -vf exclude.tmp strip.txt | sort | uniq | sed -n \"/^$start/,/^A999999/p\" > strip.tmp";
        my $batch   = "java -cp build.tmp/joeis.jar irvine.test.BatchTest -v -t $millis strip.tmp 2>\&1 >> $logname";
        print `$prepare`;
        
        my $pid = fork();
        if( $pid == 0 ) { # this is the child process
            print "This is child process\n";
            # $process = `$batch`; # start it 
            system($batch);
            print "started process with $start: $process\n";
            print "Child process is exiting\n";
            # end of child
        } else { # parent
            print "This is the parent process - child has pid $pid\n";
            if ($debug >= 1) {
                print "child process started with $start\n";
            }
            my $monitoring = 1;
            if ($debug >= 2) {
                print "sleeping $timeout s\n";
            }
            sleep $timeout; # give it 1 slot to compute
            my $old_line = &get_tail1(); 
            while ($monitoring == 1) {
                if ($debug >= 2) {
                    print "sleeping $timeout s\n";
                }
                sleep $timeout; # another slot
                my $new_line = &get_tail1();
                if ($debug >= 1) {
                    print "comparing \"$old_line\" <> \"$new_line\"\n";
                }
                if ($old_line eq $new_line) { # if it has not moved in 2nd slot, kill the process and restart
                    $monitoring = 0;
                    my $killed = kill('KILL', $pid);
                    if ($killed < 1) {
                      die "process $pid was not killed ($killed)";
                    }
                } else { # it moved - continue monitoring
                    $old_line = $new_line;
                }
            } # while monitoring    
            # end of parent
        }      
    } # if $busy
} # while forever
#----
sub get_tail1 {
    return `tail -2 $logname`;
} # get_tail1
#----
sub get_lasta {
    my $result = "";
    open(BAT, "<", $logname) or die "cannot read \"$logname\"\n";
    while (<BAT>) { # read inputfile
        $line = $_;
        $line =~ s/\s+\Z//; # chompr
        if ($line =~ m{^(A\d+)}) {
          $result = $1;
        }
    } # while <BAT>
    close(BAT);
    return $result;
} # get_lasta
#---------------------------------------
__DATA__
A002952 1       FAIL, took more than 2000 ms
A002953 15      FAIL, took more than 2000 ms
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
        at irvine.factor.factor.Cheetah.initLarge(Unknown Source)
        at irvine.factor.factor.Cheetah.doLarge(Unknown Source)
        at irvine.factor.factor.Cheetah.factor(Unknown Source)
        at irvine.factor.factor.AbstractFactorizer.factor(Unknown Source)
