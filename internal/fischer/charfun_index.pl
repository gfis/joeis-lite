#!perl

# Generate lists of characteristic function sequences
# @(#) $Id$
# 2020-08-27 Georg Fischer: copied from deris.pl
# 
# DATA from <https://oeis.org/wiki/Index_to_OEIS:_Section_Ch#char_fns>
#
#:# Usage:
#:#     perl charfun_index.pl [-d debug] [-f ofter_file] > charfun.gen 2> charfun.nyi.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:#     -cc one of the callcodes diffseq, recordpos, recordval (default)
#:#     -p  character set for allowed internal format record code(s): NCF (default), N, CN, CFN, FN
#:# Reads deriv0.txt for implemented jOEIS sequences with their offsets.
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
my $pletter = "NCF"; # default, or "NCF"
my $callcode = "recordval";
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{f}  ) {
        $ofter_file = shift(@ARGV);
    } elsif ($opt   =~ m{p}  ) {
        $pletter    = shift(@ARGV);
        $pletter    = uc($pletter); # some subset of {"C", "F", "N"}
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $line;
my ($tletter, $aseqno, $offset, $terms, $name, @rest); # records in joeis_names.txt
my ($char, $fun, $par, $nseqno);
my $level;
$offset = 1;
my $rseqno; # aseqno of the referenced, underlying sequence
my $roffset; # offset for $rseqno
my $parm1; # instance of subclass
my $parm2; # roffset
my $parm3; # level etc.
my $parm4; # additional statements in constructor
#----------------
my %ofters = ();
open (OFT, "<", $ofter_file) || die "cannot read $ofter_file\n";
while (<OFT>) {
    s{\s+\Z}{};
    ($aseqno, $offset, $terms) = split(/\t/);
    $terms = $terms || "";
    if ($offset < -1) { # offsets -2, -3: strange, skip these
    } else {
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------
my %callcodes = qw(
    charfun   CharacteristicFunction
    compseq   ComplementSequence
    diffseq   DifferenceSequence
    partsum   PartialSumSequence
    recordpos RecordPositionSequence
    recordval RecordSequence
    );
my %levels = qw(first 1 second 2 third 3 ternary 3 fourth 4 4th 4 fifth 5 5th 5 sixth 6 6th 6 seventh 7 7th 7 8th 8);
my $VOID = "VOID";
my $NYI  = "NYI";

while (<DATA>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    #characteristic functions (002): A000007 A000004 A000027 all 0
    ($char, $fun, $par, $aseqno, $rseqno, $nseqno, $name, @rest) = split(/\s+/, $line);
    print "# line \"$aseqno\", \"$rseqno\", \"$nseqno\", \"$name\"\n"if $debug >= 1;
    if (! defined($ofters{$aseqno})) { # not yet in jOEIS
        $parm1  = "";
        $parm2  = "";
        $parm3  = "";
        $parm4  = "";
        $name   = $name || "";
        if (0) {
        } elsif ($rseqno =~ m{\AA\d+\Z}) {
            &defined_rseqno();
            print "# test1 \"$aseqno\", \"$rseqno\", \"$nseqno\", \"$name\"\n" if $debug >= 1; 
        } elsif ($nseqno =~ m{\AA\d+\Z}) {
            $rseqno = $nseqno;
            &defined_rseqno();
            print "# test2 \"$aseqno\", \"$rseqno\", \"$nseqno\", \"$name\"\n" if $debug >= 1; 
            $parm1 = "new $rseqno(), false";
        } else {
            $rseqno = $VOID;
        }

        if (($rseqno ne $VOID) and ($rseqno ne $NYI)) { # matched feature
            $parm2 = $roffset; # offset of $rseqno
            print        join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, "", "", "", "", $name) . "\n";
            #                                                    rseqno  roffset level   constr
        } elsif ($rseqno eq $NYI) {
            print STDERR join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, "", "", "", "", $name) . "\n";
        } # matched feature
    } # not in jOEIS
} # while DATA
#----------------
sub defined_rseqno { # try to get $roffset and $terms
    my $result = 1; # assume success
    if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
        ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
        if ($roffset !~ m{\A\-?\d+\Z}) {
            print "# $0: invalid offset \"$roffset\" for $rseqno\n";
        }
        $parm1 = "new $rseqno()";
        $parm2 = $roffset;
    } else {
       $rseqno = $NYI;
       $result = 0; # failure
    }
    return $result;
} # defined_rseqno
__DATA__
characteristic functions (002): A000007 A000004 A000027 all 0
characteristic functions (003): A000012 A001477 [empty] natural numbers
characteristic functions (004): A000035 A005408 A005843 odd numbers
characteristic functions (005): A003849 A003622 A022342
characteristic functions (006): A004641 A086377 A081477
characteristic functions (007): A005171 A018252 A000040 nonprimes
characteristic functions (008): A005369 A002378 A078358 pronic numbers
characteristic functions (009): A005614 A022342 A003622
characteristic functions (010): A008966 A005117 A013929 squarefree
characteristic functions (011): A010051 A000040 A018252 primes
characteristic functions (012): A010052 A000290 A000037 squares
characteristic functions (013): A010054 A000217 A014132 triangular numbers
characteristic functions (014): A010055 A000961 A024619 prime powers
characteristic functions (015): A010056 A000045 A001690 Fibonacci numbers
characteristic functions (016): A010057 A000578 A007412 cubes
characteristic functions (017): A010058 A000108 A092459 Catalan numbers
characteristic functions (018): A010059 A001969 A000069 evil numbers
characteristic functions (019): A010060 A000069 A001969 odious numbers
characteristic functions (020): A011655 A001651 A008585 not mult 3
characteristic functions (021): A012245 A000142 A063992 factorials
characteristic functions (022): A014306 A145397 A000292 m(m+1)(m+2)6
characteristic functions (023): A014578 A007417 A145204
characteristic functions (024): A020987 A022155 NA
characteristic functions (025): A023531 A000096 A007401 m(m+3)2
characteristic functions (026): A023533 A000292 A145397 m(m+1)(m+2)6
characteristic functions (027): A033683 A104777 NA odd squares mod 3 > 0
characteristic functions (028): A033684 A135556 NA squares mod 3 > 0
characteristic functions (029): A035263 A003159 A036554
characteristic functions (030): A036987 A000225 NA
characteristic functions (031): A038189 A091067 A091072
characteristic functions (033): A057427 A000027 A000004 positive numbers
characteristic functions (034): A059448 A059009 A059010
characteristic functions (035): A059841 A005843 A005408 even numbers
characteristic functions (036): A063524 A000012 A087156 all 1
characteristic functions (037): A064911 A001358 A100959 semiprimes
characteristic functions (038): A065043 A028260 A026424 even number of prime factors
characteristic functions (039): A065202 A065201 A065200
characteristic functions (040): A065333 A003586 A059485 3-smooth
characteristic functions (041): A066247 A002808 A008578 composite numbers
characteristic functions (042): A066829 A026424 A028260 odd number of prime factors
characteristic functions (043): A072401 A004215 NA of the form 4^m*(8k+7)
characteristic functions (044): A075802 A001597 A007916 perfect powers
characteristic functions (045): A075897 A048645 NA
characteristic functions (046): A079260 A002144 A137409 primes of form 4n+1
characteristic functions (047): A079261 A002145 A145395 primes of form 4n+3
characteristic functions (048): A079978 A008585 A001651 mult 3
characteristic functions (049): A079979 A008588 A047253 mult 6
characteristic functions (050): A079998 A008587 A047201 mult 5
characteristic functions (051): A080110 A080112 A080113
characteristic functions (052): A080111 A080113 A080112
characteristic functions (053): A080116 A014486 NA
characteristic functions (054): A080339 A008578 A002808 {1} union {primes}
characteristic functions (055): A080545 A006005 A065090 {1} union {odd primes}
characteristic functions (056): A080995 A001318 A118300 gen. pentagonal numbers
characteristic functions (057): A082784 A008589 A047304 mult 7
characteristic functions (058): A083187 A002379 NA [ 3^n 2^n ]
characteristic functions (059): A083923 A057548 NA
characteristic functions (060): A083924 A072795 NA
characteristic functions (061): A085357 A003714 A004780 Fibbinary numbers
characteristic functions (062): A086299 A002473 A068191 7-smooth
characteristic functions (063): A088517 A001463 NA
characteristic functions (064): A089011 A005763 NA Weyl
characteristic functions (065): A091225 A014580 NA
characteristic functions (066): A091247 A091242 NA
characteristic functions (067): A092248 A030230 A030231 even number of distinct prime factors
characteristic functions (068): A093709 A028982 A028983 squares or twice squares
characteristic functions (069): A093719 A047273 A047235 (mod 2)^(mod 3)
characteristic functions (070): A095076 A020899 A095096
characteristic functions (071): A095111 A095096 A020899
characteristic functions (072): A098108 A016754 NA
characteristic functions (073): A099104 A066680 NA badly sieved numbers
characteristic functions (074): A099395 A007283 NA
characteristic functions (075): A101040 NA NA not more than 2 prime factors
characteristic functions (076): A101605 A014612 NA exactly 3 prime factors
characteristic functions (077): A101637 A014613 NA exactly 4 prime factors
characteristic functions (078): A102460 A000032 NA Lucas numbers
characteristic functions (079): A103673 A103676 A103677 (factorial)
characteristic functions (080): A103674 A103678 A103679 (factorial)
characteristic functions (081): A103675 A103680 A103681 (factorial)
characteristic functions (082): A105349 A000129 NA Pell numbers
characteristic functions (083): A107078 A013929 A005117 non unitary divisors
characteristic functions (084): A112526 A001694 A052485 powerful numbers
characteristic functions (085): A114986 A000201 A001950
characteristic functions (086): A118952 A118957 A118956
characteristic functions (087): A121262 A008586 A042968 mult 4
characteristic functions (088): A122255 A122254 A048136
characteristic functions (089): A122257 A005109 A122259 Pierpont primes
characteristic functions (090): A122261 A122260 NA mult. closure of Pierpont primes
characteristic functions (091): A122895 A123240 NA tau=Fibonacci
characteristic functions (092): A123927 A119885 NA tau=Lucas
characteristic functions (093): A130638 A005237 NA tau(n+1)=tau(n)
characteristic functions (094): A132138 A002977 A132142
characteristic functions (095): A133010 NA NA Riemann zeta
characteristic functions (096): A133011 NA NA Riemann zeta, complement
characteristic functions (097): A133100 A085787 NA gen. heptagonal numbers
characteristic functions (098): A133101 A057569 NA
characteristic functions (099): A133872 A042948 A042964 congruent 0 or 1 mod 4
characteristic functions (100): A136522 A002113 A029742 palindrome
characteristic functions (101): A137794 A073491 A073492 no prime gaps in fact
characteristic functions (102): A139689 NA NA Chen
characteristic functions (103): A141260 A141259 NA
characteristic functions (104): A143731 A024619 A000961 more than 1 prime factor
characteristic functions (105): A145649 A000959 A050505 lucky numbers
characteristic functions (106): A156660 A005384 A138887 Sophie Germain primes
characteristic functions (107): A156659 A005385 A156657 safe primes
characteristic functions (108): A079559 A005187 A055938 range of A005187
characteristic functions (109): A151774 A018900 A161989 numbers with binary weight 2
characteristic functions (110): A167392 A000041 A167376 partition numbers
characteristic functions (111): A167393 A000009 A167377 range of A000009
characteristic functions (112): A168046 A052382 A011540 zerofree numbers
characteristic functions (113): A166486 A042968 A008586 not a multiple of 4
characteristic functions (114): A011558 A047201 A008587 coprime to 5
characteristic functions (115): A097325 A047253 A008588 not a multiple of 6
characteristic functions (116): A109720 A047304 A008589 coprime to 7
characteristic functions (117): A168181 A047592 A008590 not a multiple of 8
characteristic functions (118): A168182 A168183 A008591 not a multiple of 9
characteristic functions (119): A168184 A067251 A008592 not a multiple of 10
characteristic functions (120): A145568 A160542 A008593 coprime to 11
characteristic functions (121): A168185 A168186 A008594 not a multiple of 12
characteristic functions (122): A054521 A169581 A169581