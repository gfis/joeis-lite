#!perl

# Extract parameters for PositionSequence.java
# @(#) $Id$
# 2021-08-26: read ofter
# 2020-06-21: read deriv0.tmp; from cat25.txt
# 2020-06-04, Georg Fischer
#
#:# Usage:
#:#     grep -E "Positions of " $(COMMON)/cat25.txt \
#:#     | cut -b4 | sed -e "s/ /\t/" \
#:#     | perl posins.pl [-d debug] [-f ofter-file] > posins.gen 2> posins.rest
#:# Reads deriv0.txt for implemented jOEIS sequences with their offsets.
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}

my %bases = qw(binary 2 digital 2 ternary 3 duodecimal 12 hexadecimal 16 sexagesimal 60);
my $line;
my ($aseqno, $offset1, $name, $terms, @rest); # records in joeis_names.txt
my $value;
my $cond;
my $callcode = "posins";
my $offset = 1;
my $rseqno;
my $DSEQNO = "A000000";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";

while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
#----------------
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = $offset; # "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $name, @rest) = split(/\t/, $line);
    if (! defined($ofters{$aseqno})) { 
        $rseqno = $DSEQNO;

        if (0) {
        } elsif ($name =~ m{Positions of (the digit )?\'?(\d)\'?s?\s+(after decimal point )?in (the )?decimal expansion of ([^\.]+)\.}) {
            $value = $2;
            my $expr = $5;
            if (0) {
            } elsif ($expr =~ m{\Aexp\(1\)}i) {
                $rseqno = "A001113";
            } elsif ($expr =~ m{\Asqrt\(2\)}i) {
                $rseqno = "A002193";
            } elsif ($expr =~ m{Euler\'?s?\s+(gamma|constant)}i) { # tests take too long
                $rseqno = "A001620";
            } elsif ($expr =~ m{sqrt\(5\)}i) {
                $rseqno = "A001622";
            } elsif ($expr =~ m{1\/Pi}i) {
                $rseqno = "A049541";
            } elsif ($expr =~ m{\APi}i) {
                $rseqno = "A000796";
            }   
        } elsif ($name =~ m{Positions of 0 in base\-2 representation of 1\/sqrt\(2\)\.}) {
            # A246339   null    Positions of 0 in base-2 representation of 1/sqrt(2).   nonn,easy,changed,  1..1000
            $rseqno = "A004539";
            $value = 0;
        } elsif ($name =~ m{Positions of 1 in the continued fraction expansion of Pi\.}) {
            # A203168   null    Positions of 1 in the continued fraction expansion of Pi.   nonn,nice,changed,  1..1000
            $rseqno = "A001203";
            $value = 1;
        } elsif ($name =~ m{Positions of ([^A]+)(A\d{6})}) {
            $rseqno = $2;
            $value = $1;
            $value =~ s{in \Z}{};
            if (0) {
            } elsif ($value =~ m{\A(\d+)\'?s? }) {
                $value = $1;
            } elsif ($value =~ m{\Azeroe?s? }) {
                $value = 0;
            } elsif ($value =~ m{\Aones? }) {
                $value = 1;
            } elsif ($value =~ m{\Aminus ones? }) {
                $value = -1;
            } elsif ($value =~ m{\Asevens? }) {
                $value = 7;
            } elsif ($value =~ m{\A\'?(\-?\d)\'?s? }) {
                $value = $1;
            } else {
                $rseqno = $DSEQNO; # cannot decode it
            }

        } # if $name 
        $rseqno =~ s{A190449}{A190445}; # typo
        $rseqno =~ s{A190554}{A190555}; # typo
        $rseqno =~ s{A190559}{A190555}; # typo
        $rseqno =~ s{A190697}{A190693}; # typo
        $rseqno =~ s{A287109}{A287108}; # typo
        $rseqno =~ s{A287268}{A287267} if $aseqno =~ m{A2872(69|70)}; # typo
        $rseqno =~ s{A287268}{A287337} if $aseqno =~ m{A2873(38|39|40)}; # typo
        $rseqno =~ s{A287357}{A287356} if $aseqno =~ m{A2873(57|58|59)}; # typo
        $rseqno =~ s{A284932}{A284792} if $aseqno =~ m{A2849(33|34)}; # typo
        $value  = 1 if $aseqno eq "A285564";
        if (defined($ofters{$rseqno})) { 
            my $roffset = $ofters{$rseqno}; # offset of $rseqno
            if ($aseqno ge "A036974" and $aseqno le "A037008") {
                $roffset = 0; # "3." of Pi to be ignored
            }
            if ($aseqno eq "A083866") {
                $roffset = 0;
            }
            my $parm4 = "";
            if ($aseqno eq "A037002") {
                $parm4 = "next();";
            }
            print join("\t", $aseqno, $callcode, $offset, $rseqno, $roffset, $value, $parm4, substr($name, 0, 128)) . "\n";
        } else {
            print STDERR "$line\n";
        }
    } # Positions of
} # while <>
#--------------------------------------------
__DATA__
A054285 Positions of 9's in the decimal expansion of exp(1).    nonn,base,      1..1000
A054286 Positions of 0's in the decimal expansion of the Golden Ratio (sqrt(5)+1)/2.    nonn,base,      1..1020
A054287 Positions of 1's in the decimal expansion of (1 + sqrt(5))/2.   nonn,base,changed,      1..1000
A059649 Positions of ones in A059648.   nonn,synth      1..59
A059653 Positions of ones (+1's) in A059652.    nonn,synth      1..54
A059655 Positions of minus ones (-1's) in A059652.      nonn,synth      1..57
A059657 Positions of ones (+1's) in A059651.    nonn,synth      1..47
A059659 Positions of minus ones (-1's) in A059651.      nonn,synth      1..62
A134251 Positions of 1 after decimal point in decimal expansion of 1/Pi.
A171952 Positions of 2's in A181391.    nonn,   1..835
A165461 Positions of zeros in A165460.  nonn,   0..1000
A190889 Positions of 2 in A190886.
A134251 Positions of 1 after decimal point in decimal expansion of 1/Pi.  nonn,base,changed,  1..10000
