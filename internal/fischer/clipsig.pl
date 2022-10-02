#!perl

# Reverse the signature in the Windows clipboard, and print it with the order 
# @(#) $Id$
# 2022-09-28, Georg Fischer
#
#:# Usage:
#:#   perl clipsig.pl | tee x.tmp
#---------------------------------
use strict;
use integer;
use warnings;
use POSIX;

my $version = "V1.1";
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
my $timestamp = sprintf("%04d-%02d-%02d %02d:%02d:%02d"
        , $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
my @parts = split(/\s+/, asctime(localtime(time)));  #  "Fri Jun  2 18:22:13 2000\n\0"
#                                             0   1    2 3        4
my $sigtime = sprintf("%s %02d %04d", $parts[1], $parts[2], $parts[4]);

my $offset = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{o}) {
        $offset = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $clip = `powershell -command Get-Clipboard`;
$clip =~ s{[^\-\d\,]}{}g;
my @terms = split(/\,/, $clip);
my @revte = reverse(@terms);
my $order = scalar(@terms);
print "ord=$order\n";
print "<a href=\"/index\/Rec#order_" . sprintf("%02d", $order) . "\">Index entries for linear recurrences with constant coefficients</a>, signature ("
    . join(", ", @terms) . ").\n";
print "sig=" . join(", ", @terms) . "\n";
print "rev=" . join(", ", @revte) . "\n";
print "sig=" . join(",",  @terms) . "\n";
print "rev=" . join(",",  @revte) . "\n";
__DATA__