#!perl

# Grep lines that have small values in a field
# 2020-08-24, Georg Fischer: copied from find_repeat.pl
#
#:# Usage:
#:#   perl grep_small.pl [d debug] [-m max-abs] [-n fieldno] input > output
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $debug = 0;
my $nparm = 3; # counted from 0, $(PARM1)
my $maxabs = 2;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $maxabs    = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $nparm     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
if ($maxabs > 9) {
    die "grep_small.pl: maxabs must be a single digit.\n";
}   

while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    next if $line =~ m{\A\s*(\#.*|)\Z}; # comment or empty
    my @parms = split(/\s/, $line);
    if (scalar(@parms) > $nparm) {
        if ($parms[$nparm] =~ m{\A\-?[0-$maxabs](\,\-?[0-$maxabs])*\Z}o) {
            print "$line\n";
        }
    } # if enough fields in record
} # while <>
#================================
__DATA__
A322003	eulerixf	0	nonn	0,1	2,1,0,1,0,0,0,1,0,-1,0,0,0,0,0,1,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	term

A112209 evtlper 0   seqtype prepend 1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-2,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0
A001503 evtlper 0   seqtype prepend 12,90,12000000000000000000
A036837 euguess 0   seqtype prepend 4,1,1,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
A038835 euguess 0   seqtype prepend 4,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3,3,-3
A058484 euguess 0   seqtype prepend 6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0,0,0,6,0,6,0
A058514 euguess 0   seqtype prepend 4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,4,0,4,0,4,-4,4,0,4,0,4,0,4,-4,4,0
A225956 eulerix 0   seqtype prepend 1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-2,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,2,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-2,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,2,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1,-1,1,0,1
A161458 eulerix 0   seqtype prepend 10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0