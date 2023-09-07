#!perl

# Extract parameters for product formulas 1/(1 - x^k)^(abc) and similiar
# 2023-09-07: *.jpat in ./pattern
# 2023-06-15: variable classname and cc_prefix
# 2020-12-04: copied from prodet.pl, (1 +- ax^k)^(b*k) etc.
# 2020-10-10, Georg Fischer
#
#:# Usage:
#:#   perl genet.pl [-cc patternname] [-d debug] [-f ofter_file] prod1_xk.gen > genet.gen 2> genet.rest.tmp
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#:#     -f  file with aseqno, offset1, terms (default $(COMMON)/joeis_ofter.txt)
#:# Reads ofter_file for implemented jOEIS sequences with their offsets and first terms
#:# Writes files genet{f|g|h|fg|fh|gh|}.jpat automatically.
#
# The pattern files genet*.jpat have the parameters filled from the bottom to the top:
#   $(PARM1)  statements for the constructor
#   $(PARM2)  return value of advanceF(k)
#   $(PARM3)  return value of advanceG(k)
#   $(PARM4)  return value of advanceH(k)
# The statements for gen_seq4.pl consist of one or more segments (starting with "~~")
# which give the Java code lines.
# They are prefixed by an additional segment which defines the indenting.
# A-numbers automatically yield the necessary Java "import irvine.oeis.pack.A-number" statements.
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $callcode, $offset);
my $rseqno;
my $ofter_file = "../../../OEIS-mat/common/joeis_ofter.txt";
my $classname = "GeneralizedEulerTransform";
my $cc_prefix = "genet";
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-cc}  ) {
        $cc_prefix  = shift(@ARGV);
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } elsif ($opt   =~ m{\-f}  ) {
        $ofter_file = shift(@ARGV);
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
my %znames = (0, "Z.ZERO", 1, "Z.ONE", 2, "Z.TWO"  , 3, "Z.THREE", 4, "Z.FOUR"
             ,5, "Z.FIVE", 6, "Z.SIX", 7, "Z.SEVEN", 8, "Z.EIGHT", 9, "Z.NINE", 10, "Z.TEN");
my @parms;
my ($gsig, $hexp, $fexp, $fsig, $gexp, $k, $form, $kstart, $constr, @rest);

while (<>) {
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $callcode, $offset, $k, $form, $kstart, @rest) = split(/\t/, $line);
    if (1) { # secondary polishing
         $form =~ s{\^\((A\d+\([i-n]\))\)}{\^$1}g; # remove () around ^(A-number(k))
         $form =~ s{[qz]}{x}g; # normalize q,z -> x
         $form =~ s{([\d\)])([xk])}{$1\*$2}g; # insert "*" between ")x" or "3k"
         $form =~ s{k\(}{k\*\(}g;
         $form =~ s{\,k\=1\Z}{}; # A052827
         $form =~ s{\)\=}{\)};
         $form =~ s{k\^2(\D)}{k\*k$1}g;
         $form =~ s{\=Product.*}{};
         $form =~ s{\((\d+)\*x\)\^k}{$1\^k\*x\^k}g;
    } # 2nd polishing
    $callcode = "?1init";
    @parms    = ();
    if ($form =~ m{(y|sum|prod|exp|sqrt|floor|ceil)}i) {
        $callcode = "?7yfunc";
    } elsif ($form =~ m{eta\(}) {
        $callcode = "?9etaf";
    } elsif ($form =~ m{theta}) {
        $callcode = "?Atheta";
    } elsif ($form =~ m{a\(}) {
        $callcode = "?Baeti";
    } elsif ($form =~ m{\)\/\(}) {
        $callcode = "?Cfract";
    } elsif ($form =~ m{x[^x]*x}) {
        $callcode = "?6dupx";
    } elsif ($form =~ m{\!}) {
        $callcode = "?Dfact";
    } elsif ($form =~ m{\{}) {
        $callcode = "?Ebrack";

    # A151668   prod1_xk    0   k   (1+2*x^(3^k))   >=0
    # A317913   prod1_xk    0   k   (1+k*x^k)   >=2
    } elsif ($form =~ m{\A(1\/)?\(1([\+\-])(\w+\*|\w\*\w|A\d+\([i-n]\)\*|\([^\)]+\)\*|)x\^(\w|\([^\)]+\)|A\d+\(k\))\)(\^.*)?\Z}) {
        #                 (1s1)    (2gsig2)(3  gfactor                               3)x^ (4 hexp                4)  (5f 5)
        #                        (a 1 +-       g                                    *  x ^ h                       a)  ^(-f)
        ($fsig, $gsig, $gexp, $hexp, $fexp) = ($1 || "", $2, $3, $4, $5 || 1);
        $fsig = ($fsig eq "") ? "+" : "-";
        $gexp =~ s{\*\Z}{}; # remove *
        &translate($fsig, $gsig, $gexp, $hexp, $fexp);

    } elsif ($form =~ m{\A(1\/)?\(1([\+\-])([^x]+)x\^(\w|\([^\)]+\)|A\d+\(k\))\)(\^.*)?\Z}) {
        #                 (1s1)    (2gsig2)(3gf 3)x ^(4 hexp                4)  (5f 5)
        #                        (a 1 +-       g                                    *  x ^ h                       a)  ^(-f)
        ($fsig, $gsig, $gexp, $hexp, $fexp) = ($1 || "", $2, $3, $4, $5 || 1);
        $fsig = ($fsig eq "") ? "+" : "-";
        $gexp =~ s{\*\Z}{}; # remove *
        &translate($fsig, $gsig, $gexp, $hexp, $fexp);

    }

    if ($callcode =~ m{\A\?}) { # write it into $@.rest.tmp
        $line =~ s{\t\w+\t}{\t$callcode\t};
        print STDERR "$line " . join("\t", @parms) . "\n";
    } else {
        $callcode = "genet"
            . (($parms[2] ne "Z.ONE"       ) ? "f" : "")
            . (($parms[3] ne "Z.ONE"       ) ? "g" : "")
            . (($parms[4] ne "Z.valueOf(k)") ? "h" : "")
            ;
        $callcode =~ s{genetfgh}{genet};
        &output();
    }
} # while <>

