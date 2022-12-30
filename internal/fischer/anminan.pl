#!perl

# Extract parameters for of the form a(n) = Qseqno(n) oper Rseqno(n)
# @(#) $Id$
# 2022-12-08, Georg Fischer: copied from dersimple.pl
#
#:# Usage:
#:#     perl anminan.pl [-d debug] [-f ofter_file] > $@.tmp 2> $@.rest.tmp
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
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while options
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
my $VOID = "VOID";

my $line;
my $name;
my $aofs;   # offset for $aseqno
my $qseqno; # aseqno of the 1st referenced, underlying sequence
my $qshift; # expression is qseqno(n+shift)
my $qofs;   # offset for $qseqno
my $qdisp ; # displacement for qseqno
my $rseqno; # aseqno of the 2nd referenced, underlying sequence
my $rshift; # expression is rseqno(n+shift)
my $rdisp ; # displacement for rseqno
my $rofs;   # offset for $rseqno
my $callcode;
my $skip;   # asemble skip instructions here
my $op = "min";
my $modif; # modifier (for pow)
my $initlist;
my $inits;
my $tail;
my $nok;
my $iseq;
my %ophash =
    ( "+",   "add"
    , "-",   "subtract"
    , "*",   "multiply"
    , "/",   "divide"
    , "^",   "pow"
    , "and", "and"
    , "mod", "mod"
    , "or" , "or"
    , "xor", "xor"
    , "xand", "xand"
    );
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    $aofs = 0;
    ($aseqno, $name) = split(/\t/, $line);
    $name = $name || "";
    $name =~ s{([\.]).*}{$1};
    $nok = ""; # assume all ok
    if ($name =~ m{apparent|empirical|conject}i) {
        $nok = "?conj"; # ignore the unproven
    } else {
        $iseq = 0;
        #                       1  1  2       2  3    34   5         5   4       6    67   8         8   7     9                                  8
        while ($name =~ s{[^\=]*(\=) *(min|max)\((A\d+)(\(n([\+\-]\d+)?\))? *\, *(A\d+)(\(n([\+\-]\d+)?\))?\) *([\.\;\:\,\=]|for +n *\>\=? *\d+|\Z)}{}i) {
            ($op, $qseqno, $qshift,$rseqno, $rshift, $tail) = ($2, $3, $4 || 0, $6, $8 || 0, $9);
            ($modif, $qdisp, $rdisp, $skip) = ("", "", "", "");
            $nok = "";
            $iseq ++;
            $inits = "";
            if ($nok ne "") { # failed already
            } else { # 2 dependant sequences
                if (defined($ofters{$qseqno}) && defined($ofters{$rseqno})) {
                    $callcode = "anminan";
                    $qofs = $ofters{$qseqno};
                    $rofs = $ofters{$rseqno};
                    # now determine the skip and prepend instructions
                    my $qinx = $qofs - $qshift;
                    my $rinx = $rofs - $rshift;
                    $qinx = &adjust(1, $qinx);
                    $rinx = &adjust(2, $rinx);
                    if ($qinx == $rinx && $rinx == $aofs) {
                        # ok
                    } else {
                        $callcode = "anminap";
                    }
                } else {
                    $nok = "?qrseq";
                }
            } # 2 dependant sequences
            if ($skip ne "") {
                $skip = "~~    $skip"; # prefix with indent spec.
            }
            if (length($inits) > 0) { # pattern with INITS[]
                $callcode = "anminap";
            }
            $inits = "?INITS";
            if ($iseq > 1) {
                $callcode .= $iseq;
            }
            if ($nok eq "") {
                print        join("\t", $aseqno, $callcode, $aofs, $qseqno, $rseqno, $op,  $modif, $skip, $inits, "$qofs,$rofs") . "\n";
                #                                                  parm1    parm2    parm3 $parm4  $parm5 $parm6  $parm7 parm8
            }
        } # while "= ... " matches
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
A305099	a(n) = min(A005235(n), A055211(n)), for n > 1.
A322351	a(n) = min(A003557(n), A173557(n)).
A322351	a(n) = min(A003557(n), A173557(n)).
A323137	a(n) <= min(A023107(n), A103443(n)). - _Daniel Suteu_, Feb 24 2019
A325224	a(n) = A056239(n) - min(A001222(n), A061395(n)) = A056239(n) - A325225(n).
A325225	a(n) = min(A001222(n), A061395(n)).
A325560	For all n, A325565(n) <= a(n) <= min(A000005(n), A091220(n)).
