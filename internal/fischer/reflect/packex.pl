#!perl

# Read a *.pack file and extract *.gen records in seq4 format
# @(#) $Id$
# 2023-10-31, Georg Fischer: copied from patch_queue.pl
#
#:# Usage:
#:#   perl packex.pl [-d debug] infile.pack > outfile.gen
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
my $cc = "multin";
my $debug = 0;
my $separator = "#!queue";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{cc}) {
        $cc        = shift(@ARGV);
    } elsif ($opt  =~ m{m}) {
        $mode      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my $aseqno;
my $offset;
my $callcode;
my ($nparms, $oparms) = ("", ""); 
while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    my ($sep, $nseqno);
    if (0) {
    #                                  1    1  2   2
    } elsif ($line =~ m{\A$separator\s*(A\d+)\s+(\d+)}) {
        ($aseqno, $offset) =  ($1, $2);
    #                                                  1   1  2   2
    } elsif ($line =~ m{\A\/\/ *Generated by \w+\.pl\s+(\w+)\/(\w+)}) {
        $callcode = $2;
    #                               1      1  2      2
    } elsif ($line =~ m{\A\s*super\((\-?\d+)\,([^\;]+)\)\;.*}) {
        # super(0, (p, e) -> is2(p) ? Z.ONE : (is3(p) ? p.pow(e + 1).subtract(2) : sigmaP(p, e)));
        ($offset, $nparms) = ($1, $2);
        if ($debug >= 1) {
            print "# $aseqno: oparms=\"$oparms\", nparms=\"$nparms\"\n";
        }
        # $oparms is the last level that kept the commas
        print join("\t", $aseqno, $callcode, $offset, $nparms, "PARM2", "PARM3", "PARM4", "PARM5") ."\n";
    }
} # while <>
__DATA__
#!queue A125510 1   FATAL   Difference  between next()  and a(1):   6   !=  1
package irvine.oeis.a125;
// Generated by gen_seq4.pl mult/multb at 2022-08-01 11:56

import irvine.math.z.Z;
import irvine.oeis.MultiplicativeSequence;

/**
 * A125510 Theta series of 4-dimensional lattice QQF.4.g.
 * @author Georg Fischer
 */
public class A125510 extends MultiplicativeSequence {

  /** Construct the sequence. */
  public A125510() {
    super(0, (p, e) -> is2(p) ? Z.ONE : (is3(p) ? p.pow(e + 1).subtract(2) : sigmaP(p, e)));
  }
...