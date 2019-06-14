#!perl

# Read rows from db table 'seq4' and generate corresponding Java sources for jOEIS
# @(#) $Id$
# 2019-06-13, Georg Fischer: derived from gen_pattern.pl
#
#:# Usage:
#:#   perl gen_seq4.pl [-d debug] [-a author] [-l maxlen]
#;#          [-p patprefix] [-t targetdir] infile > logfile
#:#       infile has the format: ASEQNO CALLCODE OFFSET PARM1 PARM2 PARM3 PARM4 NAME
#:#       pattern may contain all of these and $(AUTHOR), $(DATE), $(PACK)
#--------------------------------------------------------
use strict;
use integer;
use warnings;
use English; # PREMATCH

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $max_term = 16;
my $max_size = 16; 
my $max_line_len = 80;
my $indent = 6;
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $author    = "Georg Fischer";
my $patprefix = "./";
my $patext    = ".jpat";
my $callcode  = "cfsnum";
my %patterncache  = (); # empty at the beginning
my $basedir   = "../../../OEIS-mat/common";
my $targetdir = "../../src/irvine/oeis";
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{a}) {
        $author    = shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{l}) {
        $max_line_len = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $patprefix = shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $targetdir = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my $pattern;
my $offset = "0";
my $aseqno;
my @parms;
my $old_package = "";
my $gen_count = 0;

mkdir $targetdir;

while (<>) { # read inputfile
    s{\#.*}{}; # remove comments
    next if m{\A\s*\Z}; # skip empty lines
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($debug >= 1) {
        print "$line\n";
    }
    @parms    = split(/\t/, $line); # this is a row from db table 'seq4'
    $aseqno   = shift(@parms);
    $callcode = shift(@parms);
    my $iparm = 0;
    $offset   = $parms[$iparm ++]; # PARM1, PARM2 .. follow
    $pattern  = $patterncache{$callcode};
    my $name  = $parms[scalar(@parms) - 1]; # last parameter
    if (! defined($pattern)) { # new pattern
		$pattern = &read_pattern("$patprefix$callcode$patext");
		$patterncache{$callcode} = $pattern;
		if ($debug >= 1) {
		    print STDERR "read $patprefix$callcode$patext\n";
		}
    } # new pattern
    my $package = lc(substr($aseqno, 0, 4));
    my $copy = $pattern;
    $copy =~ s{\$\(ASEQNO\)}    {$aseqno}g;
    $copy =~ s{\$\(AUTHOR\)}    {$author}g;
    $copy =~ s{\$\(CALLCODE\)}  {$callcode}g;
    $copy =~ s{\$\(DATE\)}      {$timestamp}g;
    $copy =~ s{\$\(NAME\)}      {$name}g;
    $copy =~ s{\$\(OFFSET\)}    {$offset}g;
    $copy =~ s{\$\(PACK\)}      {$package}g;
    my $do_generate = 1;
    while ($iparm < scalar(@parms) - 1) {
        my $max_term_len = 0;
        my @terms = map {
              if (length > $max_term_len) {
                $max_term_len = length;
              } 
              $_
            } split(/\,\s*/, $parms[$iparm]);
        $copy =~ m{\$\(PARM$iparm(\.\w+)?\)}i;
        my $line_len = length($PREMATCH) || 0;
        my $type = $1 || "";
        my $term;
        my $len;
        my @typed_terms = ();
        foreach my $term (@terms) {
            if ($term =~ m{\/\*\*\/}) {
                $term = "";
            } 
            if ($debug >= 2) {
                print "# before: type(PARM$iparm) = \"$type\", term=\"$term\"\n";
            }
            if (0) {
        #   } elsif (($term =~ m{[^ \-\,0-9]}) or ($term !~ m{\d})) {
        #       print "# $aseqno \"$term\" contains non-digits\n";
        #       $do_generate = 0;
            } elsif (length($type) == 0) { # leave it as it is
            } elsif ($type =~ m{I}i)     { # normal int
                # term is unchanged
            } elsif ($type =~ m{L}i)     { # make 'long' constant
                if (length($term) > 16) {
                    print "# $aseqno length($term) > 16\n";
                    $do_generate = 0;
                }
                $term .= "L";
            } elsif ($type =~ m{Z}i)     { # construct new Z(String)
                $term = "new Z(\"$term\")";
            }  
            $len = length($term);
            if ($line_len >= $max_line_len) {
                $term = "\n" . (' ' x $indent) . $term;
                $line_len =           $indent;
            }
            $line_len += $len + 2; # 2 for ", ";
            if ($debug >= 2) {
                print "# after : type(PARM$iparm) = \"$type\", term=\"$term\"\n";
            }
            push(@typed_terms, $term)     
        } # foreach $term
        my $parm = join(", ", @typed_terms);
        $copy =~ s{\$\(PARM$iparm(\.\w+)?\)}{$parm}g;
        $iparm ++;
    } # while $iparm
    
    if (0) {
      } elsif ($copy =~ m{\$\((PARM\d)}) {
        print "# $aseqno $1 not replaced - skipped\n";      
    } elsif ($do_generate > 0) {
        my $packdir = "$targetdir/$package";
        if ($old_package ne $package) {
            mkdir $packdir;
            $old_package = $package;
        }
        my $filename = "$packdir/$aseqno.java";
        open(OUT, ">", $filename) || die "cannot write \"$filename\"\n";
        print OUT $copy;
        close(OUT);
        if ($debug >= 1) {
            print "$aseqno $name\n";
            if ($debug >= 1) {
                print "--------------------------------\n";
                print $copy;
            }
        } # debug
        $gen_count ++;
    } else {
        print "# $aseqno has too big parameter values - skipped\n";
    }
} # while <>
print STDERR "# $gen_count sequences generated\n";
#----------------------------------------
sub read_pattern { # read the pattern and return it
    my ($patfile) = @_;
    open(PAT, "<", $patfile) or die "cannot read \"$patfile\"\n";
    my $result = "";
    while (<PAT>) {
        if ($debug >= 1) {
          print "# $_";
        }
        $result .= $_;
    } # while <PAT>
    close(PAT);
    return $result; 
} # read_pattern
#---------------------------------------
__DATA__
package irvine.oeis.$(PACK);
// Generated by gen_pattern.pl - do NOT edit here!

import irvine.math.z.Z;
import irvine.oeis.PeriodicSequence;
import irvine.oeis.PrependSequence;

/**
 * $(ASEQNO) $(NAME)
 * @author $(AUTHOR)
 */
public class $(ASEQNO) extends PrependSequence {

  /** Construct the sequence. */
  public $(ASEQNO)() {
    super(new PeriodicSequence($(PARM3)), Z.valueOf($(PARM2)));
  }
}
#------------------------------
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
