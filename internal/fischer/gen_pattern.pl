#!perl

# Generate a series of Java sources for jOEIS
# @(#) $Id$
# 2019-04-05: -t targetdir (default "./temp")
# 2019-04-04, Georg Fischer
#
#:# Usage:
#:#   perl gen_pattern.pl [-d debug] [-a author] [-n namesfile] [-l maxlen]
#;#          [-p patprefix] [-t targetdir] infile > logfile
#:#       infile has the format: ASEQNO CALLPATTERN PARM1 PARM2 ...
#:#       pattern may contain $(NAME), $(AUTHOR), $(ASEQNO) = $(PARM0), $(DATE), $(PACK), $(PARM1), $(PARM2) ...
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
my $patprefix = "./Invoke";
my $patext    = ".jpat";
my $call_pattern = "LinearRecurrence";
my %patterns  = ();
my $basedir   = "../../../OEIS-mat/common";
my $namesfile = "$basedir/names"; 
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
    } elsif ($opt  =~ m{n}) {
        $namesfile = shift(@ARGV);
    } elsif ($opt  =~ m{p}) {
        $patprefix = shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $targetdir = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my @names   = &read_names($namesfile);
my $pattern;
mkdir $targetdir;
my $aseqno;
my @parms;
my $old_package = "";
my $gen_count = 0;

while (<>) { # read inputfile
    s{\#.*}{}; # remove comments
    next if m{\A\s*\Z}; # skip empty lines
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($debug >= 1) {
        print "$line\n";
    }
    @parms = split(/\t/, $line);
    $aseqno = shift(@parms);
    my $iparm = 0;
    $call_pattern = $parms[$iparm ++]; # [0]
    my $pattern = $patterns{$call_pattern};
    if (! defined($pattern)) { # new pattern
      $pattern = &read_pattern("$patprefix$call_pattern$patext");
      $patterns{$call_pattern} = $pattern;
      if ($debug >= 1) {
        print STDERR "read $patprefix$call_pattern$patext\n";
      }
    } # new pattern
    my $seqno = substr($aseqno, 1) + 0; # without "A" and leading zeroes
    my $package = "a" . substr($aseqno, 1, 3);
    my $copy = $pattern;
    my $name = $names[$seqno];
    $copy =~ s{\$\(ASEQNO\)}    {$aseqno}g;
    $copy =~ s{\$\(AUTHOR\)}    {$author}g;
    $copy =~ s{\$\(ASEQNO\)}    {$aseqno}g;
    $copy =~ s{\$\(DATE\)}      {$timestamp}g;
    $copy =~ s{\$\(NAME\)}      {$name}g;
    $copy =~ s{\$\(PACK\)}      {$package}g;
    my $do_generate = 1;
    while ($iparm < scalar(@parms)) {
        my $max_term_len = 0;
        my @terms = map {
              if (length > $max_term_len) {
                $max_term_len = length;
              } 
              $_
            } split(/\,\s*/, $parms[$iparm]);
        $copy =~ m{\$\(PARM$iparm(\.\w+)?\)}i;
        my $line_len = length($PREMATCH);
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
            if (($term =~ m{[^ \-\,0-9]}) or ($term !~ m{\d})) {
       			print "# $aseqno \"$term\" contains non-digits\n";
                $do_generate = 0;
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
sub read_names { # read names into an array indexed by seqno (without "A") and returns that array
    my ($namesfile) = @_;
    print STDERR "# reading from $namesfile ... ";
    open(NAM, "<", $namesfile) or die "cannot read $namesfile\n";
    my @nawol = (); # without links
    my $count = 0;
    while (<NAM>) {
        s/\s+\Z//; # chompr
        next if m{\A\s*\#}; # skip comments
        $count ++;
        my $line  = $_;
        $line     =~ m{^(\w)(\d+)\s+(.*)};
        my $seqno = $2;
        my $name  = $3;
        $name =~ s{\s+}{ }g;
        $name =~ s{\&}{\&amp;}g;
        $name =~ s{\<}{\&lt;}g;
        $name =~ s{\>}{\&gt;}g;
        $name =~ s{\'}{\&apos;}g;
        $name =~ s{\"}{\&quot;}g;
        $nawol[$seqno] = $name;
    } # while <NAM>
    close(NAM);
    print STDERR "$count names read\n";
    return @nawol;  
} # read_names
#----------------------------------------
sub read_pattern { # read the pattern and return it
    my ($patfile) = @_;
    open(PAT, "<", $patfile) or die "cannot read $patfile\n";
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
