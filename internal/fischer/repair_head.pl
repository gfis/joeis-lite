#!perl

# Evaluates a FAIL log and generates "UPDATE SET parm1=..." for proper skipping/prepending
# 2023-03-01, with "~~"
# 2020-08-27, Georg Fischer
#
#:# Usage:
#:#   perl repair_head.pl [-n fnum] [-s] input > output
#:#     -n field number (counted from 1, default 4) 
#:#     -s for 'super.next()' instead of 'next();'
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
# $timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
my $nparm = 4; # counted from 1
my $super = "";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $nparm     = shift(@ARGV);
    } elsif ($opt  =~ m{s}) {
        $super     = "super.";
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

print "-- created by $0 -n $nparm at $timestamp\n";
my $line = "";
my  ($aseqno, $termno, $fail, $expected, $dummy, $computed);
my $mod1; # modify before
my $mod2; # modify after
while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $termno, $fail, $expected, $dummy, $computed) = split(/\s+/, $line);
    if (($aseqno =~ m{\AA\d+}) and ($fail =~ m{FAIL})) {
        my @expect = split(/\,/, substr($expected, 1));
        my @comput = split(/\,/, substr($computed, 1));
        ($mod1, $mod2) = ("", "");
        if (0) {
    #   } elsif (&check(1, 0) == 1) {
    #       $mod1 = "new PrependSequence(";
    #       $mod2 = ", "  .join(",", splice(@expect, 0, 1) . ")");
    #   } elsif (&check(2, 0) == 1) {
    #       $mod1 = "new PrependSequence(";
    #       $mod2 = ", "  .join(",", splice(@expect, 0, 2) . ")");
        } elsif (&check(0, 1) == 1) {
            $mod1 =    "${super}next();";
        } elsif (&check(0, 2) == 1) {
            $mod1 =    "${super}next();~~  ${super}next();";
        }
        if (length($mod1 . $mod2) > 0) {
            print "UPDATE seq4 SET parm$nparm=\'~~  ~~{~~  $mod1~~}~~ ~~\' WHERE aseqno=\'$aseqno\';"
                . "-- $expected $computed\n";
        }
    }
} # while <>
print "COMMIT;\n";
#----
sub check {
    my ($skipe, $skipc) = @_;
    my $teste = $expected;
    while ($skipe > 0) {
        $teste =~ s{\A\,\-?\d+}{}; # remove 1 term
        $skipe --;
    } # while $skipe
    my $testc = $computed;
    while ($skipc > 0) {
        $testc =~ s{\A\,\-?\d+}{}; # remove 1 term
        $skipc --;
    } # while $skipc
    my $result = -1;
    if (length($teste) >= length($testc)) {
        $result = ($teste =~ m{\A$testc}) ? 1 : 0;
    } else {
        $result = ($testc =~ m{\A$teste}) ? 1 : 0;
    }
    if ($debug >= 1) {
        print "-- check(" .join(",", @_) . ": result=$result, $teste=$teste, $testc=$testc\n";
    }
    return $result;
} # check
#================================
__DATA__
A072401 14      FAIL    ,0,1,0,0,0,0,0,0        computed:       ,1,0,0,0,0,0,0,0
A083187 8       FAIL    ,1,1,1,0,1,0,1,0        computed:       ,0,1,1,1,0,1,0,1
A091225 9       FAIL    ,0,1,1,0,0,0,1,0        computed:       ,1,1,0,0,0,1,0,0
A099395 10      FAIL    ,1,0,0,1,0,0,0,0        computed:       ,0,1,0,0,1,0,0,0
A114986 9       FAIL    ,1,0,1,1,0,1,0,1        computed:       ,0,1,1,0,1,0,1,1
A136522 17      FAIL    ,1,0,1,0,0,0,0,0        computed:       ,0,1,0,0,0,0,0,0
A151774 10      FAIL    ,0,1,0,1,1,0,0,1        computed:       ,1,0,1,1,0,0,1,1
A156659 12      FAIL    ,0,1,0,1,0,0,0,1        computed:       ,1,0,1,0,0,0,1,0
A156660 9       FAIL    ,0,1,1,0,1,0,0,0        computed:       ,1,1,0,1,0,0,0,0