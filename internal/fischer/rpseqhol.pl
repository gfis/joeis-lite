#!perl

# Extract parameters 
# A163493 Number of binary strings of length n which have the same number of 00 and 01 substrings.
# A164137 null    Number of binary strings of length n with equal numbers of 000 and 001 substrings.      nonn,   0..500  nyi
# 2021-05-17, Georg Fischer: copied from binomin.pl
#
#:# Usage:
#:#   perl rpseqhol.pl [-d debug] $(COMMON)/joeis_names.txt > rpseqhol.tmp
#:#     -d debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $sel = 0;
my $line = "";
my ($aseqno, $callcode, $offset, $name, @rest);
my $debug   = 0;
while (scalar(@ARGV) > 0 && ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-s}  ) {
        $sel        = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

while (<>) { # from $(COMMON)/jcat25.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $name, @rest) = split(/\t/, $line);
    $callcode = "rpseqhol";
    $offset = 0;
    if ($name =~ m{Number of binary strings of length n (which have the same number|with equal numbers) of (\d+) and (\d+) substrings}) {
        my @words = ($2, $3);
        for (my $iw = 0; $iw < 2; $iw ++) {
        	$words[$iw] =~ tr{01}{12};
        	$words[$iw] = join(",", split(//, $words[$iw]));
        }
        # @w = map { my $elem = ($_ =~ );  } @w;
        print join("\t", $aseqno, $callcode, $offset, @words, "end") . "\n";
    } else {
        print STDERR join("\t", $aseqno, "rest", $offset, $name) . "\n";
    }
} # while <>
__DATA__
012345678901
