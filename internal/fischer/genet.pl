#!perl

# Extract parameters for product formulas 1/(1 - x^k)^(abc) and similiar
# 2020-12-04: copied from prodet.pl, (1 +- ax^k)^(b*k) etc.
# 2020-10-10, Georg Fischer
#
#:# Usage:
#:#   perl genet.pl [-cc patternname] [-d debug] [-f ofter_file] prod1_xk.gen > genet.gen 2> genet.rest.tmp
#:#     -cc write a file patternname.jpat and ignore all other arguments
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
# The pattern files genet*.jpat have the parameters filled from the bottom to the top:
#   $(PARM1)  return value of advanceG(n)
#   $(PARM1)  return value of advanceF(n)
#   $(PARM1)  constructor code
# These parameters for gen_seq4.pl consist of one or more segments (starting with "~~")
# which give the Java code lines. 
# They are prefixed by an additional segment which defines the indenting.
# A-numbers autmatically yield the necessary Java "import irvine.oeis.pack.A-number" statements.
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my $negate = 0; # whether "not modulo ..."
my $VOID = "A000000";
my ($aseqno, $callcode, $offset);
my $rseqno;
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $debug   = 0;
my $pseudo  = 0;
my $prepend = 0;
my %used_ccs = ();
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
    } elsif ($opt   =~ m{\-prep} ) {
        $prepend    = 1;
    } elsif ($opt   =~ m{\-pseudo} ) {
        $pseudo     = 1;
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
#----------------
my $terms;
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
my @znames = ( "Z.ZERO", "Z.ONE", "Z.TWO", "Z.THREE", "Z.FOUR"
             , "Z.FIVE", "Z.SIX", "Z.SEVEN", "Z.EIGHT", "Z.NINE", "Z.TEN");
my @parms;
my ($gsig, $hexp, $fexp, $fsig, $gfactor, $k, $form, $start, $constr, @rest);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $k, $form, $start, @rest) = split(/\t/, $line);
    $form =~ s{\^\((A\d+\([i-n]\))\)}{\^$1}g; # remove () around ^(A-number(k))
    $form =~ s{[qz]}{x}g; # normalize q,z -> x
    $form =~ s{([\d\)])x}{$1\*x}g; # insert "*" between ")x" or "3x"
    $form =~ s{\,k\=1\Z}{}; # A052827
    $callcode = "?1init";
    @parms    = ();
    if ($form =~ m{(y|sum|prod|exp)}i) {
        # ignore
    } elsif ($form =~ m{x[^x]*x}) {
        $callcode = "?6dupx";
    } elsif ($form =~ m{\A\(1([\+\-])(\d+\*|A\d+\([i-n]\)\*|\([^\)]+\)\*|)x\^(\w|\([^\)]+\))\)(\^(.*))?\Z}) {
        #                    1(gsig)12(  gfactor                        )2x^ 3(      hexp )3  4( 5  )4
        # A151668   prod1_xk    0   k   (1+2*x^(3^k))   >=0 
        ($gsig, $gfactor, $hexp, $fexp) = ($1, $2, $3, $5 || 1);
        $fsig = "+"; # f must be negated
        &translate($gsig, $gfactor, $hexp, $fexp);

    } elsif ($form =~ m{\A\(1([\+\-])(\d+)\*[xq]\^\((\d+)\^\w\)\)(\^(\d+))?\Z}) {
        # A151668   prod1_xk    0   k   (1+2*x^(3^k))   >=0 
    }
    #--------
    # %N A116377 Number of partitions of n into parts with digital root = 7.
    # %N A147787 Number of partitions of n into parts divisible by 4,6 or 9.
    # etc.

    if ($callcode =~ m{\A\?}) { # write it into $@.rest.tmp
        $line =~ s{\t\w+\t}{\t$callcode\t};
        print STDERR "$line\n"; 
    } else {
        $used_ccs{$callcode} = 1; # this is referenced
        &output();
    }
} # while <>

