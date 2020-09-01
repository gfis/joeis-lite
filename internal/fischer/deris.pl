#!perl

# Extract parameters for DiffernceSequence.java, RecordSequence etc.
# @(#) $Id$
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
    charfun   CharacteristicFunction
    compseq   ComplementSequence
    diffseq   DifferenceSequence
    partsum   PartialSumSequence
    recordpos RecordPositionSequence
    recordval RecordValue
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
        my $rimpl = 0; # assume referenced seq not yet implemented
        if ($line =~ m{apparent|empirical|conject}i) {
            # ignore the unproven
        #--------------------------------
        } elsif ($callcode =~ m{\Acharfun}) {
            if ($name =~ m{(Characteristic|Indicator) function of\s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $2;
            }
            $rimpl = &is_defined_rseqno();
        #--------------------------------
        } elsif ($callcode =~ m{\Acompseq}) {
            if ($name =~ m{Complement of\s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            $rimpl = &is_defined_rseqno();
        #--------------------------------
        } elsif ($callcode =~ m{\Adiffseq}) {
            if ($name =~ m{([Ff]irst|[Ss]econd|[Tt]hird|[Ff]ourth|[Ff]ifth|[Ss]ixth|[Ss]eventh|\d+th) differences? (of|give)[^A]*(A\d{6})}) {
                $level  = lc($1);
                $rseqno = $3;
            }
            $rimpl = &is_defined_rseqno();
        #--------------------------------
        } elsif ($callcode =~ m{\Apartprod}) {
            if ($name =~ m{Partial products of \s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            $rimpl = &is_defined_rseqno();
        #--------------------------------
        } elsif ($callcode =~ m{\Apartsum}) {
            if ($name =~ m{Partial sums of \s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            $rimpl = &is_defined_rseqno();
         #--------------------------------
        } elsif ($callcode =~ m{\Arecordpos}) {
            if (0) {
            } elsif ($name =~ m{(Positions|Locations|Indices|Indexes) of records[^A]*(A\d{6})}) {
                $rseqno = $2;
            } elsif ($name =~ m{[Ww]here records[^A]*(A\d{6})}) {
                $rseqno = $1;
            } elsif ($name =~ m{Record positions? (of|in)[^A]*(A\d{6})}) {
                $rseqno = $2;
            } elsif ($name =~ m{Records (of|in) (A\d{6})\s*\(positions\)}) {
                # %C A171863 Records in A171862 (positions).
                # %N A171867 Records in A181391 (positions).
                $rseqno = $2;
            }
            $rimpl = &is_defined_rseqno();
        #--------------------------------
        } elsif ($callcode =~ m{\Arecordval}) {
            if ($name =~ m{Records? (high |)(values? |terms? |entries |highs |)(of|in)[^A]*(A\d{6})}) {
                $rseqno = $4;
                if ($name =~ m{(indices of record|where record|records? are|\(positions\))}i) {
                    $rseqno= $VOID; # skip these
                }
            }
            $rimpl = &is_defined_rseqno();
        #--------------------------------
        } # switch callcodes
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
    if ($rseqno ne $VOID) {
        if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
            ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
            if ($roffset !~ m{\A\-?\d+\Z}) {
                print "# $0: invalid offset \"$roffset\" for $rseqno\n";
            }
        } else {
           $result = 0; # failure
        }
        for (my $pind = 0; $pind < 10; $pind ++) { # parms[0] = offset, parms[9] = name
            $parms[$pind] = "";
        } # for $pind
        my ($offset, $terms);
        if (defined($ofters{$aseqno})) {
           ($offset, $terms) = split(/\t/, $ofters{$aseqno} || "0\t0");
        } else {
           $offset = 0;
        }
        $parms[0] = $offset;
        $parms[1] = "new $rseqno()";
        $parms[9] = $name;
        $parms[2] = $roffset; # offset of $rseqno
        if ($callcode eq "diffseq") {
            if ($level =~ m{[a-z]}) {
                $level = $levels{$level};
            }
            while ($level > 1) {
                $parms[1] = "new DifferenceSequence($parms[1])";
                $level --;
            } # while level
            $parms[3] = $level;
        } # diffseq
        if (0) {
        } elsif ($pseudo != 0) { # generate all with underlying PseudoSequence
            print join("\t", $aseqno, $callcode, @parms) .       "\n";
            print join("\t", $rseqno, "pseudo",  $roffset, "") . "\n";
        } elsif ($result == 1) { # rseqno implemented in jOEIS
            print join("\t", $aseqno, $callcode, @parms)        . "\n";
        } # conditional output
    } # matched feature
    return $result;
} # is_defined_rseqno
#----------------
__DATA__
