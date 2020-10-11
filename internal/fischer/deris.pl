#!perl

# Extract parameters for DifferenceSequence.java, RecordSequence etc.
# @(#) $Id$
# 2020-09-18: shuffle
# 2020-08-31: take all, also nyi; options -pseudo and -prep; RT=78
# 2020-08-27: ComplementSequence and CharacteristicFunction
# 2020-06-24: ofter_file
# 2020-06-22: moved from diffseq.pl
# 2020-06-21, Georg Fischer: copied from posins.pl
#
#:# Usage:
#:#     grep -E "..." $(COMMON)/cat25.txt \
#:#     | cut -b4 | sed -e "s/ /\t/" \
#:#     | perl deris.pl [-cc callcode] [-d debug] [-f ofter_file] [-pseudo] [-prepend] > diffseq.gen 2> diffseq.rest
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:#     -cc one of the callcodes diffseq, recordpos, recordval (default), charfun, ...
#:#     -pseudo  whether to generate records for PseudoSequence
#:#     -prepend whether to generate records for PrependSequence
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
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
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $pseudo  = 0;
my $prepend = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}i) {
        $callcode   = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } elsif ($opt   =~ m{\-prep} ) {
        $prepend    = 1;
    } elsif ($opt   =~ m{\-pseudo} ) {
        $pseudo     = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
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
        $ofters{$aseqno} = "$offset\t$terms";
    }
} # while <OFT>
close(OFT);
print STDERR "# $0: " . scalar(%ofters) . " jOEIS offsets and some terms read from $ofter_file\n";
#----------------
my %callcodes = qw(
    binomx    BinomialTransformSequence
    charfun   CharacteristicFunction
    compseq   ComplementSequence
    diffseq   DifferenceSequence
    eulerx    EulerTransform
    eulerix   EulerInvTransform
    moebiusx  MobiusTransformSequence
    moebiusix InverseMobiusTransformSequence
    partsum   PartialSumSequence
    primepos  PrimePositionSubsequence
    primeval  PrimeSubsequence
    recordpos RecordPositionSubsequence
    recordval RecordSubsequence
    stirling2 Stirling2TransformSequence
    );
my %levels = qw(first 1 second 2 third 3 ternary 3 fourth 4 4th 4 
                fifth 5 5th 5 sixth 6 6th 6 seventh 7 7th 7 8th 8 eighth 8 
                9th 9 ninth 9 10th 10 tenth 10); # for diffseq
my $VOID = "VOID";

