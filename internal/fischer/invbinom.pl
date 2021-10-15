#!perl

# Extract parameters for "inverse binomail transform of" 
# 2021-10-14, Georg Fischer: copied from divpow.pl
#
#:# Usage:
#:#   perl invbinom.pl [-d debug] $(COMMON)/joeis_names.txt > output.seq4
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, $name, @rest);
my ($rseqno);
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $offset = 0;
$callcode = "invbinom";
# while (<DATA>) { # from joeis_names.txt
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    # next if $superclass ne "null";
    my $k;
    if (0) {
    } elsif ($name =~ m{(inverse binomial transform (.*)}i) {
        my $rest = $1;
        if ($rest =~ m{(A\d\d\d\d\d\d+)}) {
            $rseqno = $1;
            print join("\t", $aseqno, "$callcode", $offset, $rseqno, $name) . "\n";
        }
    }
} # while <>
__DATA__
A089302 null    Triangle read by rows in which each row is the inverse binomial transform of a diagonal of A089246.
A089942 null    Inverse binomial matrix applied to A039599.     nonn,tabl,changed,      0..1274 nyi
A093523 null    Inverse binomial transform of A010054 (1 if triangular number else 0).  sign,synth      0..36   nyi
A093968 LinearRecurrence        Inverse binomial transform of n*Pell(n).        easy,nonn,synth 0..38   unkn
A098111 LinearRecurrence        Inverse binomial transform of A098149.  easy,sign,synth 0..25   unkn