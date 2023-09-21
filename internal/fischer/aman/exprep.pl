#!perl

# Expand abbreviated expressions (only if callcode = "LAMBDA")
# @(#) $Id$
# 2023-09-21, Georg Fischer: copied from morfps.pl
#
#:# Usage:
#:#   perl exprep.pl input.seq4 > output.seq4
#---------------------------------
use strict;
use integer;
use warnings;

my $line;
my ($aseqno, $callcode, $offset, $lambda);

while(<>) {
    s{\s+\Z}{}; # chompr
    $line = $_;
    next if $line !~ m{\AA[0-9]+\s+LAMBDA}; # does not start with A-number, and is not abbreviated
    $line =~ s{\tLAMBDA}{\tlambda};
    $line =~ s{\t}{ }g;
    ($aseqno, $callcode, $offset, $lambda) = split(/ /, $line, 4);
    $lambda =~ s{ }{}g;
    $lambda =~ s{newQ}{new Q}g;
    my $prefix = "";
# bad    if ($lambda =~ m{MFAC\([nk]\-(\d+)}) {
# bad        $prefix = "(n <= $1) ? Z.ONE : ";
# bad    }
    $lambda =~ s{\,}{\, }g;
    $lambda =~ s{(\-\>|[\+\-\:\?])}{ $1 }g;
    if ($lambda =~ s{^MFAC\(n\)\*}{}) {
        $lambda .=  ".MUL(MFAC(n))";
    }
    # caution, order matters:
    $lambda =~ s{sumdiv\(}  {Integers.SINGLETON.sumdiv\(}g;
    $lambda =~ s{SUMDIV\(}  {Rationals.SINGLETON.sumdiv\(}g;
    $lambda =~ s{sum\(}     {Integers.SINGLETON.sum\(}g;
    $lambda =~ s{SUM}       {Rationals.SINGLETON.sum}g;
    $lambda =~ s{ZVA}       {Z.valueOf}g;
    $lambda =~ s{SUB}       {subtract}g;
    $lambda =~ s{MUL}       {multiply}g;
    $lambda =~ s{DIV}       {divide}g;
    $lambda =~ s{BIN}       {Binomial.binomial}g;
    $lambda =~ s{ST1}       {Stirling.firstKind}g;
    $lambda =~ s{ST2}       {Stirling.secondKind}g;
    $lambda =~ s{MFAC}      {MemoryFactorial.SINGLETON.factorial}g;
    if (($lambda =~ m{Rationals}) && ($lambda !~ m{\.den\(\)|\.num\(\)})) {
        $lambda .= ".num()";
    }
    $lambda = "$prefix$lambda";
    print join("\t", $aseqno, $callcode, $offset, $lambda) . "\n";
} # while <>
#--------
__DATA__
A361617	lambda	0	MFAC(n)*SUM(0,n  , k -> new Q(BIN(n+(n-1)*(k+1),n-k)	,	MFAC(k)))
A361626	lambda	0	MFAC(n)*SUM(0,n  , k -> new Q(BIN(n+2*k+1,n-k)	,	MFAC(k)))
A343884	lambda	0	MFAC(n)*SUM(0,n  , k -> new Q(BIN(n+k+1,n-k)	,	MFAC(k)))
A351931	lambda	0	MFAC(n)*SUM(0,n/5, k -> new Q(-1,120).pow(k).MUL(BIN(n-4*k,k)).DIV(MFAC(n-4*k)))
A352659	lambda	0	MFAC(n)*SUM(0,n/3, k -> new Q(Z.ONE	,	MFAC(3*k)))
A361657	lambda	0	MFAC(n)*SUM(0,n/4, k -> new Q(Z.ONE	,	(MFAC(k).square()	.MUL(MFAC(2*k).DIV(MFAC(n-4*k))))))
A361673	lambda	0	MFAC(n)*SUM(0,n/5, k -> new Q(Z.ONE	,	(MFAC(k).pow(3)		.MUL(MFAC(2*k).DIV(MFAC(n-5*k))))))
A361637	lambda	0	MFAC(n)*SUM(0,n/4, k -> new Q(Z.ONE	,	(MFAC(k).pow(4)		.MUL(MFAC(n-4*k)))))
A351932	lambda	0	MFAC(n)*SUM(0,n/4, k -> new Q(Z.ONE	,	ZVA(24).pow(k)		.MUL(BIN(n-3*k,k).DIV(MFAC(n-3*k)))))
