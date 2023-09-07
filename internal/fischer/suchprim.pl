#!perl

# Extract parameters for "Numbers such that ... is prime"
# 2023-09-07: *.jpat in ./pattern
# 2021-01-03, Georg Fischer: copied from nest.pl
#
#:# Usage:
#:#   grep ... $(COMMON)/joeis_names.txt \
#:#   | perl suchprim.pl [-d debug] > output
#:#     -d  debugging level (0=none (default), 1=some, 2=more)
#--------------------------------------------------------
use strict;
use integer;
use warnings;

my $line = "";
my ($aseqno, $superclass, $callcode, @rest, $name);
my $debug   = 0;
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt   =~ m{\-d}  ) {
        $debug      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt

my @parms;
my $offset = 0;
my $rseqno = "";
while (<>) { # from joeis_names.txt
    s/\s+\Z//; # chompr
    $line = $_;
    ($aseqno, $superclass, $name, @rest) = split(/\t/, $line);
    my $cond  = "";
    $callcode = "";                 
    @parms = ($offset, 0, 0, 0, 0); # offset, mConst1, mPow10, mConstR, mAdd
                                           # parms[0]      [1]     [2]      [3]   [4]
    if (0) {
    
    } elsif ($name =~ m{Numbers [k-n] such that (the string |the concatenation )?(\d+[k-n]) is (a )?prime}) {
        # A104912   null    Numbers k such that the string 9876543210k is prime.    nonn,base,synth 1..49   nyi
        # A104914   null    Numbers n such that the string 987654321k is prime. nonn,base,  1..10000    nyi
        $cond = $2;
        $callcode = "parm2";
        $cond =~ s{ }{}g; # remove spaces
        $cond =~ s{[k-n]}{}; # remove k or n
        $parms[1] = "A103603";
        $parms[2] = "\"$cond\"";
        $parms[4] = "suchprik";
        $parms[5] = $name;
    
    } elsif ($name =~ m{Numbers [k-n] such that (the string |the concatenation )?([k-n]\d+) is (a )?prime}) {
        # A103540   null    Numbers k such that the string k2357111317 is prime.    base,nonn,  1..1000 nyi
        # A103541   null    Numbers n such that n23571113171923 is prime.   base,nonn,  1..10000    nyi
        # A104044   null    Numbers n such that n7 is prime and n is a multiple of ten. base,nonn,synth 1..44   nyi
        $cond = $2;
        $callcode = "suchprki";
        $parms[1] = "A099192";
        $cond =~ s{ }{}g; # remove spaces
        $cond =~ s{[k-n]}{}; # remove k or n
        if ($name =~ m{is prime and [k-n] is a multiple of (ten|10)}) {
            $cond = "0$cond"; # insert a zero
            $callcode = "suchprk0";
            $parms[1] = "A102915";
        }
        $parms[2] = "\"$cond\"";
        $parms[3] = "\"1" . ("0" x length($cond)) . "\"";
        $parms[4] = $callcode;
        $parms[5] = $name;
        $callcode = "parm3";
    
    } elsif ($name =~ m{Numbers [k-n] such that ([^i]+)is (a )?prime}) {
        # A102990   null    Numbers n such that 4*10^n + 3*R_n + 6 is prime, where R_n = 11...1 is the repunit (A002275) of length n.
        # A103100   null    Numbers n such that 9*10^n + 5*R_n - 4 is prime, where R_n = 11...1 is the repunit (A002275) of length n.   more,nonn,changed,synth 1..24   nyi
        # A259128   null    Numbers k such that R_k + 3*10^k + 2 is prime, where R_k = 11...11 is the repunit (A002
        # A095306   null    Numbers n such that r(k) * 2^n + 1 is prime, where r() = A002275 the repunits and k is the number of decimal digits of 2^n. more,nonn,base,changed,synth    1..16   nyi
        # A256906   null    Numbers k such that 7*R_k + 10 is prime, where R_k = 11...1 is the repunit (A002275) of
        # A256912   null    Numbers k such that R_(k+2) - 10^k is prime, where R_k = 11...1 is the repunit (A002275
        $cond = "+$1";
        $cond =~ s{ }{}g; # remove spaces
        $cond =~ s{n}{k}g;
        my @exprs = split(/([\+\-])/, $cond); # return the separators also
        my $nexpr = scalar(@exprs);
        # now $exprs has component pairs (sign, expr), where expr = 
        # r : 4*R_k
        # t : 3*10^k
        # a : 5
        my $rta = "";
        my ($const1, $pow10, $constR, $constA) = (0, 0, 0, 0);
        my 
        $ipart = 0;
        while ($ipart < $nexpr) {
            if ($exprs[$ipart] =~ m{\A((\d+)\*)?R_k}) {
                $rta .= "r";
                $constR = $2 || 1;
            }
            $ipart += 2;
        } # while R
        $ipart = 0;
        while ($ipart < $nexpr) {
            if ($exprs[$ipart] =~ m{\A((\d+)\*)?10\^k}) {
                $rta .= "t";
                $const1 = $2 || 1;
            }
            $ipart += 2;
        } # while 10
        $ipart = 0;
        while ($ipart < $nexpr) {
            if ($exprs[$ipart] =~ m{\A((\d+))\Z}) {
                $rta .= "a";
                $constA = $exprs[$ipart - 1] . ($2 || 0);
            }
            $ipart += 2;
        } # while add
        @parms = ($offset, $const1, $const1, $constR, $constA);
        $callcode = "suchp$rta";
        if (0) {
            print "# $aseqno npart=$nexpr; cond=$cond; exprs=" . join ("; ", @exprs) . "\t$name\n";
        }
        $parms[5] = $name;
    
    } elsif ($name =~ m{Numbers [k-n] such that ([^i]+)is prime}) {
        # A105583   null    Numbers k such that 101*k + 997 is prime.   nonn,easy,changed,  1..10000    nyi
        # A107123   null    Numbers n such that (10^(2n+1)+18*10^n-1)/9 is prime.   nonn,base,more,changed,synth    1..6    nyi
        $cond = $1;
        $callcode = "suchprim";
        $cond =~s { }{}g; # remove spaces
    
    } # if proper name
    if ($callcode =~ m{parm\d|suchp(rim|rik|rki|rk0|rt|ra|ta|rta)}) {
        print join("\t", $aseqno, $callcode, join("\t", @parms)) . "\n";
    } else {
        print STDERR join("\t", $aseqno, $name) . "\n";
    }
} # while <>
&write_jpats();
#================================
sub write_jpats {
    foreach my $cc ("rim", "rik", "rki", "rk0", "rt", "ra", "ta", "rta") {
        my $jpat_name = "suchp$cc.jpat";
        open (JPAT, ">", "./pattern/$jpat_name") or die "cannot write \",/pattern/$jpat_name\"";
        print JPAT <<'GFis';
package irvine.oeis.$(PACK);
// Generated by $(GEN) $(CALLCODE) at $(DATE)
// DO NOT EDIT here!

import irvine.math.z.Z;
import irvine.oeis.Sequence;

/**
 * $(ASEQNO) $(NAME)
 * @author $(AUTHOR)
 */
public class $(ASEQNO) implements Sequence {
  protected long mK = -1L; // number k to be returned
  protected Z mConst1 = new Z("$(PARM1)");
  protected Z mPow10 = new Z("$(PARM2)");
  protected Z mConstR = new Z("$(PARM3)");
  protected Z mR_n = Z.ZERO;
  protected Z mConstA = Z.valueOf($(PARM4));

  @Override
  public Z next() {
    boolean busy = true;
    while (busy) {
      ++mK;
GFis
#----
        if (0) {
#----
        } elsif ($cc =~ m{\Ark[i0]\Z}) {
            my $times10 = ($cc =~ m{0}) ? " * 10" : "";
            print JPAT <<"GFis";
      if (mConst1.add(mPow10.multiply(mK)).isProbablePrime()) {
        busy = false;
      }
    }
    return Z.valueOf(mK$times10);
GFis
#----
        } elsif ($cc =~ m{\Arik\Z}) {
            print JPAT <<'GFis';
      if ((mK & 1) != 1) { 
        ++mK;
      }
      if (Z.valueOf(mK).compareTo(mPow10) >= 0) {
        mPow10 = mPow10.multiply(Z.TEN);
      }
      if (mPow10.multiply(mConst1).add(mK).isProbablePrime()) {
        busy = false;
      }
    }
    return Z.valueOf(mK);
GFis
#----
        } elsif ($cc =~ m{\Arim\Z}) {
            print JPAT <<'GFis';
      if (mConst1.add(mPow10.multiply(mK)).isProbablePrime()) {
        busy = false;
      }
    }
    return Z.valueOf(mK);
GFis
#----
        } elsif ($cc =~ m{\Art\Z} ) {
            print JPAT <<'GFis';
      if (mPow10.add(mR_n.multiply(mConstR)).isProbablePrime()) {
        busy = false;
      }
      mR_n = mR_n.multiply(10).add(1);
      mPow10 = mPow10.multiply(10);
    }
    return Z.valueOf(mK);
GFis
#----
        } elsif ($cc =~ m{\Ara\Z} ) {
            print JPAT <<'GFis';
      if (mR_n.multiply(mConstR).add(mConstA).isProbablePrime()) {
        busy = false;
      }
      mR_n = mR_n.multiply(10).add(1);
    }
    return Z.valueOf(mK);
GFis
        } elsif ($cc =~ m{\Ata\Z} ) {
            print JPAT <<'GFis';
      if (mPow10.add(mConstA).isProbablePrime()) {
        busy = false;
      }
      mPow10 = mPow10.multiply(10);
    }
    return Z.valueOf(mK);
GFis
        } elsif ($cc =~ m{\Arta\Z} ) {
            print JPAT <<'GFis';
      if (mPow10.add(mR_n.multiply(mConstR)).add(mConstA).isProbablePrime()) {
        busy = false;
      }
      mR_n = mR_n.multiply(10).add(1);
      mPow10 = mPow10.multiply(10);
    }
    return Z.valueOf(mK);
GFis
#----
        } # else wrong $cc
#----
        print JPAT <<'GFis';
  }
}
GFis
        close(JPAT);
    } # foreach
} # sub write_jpats
#================
__DATA__
