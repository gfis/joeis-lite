#!perl

# Grep 2 lines a, b starting with "A"; check whether a(a(n)) = b(n)
# 2021-02-10, Georg Fischer
#
#:# Usage:
#:#   perl keeplast.pl input > output
#----------------------------------------------------------------
use strict;
use integer;
use warnings;

my $maxlen = 20;
my (@aterms, @bterms, $aoffset);
my $iseq = 0;
while (<>) {
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\A(A\d+)}) { # with A-number
        my ($aseqno, $offset, $termstr) = split(/\t/, $line);
        my @terms = split(/\,/, $termstr);
        pop(@terms); # last may be incomplete
        my $n = 0;
        my $busy = 1;
        while ($busy == 1 && $n < scalar(@terms)) {
            if (length($terms[$n]) > $maxlen) {
                $busy = 0;
            } else {
                $n ++;
            }
        } # while
        my @xterms = splice(@terms, 0, $n); # truncate at first longer than 6
        for (my $n = 0; $n < $offset; $n++) {
            unshift(@xterms, 0);
        }
        print join("\t", $aseqno, $offset, join(",", @xterms)) . "\n";
        $iseq ++;
        if (0) {
        } elsif ($iseq == 1) {
            @aterms = @xterms;
            $aoffset = $offset;
        } elsif ($iseq == 2) {
            @bterms = @xterms;
        } else {
            # ignore
        }
    } # with A-number
} # while <>

my $alen = scalar(@aterms);
my $blen = scalar(@bterms);

for (my $n = $aoffset; $n < $alen; $n++) {
    my $an = $aterms[$n];
    if ($an < $alen) {
        my $aan = $aterms[$an];
        if ($n < $blen) {
            if ($aan eq $bterms[$n]) {
                print ".. n=$n: a(n)=$an, a(a(n))=$aan == b(n)=$bterms[$n]\n";
            } else {
                print "?? n=$n: a(n)=$an, a(a(n))=$aan != b(n)=$bterms[$n]\n";
            }
        }
    } else {
        # ignore outside
                print ">> n=$n: a(n)=$an\n";
    }
} # for $n
__DATA__
java irvine.oeis.InverseAronsonTransform -d 0 -n 16 -s A008585 -o 0
A000000 0       0,2,3,6,5,12,9,8,21,18,11,30,15,14,39,36
