#!perl

# Read a *.pack file and patch all members
# @(#) $Id$
# 2023-07-17, Georg Fischer: copied from queue.pl; Solar ok?
#
#:# Usage:
#:#   perl patch_queue.pl [-d debug] [-m mode] infile > outfile
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
my $mode = "u";
my $debug = 0;
my $separator = "#!queue";
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

my %tardirs = ();
my $srcroot = "../../../../joeis/src/irvine/oeis";
my $tarroot = "../../../src/irvine/oeis";
my $pack_count = 0;
my $aseqno = "";
my $offset = 0;
my @rest;
my $sep;

if (1) { # elsif ($mode =~ m{^u}) { # unpack
    my $change = "";
    while (<>) { # read inputfile
        s{\s+\Z}{}; # chompr
        my $line = $_;
        my ($sep, $nseqno);
        if ($line =~ m{\A$separator}) {
            &patch1($aseqno, $change, @rest);
            $change = "$line\n";
            ($sep, @rest) = split(/\t/, $line);
        } else {
            $change .= "$line\n";
        }
    } # while <>
    print join("\t", $separator, "A999999", 0, 0, 0, 0) ."\n";
    print STDERR "# $pack_count files written\n";
}
#----
sub patch1 {
    my ($aseqno, $change, @rest) = @_;
    my $offset = $rest[3];
    $change =~ s{\n\/\/ *DO NOT EDIT[^\n]*}{};
    $change =~ s{\n\n\n}{\n\n}mg;
    if ($debug >= 1) {
        print STDERR "# $aseqno written\n";
    }
    $pack_count ++;
    #---- start of real patch
    if (0) {
    } elsif ($mode =~ m{hasoc16}) {
        $change =~ s{\n  public \$\(ASEQNO\)\(final int offset\)}
                    {\n  protected \$\(ASEQNO\)\(final int offset\)}m;
        $change =~ s{(\n *\/\*\* *Constructor with offset)}
                    {\n  \/\*\*\n   \* Constructor with offset}m;
        if ($change !~ m{(public|protected) (\$\(ASEQNO\)|A\d+)\(\)}) {
            $change =~ s{(\n *\/\*\*\n *\* *Constructor with offset)} 
                        {\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    this\($offset\)\;\n  \}\n$1}m;
        }
        print $change;
    } elsif ($mode =~ m{hasoc17}) {
        if ($change =~ s[(public|protected) +(\$\(ASEQNO\)|A\d+)\(\) *\{]
                        [$1 $2\(\) \{\n    super\($offset\)\;]m) {
        } else {
            $change =~ s[extends (A\w+) \{\n]
                        [extends $1 \{\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    super\($offset\)\;\n  \}\n]m;
        }
        print $change;
    } elsif ($mode =~ m{hasoc18b}) {
        if (1) {
            $change =~ s[extends (A\w+) \{\n]
                        [extends $1 \{\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$\(ASEQNO\)\(\) \{\n    super\(\$\(OFFSET\)\)\;\n  \}\n]m;
        }
        print $change;
    } else {
        print STDERR "unknown mode $mode\n";
    }
    #---- end   of real patch
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