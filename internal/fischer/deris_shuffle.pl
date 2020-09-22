#!perl

# Determine skip and/or prepend in deris.gen
# @(#) $Id$
# 2020-09-20: Georg Fischer: copied from posins.pl
#
#:# Usage:
#:#     perl deris_shuffle.pl -i.bak deris.gen
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -cc one of the callcodes diffseq, recordpos, recordval (default), charfun, ...
#:#     deris.gen file with aseqno, callcode, offset1, rseqno, roffset, constr, parm7=aterms, parm8=rterms
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
my $callcode;
my $limit = 4;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-lim}i) {
        $limit      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my %callcodes = qw(
    charfun   CharacteristicFunction
    compseq   ComplementSequence
    diffseq   DifferenceSequence
    eulerx    EulerTransform
    eulerix   EulerInvTransform
    moebiusx  MobiusTransform
    moebiusix InverseMobiusTransform
    partsum   PartialSumSequence
    primepos  PrimePositionSubsequence
    primeval  PrimeSubsequence
    recordpos RecordPositionSubsequence
    recordval RecordSubsequence
    );
my $line;
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    my ($aseqno, $callcode, @parms) = split(/\t/, $line);
    my $iparm = 0;
    my $offset = $parms[$iparm ++];
    my $rseqno = $parms[$iparm ++]; # 1
    my $roffset= $parms[$iparm ++]; # 2
    my $dummy3 = $parms[$iparm ++]; # 3
    my $dummy4 = $parms[$iparm ++]; # 4
    my $dummy5 = $parms[$iparm ++]; # 5
    my $dummy6 = $parms[$iparm ++]; # 6
    my $alist  = $parms[$iparm ++]; # 7
    my $rlist  = $parms[$iparm ++]; # 8

    my @aterms = split(/\,/, $alist);
    my @rterms = split(/\,/, $rlist);
    my $busy = 1;
    my $inda = 0;
    while ($busy == 1 && $inda < $limit) {
        my $indr = 0;
        while ($busy == 1 && $indr < $limit) {
            if (  $aterms[$inda + 0] == $rterms[$indr + 0]
               && $aterms[$inda + 1] == $rterms[$indr + 1]
               && $aterms[$inda + 2] == $rterms[$indr + 2]
               && $aterms[$inda + 3] == $rterms[$indr + 3]
               ) {
               $busy = ($indr + $inda) > 0 ? 0 : 1;
               $parms[2] = ($indr > 0) ? "$indr, " : ""; # skip
               $parms[4] = ($inda > 0) ? ", " . join(",", splice(@aterms, 0, $inda)) : ""; # prepend
            }
            $indr ++;
        } # while $indr
        $inda ++;
    } # while $inda
    if ($busy == 0) {
        print join("\t", $aseqno, $callcode, @parms) . "\n";
    }
} # while <>
__DATA__
