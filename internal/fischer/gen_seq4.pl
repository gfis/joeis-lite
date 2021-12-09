#!perl

# Read rows from db table 'seq4' and generate corresponding Java sources for jOEIS
# @(#) $Id$
# 2021-11-26: V2.9: but only "Binomial("
# 2021-11-26: V2.8: import Binomial
# 2021-11-11: V2.7: no import for "Function"
# 2021-11-09: V2.6: Transpose, AbsoluteSequence
# 2021-10-29, V2.5: -cc concatenated with callcode in infile
# 2021-10-28, V2.4: -cc overwrites callcodes in infile
# 2021-10-10, V2.3: for subpackages irvine.oeis.cons|triangle
# 2020-09-02, V2.2: do not import @OVerride 
# 2020-06-21, V2.1: imports not from comments
# 2020-06-16, V2.0: hash for imports automatically compiled
# 2020-06-09, V1.8: leading "~~;  private final CR ~~parm2~~parm2~~...
# 2020-05-19, V1.7: replace ~~ in $(PARMi) -> newline + 8 spaces
# 2019-12-06, V1.6: no spaces in vectors
# 2019-07-04, V1.5: -m: only those not already in $maindir
# 2019-06-23: up to 8 $(PARMi) in seq4
# 2019-06-13, Georg Fischer: derived from gen_pattern.pl
#
#:# Usage:
#:#   perl gen_seq4.pl [-d debug] [-a author] [-cc callcode] [-l maxlen]
#:#          [-p patprefix] [-t targetdir] [-nc] infile > logfile
#:#   -a  author     Sean or Georg
#:#   -cc callcode   overwrites the callcode in the infile
#:#   -l  maxlen     maximum length of a line during $(PARMi) expansion
#:#   -nc           do not overwrite if already present in $maindir
#:#   -p  patprefix  directory prefix where to find the *.jpat pattern file(s)
#:#
#:#   infile lines have the format: ASEQNO CALLCODE OFFSET PARM1 PARM2 PARM3 PARM4 ... PARM8 NAME
#:#   The pattern file(s) may contain all of these
#:#   and $(AUTHOR), $(DATE), $(GEN), $(IMPORT), $(PACK), $(PROG).
#--------------------------------------------------------
use strict;
use integer;
use warnings;
use English; # PREMATCH

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min);
# $timestamp = sprintf ("%04d-%02d-%02d ", $year + 1900, $mon + 1, $mday);
my $program = "gen_seq4.pl V2.9";
my $max_term = 16;
my $max_size = 16;
my $max_line_len = 120;
my $indent = 6;
my $debug = 0;
if (scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $author    = "Georg Fischer";
my $patprefix = "./";
my $patext    = ".jpat";
my $cc        = "";
my $callcode  = "cfsnum";
my %patterncache  = (); # empty at the beginning
my $basedir   = "../../../OEIS-mat/common";
my $targetdir = "../../src/irvine/oeis";
my $maindir   = "../../../joeis/src/irvine/oeis";
my $clobber   = 1; # overwrite even if already present in $maindir
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{a}) {
        $author    =  shift(@ARGV);
    } elsif ($opt  =~ m{cc}) {
        $cc        =  shift(@ARGV);
    } elsif ($opt  =~ m{d}) {
        $debug     =  shift(@ARGV);
    } elsif ($opt  =~ m{l}) {
        $max_line_len = shift(@ARGV);
    } elsif ($opt  =~ m{nc}) {
        $clobber   = 0;
    } elsif ($opt  =~ m{p}) {
        $patprefix =  shift(@ARGV);
    } elsif ($opt  =~ m{t}) {
        $targetdir =  shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $TYPE_PERM = 1; # import is permanent (from the pattern)
my $TYPE_TEMP = 2; # import is temporary (from the parameters)
my %imports = (); # hash for classes to be imported; key=1 - always, key=2 - for this specific class (deleted at the end)
my $pattern;
my $offset = "0";
my $aseqno;
my $package;
my $name;
my @parms;
my $old_package = "";
my $gen_count = 0;

mkdir $targetdir;
my $old_callcode = "";
while (<>) { # read inputfile
    s{\A\#.*}{}; # remove comments
    next if m{\A\s*\Z}; # skip empty lines
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($debug >= 1) {
        print "$line\n";
    }
    @parms    = split(/\t/, $line); # this is a row from db table 'seq4'
    $aseqno   = shift(@parms);
    next if scalar(@parms) == 0; # only aseqno => came from CC=man
    $callcode = shift(@parms);
    my $iparm = 0;
    $offset   = $parms[$iparm ++]; # PARM1, PARM2, ... PARM8, NAME follow
    $name  = $parms[scalar(@parms) - 1]; # last parameter
    $name =~ s{\&}{\&amp\;}g;
    $name =~ s{\'}{\&apos\;}g;
    $name =~ s{\"}{\&quot\;}g;
    $name =~ s{\<}{\&lt\;}g;
    $name =~ s{\>}{\&gt\;}g;
    $pattern  = $patterncache{$callcode};
    if ($old_callcode ne $callcode) { # pattern changes - read again because of imports
        $old_callcode = $callcode;
        $pattern = &read_pattern("$patprefix$callcode$patext");
        $patterncache{$callcode} = $pattern;
        if ($debug >= 1) {
            print STDERR "read $patprefix$callcode$patext\n";
        }
    } # new pattern
    $package = lc(substr($aseqno, 0, 4)); # Java package name
    my $copy = $pattern;
    my $do_generate = 1;
    if ($debug >= 2) {
        print "# scalar(parms)=" . scalar(@parms) . "\n";
    }
    while ($iparm < scalar(@parms) - 1) { # for all $(PARMi)
        my $max_term_len = 0;
        my @terms;
        if ($parms[$iparm] !~ m{\~\~}) { # with statement separator
            @terms = map {
                if (length > $max_term_len) {
                    $max_term_len = length;
                }
                $_
            } split(/\,\s*/, $parms[$iparm]);
        } else {
            @terms = ($parms[$iparm]);
        }
        if ($debug >= 2) {
            print "# start iparm=$iparm, terms=" . join(",", @terms) . "\n";
        }
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
            } elsif (length($type) == 0) { # leave it, but replace "~~" -> newlines
                if ($term =~ m{\A\~\~([^\~]*)}) { # leading ~~ - special separator
                    my $separator = $1;
                    $separator =~ m{\A(\S*)(\s+.*)}; # separator has the form: head spaces tail
                    my $head = $1;
                    my $tail = $2;
                    $tail = $separator; # new logic
                    $head = "";
                    $term =~ s{\A\~\~([^\~]*)(\~\~)?}{}; # remove the separator
                    my $statements = "";
                    foreach my $part (split(/\~\~/, $term)) {
                        $statements .= "$tail$part$head\n";
                    }
                    $statements =~ s{\n\Z}{};
                    $term = $statements;
                } else { # infix ~~
                    $term =~ s{\~\~}{\"\n        , \"}g; # 8 spaces and comma
                }
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
            $line_len += $len + 1; # 1 for ",";
            if ($debug >= 2) {
                print "# after : type(PARM$iparm) = \"$type\", term=\"$term\"\n";
            }
            push(@typed_terms, $term)
        } # foreach $term
        my $parm = join(",", @typed_terms);
        if ($parms[$iparm] =~ m{(\, ?)\Z}) { 
            $parm .= $1;
        }
        if ($parm eq "") { # remove empty line
            $copy =~ s{\n\s*\$\(PARM$iparm(\.\w+)?\)\s*\n}{\n}g;
        }
        $copy =~ s{\$\(PARM$iparm(\.\w+)?\)}{$parm}g;
        $iparm ++;
    } # while $iparm

    if (0) {
    } elsif ($copy =~ m{\$\((PARM\d)}) {
        print "# $aseqno $1 not replaced - skipped\n";
        if ($debug >= 1) {
            print "$copy\n================================\n";
        }
    } elsif ($do_generate > 0) {
        &write_output($copy, $aseqno);
    } else {
        print "# $aseqno has too big parameter values - skipped\n";
    }
    &clean_imports();
} # while <>
print STDERR "# $gen_count sequences generated\n";
#-----------------
sub write_output {
    my ($copy, $aseqno) = @_; # global $old_package, $gen_count, $debug
    my $call1 = ($cc eq $callcode) ? $cc : "$cc/$callcode"; 
    map {
        my $line = $_;
        if ($line !~ m{\A\s*\*\s+}) {
            &extract_imports($line, $TYPE_TEMP);
        }
        $line
        } split(/\n/, $copy);
    $copy =~ s{\$\(ASEQNO\)}         {$aseqno}g;
    $copy =~ s{\$\(AUTHOR\)}         {$author}g;
    $copy =~ s{\$\(CALLCODE\)}       {$call1}g;
    $copy =~ s{\$\(DATE\)}           {$timestamp}g;
    $copy =~ s{\$\(GEN\)}            {$0}g;
    $copy =~ s{\$\(IMPORT\)}         {&get_imports($aseqno)}eg;
    $copy =~ s{\$\(PROG\)}           {$program}g;
    $copy =~ s{\$\(NAME\)}           {$name}g;
    $copy =~ s{\$\(OFFSET\) *\- *1}  {$offset - 1}eg;
    $copy =~ s{\$\(OFFSET\)}         {$offset}g;
    $copy =~ s{\$\(PACK\)}           {$package}g;
    my $package = lc(substr($aseqno, 0, 4));
    # print STDERR "==> $maindir/$package/$aseqno.java ?\n";
    if ($clobber == 1 or (! -r "$maindir/$package/$aseqno.java")) { # overwrite or does not yet exist
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
            print "--------------------------------\n";
            print $copy;
        } # debug
        $gen_count ++;
    } # overwrite
} # write_output
#--------------------------------
sub read_pattern { # read the pattern and return it
    my ($patfile) = @_;
    %imports = (); # start with no imports
    open(PAT, "<", $patfile) or die "cannot read \"$patfile\"\n";
    my $state = "init";
    my $result = "";
    while (<PAT>) {
        my $patline = $_; # no chompr!
        if ($debug >= 2) {
          print "# patline=$patline";
        }
        if ($state eq "init" and ($patline =~ m{\A\s*\Z})) {
            $state =  "next";
            $result .= "\n\$(IMPORT)\n";
            $patline = "";
        }
        if ($patline =~ m{\A\s*import +([\w\.]+)\;}) {
            my $class = $1;
            $imports{$class} = $TYPE_PERM; # permanent for this pattern
            $patline = "";
        } else {
            &extract_imports($patline, $TYPE_PERM);
        }
        $result .= $patline;
    } # while <PAT>
    close(PAT);
    if ($debug >= 1) {
        print "# pattern: \n$result";
    }
    return $result;
} # read_pattern
#--------------------------------
sub clean_imports { # remove all temporary imports, keep the ones from the pattern only
    my @permkeys = grep { $imports{$_} == $TYPE_PERM } keys(%imports);
    %imports = ();
    foreach my $key (@permkeys) {
        $imports{$key} = $TYPE_PERM;
    } # foreach
} # clean_imports
#--------------------------------
sub extract_imports { # look for Annnnnnn, ZUtils. StringUtils. CR. etc.
    my ($line, $itype) = @_; # 1 = permanent for this pattern, 2 = temporary
    my @aseqnos = ($line =~ m{(A\d{6})}g);
    foreach my $aseqno (@aseqnos) {
        $imports{"irvine.oeis." . lc(substr($aseqno, 0, 4)) . ".$aseqno"}                   = $itype;
    } # foreach
    if ($line =~ m{\WZUtils\.}        ) { $imports{"irvine.math.z.ZUtils"}                  = $itype; }
    if ($line =~ m{\WZeta\.}          ) { $imports{"irvine.math.cr.Zeta"}                   = $itype; }
    if ($line =~ m{\WBinomial\.}      ) { $imports{"irvine.math.z.Binomial"}                = $itype; }
    if ($line =~ m{\WStringUtils\.}   ) { $imports{"irvine.util.string.StringUtils"}        = $itype; }
    if ($line =~ m{\WMemoryFactorial} ) { $imports{"irvine.math.factorial.MemoryFactorial"} = $itype; }
    if ($line =~ m{\WQ\W}             ) { $imports{"irvine.math.q.Q"}                       = $itype; }
    if ($line =~ m{\WCR\W}            ) { $imports{"irvine.math.cr.CR"}                     = $itype; }
    if ($line =~ m{\WComputableReals} ) { $imports{"irvine.math.cr.ComputableReals"}        = $itype; }
    if ($line =~ m{\WUnaryCRFunction} ) { $imports{"irvine.math.cr.UnaryCRFunction"}        = $itype; }
    if ($line =~ m{\WAbsoluteSequence}) { $imports{"irvine.oeis.AbsoluteSequence"  }        = $itype; }
    if ($line =~ m{\WLinearRecurrence}) { $imports{"irvine.oeis.LinearRecurrence"  }        = $itype; }
    if ($line =~ m{\WPaddingSequence} ) { $imports{"irvine.oeis.PaddingSequence"   }        = $itype; }
    if ($line =~ m{\WPeriodicSequence}) { $imports{"irvine.oeis.PeriodicSequence"  }        = $itype; }
    if ($line =~ m{\WPrependSequence} ) { $imports{"irvine.oeis.PrependSequence"   }        = $itype; }
    if ($line =~ m{\WSkipSequence}    ) { $imports{"irvine.oeis.SkipSequence"      }        = $itype; }
    if ($line =~ m{\WTranspose}       ) { $imports{"irvine.oeis.triangle.Transpose"}        = $itype; }
    
    if ($line !~ m{\A\s*(\/\/|\/\*|\*)}) { # no comment line
        while (($line =~ s{[^\(\.\@\w]([A-Z][\.\w\_]+)}{}) > 0)  { # non-name followed by Java classname starting with uppercase
            my $class_name = $1; 
            # look it up in the imports accumulated so far
            $class_name =~ m{\.(\w+)\Z};
            my $last_name = $1;
            my $found = 0;
            foreach my $key (keys(%imports)) {
                if ($key =~ m{\.$last_name\Z}) {
                    $found = 1;
                }
            } # foreach $key
            if ($found) { # already there - do nothing
            } elsif (($class_name !~ m{\AA\d+})               # A-number
                and  ($class_name !~ m{\.})                   # contains dot
                and  ($class_name !~ m{\A[A-Z]+\Z})           # only uppercase = constant
                and  ($class_name !~ m{\A(String|Integer)\Z}) # common Java types
                and  ($class_name !~ m{\AComputableReals\Z})
                and  ($class_name !~ m{\AUnaryCRFunction\Z})
                and  ($class_name !~ m{\AFunction\Z})
               ) {
                $imports{"irvine.oeis.$class_name"} = $itype; 
            }
        } # Java classname
    } # no comment
    if ($debug >= 2) {
        print "# imports: " . join(",", map { "$_\($imports{$_}\)" } sort(keys(%imports))) . "\n";
    } # debug
    delete($imports{"irvine.oeis.CR"});
} # extract_imports
#--------------------------------
sub get_imports {
    my ($aseqno) = @_;
    my $result = "";
    foreach my $key (sort(keys(%imports))) {
        if ($key !~ m{\.$aseqno}) { # do not self-import the sequence to be generated
            $result .= "\nimport $key;";
        }
    } # foreach
    return length($result) > 0 ? substr($result, 1) : $result; # ignore leading "\n"
} # get_imports
#--------------------------------
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
