#!perl

# Read a *.pack file and extract *.gen records in seq4 format with CC=rpt
# @(#) $Id$
# 2025-10-03: renamed from reflect/oackex_genet.pl; *D-United=35
# 2025-10-01, Georg Fischer: copied from packex.pl
#
#:# Usage:
#:#   perl packex_genet.pl [-d debug] infile.pack > outfile.gen
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
my %zhash = qw(ZERO 0 ONE 1 TWO 2 THREE 3 FOUR 4 FIVE 5 SIX 6 SEVEN 7 EIGHT 8 NINE 9 TEN 10 NEG_ONE -1);
my $mode = "u";
my $cc = "rpt";
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

my $aseqno;
my $offset;
my $kmin;
my $rest;
my $build = ".";
my $letter; # f, g, h
my $method;
my %seqs = ();
my $comment;

while (<>) { # read inputfile
    s{\s+\Z}{}; # chompr
    my $line = $_;
    if (0) {
    #                                  1    1
    } elsif ($line =~ m{\A$separator\s*(A\d+)}) {
        ($aseqno) =  ($1);
    # * G.f.: <code>Product_{k&gt;=1} (1/(1-x^A028260(k)))</code>
    #        
    } elsif ($line =~ m{\A *\* *G\.f\.\: *\<code\>([^\<]*)\<}) {
        ($comment) =  ($1);
    #                               1   1     2   23      3
    } elsif ($line =~ m{\A\s*super\((\d+)\,\s*(\d+)([^\;]+)*\;}) {
        ($offset, $kmin, $rest) = ($1, $2, $3 || "");
        if ($kmin < 1) {
            $build .= ".kMin($kmin)"; # kMin = 0
        } elsif ($kmin > 1) {
            $comment .= " /*.kMin($kmin)*/"; # must be done by g()
        }
        if ($rest ne ")") {
            $build .= " /* rest=$rest */ ";
        }
    #                            1     1         2    2
    } elsif ($line =~ m{\A\s*mSeq([FGH]) *\= new (A\d+)\(}) {
        my ($Letter, $rseqno) = ($1, $2);
        $seqs{$Letter} = $rseqno;
    #                          1     1
    } elsif ($line =~ m{advance([FGH])}) {
        $letter = lc($1);
    #                          1      1
    } elsif ($line =~ m{return ([^\;]+)\;}) {
        my $expr = $1;
        my $method = ".$letter";
        if (0) {
        } elsif (($letter eq "g") and ($expr =~ m{\A\s*Z\.ONE\s*\Z})) {
            # ignore
        #                                   1      1
        } elsif ($expr =~ s{new Z\[\] *\{ *([^\}]+)\}}{new Q($1)}) { # for "f" only
            if ($expr !~ m{\,}) {
                $expr =~ s{new Q\(}{};
                $expr =~ s{\)\Z}{};
                $method = ".f";
            } else {
                $method = ".fq";
            }
            if ($expr !~ m{\A\s*Z\.ONE\s*\Z}) {
                $build .= "$method(k -> $expr)";
            }
        } else {
            $build .= "$method(k -> $expr)";

        }
    } elsif ($line =~ m{\A\}}) { # end of Java class
        $build =~ s{\A\.+}{}; # leading dot was for rapt.jpat
        $build =~ s{\(long\)}{}g;
        $build =~ s{mKfg|mKh}{k}g;
        $build =~ s{k *\-\> *mSeq([FGH])\.next\(\)\.negate\(\)}{k -> Z.NEG_ONE\, new $seqs{$1}\(\)}g; # polish mSeqX.next().negate()
        $build =~ s{k *\-\> *mSeq([FGH])\.next\(\)}                             {new $seqs{$1}\(\)}g; # polish mSeqX.next()
        $build =~ s{(irvine\.math\.z\.)?Binomial\.binomial}{BI}g;
        # (k < 2) ?
        #               1       1
        $build =~ s{\(\((k[^\)]+)\) *\?}{\($1 \?}g;
        #                     1   1      2   2
        $build =~ s{new Q\(Z\.(\w+)\, *Z\.(\w+)\)}{new Q\($zhash{$1}\, $zhash{$2}\)}g;
        #            (                    (1      1 ) )  l (          )
        $build =~ s{\(k *\-\> *Z\.valueOf\((\-?\d+)\)\)}{l\(k \-\> ${1}L\)}g;
        #            (            (1  1 )  l (          )
        $build =~ s{\(k *\-\> *Z\.(\w+)\)}{l\(k \-\> $zhash{$1}L\)}g;
        #            (            (1  1             )  l (                     )
        $build =~ s{\(k *\-\> *Z\.(\w+)\.negate\(\)\)}{l\(k \-\> \-$zhash{$1}L\)}g;
        # k -> Z.NEG_ONE, new A000000()
        #                         1   1
        $build =~ s{\(k *\-\> *Z\.NEG_ONE\, *new}{\(\(k\, t\) \-\> t\.negate\(\)\, new}g;
        # k -> Z.THREE, new A000000()
        #                         1   1
        $build =~ s{\(k *\-\> *Z\.(\w+)\, *new}{\(\(k\, t\) \-\> t\.\*\($zhash{$1}\)\, new}g;
        # (new A038548().subtract(1).negate()))
        #                 1    1    2        3          3 2
        $build =~ s{\(new (A\d+)\(\)([^\)]+\)(\.[^\)]+\))?)}{\(\(k\, t\) \-\> t$2\, new $1\(\)}g;
        # fl(k -> -1L)
        #           l (        1      1  )
        $build =~ s{l\(k *\-\> (\-?\d+)L\)}{\($1\)}g;
        # g(k -> Z.valueOf(3L * k - 1).negate())
        #            (                   (1      1 )
        $build =~ s{\(k *\-\> Z\.valueOf\(([^\)]+)\)\.negate\(\)}{l\(k \-\> \-\($1\)}g;
        # g(k -> Z.valueOf(3L * k - 1)).h(k -> Z.valueOf(3 * k - 1))	Product_{k&gt;=1} (1/(1-(3*k-1)*x^(3*k-1)))
        #            (                   (1      1 )
        $build =~ s{\(k *\-\> Z\.valueOf\(([^\)]+)\)}{l\(k \-\> $1}g;

        print join("\t", $aseqno, $cc, $offset, $build, $comment) ."\n";
        $build = ".";
        %seqs = (); 
        $comment = "";
    }
    if ($debug >= 1) {
        print "# $aseqno, method=$method, build=$build\n";
    }
} # while <>
__DATA__
A303124 rpt     0       f(k -> new Z[]{Z.NEG_ONE, Z.FOUR}).g(k -> Z.valueOf(16).pow(k).negate())
A303125 rpt     0       f(k -> new Z[]{Z.NEG_ONE, Z.FIVE}).g(k -> Z.valueOf(25).pow(k).negate())
A303130 rpt     0       f(k -> new Z[]{Z.ONE, Z.THREE}).g(k -> Z.NINE.pow(k).negate())
A303131 rpt     0       f(k -> new Z[]{Z.ONE, Z.FOUR}).g(k -> Z.valueOf(16).pow(k).negate())
A303132 rpt     0       f(k -> new Z[]{Z.ONE, Z.FIVE}).g(k -> Z.valueOf(25).pow(k).negate())
A303135 rpt     0       f(k -> new Z[]{Z.ONE, Z.FOUR}).g(k -> Z.valueOf(16).pow(k))
A
#!queue A046675 GeneralizedEulerTransform   Expansion   of  Product_{i>0}   (1-x^{p_i}),    where   p_i are the primes. sign    0..10000    genetfh _N. J.  A.  Sloane_
package irvine.oeis.a046;
// Generated by gen_seq4.pl genetfh at 2020-12-16 11:03
// DO NOT EDIT here!

import irvine.math.z.Z;
import irvine.oeis.a000.A000040;
import irvine.oeis.transform.GeneralizedEulerTransform;


/**
 * A046675 Expansion of Product_{i&gt;0} (1-x^{p_i}), where p_i are the primes.
 * G.f.: <code>Product_{k&gt;=1} ((1-x^A000040(k)))</code>
 * @author Georg Fischer
 */
public class A046675 extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public A046675() {
    super(0, 1);
    mSeqH = new A000040();
    mNextH = advanceH(mKh);
  }

  @Override
  protected Z[] advanceF(final long k) {
    return new Z[]{Z.NEG_ONE};
  }

  @Override
  protected Z advanceH(final long k) {
    return mSeqH.next();
  }

}
