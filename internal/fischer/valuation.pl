#!perl

# Extract parameters for irvine.math.z.ZUtils.valuation(base, n)
# 2022-03-16, Georg Fischer: copied from prisub.pl
#
#:# Usage:
#:#   grep -E "^\%[NFC]" $(COMMON)/jcat25.txt | grep valuation | cut -b4- | sed -e "s/ /\t/" \
#:#   | perl valuation.pl [-d debug] [-e] [-f ofter_file] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
my $offset = 0;
my $rseqno = "";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = sjift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $terms;
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------
my $base = "";
my @znames = qw(ZERO ONE TWO THREE FOUR FIVE SIX SEVEN EIGHT NINE TEN);
$callcode = "valuat";

while (<>) { # from jcat25.txt, like asname.txt
    s/\s+\Z//; # chompr
    $line = $_;
    $rseqno = "";
    ($aseqno, $name) = split(/\t/, $line);
    if (0) {
    } elsif ($name =~ m{(\d+)\-adic valuation of (A\d+)}) {
        $base   = $1;
        $rseqno = $2;
    } # if proper name
    
    if (0) {
    } elsif (length($rseqno) > 0) {
        $base = $base <= 10 ? "Z.$znames[$base]" : "Z.valueOf($base)";
        print        join("\t", $aseqno, $callcode, $offset, $rseqno, $base, $name) . "\n";
    } else {
        $name =~ m{(A\d\d+)};
        $rseqno = $1 || "";
        print STDERR join("\t", $aseqno, $callcode, $offset, $rseqno, 2, $name) . "\n";
    }
} # while <>
#================
__DATA__