my $line;
my $name;
my @parms; # records in joeis_names.txt
my $level; # of nesting for diffseq
my $rseqno; # aseqno of the referenced, underlying sequence
my $roffset; # offset for $rseqno

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($prepend == 0) {
        my $tletter;
        ($tletter, $aseqno, $name) = split(/\t/, $line);
        $rseqno = $VOID; # assume suppression of the generation of this record
        my $isok = 0; # assume referenced seq not yet implemented
        if ($line =~ m{apparent|empirical|conject}i) {
            # ignore the unproven
        #--------------------------------
        } elsif ($callcode =~ m{\Abinomx}) {
            if ($name =~ m{(Binomial transform of|Inverse binominal transform is)[^A]*(A\d+)\s*[\.\;\:\)]}i) {
                $rseqno = $2;
                if ($name =~ m{inverse binomial transform of}i) {
                    $rseqno = $VOID; # assume suppression of the generation of this record
                }
                if ($isok = &is_defined_rseqno()) {
                    $callcode = "binomx";
                }
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Acharfun}) {
            if ($name =~ m{\A(Characteristic|Indicator) function of}) {
                if ($name =~ m{\A(Characteristic|Indicator) function of[^A]*(A\d+)}) {
                    $rseqno = $2;
                    if ($isok = &is_defined_rseqno()) {
                    }
                } elsif (! defined($ofters{$aseqno})) {
                    print STDERR "$line\n";
                }
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Acompseq}) {
            if ($name =~ m{\AComplement of\s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            if ($isok = &is_defined_rseqno()) {
                if ($pseudo == 1 and $aseqno lt $rseqno) { 
                    $isok = 0; # enforce aseqno > rseqno
                }
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Adiffseq}) {
            if (0) {
            } elsif ($name =~ m{\A(First|Second|Third|Fourth|Fifth|Sixth|Seventh|\d+th) differences? of\s+(A\d{6})[\.\;\:]}) {
                $level  = lc($1);
                $rseqno = $2;
            } elsif ($name =~ m{\A(First|Second|Third|Fourth|Fifth|Sixth|Seventh|\d+th) differences? give\s+(A\d{6})[\.\;\:]}) {
                $level  = lc($1);
                $rseqno = $aseqno;
                $aseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
                if ($level =~ m{[a-z]}) {
                    $level = $levels{$level};
                }
                while ($level > 1) {
                    $parms[3] = "new DifferenceSequence($parms[3])";
                    $level --;
                } # while level
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Aessent}) {
            if (length($name) <= 128 
                    and ($name =~ m{Essentially |same as |identical to|apart from |duplicate of })
                    and ($name !~ m{(not |are )the same|(not |are )identical }i)
                ) {
                if ($name =~ m{(A\d{6}\d*)}) {
                    $rseqno = $1;
                }
            }
            if ($isok = &is_defined_rseqno()) {
                $callcode = "essent";
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Aeulerx}) {
            if ($name =~ m{\A(Euler transform of|Inverse Euler transform is)\s*(A\d+)\s*[\.\;\:]}i) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
                $callcode = "eulerx";
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Aeulerix}) {
            if ($name =~ m{\A(Inverse Euler transform of|Euler transform is)\s*(A\d+)\s*[\.\;\:]}i) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Amoebiusx}) {
            if ($name =~ m{\A(M.e?bius transform of|Inverse M.e?bius transform is)\s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Amoebiusix}) {
            if ($name =~ m{\A(Inverse M.e?bius transform of|M.e?bius transform is)\s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Apartprod}) {
            if ($name =~ m{\APartial products of \s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Apartsum}) {
            if ($name =~ m{\APartial sums of \s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Aprimepos}) {
            if (0) {
            } elsif ($name =~ m{\A(Positions|Locations|Indices|Indexes) of primes (of |in )(A\d{6})}) {
                $rseqno = $3;
            } elsif ($name =~ m{\APrime positions? (of|in) *(A\d{6})}) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Aprimeval}) {
            if ($name =~ m{\APrimes (of|in) *(A\d{6})}) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Arecordpos}) {
            if (0) {
            } elsif ($name =~ m{\A(Positions|Locations|Indices|Indexes) of records[ a-z]+(A\d{6})}) {
                $rseqno = $2;
            } elsif ($name =~ m{[Ww]here records[ a-z]+(A\d{6})}) {
                $rseqno = $1;
            } elsif ($name =~ m{\ARecord positions? (of|in) *(A\d{6})}) {
                $rseqno = $2;
            } elsif ($name =~ m{\ARecords (of|in) (A\d{6})\s*\(positions\)}) {
                # %C A171863 Records in A171862 (positions).
                # %N A171867 Records in A181391 (positions).
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Arecordval}) {
            if ($name =~ m{\ARecords? (high |)(values? |terms? |entries |highs |)(of |in )(A\d{6})}) {
                $rseqno = $4;
                if ($name =~ m{(indices of record|where record|records? are|\(positions\))}i) {
                    $rseqno = $VOID; # skip these
                }
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } elsif ($callcode =~ m{\Astirling2}) {
            if ($name =~ m{\A(STIRLING|Stirling)2? transform of (A\d{6})}) {
                $rseqno = $2;
            }
            if ($isok = &is_defined_rseqno()) {
            }
        #--------------------------------
        } # switch callcodes
        if (0) { # no output
        } elsif ($pseudo != 0 and $rseqno ne $VOID) { # generate all with underlying PseudoSequence
            print join("\t", $aseqno  , $callcode, @parms       ) . "\n";
            print join("\t", $parms[1], "pseudo",  $parms[2], "") . "\n";
        } elsif ($isok == 1) { # rseqno implemented in jOEIS
            print join("\t", $aseqno,   $callcode, @parms)        . "\n";
        } # conditional output
   #================
    } else {
        ($aseqno, $callcode, @parms) = split(/\t/, $line);
    }
    if (1) { # ! defined($ofters{$aseqno})) { 
    } # not in jOEIS
} # while <>
#----------------
sub is_defined_rseqno { # try to get ($rseqno, $roffset) 
    my $result = 1; # assume success
    for (my $pind = 0; $pind < 10; $pind ++) { # parms[0] = offset, parms[9] = name
        $parms[$pind] = "";
    } # for $pind
    $roffset = 0;
    my $offset = 0;
    my $terms  = "0";
    if ($rseqno ne $VOID) {
        if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
            ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
            if ($roffset !~ m{\A\-?\d+\Z}) {
                print "# $0: invalid offset \"$roffset\" for $rseqno\n";
            }
        } else {
           $result = $pseudo; 
        }
        if (defined($ofters{$aseqno})) {
           ($offset, $terms) = split(/\t/, $ofters{$aseqno} || "0\t0");
        } else {
           $offset = 0;
        }
    } else {
        $result = 0;
    } # no matched feature
    $parms[0] = $offset;
    $parms[1] = $rseqno; # underlying sequence
    $parms[2] = $roffset; # offset of $rseqno
    $parms[3] = "new $rseqno()"; # instance of underlying sequence
    $parms[5] = ""; # additional constructor parameter(s)
    $parms[9] = $name;
    return $result;
} # is_defined_rseqno
#----------------
__DATA__
