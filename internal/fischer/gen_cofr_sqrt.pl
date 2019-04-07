#!perl

# Generate linear recurrence programs
# @(#) $Id$
# 2019-04-01: "L" constants, HTML entities in names
# 2019-03-29, Georg Fischer
#
#:# Usage:
#:#   perl gen_linrec.pl [-d debug] [-n namesfile] infile > outfile
#:#       infile has the format: A-number tab signature space initerms space termno
#:#       signature is not (yet) reversed, comma separated, no spaces
#:#       at most 16 terms are output, and the last term must be shorter than 17 chars.
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $max_term = 16;
my $max_size = 16; 
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $basedir   = "../../../OEIS-mat/common";
my $namesfile = "$basedir/names"; 
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{n}) {
        $namesfile = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

# print `head -n16 $namesfile`;    
my $line;
my $aseqno;
my $rest;
my $lorder  = 0;
my $signature;
my $initerm = "";
my $termno  = 0;
my $old_package = "";
my $gen_count = 0;

while (<>) {
    $line = $_;
    $line =~ s/\s+\Z//; # chompr
    ($aseqno, $rest) = split(/\t/, $line);
    ($signature, $initerm, $termno) = split(/ /, $rest);
    my @signatures = split(/\,/, $signature);
    my @initerms   = split(/\,/, $initerm  );
    my $sign_ord =        scalar(@signatures);
    my $term_ord =        scalar(@initerms  );
    my @preterms = ();
    if ($term_ord > $sign_ord) {
        @preterms = splice(@initerms, 0, scalar(@initerms) - $sign_ord);
	    $term_ord = scalar(@initerms  );
    }
    if (    $sign_ord <= $max_term 
        and $sign_ord <= $term_ord 
        and length($initerms[$term_ord - 1]) <= $max_size
        and ($signature !~ m{[^\-\,0-9]}) 
        ) {  
        &output($aseqno
            , join(", ", reverse map { $_ . "L" } @signatures)
            , join(", ",         map { $_ . "L" } @initerms)
            , join(", ",         map { $_ . "L" } @preterms)
            , $sign_ord
            );
    } else {
        print "# different counts or too many / too long terms: $line\n";
    }
} # while <>
print "# $gen_count sequences generated\n";
#--------------------------------------------
sub output {
    my ($aseqno, $signature, $initerm, $preterm, $sign_ord) = @_;
    my $package = "a" . substr($aseqno, 1, 3);
    my $packdir = "oeis/$package";
    if ($old_package ne $package) {
        print `mkdir $packdir`;
        $old_package = $package;
    }
    my $filename = "$packdir/$aseqno.java";
    open(OUT, ">", $filename) || die "cannot write \"$filename\"\n";
    # get the name
    my $name = `grep -E \"^$aseqno\" $namesfile`;
    $name =~ s{\s+}{ }g;
    $name =~ s{\&}{\&amp;}g;
    $name =~ s{\<}{\&lt;}g;
    $name =~ s{\>}{\&gt;}g;
    $name =~ s{\'}{\&apos;}g;
    $name =~ s{\"}{\&quot;}g;
    print OUT <<"GFis";
package irvine.oeis.$package;
// Generated by gen_linrec.pl - DO NOT EDIT here!

import irvine.oeis.LinearRecurrence;

/**
 * $name
 * \@author Georg Fischer
 */
public class $aseqno extends LinearRecurrence {

  /** Construct the sequence. */
  public $aseqno() {
GFis
    if ($preterm eq "") {
        print OUT <<"GFis";
    super(new long[] {$signature}, new long[] {$initerm});
GFis
    } else {
        print OUT <<"GFis";
    super(new long[] {$signature}, new long[] {$initerm}, new long[] {$preterm});
GFis
    }
    print OUT <<"GFis";
  } // constructor()
} // $aseqno
GFis
    close(OUT);
    print "# $aseqno (order $sign_ord) written, " . length($preterm) . "\n";
    $gen_count ++;
} # output
__DATA__
package irvine.oeis.a010;

import irvine.math.z.Z;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.PrependSequence;

/**
 * A010237 Continued fraction for sqrt(199).
 * @author Sean A. Irvine
 */
public class A010237 extends PrependSequence {

  /** Construct the sequence. */
  public A010237() {
    super(new PeriodicSequence(9, 2, 1, 2, 2, 5, 4, 1, 1, 13, 1, 1, 4, 5, 2, 2, 1, 2, 9, 28), Z.valueOf(14));
  }
}
