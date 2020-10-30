#!perl

# Extract parameters for comparisions of digit sets
# @(#) $Id$
# 2020-10-30, Georg Fischer: copied from nisolut.pl
#
#:# Usage:
#:#     perl digsets.pl [-d level] > $@.gen
#:#         -d  debugging level (0=none (default), 1=some, 2=more)
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
my $cc = "digsets";
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
my $line;
my @parms; # records in joeis_names.txt
my $matrix;
my $offset = 0;
my $callcode;

while (<DATA>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $callcode = $cc;
    my ($aseqno, $superclass, $name, $keywords, $range) = split(/\t/, $line);
    $name =~ s{base[ \-](\d+) digit}{base x digit};
    my $base1 = $1 || "";
    $name =~ s{base[ \-](\d+) digit}{base y digit};
    my $base2 = $1 || "";
    my $rseqno = "VOID";
    if (0) {
    } elsif ($name =~ m{sum of base x}i) {
        $rseqno = "A037303";
    } elsif ($name =~ m{no base x}i) {
        $rseqno = "A037337";
    } elsif ($name =~ m{every base x}i) {
        $rseqno = "A037372";
    } elsif (($name =~ m{set of base x}) and ($name =~ m{equals})) {
        $rseqno = "A037408";
    }
    print join("\t", $aseqno, $callcode, 0, $rseqno, $base1, $base2) . "\n";
} # while DATA
__DATA__
A037303	null	(sum of base 2 digits of n)=(sum of base 5 digits of n).	nonn,base,changed,	1..1000
A037304	null	(sum of base 2 digits of n)=(sum of base 6 digits of n).	nonn,base,synth	1..48
A037305	null	(sum of base 2 digits of n)=(sum of base 7 digits of n).	nonn,base,synth	1..47
A037307	null	(sum of base 2 digits of n)=(sum of base 9 digits of n).	nonn,base,synth	1..47
A037308	null	Numbers k such that (sum of base-2 digits of k) = (sum of base 10 digits of k).	nonn,base,	1..10000
A037309	null	(sum of base 3 digits of n)=(sum of base 4 digits of n).	nonn,base,synth	1..49
A037310	null	Numbers with the same sum of base 3 digits as sum of base 5 digits.	nonn,base,	1..10000
A037311	null	(sum of base 3 digits of n)=(sum of base 6 digits of n).	nonn,base,synth	1..49
A037312	null	(sum of base 3 digits of n)=(sum of base 7 digits of n).	nonn,base,	1..1000
A037313	null	(sum of base 3 digits of n)=(sum of base 8 digits of n).	nonn,base,synth	1..48
A037314	null	Numbers n such that (sum of base 3 digits of n)=(sum of base 9 digits of n).	nonn,base,changed,synth	0..53
A037315	null	(sum of base 3 digits of n)=(sum of base 10 digits of n).	nonn,base,look,	1..10000
A037316	null	(sum of base 4 digits of n)=(sum of base 5 digits of n).	nonn,base,	1..10000
A037317	null	(sum of base 4 digits of n)=(sum of base 6 digits of n).	nonn,base,synth	1..48
A037318	null	(Sum of base 4 digits of n)=(sum of base 7 digits of n).	nonn,base,synth	1..54
A037319	null	(sum of base 4 digits of n)=(sum of base 8 digits of n).	nonn,base,synth	1..50
A037320	null	(sum of base 4 digits of n)=(sum of base 9 digits of n).	nonn,base,synth	1..48
A037321	null	Numbers n such that (sum of base 4 digits of n)=(sum of base 10 digits of n).	nonn,base,synth	1..51
A037322	null	Numbers n such that (sum of base 5 digits of n) = (sum of base 6 digits of n).	nonn,base,synth	1..50
A037323	null	(sum of base 5 digits of n)=(sum of base 7 digits of n).	nonn,base,synth	1..55
A037324	null	(sum of base 5 digits of n)=(sum of base 8 digits of n).	nonn,base,	1..1000
A037325	null	(sum of base 5 digits of n)=(sum of base 9 digits of n).	nonn,base,synth	1..57
A037326	null	(sum of base 5 digits of n)=(sum of base 10 digits of n).	nonn,base,synth	1..47
A037327	null	(sum of base 6 digits of n)=(sum of base 7 digits of n).	nonn,base,synth	1..49
A037328	null	(sum of base 6 digits of n)=(sum of base 8 digits of n).	nonn,base,synth	1..50
A037329	null	(sum of base 6 digits of n)=(sum of base 9 digits of n).	nonn,base,synth	1..50
A037330	null	(sum of base 6 digits of n)=(sum of base 10 digits of n).	nonn,base,synth	1..49
A037331	null	(sum of base 7 digits of n)=(sum of base 8 digits of n).	nonn,base,synth	1..50
A037332	null	(sum of base 7 digits of n)=(sum of base 9 digits of n).	nonn,base,synth	1..51
A037333	null	(sum of base 7 digits of n)=(sum of base 10 digits of n).	nonn,base,synth	1..54
A037334	null	(sum of base 8 digits of n)=(sum of base 9 digits of n).	nonn,base,synth	1..49
A037335	null	(sum of base 8 digits of n)=(sum of base 10 digits of n).	nonn,base,synth	1..47
A037336	null	(sum of base 9 digits of n)=(sum of base 10 digits of n).	nonn,base,synth	1..49
A037337	null	n-th number k such that no base 9 digit of k is a base 10 digit of k.	nonn,base,	1..1000
A037339	null	Numbers n such that no base 2 digit of n is a base 5 digit of n.	nonn,base,	1..1000
A037340	null	Numbers n such that no base 2 digit of n is a base 6 digit of n.	nonn,base,	1..1000
A037341	null	Numbers n such that no base 2 digit of n is a base 7 digit of n.	nonn,base,	1..1000
A037342	null	Numbers n such that no base 2 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037343	null	Numbers n such that no base 2 digit of n is a base 9 digit of n.	nonn,base,	1..1000
A037344	null	Numbers n such that no base 2 digit of n is a base 10 digit of n.	nonn,base,	1..1000
A037345	null	Numbers n such that no base 3 digit of n is a base 4 digit of n.	nonn,base,	1..54
A037346	null	Numbers n such that no base 3 digit of n is a base 5 digit of n.	nonn,base,	1..1000
A037347	null	n-th number k such that no base 3 digit of k is a base 6 digit of k.	nonn,base,	1..1000
A037348	null	Numbers k such that no base 3 digit of k is a base 7 digit of k.	nonn,base,	1..1000
A037349	null	Numbers n such that no base 3 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037350	null	Numbers n such that no base 3 digit of n is a base 9 digit of n.	nonn,base,	1..1000
A037351	null	Numbers n such that no base 3 digit of n is a base 10 digit of n.	nonn,base,	1..1000
A037352	null	Numbers n such that no base 4 digit of n is a base 5 digit of n.	nonn,base,	1..600
A037353	null	Numbers k such that no base-4 digit of k is a base-6 digit of k.	nonn,base,changed,	1..1000
A037354	null	Numbers n such that no base 4 digit of n is a base 7 digit of n.	nonn,base,	1..1000
A037355	null	Numbers n such that no base 4 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037356	null	Numbers n such that no base 4 digit of n is a base 9 digit of n.	nonn,base,	1..1000
A037357	null	Numbers n such that no base 4 digit of n is a base 10 digit of n.	nonn,base,	1..1000
A037358	null	Numbers n such that no base 5 digit of n is a base 6 digit of n.	nonn,base,	1..1000
A037359	null	Numbers n such that no base 5 digit of n is a base 7 digit of n.	nonn,base,	1..1000
A037360	null	Numbers n such that no base 5 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037361	null	Numbers n such that no base 5 digit of n is a base 9 digit of n.	nonn,base,	1..1000
A037362	null	Numbers n such that no base 5 digit of n is a base 10 digit of n.	nonn,base,	1..1000
A037363	null	Numbers n such that no base 6 digit of n is a base 7 digit of n.	nonn,base,	1..1000
A037364	null	Numbers n such that no base 6 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037365	null	Numbers n such that no base 6 digit of n is a base 9 digit of n.	nonn,base,	1..1000
A037366	null	Numbers n such that no base 6 digit of n is a base 10 digit of n.	nonn,base,	1..1000
A037367	null	Numbers n such that no base 7 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037368	null	Numbers n such that no base 7 digit of n is a base 9 digit of n.	nonn,base,	1..1000
A037369	null	Numbers n such that no base 7 digit of n is a base 10 digit of n.	nonn,base,	1..1000
A037370	null	n-th number k such that no base 8 digit of k is a base 9 digit of k.	nonn,base,	1..1000
A037371	null	n-th number k such that no base 8 digit of k is a base 10 digit of k.	nonn,base,	1..1000
A037372	null	Numbers n such that every base 2 digit of n is a base 3 digit of n.	nonn,base,	1..10000
A037373	null	Numbers n such that every base 2 digit of n is a base 4 digit of n.	nonn,base,	1..10000
A037374	null	Numbers n such that every base 2 digit of n is a base 5 digit of n.	nonn,base,	1..10000
A037375	null	Numbers n such that every base 2 digit of n is a base 6 digit of n.	nonn,base,	1..10000
A037376	null	Numbers n such that every base 2 digit of n is a base 7 digit of n.	nonn,base,	1..10000
A037377	null	n-th number k such that every base 2 digit of k is a base 8 digit of k.	nonn,base,	1..10000
A037378	null	n-th number k such that every base 2 digit of k is a base 9 digit of k.	nonn,base,	1..10000
A037379	null	n-th number k such that every base 2 digit of k is a base 10 digit of k.	nonn,base,	1..10000
A037380	null	Numbers n such that every base 3 digit of n is a base 4 digit of n.	nonn,base,	1..10000
A037381	null	Numbers n such that every base 3 digit of n is a base 5 digit of n.	nonn,base,	1..10000
A037382	null	Numbers n such that every base 3 digit of n is a base 6 digit of n.	nonn,base,	1..10000
A037383	null	Numbers n such that every base 3 digit of n is a base 7 digit of n.	nonn,base,	1..10000
A037384	null	Numbers n such that every base 3 digit of n is a base 8 digit of n.	nonn,base,	1..1000
A037385	null	Numbers n such that every base 3 digit of n is a base 9 digit of n.	nonn,base,	1..10000
A037386	null	Every base 3 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037387	null	Numbers n such that every base 4 digit of n is a base 5 digit of n.	nonn,base,changed,	1..10000
A037388	null	Numbers n such that every base 4 digit of n is a base 6 digit of n.	nonn,base,	1..10000
A037389	null	Every base 4 digit of k is a base 7 digit of k.	nonn,base,	1..10000
A037390	null	Numbers n such that every base 4 digit of n is a base 8 digit of n.	nonn,base,	1..10000
A037391	null	Numbers n such that every base 4 digit of n is a base 9 digit of n.	nonn,base,	1..10000
A037392	null	Every base 4 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037393	null	Numbers n such that every base 5 digit of n is a base 6 digit of n.	nonn,base,	1..10000
A037394	null	Numbers n such that every base 5 digit of n is a base 7 digit of n.	nonn,base,	1..10000
A037395	null	Numbers n such that every base 5 digit of n is a base 8 digit of n.	nonn,base,	1..10000
A037396	null	Numbers n such that every base 5 digit of n is a base 9 digit of n.	nonn,base,	1..10000
A037397	null	Every base 5 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037398	null	Numbers n such that every base 6 digit of n is a base 7 digit of n.	nonn,base,	1..10000
A037399	null	Numbers n such that every base 6 digit of n is a base 8 digit of n.	nonn,base,	1..10000
A037400	null	Numbers n such that every base 6 digit of n is a base 9 digit of n.	nonn,base,	1..10000
A037401	null	Every base 6 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037402	null	Numbers n such that every base 7 digit of n is a base 8 digit of n.	nonn,base,	1..10000
A037403	null	Numbers n such that every base 7 digit of n is a base 9 digit of n.	nonn,base,	1..10000
A037404	null	Every base 7 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037405	null	Numbers n such that every base 8 digit of n is a base 9 digit of n.	nonn,base,	1..10000
A037406	null	Every base 8 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037407	null	Every base 9 digit of n is a base 10 digit of n.	nonn,base,	1..10000
A037408	null	Numbers n such that the set of base-2 digits of n equals the set of base-3 digits of n.	nonn,base,	1..10000
A037409	null	Numbers n such that the set of base-2 digits of n equals the set of base-4 digits of n.	nonn,base,	1..10000
A037410	null	Positive numbers n such that the set of base-2 digits of n equals the set of base-5 digits of n.	nonn,base,	1..10000
A037411	null	Positive numbers n such that the set of base-2 digits of n equals the set of base-6 digits of n.	nonn,base,	1..10000
A037412	null	Positive numbers n such that the set of base-2 digits of n equals the set of base-7 digits of n.	nonn,base,	1..10000
A037413	null	Positive numbers n such that the set of base-2 digits of n equals the set of base-8 digits of n.	nonn,base,	1..10000
A037414	null	Positive numbers n such that the set of base 2 digits of n equals the set of base 9 digits of n.	nonn,base,	1..10000
A037415	null	Positive numbers n such that the set of base 2 digits of n equals the set of base 10 digits of n.	nonn,base,	1..10000
A037416	null	Positive integers n such that the set of base-3 digits of n equals the set of base-4 digits of n.	nonn,base,	1..10000
A037417	null	Positive integers n such that the set of base-3 digits of n equals the set of base-5 digits of n.	nonn,base,	1..10000
A037418	null	Positive integers n such that the set of base-3 digits of n equals the set of base-6 digits of n.	nonn,base,	1..10000
A037419	null	Positive integers n such that the set of base-3 digits of n equals the set of base-7 digits of n.	nonn,base,	1..10000
A037420	null	Positive numbers n such that the set of base-3 digits of n equals the set of base-8 digits of n.	nonn,base,	1..10000
A037421	null	Positive numbers n such that the set of base-3 digits of n equals the set of base-9 digits of n.	nonn,base,	1..10000
A037422	null	Positive numbers n such that the set of base 3 digits of n equals the set of base 10 digits of n.	nonn,base,	1..10000
A037423	null	Positive numbers n such that the set of base-4 digits of n equals the set of base-5 digits of n.	nonn,base,	1..10000
A037424	null	Positive numbers n such that the set of base-4 digits of n equals the set of base-6 digits of n.	nonn,base,	1..10000
A037425	null	Positive numbers n such that the set of base-4 digits of n equals the set of base-7 digits of n.	nonn,base,	1..10000
A037426	null	Positive numbers n such that the set of base-4 digits of n equals the set of base-8 digits of n.	nonn,base,	1..10000
A037427	null	Positive numbers n such that the set of base-4 digits of n equals the set of base-9 digits of n.	nonn,base,	1..10000
A037428	null	Positive numbers n such that the set of base-4 digits of n equals the set of base-10 digits of n.	nonn,base,	1..10000
A037429	null	Positive numbers n such that the set of base-5 digits of n equals the set of base-6 digits of n.	nonn,base,	1..10000
A037430	null	Positive numbers n such that the set of base-5 digits of n equals the set of base-7 digits of n.	nonn,base,	1..10000
A037431	null	Positive numbers n such that the set of base-5 digits of n equals the set of base-8 digits of n.	nonn,base,	1..10000
A037432	null	Positive numbers n such that the set of base-5 digits of n equals the set of base-9 digits of n.	nonn,base,	1..10000
A037433	null	Positive numbers n such that the set of base-5 digits of n equals the set of base-10 digits of n.	nonn,base,	1..10000
A037435	null	Positive numbers n such that the set of base-6 digits of n equals the set of base-8 digits of n.	nonn,base,	1..10000
A037436	null	Numbers n such that the set of base 6 digits of n equals the set of base 9 digits of n.	nonn,base,	1..1000
A037437	null	Positive numbers n such that the set of base-6 digits of n equals the set of base-10 digits of n.	nonn,base,	1..10000
A037438	null	Positive numbers n such that the set of base-7 digits of n equals the set of base-8 digits of n.	nonn,base,	1..10000
A037439	null	Positive numbers n such that the set of base-7 digits of n equals the set of base-9 digits of n.	nonn,base,	1..10000
A037440	null	Positive numbers n such that the set of base-7 digits of n equals the set of base-10 digits of n.	nonn,base,	1..10000
A037441	null	Positive numbers n such that the set of base-8 digits of n equals the set of base-9 digits of n.	nonn,base,	1..10000
A037442	null	Positive numbers n such that the set of base-8 digits of n equals the set of base-10 digits of n.	nonn,base,	1..10000
A037443	null	Positive numbers n such that the set of base-9 digits of n equals the set of base-10 digits of n.	nonn,base,	1..10000
