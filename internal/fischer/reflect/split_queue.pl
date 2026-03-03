#!perl

# Read a *.pack file and patch all members
# @(#) $Id$
# 2026-03-03: .m noxtend|manual
# 2026-02-16, Georg Fischer: copied from patch_queue.pl; *WP=80
#
#:# Usage:
#:#   perl split_queue.pl [-d debug] [-m mode] infile > outfile
#:m        -m abstract  AbstractSequence, (this|super)\(\d[\)\,]\)
#:#        -m manual    copy the block unchanged if the header contains the word "man"
#:#        -m noxtend   convert "extends Seq" to AbstractSequence and member declaration for Seq
#:#        -m sequencei Sequence0/1
#:m        -m basuper   (ContinuedFraction|Filter|...)Sequence - superclass is an jOEIS base class
#:m        -m sesuper   superclass is another sequence
#
# separate changed blocks -> STDOUT and unchanged blocks -> STDERR
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $mode  = "u";
my $debug = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $pack_count = 0;
my $aseqno = "";
my $offset = 0;
my @rest;
my $separator = "#!queue";
my $sep; # separator line: ($separator, $aseqno, oldoff, arrow, newoff, superclass, man),
         # for example: "#!queue\tA006083\t0\t->\t1\tContinuedFractionSequence man
my $block; # a separator line and the content of a jOEIS Java program
my $chan_count = 0;
my $unch_count = 0;

$block = "";
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if ($line =~ m{\A$separator}) {
        &patch1();
        $block = "$line\n";
        ($sep, @rest) = split(/\t/, $line);
    } else {
        $block .= "$line\n";
    }
} # while <>
print        join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
print STDERR join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
print        "# $chan_count files patched -> ../../src\n";
print STDERR "# $unch_count files unchanged\n";
# end main
#----
sub patch1 {
    my ($bseqno, $oldoff, $arrow, $newoff, $superclass) = @rest;  
    $aseqno = $bseqno;
    $block =~ s{\n\/\/ *DO NOT EDIT[^\n]*}{};
    $block =~ s{\n\n\n}{\n\n}mg;
    if ($debug >= 1) {
        print STDERR "# $aseqno written\n";
    }
    #--------------------------------
    if ($mode =~ m{abstract}i) {
        if(0) {
        } elsif ($superclass =~ m{(Abstract)Sequence}) {
            $chan_count ++;
            #           1          1         2      2
            $block =~ s{(this|super)\($oldoff([\)\,])}
                                 {$1\($newoff$2}m;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }
    }
    #--------------------------------
    if ($mode =~ m{manual}i) {
        if (scalar(grep { $_ =~ m{\Aman} } @rest) > 0) {
            $chan_count ++;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }
    }
    #--------------------------------
    if ($mode =~ m{noxtend}i) {
        if(0) {
        } elsif ($superclass =~ m{\AA\d{6}\Z}) {
            $chan_count ++;
            my $ano = lc(substr($aseqno, 0, 4));
            $block =~ s[extends +$superclass][extends AbstractSequence]m;
            if (0) {
        #   } elsif ($block =~ s{import irvine\.oeis\.$ano\.$aseqno\;\n}
        #                       {import irvine\.oeis\.AbstractSequence\;\nimport irvine\.oeis\.$ano\.$aseqno\;\n}m
        #       ) {
            } elsif ($block =~ s{import irvine\.math\.z\.Z\;\n}
                                {import irvine\.math\.z\.Z\;\nimport irvine\.oeis\.AbstractSequence\;\n}m
                ) {
            }
            my $mseq = <<"GFis";

  private final $superclass mSeq = new $superclass();
GFis
            my $constructor = <<"GFis";

  /* Construct the sequence. */
  public $aseqno() {
    super($newoff);
  }
GFis
            if ($block =~           m{\n *\/\*\* Construct the sequence}) {
                $block =~           s{\n *\/\*\* Construct the sequence}
                                {$mseq\n  \/\*\* Construct the sequence}m;
            } else {
                $block =~           s[\n *\@Override\n *public Z next]
                    [$mseq$constructor\n  \@Override\n  public Z next]m;
            }
            $block =~ s[super\.next\(\)]
                        [mSeq\.next\(\)]mg;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }
    }
    #--------------------------------
    if ($mode =~ m{sequencei}i) {
        if(0) {
        } elsif ($superclass eq "Sequence$oldoff" && $newoff <= 3) {
            $chan_count ++;
            $block =~ s[Sequence$oldoff][Sequence$newoff]mg;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }
    }
    #--------------------------------
    if ($mode =~ m{setoffset}i) {
        if(0) {
        } elsif ($block =~ m{setOffset\($oldoff\)}m) {
            $chan_count ++;
            $block =~ s[setOffset\($oldoff\)][setOffset\($newoff\)]mg;
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }
    }
    #--------------------------------
    if ($mode =~ m{basuper}i) { # superclass is a OEIS base class
        if(0) {
        } elsif (0
                || ($superclass =~ m{(Antidiagonal|Brief|Cached|ContinuedFraction(OfSqrt)?|DecimalExpansion|Difference|EulerTransform)Sequence})
                || ($superclass =~ m{(Filter|FilterNumber|FilterPosition|Finite|Gf|DenominatorGf|GeneratingFunction|Inverse|Lambda)Sequence})
                || ($superclass =~ m{(Padding|Partial(Sum|Product)|Periodic|Prepend|RecordPosition|RowSum|(Single|Simple)Transform)Sequence})
                || ($superclass =~ m{BaseTriangle|Combiner|EulerTransform|(Linear|Holonomic)Recurrence|Lambda(Array|Table|Triangle)})
                || ($superclass =~ m{PrependColumn|(Vector)?Product})
                ) {
            $chan_count ++;
            if ($block =~ m{super\($oldoff\,}m) {
                $block =~ s{super\($oldoff\,}
                           {super\($newoff\,}m;
            } else {
                $block =~ s[super\(][super($newoff\, ]m;
            }
            print        $block;
        } else {
            $unch_count ++;
            print STDERR $block;
        }
    }
    #--------------------------------
    if ($mode =~ m{sesuper}i) { # superclass is another sequence
        if(0) {
        } elsif ($superclass =~ m{\AA\d{6}}) {
            if ($block =~ m{super\($oldoff\,}m) {
                $block =~ s{super\($oldoff\,}
                           {super\($newoff\,}m;
                $chan_count ++;
                print        $block;
            } else {
                $unch_count ++;
                print STDERR $block;
            }
        }
    }
    #--------------------------------
} # patch1
__DATA__
# Starting report at 2022-08-16 15:32:35
A002162 1 -> 0  DecimalExpansionSequence
A002285 1 -> 0  DecimalExpansionSequence
A002389 1 -> 0  DecimalExpansionSequence
A002390 1 -> 0  DecimalExpansionSequence
A002580 0 -> 1  DecimalExpansionSequence
A002794 1 -> 0  A030125
A002795 1 -> 0  A002794
A003077 1 -> 0  DecimalExpansionSequence
A003676 1 -> -33    DecimalExpansionSequence

#!queue A019067 2   ->  3   A018940 --------------------------------
package irvine.oeis.a019;

import java.io.BufferedReader;
...