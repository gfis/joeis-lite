#!perl

# Read a *.pack file and patch all members
# @(#) $Id$
# 2023-08-25: -m ratio; *RW=80
# 2023-07-17, Georg Fischer: copied from queue.pl; Solar ok?
#
#:# Usage:
#:#   perl patch_queue.pl [-d debug] [-m mode] infile > outfile
#
# Caution: new version now in split_queue.pl!
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
my $sep;   # separator line: ($separator, $aseqno, oldoff, arrow, newoff, superclass), for example: "#!queue\tA006083\t0\t->\t1\tContinuedFractionSequence
my $block; # a separator line and the content of a jOEIS Java program
my $changed = 0; # whether the block was changed

$block = "";
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if ($line =~ m{\A$separator}) {
        &patch1($aseqno, $block, @rest);
        $block = "$line\n";
        ($sep, @rest) = split(/\t/, $line);
    } else {
        $block .= "$line\n";
    }
} # while <>
print join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
print STDERR "# $pack_count files written\n";
# end main
#----
sub patch1 {
    my ($aseqno, $block, @rest) = @_;
    my $offset = $rest[3];
    $block =~ s{\n\/\/ *DO NOT EDIT[^\n]*}{};
    $block =~ s{\n\n\n}{\n\n}mg;
    if ($debug >= 1) {
        print STDERR "# $aseqno written\n";
    }
    $pack_count ++;
    #---- start of real patches
    if (0) {
    #--------------------------------
    } elsif ($mode =~ m{ratio}) {
        $block =~ s[(\.z\.Z\;)][$1\nimport irvine\.math\.q\.Q\;];
        $block =~ s[\.z\.Integers;][\.q\.Rationals\;]g;
        $block =~ s[Integers\.][Rationals\.]g;
        $block =~ s[Z\.ONE\.shiftLeft][Z\.TWO\.pow]g;
        $block =~ s[Z\.][Q\.]g;
        $block =~ s[Q\.valueOf][new Q]g;
        $block =~ s[\)\)\)\;][\)\)\.num\(\)\)\;]g;
        #            1                                      (       )1
        $block =~ s[(MemoryFactorial\.SINGLETON\.factorial\([^\)]+\))][new Q\($1\)];
        print $block;
    #--------------------------------
    } elsif ($mode =~ m{hasoc16}) {
        $block =~ s{\n  public \$\(ASEQNO\)\(final int offset\)}
                    {\n  protected \$\(ASEQNO\)\(final int offset\)}m;
        $block =~ s{(\n *\/\*\* *Constructor with offset)}
                    {\n  \/\*\*\n   \* Constructor with offset}m;
        if ($block !~ m{(public|protected) (\$\(ASEQNO\)|A\d+)\(\)}) {
            $block =~ s{(\n *\/\*\*\n *\* *Constructor with offset)} 
                        {\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    this\($offset\)\;\n  \}\n$1}m;
        }
        print $block;
    #--------------------------------
    } elsif ($mode =~ m{hasoc17}) {
        if ($block =~ s[(public|protected) +(\$\(ASEQNO\)|A\d+)\(\) *\{]
                        [$1 $2\(\) \{\n    super\($offset\)\;]m) {
        } else {
            $block =~ s[extends (A\w+) \{\n]
                        [extends $1 \{\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    super\($offset\)\;\n  \}\n]m;
        }
        print $block;
    } elsif ($mode =~ m{hasoc18b}) {
        if (1) {
            $block =~ s[extends (A\w+) \{\n]
                        [extends $1 \{\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    super\(\$\(OFFSET\)\)\;\n  \}\n]m;
        }
        print $block;
    #--------------------------------
    } elsif ($mode =~ m{hasoc22a}) {
        # public class A000763 extends A052894 {
        if ($block =~ m{super\.}) {
            $block =~ s{super\.}{mSeq1\.}mg;
            if ($block =~ m{(\n *public *A\d+\(\) *\{\n *)}) {
                $block =~ s{class +(A\d+) +extends +(A\d+) *\{\n+}
                            {class $1 extends AbstractSequence \{\n\n  private final $2 mSeq1 = new $2()\;\n\n}mg;
                $block =~ s{(\n *public *A\d+\(\) *\{\n *)}
                            {$1super\(\$\(OFFSET\)\)\;\n    }m;
            } else {
                $block =~ s{class +(A\d+) +extends +(A\d+) *\{\n+}
                            {class $1 extends AbstractSequence \{\n\n  private final $2 mSeq1 = new $2()\;\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    super\(\$\(OFFSET\)\)\;\n  \}\n\n}mg;
            }
            $block =~ s{(\n\n\/\*\*)}
                        {\nimport irvine\.oeis\.AbstractSequence\;\n\n\/\*\*}m;
            print $block;
        }
    #--------------------------------
    } elsif ($mode =~ m{hasoc22a}) {
        # public class A000763 extends A052894 {
        if ($block =~ m{super\.}) {
            $block =~ s{super\.}{mSeq1\.}mg;
            if ($block =~ m{(\n *public *A\d+\(\) *\{\n *)}) {
                $block =~ s{class +(A\d+) +extends +(A\d+) *\{\n+}
                            {class $1 extends AbstractSequence \{\n\n  private final $2 mSeq1 = new $2()\;\n\n}mg;
                $block =~ s{(\n *public *A\d+\(\) *\{\n *)}
                            {$1super\(\$\(OFFSET\)\)\;\n    }m;
            } else {
                $block =~ s{class +(A\d+) +extends +(A\d+) *\{\n+}
                            {class $1 extends AbstractSequence \{\n\n  private final $2 mSeq1 = new $2()\;\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    super\(\$\(OFFSET\)\)\;\n  \}\n\n}mg;
            }
            $block =~ s{(\n\n\/\*\*)}
                        {\nimport irvine\.oeis\.AbstractSequence\;\n\n\/\*\*}m;
            print $block;
        }
    #--------------------------------
    } elsif ($mode =~ m{direct17}) {
        my $insert = <<"GFis";

  public static Z a(final int n) {
    return a(Z.valueOf(n));
  }

  public static Z a(final Z n) {
    return a(n.intValueExact());
  }
GFis
        $block =~ s[(extends +(\w+))]
                    [$1 implements DirectSequence]mg;
        $block =~ s[\n  \}\n *\n  \{][]m;
        $block =~ s{(\n\n\/\*\*)}
                    {\nimport irvine\.oeis\.DirectSequence\;\n\n\/\*\*}m;
        $block =~ s[\n  \}\n}\n]
                    [\n  \}\n$insert\n}\n]m;
        print $block;
    #--------------------------------
    } else {
        print STDERR "# unknown mode $mode\n";
    }
    #---- end   of real patch
    $changed = 0; # next one is not yet changed
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