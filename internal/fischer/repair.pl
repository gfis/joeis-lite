#!perl

# Evaluates a $(CC).fail.log file and possibly writes modified programs into ./manual
# 2021-11-04, Georg Fischer
#
#:# Usage:
#:#   perl repair.pl $(CC).fail.log
#:#     -n dry run, do not write modified files
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
# $timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
my $ndry = 0; 
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $ndry = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line = "";
my  ($aseqno, $termno, $fail, $expected, $dummy, $computed);
my $mod1; # modify before
my $mod2; # modify after
while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    if ($line =~ m{\AA\d\d+}) {
        ($aseqno, $termno, $fail, $expected, $dummy, $computed) = split(/\s+/, $line);
        if ($fail =~ m{FAIL}) {
            my @expect = split(/\,/, substr($expected, 1));
            my @comput = split(/\,/, substr($computed, 1));
            my $teste  = join(",", splice(@expect, 0, 6));
            my $testc  = join(",", splice(@comput, 0, 6));
            my $c_in_e = index($expected, $testc);
            my $e_in_c = index($computed, $teste);
            if ($ndry) {
                if (0) {
                } elsif ($c_in_e > 0) {
                    print join("\t", $aseqno, "prepend", substr($expected, 0, $c_in_e - 1)) . "\n";
                    
                } elsif ($e_in_c > 0) { 
                    print join("\t", $aseqno, "skip"   , substr($computed, 0, $e_in_c - 1)) . "\n";
                }
            } else { # not dry
            } # not dry
        } # FAIL
    }
} # while <>
#----
sub check { # compare after skipping expected and computed terms
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