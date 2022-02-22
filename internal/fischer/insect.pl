#!perl

# Extract parameters for IntersectionSequence
# 2022-02-22, Georg Fischer
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl insect.pl [-d debug] [-e] [-f ofter_file] > output
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
my $ex = "";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
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
my ($parms, $letter, $expr);
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    $callcode = "nyi";
    my @aseqnos;
    ($aseqno
        # for joeis_names.txt: , $superclass
        , $name) = split(/\t/, $line);
    if (0) {
    } elsif ($name =~ m{Intersection of (A\d+) (and|inter) (A\d+)}i) {
        @aseqnos = ($1, $3);
        if (defined($ofters{$aseqnos[0]}) && defined($ofters{$aseqnos[1]})) {
            $callcode = "insect2";
        }
    } elsif ($name =~ m{Intersection of +(A\d+)\, +(A\d+) +and +(A\d+)}i) {
        @aseqnos = ($1, $2);
        if (defined($ofters{$aseqnos[0]}) && defined($ofters{$aseqnos[1]})) {
            $callcode = "insect2";
        }
    }
    if ($callcode ne "nyi") {
        print join("\t", $aseqno, $callcode, 0, join("\t", map { "new $_()" } @aseqnos)) . "\n";
    }
} # while <>
__DATA__
A065767 null    Intersection of A065764 and A065765
A065768 null    Intersection of A065764 and A065766
A071348 null    Intersection of A068017 and A068019
1000    nyi
A080118 null    Intersection of A080117 and A014486
A081292 null    Intersection of A014486 and A079946
A108109 null    Intersection of A108027, A108028, A
A113601 null    Intersection of A002144 and A005098
A117482 null    Numbers with no 1's in their base-3
A128996 null    Intersection of A061068 and A064270
A129307 null    Intersection of A000217 and A005098