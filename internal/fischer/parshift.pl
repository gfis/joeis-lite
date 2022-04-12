#!perl

# Extract parameters for Paradigm Shift Procedures
# 2022-04-11, Georg Fischer: copied from primen.pl
#
#:# Usage:
#:#   parshift.pl > parshift.gen  
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, $name, @rest);
my ($parms, $letter, $form);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ex = "";
my $ok;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) { # from jcat25.txt, polished
    s/\s+\Z//; # chompr
    s/ /\t/;
    s/ /\t/;
    ($letter, $aseqno, $form) = split(/\t/);
    $callcode = "holos";
    $form =~ s{for +n *\>\= *(\d+)\.?}{};
    my $ninit = $1 - 1;
    $form =~ m{a\(n\) *\= *(\d+) *\* *a\(n *\- *(\d+)\)};
    my $factor = $1;
    my $distance = $2;
    my $matrix = "[0,$factor";
    for (my $k = 1; $k < $distance; $k ++) {
        $matrix .= ",0";
    }
    $matrix .= ",-1]";
    my $inits = "";
    my ($as, $cnt, $termstr) = split(/\t/, `grep $aseqno ../../../OEIS-mat/common/asdata.txt`);
    if ($cnt < $ninit) {
        $callcode = "";
        print STDERR "# error: $cnt < $ninit terms for $aseqno\n";
    } else {
        my @terms = split(/\,/, $termstr);
        $inits = "[" . join(",", splice(@terms, 0, $ninit)) . "]";
    }
    if (length($callcode) > 0) {
        print join("\t", $aseqno, $callcode, 1, $matrix, $inits, 0, 0) . "\n";
    }
} # while <>
#================
__DATA__
#F A193455 a(n) = 5*a(n-8) for n >= 34  [0,-5,0,0,0,0,0,0,0,1]"
%F A193456 for n>=69, a(n)=6*a(n-10)
%F A193457 for n>=80, a(n)=6*a(n-11)
#F A246074 a(n) = 2*a(n-6) for n >= 12.
#F A246075 a(n) = 2*a(n-7) for n >= 14.
#F A246076 a(n) = 2*a(n-8) for n >= 25.
#F A246077 a(n) = 2*a(n-5) for n >= 16.
#F A246078 a(n) = 3*a(n-11) for n >= 26.
#F A246079 a(n) = 3*a(n-14) for n >= 33.
#F A246080 a(n) = 3*a(n-6) for n >= 10.
#F A246081 a(n) = 3*a(n-9) for n >= 15.
#F A246082 a(n) = 3*a(n-12) for n >= 20.
#F A246083 a(n) = 3*a(n-15) for n >= 25.
#F A246084 a(n) = 3*a(n-7) for n >= 26.
#F A246085 a(n) = 3*a(n-10) for n >= 25.
#F A246086 a(n) = 3*a(n-13) for n >= 32.
#F A246087 a(n) = 3*a(n-16) for n >= 39.
#F A246088 a(n) = 4*a(n-10) for n >= 32.
%F A246089 a(n) = 3*a(n-11) for n >= 41.
%F A246090 a(n) = 3*a(n-14) for n >= 51.
%F A246091 a(n) = 3*a(n-17) for n >= 62.
#F A246092 a(n) = 4*a(n-11) for n >= 36.
%F A246093 a(n) = 4*a(n-15) for n >= 48.
%F A246094 a(n) = 3*a(n-15) for n >= 72.
%F A246095 a(n) = 3*a(n-18) for n >= 66.
%F A246096 a(n) = 4*a(n-12) for n >= 67.
%F A246097 a(n) = 4*a(n-16) for n >= 52.
%F A246098 a(n) = 4*a(n-20) for n >= 64.
%F A246099 a(n) = 3*a(n-19) for n >= 164.
%F A246100 a(n) = 5*a(n-15) for n >= 75.
%F A246101 a(n) = 4*a(n-17) for n >= 75.
%F A246102 a(n) = 4*a(n-21) for n >= 67.
%F A246103 a(n) = 4*a(n-25) for n >= 100.