# now write all gen*.jpat files which have been referenced
foreach $callcode (keys(%used_ccs)) {
    if ($callcode ne "") {
        &write_jpat($callcode);
    }
} # foreach
#================================
sub translate {
        my ($gsig, $gfactor, $hexp, $fexp) = @_;
        $callcode = "genet";
        my ($constr, $f, $g, $h);
        $start =~ m{(\d+)};
        $start = $1;
        $constr = "~~super(1);~~mK = 0;"; # . (($start >= 1) ? ($start - 1) : 0) . ";";
        #-- gsig = + | -
        # $gsig = ($gsig eq "+") ? "-" : "";
        #-- gfactor = | A123456(k)* | 3* | (expr)* |
        $gfactor =~ s{\*\Z}{};
        if ($gfactor eq "") {
            $g = ($gsig eq "-") ? "Z.ONE" : "Z.NEG_ONE";
        } elsif ($gfactor =~ m{\A(A\d+)\(}) { # A-number
            $rseqno = $1;
            my $ofter = $ofters{$rseqno};
            if (defined($ofter)) {
                my ($roffset, $rterms) = split(/\t/, $ofter);
                $constr .= "~~mSeqG = new $rseqno();" . (($roffset == 0) ? "~~mSeqG.next();" : "");
            } else {
                $callcode = "?2rndefG"; # do not output
            }
            $g = "mSeqG.next()" . (($gsig eq "-") ? "" : ".negate()");
        } elsif ($gfactor =~ m{\A(\d+)\Z}) { # 3
            $g = "Z.valueOf("   . (($gsig eq "-") ? "" : "-") . "$gfactor)";
        } else {
            $g = "Z.valueOf("   . (($gsig eq "-") ? "" : "-") . "$gfactor)";
        }
        if ($start >= 2) {
        	$g = "(mK < $start) ? Z.ZERO : $g";
        }
        # fexp = 1 | 2 | A-number(k)
        if ($fexp eq "1") {
            $f = ($fsig eq "+") ? "Z.NEG_ONE" : "Z.ONE";
        } elsif ($fexp =~ m{\A[k\d\+\*\-\()]+\Z}) { # expression in k, without ^
            $f = "Z.valueOf("   . (($fsig eq "-") ? "$fexp" : "-($fexp))");
        } elsif ($fexp =~ m{\A(A\d+\(\w\))\Z}) { # A123456(k)
            $rseqno = $1;
            if (defined($ofters{$rseqno})) {
                $constr .= "~~mSeqF = new $rseqno();";
            } else {
                $callcode = "?3rndefF"; # do not output
            }
            $f = "mSeqF.next()" . (($fsig eq "-") ? "" : ".negate()");
        } else {
            $callcode = "?4syntF"; # no output
        }
        # hexp = k | (3^k)
        if ($hexp eq "k") {
            $h = "k";
        } elsif ($hexp =~ m{\A\((\d+)\^k\)\Z}) { # (3^k)
            my $b = $1;
            $h = "mHp1 * $b";
        } else {
            $callcode = "?5syntH";
        }
        if (length($constr) > 0) {
            $constr = "~~    $constr";
        }
        @parms = ($constr, $f, $g, $h);
} # translate
#----
sub output { # global $line, @periods, $reason
    print join("\t", $aseqno, $callcode, $offset, @parms, '', '', $form) . "\n";
} # output
#--------
sub write_jpat {
    my ($cc) = @_;
    my $jpatname = "$cc.jpat";
    open (JPAT, ">", $jpatname) or die "cannot write \"$jpatname\"";
    print JPAT <<'GFis';
package irvine.oeis.$(PACK);
// Generated by $(GEN) $(CALLCODE) at $(DATE)
// DO NOT EDIT here!
import irvine.math.z.Z;
import irvine.oeis.GeneralizedEulerTransform;

/**
 * $(ASEQNO) $(NAME)
 * @author $(AUTHOR)
 */
public class $(ASEQNO) extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public $(ASEQNO)() {
$(PARM1)
  }

  @Override
  protected Z advanceF(final int k) {
    return $(PARM2);
  }

  @Override
  protected Z advanceG(final int k) {
    return $(PARM3);
  }

  @Override
  protected int advanceH(final int k) {
    return $(PARM4);
  }

}
GFis
    close(JPAT);
} # sub write_jpat
#--------
__DATA__
A261582 prod1_xk    0   k   1/(1+3*x^k) >=1 
A303352 prod1_xk    0   k   1/(1+4*x^k)^(1/2)   >=1 
