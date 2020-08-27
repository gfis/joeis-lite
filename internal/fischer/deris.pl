#!perl

# Extract parameters for DiffernceSequence.java, RecordSequence etc.
# @(#) $Id$
# 2020-06-24: ofter_file
# 2020-06-22: moved from diffseq.pl
# 2020-06-21, Georg Fischer: copied from posins.pl
#
#:# Usage:
#:#     grep -E "..." $(COMMON)/cat25.txt \
#:#     | cut -b4 | sed -e "s/ /\t/" \
#:#     | perl deris.pl [-cc callcode] [-d debug] [-f ofter_file] [-p tpattern] > diffseq.gen 2> diffseq.rest
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:#     -cc one of the callcodes diffseq, recordpos, recordval (default)
#:#     -p  character set for allowed internal format record code(s): N (default), CN, CFN, FN
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
my $pletter = "N"; # default, or "NCF"
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
my $level;
$offset = 1;
my ($rseqno, $roffset);
my $parm1  = "";
my $parm2  = "";
my $parm3  = "";
my $parm4  = "";
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
    compseq   ComplementSequence
    diffseq   DifferenceSequence
    recordpos RecordPositionSequence
    recordval RecordSequence
    );
my %levels = qw(first 1 second 2 third 3 ternary 3 fourth 4 4th 4 fifth 5 5th 5 sixth 6 6th 6 seventh 7 7th 7 8th 8);
my $VOID = "VOID";
while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($tletter, $aseqno, $name) = split(/\t/, $line);
    if (($tletter =~ m{[$pletter]}o) and ! defined($ofters{$aseqno})) { # not yet in jOEIS
        $rseqno = $VOID;
        $parm1  = "";
        $parm2  = "";
        $parm3  = "";
        $parm4  = "";
        if ($line =~ m{apparent|empirical|conject}i) {
            # ignore the unproved
        } elsif ($callcode =~ m{\Acompseq}) {
            if (0) {
            } elsif ($name =~ m{Complement of\s*(A\d+)\s*[\.\;\:]}) {
                $rseqno = $1;
            }
            if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
                $parm1 = "new $rseqno()";
                ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
                if ($roffset !~ m{\A\-?\d+\Z}) {
                    print "# $0: invalid offset \"$roffset\" for $rseqno\n";
                }
            } else {
                $rseqno = $VOID;
            }
            # compseq

        } elsif ($callcode =~ m{\Adiffseq}) {
            if (0) {
            } elsif( $name =~ m{([Ff]irst|[Ss]econd|[Tt]hird|[Ff]ourth|[Ff]ifth|[Ss]ixth|[Ss]eventh|\d+th) differences? (of|give)[^A]*(A\d{6})}) {
                $level  = lc($1);
                $rseqno = $3;
            }
            if (defined($ofters{$rseqno})) {
                if ($level =~ m{[a-z]}) {
                    $level = $levels{$level};
                }
                $parm1 = "new $rseqno()";
                while ($level > 1) {
                    $parm1 = "new DifferenceSequence($parm1)";
                    $level --;
                } # while level
                $parm3 = $level;
                ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
            } else {
                $rseqno = $VOID;
            }
            # diffseq

        } elsif ($callcode =~ m{\Arecordpos}) {
            if (0) {
            } elsif ($name =~ m{(Positions|Locations|Indices|Indexes) of records[^A]*(A\d{6})i}) {
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
            if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
                $parm1 = "new $rseqno()";
                ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
                if (0 and $roffset < $offset) {
                    $parm4 = "~~    ";
                    for (my $ind = $roffset; $ind < $offset; $ind ++) {
                        $parm4 .= "~~next();";
                    } # for ind
                } # roffset <
            } else {
                $rseqno = $VOID;
            }
            # recordpos
        } elsif ($callcode =~ m{\Arecordval}) {
            if (0) {
            } elsif ($name =~ m{Records? (high |)(values? |terms? |entries |highs |)(of|in)[^A]*(A\d{6})}) {
                $rseqno = $4;
                if ($name =~ m{(indices of record|where record|records? are|\(positions\))}i) {
                    $rseqno= $VOID; # skip these
                }
            }
            if (defined($ofters{$rseqno})) { # found and implemented in jOEIS {
                $parm1 = "new $rseqno()";
                ($roffset, $terms) = split(/\t/, $ofters{$rseqno});
                if ($roffset !~ m{\A\-?\d+\Z}) {
                    print "# $0: invalid offset \"$roffset\" for $rseqno\n";
                }
            } else {
               $rseqno = $VOID;
            }
            # recordval
        } # switch callcodes

        if ($rseqno ne $VOID) { # matched feature
            $parm2 = $roffset; # offset of $rseqno
            print        join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, $name) . "\n";
            #                                                    rseqno  roffset level   constr
        } else {
            print STDERR join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, $name) . "\n";
        } # matched feature
    } # not in jOEIS
} # while <>
#----------------
__DATA__
