#!perl

# For all A-numbers in a seq4-record: add comment lines with the names
# @(#) $Id$
# 2021-10-03, Georg Fischer
#
#:# Usage:
#:#   perl -i.bak annotate.pl [-data] icc.gen
#:#      -data add data lines also
#:#   Modifies the file in place.
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
# print "# annotated by joeis-lite/internal/fischer/annotate.pl $timestamp\n";

my $data  = 0;
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{w}) {
        my $data   = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my $COMMON = "../../../OEIS-mat/common";
my $aseqno;
my %hash;

# while(<DATA>) {
while(<>) {
    next if ! m{\AA\d}; # take A-number lines only, remove old comment
    print; # repeat the line
    s/\s+\Z//; # chompr
    my $line = $_;
    if ($line =~ m{\A(A\d+)}) { # starts with A-number
        %hash = ();
        $aseqno = $1;
        print STDERR "$aseqno\n";
        &annot($aseqno);
        foreach my $aseqno ($line =~ m{\W(A\d\d\d+)}g) {
            &annot($aseqno);
        } # foreach
    } # if A-number
    print "#--------\n";
} # while <>
#----
sub annot {
    my ($aseqno) = @_;
    if (! defined($hash{$aseqno})) {
        $hash{$aseqno} = 1; # don't annotate it again for this seq4 record
        my $result;
        my $cmd  = "grep -E \"^$aseqno\" $COMMON/asname.txt";
        $result = `$cmd`;
        $result =~ s{\s+\Z}{};
        print "# $result\n";
        if ($data) {
            $cmd = "grep -E \"^$aseqno\" $COMMON/bfdata.txt";
            $result = `$cmd`;
            $result =~ s{\s+\Z}{};
            if (length($result) > $data) {
                $result =~ substr($result, 0, $data);
                $result =~ s{\,[\s\d]\Z}{\.\.\.};
            }
            print "# $result\n";
        } # if -data
    } # not twice
} # annot
__DATA__
A053207	wraptr	0	A172273	A005843						Rows of triangle formed using Pascal's rule except begin n-th row with n and end it with n+1.
A054143	wraptr	0	______1	A168604						Triangular array T given by T(n,k) = Sum_{0 <= j <= i-n+k, n-k <= i <= n} C(i,j) for n >= 0 and 0 <= k <= n.
A057211	wraptre	1	A059841	A059841	A059841	~~    ~~return getPlus();					n-th run has length n.

