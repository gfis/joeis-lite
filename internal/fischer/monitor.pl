#!perl

# Monitor BatchTest.class in another process and survey the running time of each sequence
# @(#) $Id$
# 2019-04-27: new attempt
# 2019-04-15, Georg Fischer
#
#:# Usage:
#:#   perl monitor.pl [-d debug] [-h[elp]] [-l logfile] [-t timeout]
#:#       -d debugging level: 0 (none), 1 (some), 2 (more)
#:#       -l logfile to be monitored, default: batch.log
#:#       -t timeout in seconds (default: 4 s)
#:#       -k interrupt all processes if more than one is running
#--------------------------------------------------------
use strict;
use integer;
use warnings;

if (scalar(@ARGV) == 0) {
}
my $logname   = "batch.log";
my $start     = "";
my $timeout   = 4;
my $debug     = 0;
my $interrupt = 1;

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
    } elsif ($opt  =~ m{l}) {
        $logname   = shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $timeout   = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
print "monitor V1.08 -s $start -l $logname -t $timeout\n";
my $line;
my $cmd;
my $process;

my $busy = 1;
while ($busy == 1) { # forever
    my @running = split(/\r?\n/, `ps -efa | grep java | grep BatchTest | grep -vE "/bin/sh"`);
    if ($debug >= 1) {
        print join("", map { "process: $_\n" } @running);
    }
    if (0) {
    } elsif (scalar(@running) == 0) {
        if ($debug >= 1) {
            print "no running BatchTest found\n";
        }
    } elsif (scalar(@running) >= 2) {
        if ($debug >= 1) {
            print "more than one running BatchTest found\n";
        }
        if ($interrupt > 0) { 
            print "interrupt all\n";
            map {   my $line = $_;
                    if ($line =~ m{^\w+\s+(\d+)}) {
                        my $pid = $1;
                        kill('KILL', $pid);
                    }
                } @running;
        } # interrupt
        exit;
    } elsif ($running[0] =~ m{^\w+\s+(\d+)}) { # 1 running process found
        my $pid = $1;
        print "start monitoring process $pid\n";
        my $old_line = &get_tail1(); 
        sleep $timeout; # another slot
        my $new_line = &get_tail1();
        if ($debug >= 1) {
            print "comparing \"$old_line\" <> \"$new_line\"\n";
        }
        if ($old_line eq $new_line) { # if it has not moved in 2nd slot, kill the process and restart
            my ($user, $pidch, $rest) = split(/\s+/, `ps -efa | grep BatchTest | grep -vE "grep|/bin/sh"`);
            print `kill -9 $pidch`;
            if ($debug >= 2) {
                $new_line =~ m{^(A\d+)};
                my $aseqno = $1;
                open(LOG, ">>", $logname) or die "cannot open \"$logname\"\n";
                $aseqno = sprintf("A%06d", substr($aseqno, 1) + 1);
                print LOG "$aseqno  FATAL timeout $timeout - killed\n";
                print     "$aseqno  FATAL timeout $timeout - killed\n";
                $aseqno = sprintf("A%06d", substr($aseqno, 1) + 1);
                print LOG "$aseqno  ---- restart point at " . &get_timestamp() . "\n";
                print     "$aseqno  ---- restart point at " . &get_timestamp() . "\n";
                close(LOG);
                sleep $timeout;
            }
        } else { # it moved - continue monitoring
            $old_line = $new_line;
        }
        # one was running
    } # switch
    sleep $timeout; # another slot
} # while forever
#----
sub get_timestamp {
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
    my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
    return $timestamp;
} # get_timestamp
#----
sub get_tail1 {
    return `grep -E "^A" $logname | tail -n1`;
} # get_tail1
#---------------------------------------
__DATA__
A002952 1       FAIL, took more than 2000 ms
A002953 15      FAIL, took more than 2000 ms
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
        at irvine.factor.factor.Cheetah.initLarge(Unknown Source)
        at irvine.factor.factor.Cheetah.doLarge(Unknown Source)
        at irvine.factor.factor.Cheetah.factor(Unknown Source)
        at irvine.factor.factor.AbstractFactorizer.factor(Unknown Source)
gfis@atair:~/work/gits/OEIS-mat/common$ ps -efa | grep java
tomcat8   1831     1  0 06:15 ?        00:00:50 /usr/lib/jvm/default-java/bin/java -Djava.util.logging.config.file=/var/lib/tomcat8/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.awt.headless=true -XX:+UseConcMarkSweepGC -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -classpath /usr/share/tomcat8/bin/bootstrap.jar:/usr/share/tomcat8/bin/tomcat-juli.jar -Dcatalina.base=/var/lib/tomcat8 -Dcatalina.home=/usr/share/tomcat8 -Djava.io.tmpdir=/tmp/tomcat8-tomcat8-tmp org.apache.catalina.startup.Bootstrap start
gfis     16126 16112  0 16:00 pts/0    00:00:00 /bin/sh -c java -cp build.tmp/joeis.jar irvine.test.BatchTest -v -b ../../gits/OEIS-mat/common/bfile  -t 2 \ ??strip.tmp   2>&1 | tee batch.log
gfis     16127 16126 99 16:00 pts/0    00:01:59 java -cp build.tmp/joeis.jar irvine.test.BatchTest -v -b ../../gits/OEIS-mat/common/bfile -t 2 strip.tmp
gfis     16306 16290  0 16:01 pts/1    00:00:00 grep --color=auto java
gfis@atair:~/work/gits/OEIS-mat/common$ kill -9 16127
