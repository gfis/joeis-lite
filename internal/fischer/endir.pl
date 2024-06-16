#!perl

# Change A-numbers into D-numbers for DirectSequences and F/K-numbers for Functions and known calls
# @(#) $Id$
# 2024-05-27: later than the version in OEIS-mat/arti/endirect.pl
# 2024-05-14, Georg Fischer: copied from ../sortprep.pl
#
#:# Usage:
#:#   perl endir.pl [-f directfile] infile > outfile
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $direct_file = "reflect/direct.tmp";
my $debug = 0;
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{f}) {
        $direct_file = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

open(DIR, "<", $direct_file) || die "cannot read $direct_file\n";
my %dirs = ();
while (<DIR>) {
    if (m{^(A\d+)}) {
        $dirs{$1} = 1;
    }
} # while <DIR>
close(DIR);

my $line;
while (<>) {
    $line = $_;
    if ($debug >= 1) {
        print "# line=$line";
    }
    foreach my $aseqno ($line =~ m{\b(A\d+)}g) {
        if (defined($dirs{$aseqno})) {
            $line =~ s{$aseqno}{"D" . substr($aseqno, 1)}eg;
        }
    } # foreach
    print $line;
} # while <>
__DATA__
#	F	A339420	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	0	A023358,A323633
%	F	A073118	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A008472,A000041
%	F	A073119	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A007814,A000041
%	F	A073336	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A046951,A000041
%	F	A090319	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	0	A003149,A003149
%	F	A338223	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	0	A014968,A014968
%	F	A342228	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A035316,A000041
%	F	A342229	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A113061,A000041
%	F	A342230	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A001511,A000041
%	F	A342231	a(n)=Sum_{k=(\d+),n}Annn(k)*Annn(n-k)	1	A038712,A000041