&write_jpats(); # write all genet[fgh]*.jpat files
#================================
sub output { # global $line, @periods, $reason
    print join("\t", $aseqno, $callcode, @parms, $kstart, $form) . "\n";
} # output
#----
sub translate {
        my ($fsig, $gsig, $gexp, $hexp, $fexp) = @_;
        $callcode = $cc_prefix;
        my ($constr, $f, $g, $h);
        $kstart =~ m{(\d+)};
        $kstart = $1;
        $constr = "~~super(\$(OFFSET), $kstart);"; # . (($kstart >= 1) ? ($kstart - 1) : 0) . ";";

        #-- fexp = 1 | 2 | A-number(k)
        $fexp =~ s{\A\^?}{}; # remove ^
        $fexp =~ s{\A\((.*)\)\Z}{$1}; # remove surrounding ()
        my $froot = "";
        $f = $fexp;
        if (0) {
        } elsif ($fexp eq "1")                       { # 1
            $f = ($fsig eq "-") ? "Z.ONE" : "Z.NEG_ONE";
        } elsif ($fexp =~ m{\A([k\d\+\-\*(\)]+)(\/\d)?\Z}) { # expression in k, without ^, optional trailing "/6"
            $f = (($fsig eq "-") ? "$fexp" : "-($fexp)");
            $f =~ s{\A\-\(\-([k\d\/\*]+)\)\Z}{$1}; # -(-(1/2)) -> 1/2
            $f =~ s{\A\-\(([k\d\/\*]+)\)\Z}{\-$1}; # -(1/2) -> -1/2
            if ($f =~ m{\A([k\d\+\-\*(\)]+)\/(\d)\Z}) { # with trailing "/2"
                ($f, $froot) = ($1, $2);
                $f = &expr_k($f) . ", " . ($znames{$froot} || "Z.valueOf($froot)");
            } else {
                $f = &expr_k($f);
            }
        } elsif ($fexp =~ m{\A(\w+)\^(\w+)\Z})       { # 2^k or k^3 or k^k
            $f = &power_k($1, $2);
            $f = $f          . (($fsig eq "-") ? "" : ".negate()");
        } elsif ($fexp =~ m{\A\-(\w+)\^(\w+)\Z})     { # -2^k or -k^3 or -k^k
            $f = &power_k($1, $2);
            $fsig = ($fsig eq "-") ? "+" : "-"; # negate
            $f = $f          . (($fsig eq "-") ? "" : ".negate()");
        } elsif ($fexp =~ m{\A\((\w+)\^(\w+)\)\Z})   { # (2^k) or (k^3) or (k^k)
            $f = &power_k($1, $2);
            $f = $f          . (($fsig eq "-") ? "" : ".negate()");
        } elsif ($fexp =~ m{\A(\-)?(A\d+)\(\w(\+1)?\)([\+\-\*]\w)?\Z}) { # A123456(k)-1
            #                 1    2         3       4
            my $sign     = $1 || "+";
            $rseqno      = $2;
            my $oshift   = $3 || "";
            my $appendix = $4 || "";
            if ($sign eq "-") {
                $fsig = ($fsig eq "-") ? "+" : "-"; # negate
            }
            my $ofter = $ofters{$rseqno};
            if (defined($ofter)) {
                my ($roffset, $rterms) = split(/\t/, $ofter);
                $constr .= "~~mSeqF = new $rseqno();" . (($roffset == 0) ? "~~mSeqF.next();" : "");
                if ($oshift ne "") {
                    $constr .= "~~mSeqF.next();";
                }
            } else {
                $callcode = "?3rnunF"; # do not output
            }
            $f = "mSeqF.next()";
            if ($appendix ne "") {
                $appendix =~ s{\A\-}{.subtract\(};
                $appendix =~ s{\A\+}{.add\(};
                $appendix =~ s{\A\*}{.multiply\(};
                $f .= "$appendix)";
            }
            $f .= (($fsig eq "-") ? "" : ".negate()");
            $f =~ s{valueOf\(\-\(\-(\d+)\)\)}{valueOf\($1\)}g;
        } elsif ($fexp =~ m{\Abinomial\(})           { # binomial(m,n)
            $f = "irvine.math.z.Binomial.$fexp";
            $f .= (($fsig eq "-") ? "" : ".negate()");
        } else {
            $callcode = "?4serrF"; # no output
        }

        #-- gsig = + | -
        # $gsig = ($gsig eq "+") ? "-" : "";
        #-- gfactor = | A123456(k) | 3 | k | (expr)*
        $g = "$gsig$gexp";
        $rseqno = "";
        if (0) {
        } elsif ($gexp eq "")                                { # no g()
            $g = ($gsig eq "-") ? "Z.ONE" : "Z.NEG_ONE";
        } elsif ($gexp =~ m{\A(A\d+)\(})                     { # g(k) = A123456(k)
            $rseqno = $1;
            my $ofter = $ofters{$rseqno};
            if (defined($ofter)) {
                my ($roffset, $rterms) = split(/\t/, $ofter);
                $constr .= "~~mSeqG = new $rseqno();" . (($roffset == 0) ? "~~mSeqG.next();" : "");
            } else {
                $callcode = "?2rnunG"; # do not output
            }
            $g = "mSeqG.next()" . (($gsig eq "-") ? "" : ".negate()");
            if ($kstart >= 2) {
                $g = "$g.multiply((mKfg < $kstart) ? Z.ZERO : Z.ONE)";
            }
        } else { # 3 | k | (expr)*
            if (0) {
            } elsif ($gexp =~ m{\A(\d+)\Z})                  { # 3
                $g = $znames{$gexp} || "Z.valueOf($gexp)";
            } elsif ($gexp =~ m{\A(k)\Z})                    { # k
                $g = "Z.valueOf($gexp)";
            } elsif ($gexp =~ m{\A(\w+)\^(\w+)\Z})           { # k^3 or 3^k
                $g = &power_k($1, $2);
            } elsif ($gexp =~ m{\A([k\d\+\-\*\/\\(\)]+)\Z})  { # expr in k, but no "^"
                $g = &expr_k($gexp);
            } else {
                $callcode = "?8serrG";
            }
            $g .= (($gsig eq "-") ? "" : ".negate()");
            $g =~ s{valueOf\(\-\(\-(\d+)\)\)}{valueOf\($1\)}g;
        }
        if ($kstart >= 2 && $rseqno eq "") {
            $g = "(mKfg < $kstart) ? Z.ZERO : $g";
        }
        
        #-- hexp = k | (...)
        $h = $hexp;
        # $callcode = "geneth"; # use a different if h(k) != k
        if (0) {
        } elsif ($hexp eq "k") { # k
            $h = "Z.valueOf(k)";
            # $callcode = "genet";
        } elsif ($hexp =~ m{\A\((\d+)\^k\)\Z}          ) { # (3^k)
            $h = &power_k($1, "k");
        } elsif ($hexp =~ m{\A\(k\^2\)\Z}              ) { # (k^2)
            $h = "Z.valueOf(k * k)";
        } elsif ($hexp =~ m{\A\(k\^([k\d+])\)\Z}       ) { # (k^5) or (k^k)
            $h = &power_k("k", $1);
        } elsif ($hexp =~ m{\A([k\d\*\+\-\(\)]+)\Z}    ) { # (3*k+1)
            $h = &expr_k($1);
        } elsif ($hexp =~ m{\A(A\d+)\(k\)\Z}           ) { # A123456(k)
            $rseqno = $1;
            my $ofter = $ofters{$rseqno};
            if (defined($ofter)) {
                my ($roffset, $rterms) = split(/\t/, $ofter);
                $constr .= "~~mSeqH = new $rseqno();";
            } else {
                $callcode = "?2rnunH"; # do not output
            }
            $h = "mSeqH.next()"; # . (($hsig eq "-") ? "" : ".negate()");
        } else {
            $callcode = "?5serrH";
        }
        if ($h ne "Z.valueOf(k)") {
            $constr .= "~~mNextH = advanceH(mKh);";
            $g =~ s{k}{mKh}g;
            $callcode = "geneth";
        }

        #-- constr
        if (length($constr) > 0) {
            $constr = "~~    $constr";
        }
        if ($hexp ne "k") {
            if (($fexp =~ m{[Ak]}) && ($fexp ne $hexp) && ("-$fexp" ne $hexp)) {
                $callcode = "?Ffneh";
            }
        }
        #       $parms[0]  $(PARM1) 2   3   4   5        6
        @parms = ($offset, $constr, $f, $g, $h, $kstart, $form);
} # translate
#----
sub power_k {
    my ($base, $exp) = @_;
    my $result;
    if ($base eq "k") {
        $result = "Z.valueOf(k).pow($exp)";
    } elsif ($base =~ m{\A\d+\Z}) {
        $base = $znames{$base} || "Z.valueOf($base)";
        $result = "$base.pow($exp)";
    }
    return $result;
} # power_k
#----
sub expr_k {
    my ($expr) = @_;
    my @terms = split(/\*/, $expr);
    # $expr =~ s{(\d)\b}{$1L}g; # no more necessary
    return "Z.valueOf($expr)"; # shift(@terms);
} # expr_k
#--------
sub write_jpats {
    my $dol = "\$";
    my $at  = "@";
    my $pat_head = <<'GFis';
package irvine.oeis.$(PACK);
// Generated by $(GEN) $(CALLCODE) at $(DATE)

import irvine.math.z.Z;
import irvine.oeis.transform.GeneralizedEulerTransform;

/**
 * $(ASEQNO) $(NAME)
 * G.f.: <code>Product_{k&gt;=$(PARM5)} ($(PARM6))</code>
 * @author $(AUTHOR)
 */
public class $(ASEQNO) extends GeneralizedEulerTransform {

  /** Construct the sequence. */
  public $(ASEQNO)() {
$(PARM1)
  }
  
GFis
    $pat_head =~ s{GeneralizedEulerTransform}{$classname}g;
    my $pat_f= <<'GFis';
  @Override
  protected Z[] advanceF(final long k) {
    return new Z[] { $(PARM2) };
  }
  
GFis
    my $pat_g= <<'GFis';
  @Override
  protected Z advanceG(final long k) {
    return $(PARM3);
  }
  
GFis
    my $pat_h= <<'GFis';
  @Override
  protected Z advanceH(final long k) {
    return $(PARM4);
  }
  
GFis
    my $pat_tail= <<'GFis';
}
GFis
    foreach my $cc ("f","g","h","fg","fh","gh","fgh") {
        my $jpat_name = ($cc eq "fgh") ? "genet.jpat" : "genet$cc.jpat";
        open (JPAT, ">", "./pattern/$jpat_name") or die "cannot write \",/pattern/$jpat_name\"";
        print JPAT $pat_head;
        if ($cc =~ m{f}) { print JPAT $pat_f; }
        if ($cc =~ m{g}) { print JPAT $pat_g; }
        if ($cc =~ m{h}) { print JPAT $pat_h; }
        print JPAT $pat_tail;
        close(JPAT);
    } # foreach
} # sub write_jpats
#--------
__DATA__
A261582 prod1_xk    0   k   1/(1+3*x^k) >=1
A303352 prod1_xk    0   k   1/(1+4*x^k)^(1/2)   >=1
