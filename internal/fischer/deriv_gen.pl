#!perl

# Prepare .gen file for callcode "deriv"
# @(#) $Id$
# 2020-06-17, Georg Fischer
#
#:# Usage:
#:#   perl deriv_gen.pl [-d debug] deriv6.tmp > deriv7.tmp
#-------------------------------------------------
use strict;
use integer;
use warnings;
use Digest::MD5;

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);

my $debug = 0;
if (scalar(@ARGV) < 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#--------
my ($aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, @rest);
my (                             $form,  $name,  $cond,  $term8);
my $FSEP = "~~";
my %digits = qw(ONE 1 TWO 2 THREE 3 FOUR 4 FIVE 5 SIX 6 SEVEN 7 EIGHT 8 NINE 9 TEN 10);
while (<>) {
    my $line = $_;
    next if $line !~ m{\AA\d+};
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $callcode, $offset, $form,  $name,  $cond,  $term8, @rest) = split(/\t/, $line);
    $cond =~ s{n\>\=}{};
    my @terms = split(/\,/, $term8);
    pop(@terms); # remove last - not reliable, may be truncated
    my $ok = 1;
    my %imports = (); # rseqno -> 1
    my %clamems = (); # A000959 -> "    final Sequence mA000959 = new A000959(); ", class member declarations
    my @constrs = (); # init statements in constructor
    my @nexts   = (); # preparations in method next()
    my %rseqnos = (); # different rseqno's
    my @rseqs = ($form =~ m{(A\d+\_\w*)}g); # $aseqno is derived from these
    foreach my $rseqelem (@rseqs) {
        $rseqelem =~ m{\A(A\d+)_(\d+)((__?)(\d+))?}; 
        my ($rseqno, $rofs) = ($1, $2);
        my $sign = $4 || "+";
        my $dist = $5 || 0;
        if ($sign eq "+") {
            $rofs += $dist;
        } else {
            $rofs -= $dist;
        }
        if ($rofs != $offset) {
            $ok = -1; # differing offsets
        }
        if (! defined($rseqnos{$rseqno})) {
            $rseqnos{$rseqno} = $rofs;
        } else {
            $rseqnos{$rseqno} .= ",$rofs";
        }
        if (scalar(%rseqnos) != scalar(@rseqs)) {
            $ok = -2; # duplicate rseqnos
        }
        $imports{$rseqno} = 1;
        $clamems{$rseqno} = "final Sequence m$rseqno = new $rseqno();";
        $form =~ s{$rseqelem}{m$rseqno.next()};
    } # foreach
    
    if ($form =~ m{Z\.valueOf\(mN\)} { # add the property "protected long mN;", initialize and increment it
        unshift(@constrs, "mN = " . ($offset - 1) . ";");
        unshift(@nexts,   "++mN;");
        $clamems{"A999991"} = "protected long mN;";
    } # mN addition
    if (1) { # some patches
        $form =~ s{\.pow\(Z\.ONE\.divide\(Z\.TWO\)\)}{\.sqrt\(\)}g; # pow(1/2) -> sqrt
        $form =~ s{\.pow\(Z\.ONE\.divide\(Z\.(\w+)\)\)}{\.root\($digits{$1}\)}g; # pow(1/m) -> root(m)
        $form =~ s{Z\.ZERO\.subtract\(Z\.ONE\)}{Z\.NEG_ONE}g; # 0-1 -> -1
        $form =~ s{Z\.NEG_ONE\.pow\(Z.valueOf\(mN\)\)}{\((mN \& 1L) \=\= 0 \? Z\.ONE \: Z\.NEG_ONE\)}g; # (-1)^n
    } # patches
    
    $callcode = "deriv";
    # deriv.jpat is filled in the following order:
    $parm4 = scalar(%clamems) == 0 ? "" : "$FSEP  $FSEP"   . join($FSEP, sort(values(%clamems)));
    $parm3 = scalar(@constrs) == 0 ? "" : "$FSEP    $FSEP" . join($FSEP, @constrs); 
    $parm2 = scalar(@nexts  ) == 0 ? "" : "$FSEP    $FSEP" . join($FSEP, @nexts); 
    $parm1 = $form; # return value of method next()
    unshift(@rest, $name); # add at the beginning
    if ($ok >= 1) {
        print join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, @rest) . "\n";
    } else {
        print STDERR "# problem$ok:" 
            . join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, @rest) . "\n";
    }
} # while 
#----
sub parm_join {
    my %hash = @_;
    my $result = "";
    if (scalar(%hash) > 0) {
        $result = "$FSEP  $FSEP" . join($FSEP, sort(values(%hash)));
    }
    return $result;
} # parm_join
#----------------
__DATA__
A032548	postder	1	~~A007093_0.divide(Z.valueOf(mN)).floor()	floor(A007093_0/n))		1,1,1,1,1,1,1,1
A032741	postder	0	~~A000005_1.subtract(Z.ONE)	A000005_1-1		0,0,1,1,2,1,3,1
A032742	postder	1	~~Z.valueOf(mN).subtract(A060681_1)	n - A060681_1		1,1,1,2,1,3,1,4
A033157	postder	1	~~A185256_1.add(Z.ONE)	A185256_1 + 1		1,4,5,8,10,13,14,17
A033196	postder	1	~~Z.valueOf(mN).multiply(A000082_1)	n *A000082_1		1,12,36,96,150,432,392,768
A033200	postder	1	~~A033203_1__1	A033203_1__1		3,11,17,19,41,43,59,67
A033273	postder	1	~~A000005_1.subtract(A001221_1)	A000005_1 - A001221_1		1,1,1,2,1,2,1,3
A033452	postder	0	~~A005493_0.subtract(A000110_0__1)	A005493_0 - A000110_0__1		0,1,5,22,99,471,2386,12867
A033633	postder	1	~~A000040_1.mod(Z.valueOf(19))	A000040_1 % 19		2,3,5,7,11,13,17,0
A033684	postder	0	~~A010052_0.multiply(A011655_0)	A010052_0*A011655_0		0,1,0,0,1,0,0,0
