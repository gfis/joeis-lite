#!perl

# Evaluate anopan.gen for proper shifting of offsets
# @(#) $Id$
# 2022-12-13, Georg Fischer: copied from anopan.pl
#
#:# Usage:
#:#     perl anopan_eval.pl aseqno
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (0 and scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $COMMON = "../../../OEIS-mat/common";
my $maxlen = 32;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-l}  ) {
        $maxlen     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
#----------------
my $aseqno = shift(@ARGV);
my $offset = 1;
my $terms;
my $line = `grep $aseqno anopsn.gen`;
my $callcode;
my $aofs;   # offset for $aseqno
my $initlist;
my $name;
my $qseqno; # aseqno of the 1st referenced, underlying sequence
my $qshift; # expression is qseqno(n+shift)
my $qofs;   # offset for $qseqno
my $qdisp ; # displacement for qseqno
my $rseqno; # aseqno of the 2nd referenced, underlying sequence
my $rshift; # expression is rseqno(n+shift)
my $rdisp ; # displacement for rseqno
my $rofs;   # offset for $rseqno
my $skip;   # asemble skip instructions here
my $op;
my $modif; # modifier (for pow)
my $inits;
my $nok;
    ($rofs  , $callcode, $aofs, $qseqno, $rseqno, $op,  $modif, $skip, $inits, $qofs) = split(/\t/, $line);
    ($qofs, $rofs) = split(/\,/, $qofs);
    print "$qseqno+$qofs:" . &head($qseqno, $qofs) . "\n";
    print "$rseqno+$rofs:" . &head($rseqno, $rofs) . "\n";
    print "---- $op $modif->\n"; 
    print "$aseqno+$aofs:" . &head($aseqno, $aofs) . "\n";
#----------------
sub head {
    my ($xseqno, $xofs) = @_;
    my $result = "";
    my $line = `grep $xseqno $COMMON/stripped`;
    $line =~ s{\s+\Z}{}; # chompr
    my ($dummy, $list) = split(/ \,/, $line);
    my (@terms) = split(/\,/, $list);
    my $len = scalar(@terms);
    if ($len > $maxlen) {
        $len = $maxlen;
    }
    for (my $i = 0; $i < $len; $i ++) {
        $result .= sprintf("%4d,", $terms[$i]);
    }
    while ($xofs > 0) {
        $result = "     $result";
        $xofs --;
    }
    return $result;
} # head
__DATA__
A067309	anopan	0	A000273	A051504	subtract			?INITS	0,0		Number of symmetric unlabeled digraphs (unlabeled digraphs with nontrivial automorphism group).
A069651	anopan	0	A005249	A000142	divide			?INITS	0,0		For n >= 1, let M_n be the n X n matrix with M_n(i,j) = i^2/(i+j); then a(n) = 1/det(M_n). Also, a(0) = 1 by convention.
A072565	anopan	1	A023523	A000040	mod		~~    ~~mSeq1.next();	?INITS	1,1		a(n) = prime(n+1)*prime(n+2)+1 mod prime(n), where prime(n) is the n-th prime.
A074740	anopan	1	A066843	A002866	divide		~~    ~~mSeq2.next();	?INITS	1,0		a(n) = n!*2^(n-1)/Product_{k=1..n} tau(k) where tau = A000005.
A075113	anopan	0	A000217	A048702	subtract		~~    ~~mSeq2.next();	?INITS	0,0		a(n) = A000217(n) - A048702(n+1).
A077612	anopan	1	A110660	A000142	multiply		~~    ~~mSeq1.next();~~mSeq1.next();~~mSeq1.next();	?INITS	0,0		Number of adjacent pairs of form (even,even) among all permutations of {1,2,...,n}.
A079887	anopan	1	A002330	A002231	subtract		~~    ~~mSeq1.next();~~mSeq2.next();	?INITS	1,1		Values of y-x where p runs through the primes of form 4k+1 and p=x^2+y^2, 0<=x<=y.
