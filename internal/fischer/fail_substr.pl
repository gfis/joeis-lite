#!perl

# Modify FAILed entries in a logfile having mutual substrings
# @(#) $Id$
# 2024-04-16, Georg Fischer: copied from htmlize.pl
#
#:# usage:
#:#   perl -i.bak fail_substr.pl [-d {0|1|2}] [-s skip] joeis_check.html 
#:#       -d     debugging mode (0=none, 1=some, 2=more)
#:#       -s max maximum number of initial, differing terms
#:#---------------------------------
use strict;
use integer;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d"  #:%02d\+01:00"
        , $year + 1900, $mon + 1, $mday, $hour, $min); # , $sec, $isdst);

if (scalar(@ARGV) == 0) { # print help and exit
  print `grep -E "^#:#" $0 | cut -b3-`;
  exit;
} # print help

my $debug = 0;
my $max_skip = 4;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A\-})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{\A\-d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{\A\-s}) {
        $max_skip  = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line;
my ($oldexp, $oldcom);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    if (substr($line, 0, 4) eq "<tr>") {
        #                          1      1          2      2
        if ($line =~ m{FAIL[^\,]+\,([^\<]+)\<[^\,]+\,([^\<]+)\<}) {
            print "<!--$1/$2-->\n";
            ($oldexp, $oldcom) = ($1, $2);
            $oldexp =~ s/\.\.\.//;
            if (&mutual_prefix($oldexp, $oldcom)) {
            }
        } # FAIL
    } # <tr>
    print "$line\n";
} # while <>
#----
sub mutual_prefix() { # global $max_skip, $line, $oldexp, $oldcom
    my ($newexp, $newcom) = ($oldexp, $oldcom);
    my $prefix;
    my @listexp = split(/\,/, substr($oldexp, 1)); # leading comma ssumed!
    my @listcom = split(/\,/, substr($oldcom, 1)); # leading comma ssumed!
    my $busy = 1;
    my $skip = 1;
    while ($busy && $skip <= $max_skip) {
        if ($busy) {
            shift(@listexp);
            $prefix = join(",", @listexp);
            print "<!-- prefix=$prefix, oldcom=$oldcom -->\n";
            if (index($oldcom, $prefix) > 0) {
                $busy = 0;
            }
        }
        if ($busy) {
            shift(@listcom);
            $prefix = join(",", @listcom);
            print "<!-- prefix=$prefix, oldexp=$oldexp -->\n";
            if (index($oldexp, $prefix) > 0) {
                $busy = 0;
            }
        }
        $skip ++;
    } # while
    if ($busy == 0) { # found a prefix
        $newexp =~ s{$prefix}{\<\/span\>\<span class\=\"refp\"\>$prefix\<\/span\>};
        $newcom =~ s{$prefix}{\<\/span\>\<span class\=\"refp\"\>$prefix\<\/span\>};
        $newexp =  "\<span class\=\"err\"\>$newexp";
        $newcom =  "\<span class\=\"err\"\>$newcom";
        $line =~ s{$oldcom}{$newcom};
        $line =~ s{$oldexp}{$newexp};
    }
    return 1 - $busy; # whether a prefix was found
} # mutual_prefix   
#--------
__DATA__
<tr><td class="bor"><a href="https://oeis.org/A305542" target="_blank">A305542</a></td><td class="bor">4</td><td class="bor">FAIL</td><td class="bor">,3,12,35,111,318,934,2634,7503...</td><td class="bor">,0,0,-4,-9,-29,-46,-119,-177</td></tr>
<tr><td class="bor"><a href="https://oeis.org/A305543" target="_blank">A305543</a></td><td class="bor">2</td><td class="bor">FAIL</td><td class="bor">,0,0,3,24,124,588,2487,10240...</td><td class="bor">,1,3,17,110,898,8682,97296,12389</td></tr>
<tr><td class="bor"><a href="https://oeis.org/A305544" target="_blank">A305544</a></td><td class="bor">3</td><td class="bor">FAIL</td><td class="bor">,0,0,12,150,1200,7845,46280,2546...</td><td class="bor">,1,3,5,9,15,-5,-17,-408</td></tr>
<tr><td class="bor"><a href="https://oeis.org/A305545" target="_blank">A305545</a></td><td class="bor">2</td><td class="bor">FAIL</td><td class="bor">,0,0,0,0,60,1080,11970,105840...</td><td class="bor">,1,4,24,157,1248,11697,127066,15</td></tr>
    if (substr($line, 0, 4) eq "<tr>") {
    	#                                1      1          2      2
        if (($line =~ m{FAIL[^,]+\,([^<]+)\<[^,+]\,([^<]+)\<})) {
            print "<!--$1/$2-->\n";
    #   if (1 or ($line =~ m{FAIL[^\,]+\,(\S*)})) {
            my ($oldexp, $oldcom) = ($1, $2);
            my ($newexp, $newcom) = ($1, $2);
            $newcom = "<span class=\"warn\">$newcom</span>";
        #   print "<!--$newcom-->\n";
            $line =~ s{$oldexp}{$newexp};
            $line =~ s{$oldcom}{$newcom};
        } # FAIL
    } # <tr>
    print "$line\n";
