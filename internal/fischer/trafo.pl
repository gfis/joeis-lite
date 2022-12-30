#!perl

# Extract parameters for of the (inverse)Meobius transform
# @(#) $Id$
# 2022-12-19, Georg Fischer: copied from anopan.pl
#
#:# Usage:
#:#     ...jcat25 ... | cut -b 4- | sed -e "s/ /\t/" \
#:#     | perl trafo.pl [-d debug] [-f ofter_file] > $@.tmp 2> $@.rest.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
my $tf = "M..?bius";
if (0 and scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $COMMON = "../../../OEIS-mat/common";
my $ofter_file = "$COMMON/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } elsif ($opt   =~ m{\-tf}  ) {
        $tf         = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
my $trafo = $tf;
if (0) {
} elsif ($trafo =~ m{Binom}) {
    $trafo = "Binomial";
} elsif ($trafo =~ m{Boustro}) {
    $trafo = "Boustrophedon";
} elsif ($trafo =~ m{Euler}) {
    $trafo = "Euler";
} elsif ($trafo =~ m{Logarith}) {
    $trafo = "Logarithmic";
} elsif ($trafo =~ m{bius}) {
    $trafo = "Mobius";
} elsif ($trafo =~ m{Weigh}) {
    $trafo = "Weigh";
} else {
    print STDERR "unknown transform: \"$tf\"\n";
    exit();
}
my $trafoseq = "$trafo" . (($trafo =~ m{Euler}i) ? "Transform" : "TransformSequence");
#----------------
my $aseqno;
my $offset = 1;
my $terms;
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

my $line;
my $name;
my $aofs;   # offset for $aseqno
my $qseqno; # aseqno of the 1st referenced, underlying sequence
my $qshift; # expression is qseqno(n+shift)
my $qofs;   # offset for $qseqno
my $qdisp ; # displacement for qseqno
my $callcode;
my $skip;   # asemble skip instructions here
my $initlist;
my $inits;
my $inverse;
my $iseq;
my $nok;
my $superclass;
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $nok = ""; # assume all ok
    ($aseqno, $name) = split(/\t/, $line);
    $aofs = 0;
    $callcode = "trafo";
    $name = $name || "";
    $name =~ s{([\.]).*}{$1};
    $inits = "";
    $name =~ s{M..?bius}{Mobius}g; # brute force normalization
    if ($name =~ m{apparent|empirical|conject}i) {
        $nok = "?conj"; # ignore the unproven
    #                   1        1                  2  2 3    34   5         5  4 
    } elsif ($name =~ m{(Inverse )?$trafo transform (of) (A\d+)(\(n([\+\-]\d+)\))?}i) {
        ($inverse, $qseqno, $qdisp, $qshift) = ($1 || "", $3, $4 || "", $5 + 0 || "0");
    #                   1        1                  2        2 3    34   5         5  4 
    } elsif ($name =~ m{(Inverse )?$trafo transform (is|gives) (A\d+)(\(n([\+\-]\d+)\))?}i) { # opposite direction
        ($inverse, $qseqno, $qdisp, $qshift) = ($1 || "", $3, $4 || "", $5 + 0 || "0");
        $inverse = ($inverse =~ m{inver}i) ? "" : "Inverse"; # toggle it
    } else {
        $nok = "?ntf";
    }
    if (($nok eq "") && defined($ofters{$qseqno})) { # dependant sequence is already in jOEIS
        $inverse =~ s{inver.*}{Inverse}i;
        $iseq ++;
        $qofs = $ofters{$qseqno};
        $inits = "?INITS";
        $superclass = "$inverse$trafoseq";
        if ($nok eq "") {
            print        join("\t", $aseqno, $callcode, $aofs, $qseqno, $superclass, (($qshift > 0) ? ", $qshift" : ", 0")) . "\n";
            #                                                  parm1    parm2        parm3
        }
    }
    if ($nok eq "" && $iseq > 0) {
    } else {
        print STDERR join("\t", $aseqno, $nok     , $name) . "\n";
    }
} # while <>
#----
sub adjust { 
    my ($iseq, $inx) = @_;
    while ($inx < $aofs) {
        $skip .= "~~mSeq$iseq.next();";
        $inx ++;
    } # while
    return $inx;
} # adjust
#----------------
__DATA__
A006792	anopan	10	2,0,0,0,0,4,8,0,4	a(n) = A006799(n) - A185959(n). - _Andrew Howroyd_, Nov 27 2018
A007411	anopan	2		a(n) = A003182(n) - A003182(n-1) - 1 = A006602(n) - 1.
A007762	anopan	1	1,8,120,2288,49680,1170968,29206632,759265760,20371816992	a(n) = A006318(n-1) * A104550(n) for all known terms [discovered by Sequence Machine]. - _Andrey Zabolotskiy_, Oct 12 2021
A048289	anopan	0		a(n) = A007565(n) - A007565(n-1), for n > 1. - _M. F. Hasler_, Nov 24 2016
A052443	anopan	1	0,0,1,2,7,39,332,4735,113176	a(n) = A002218(n) - A006290(n) for n > 2. - _Andrew Howroyd_, Sep 04 2019
A054907	anopan	0	1,0,0,0,0,0,0,0,1	If 8|n then a(n) = A054908(n) + A054909(n/8), otherwise a(n) = A054908(n). - _Andrey Zabolotskiy_, Nov 05 2021
