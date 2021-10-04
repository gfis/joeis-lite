#!perl

# Extract parameters from Clark Kimberling's guides (overview tables)
# @(#) $Id$
# 2021-08-24, Georg Fischer: copied from solvetab.pl
#
#:# Usage:
#:#   perl ck_guides.pl [-d debug] [-a sel] > output.tmp
#--------------------------------------------------------
use strict;
use integer;
use warnings;
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime (time);
my $timestamp = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);
$timestamp = sprintf ("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
my $debug = 0;
if (0 && scalar(@ARGV) == 0) {
    print `grep -E "^#:#" $0 | cut -b3-`;
    exit;
}
my $asel = "0-9a-zA-Z"; # select all possible TAB codes
while (scalar(@ARGV) > 0 and ($ARGV[0] =~ m{\A[\-\+]})) {
    my $opt = shift(@ARGV);
    if (0) {
    } elsif ($opt  =~ m{d}) {
        $debug     = shift(@ARGV);
    } elsif ($opt  =~ m{a}) {
        $asel      = shift(@ARGV);
    } else {
        die "invalid option \"$opt\"\n";
    }
} # while $opt
my $offset = 0;
my ($opt, $base, @ans, $callcode, $expr, $aseqno, $rseqno, $var);
my @anum = qw (
  ZERO
  ONE
  TWO
  THREE
  FOUR
  FIVE
  SIX
  SEVEN
  EIGHT
  NINE
  TEN
  );
my %hash = ();
while (<DATA>) {
    my $line = $_;
    $line =~ s/\s+\Z//; # chompr
    if ($line =~ m{\A\=(\w)\=}) {
        $opt = $1;
        # print "opt=$opt\n";
        if ($opt !~ m{[$asel]}) {
            # print "# no desired opt code $opt, ignore\n";
        } elsif ($opt eq "F") { # signum(#raise - #fall)
            ($opt, $base, @ans) = split(/\s+/, $line);
            $callcode = "basraifal";
            &outstd($ans[0], $base, 0);
            &outstd($ans[1], $base, 1);
            &outstd($ans[2], $base,-1);
        } elsif ($opt eq "G") { # signum(#pits - #peaks)
            ($opt, $base, @ans) = split(/\s+/, $line);
            $callcode = "baspitpeak";
            &outstd($ans[0], $base, 0);
            &outstd($ans[1], $base, 1);
            &outstd($ans[2], $base,-1);
        } elsif ($opt eq "H") { # pieces
            ($opt, $base, @ans) = split(/\s+/, $line);
            $callcode = "baspiece";
            &outstd($ans[0], $base);
        } elsif ($opt eq "I") { # zigzag up, down or none
            ($opt, $base, @ans) = split(/\s+/, $line);
            $callcode = "baszigzag";
            &outstd($ans[0], $base, 1);
            &outstd($ans[1], $base,-1);
            &outstd($ans[2], $base, 0);
        } elsif ($opt eq "J") { # distinct run lengths
            ($opt, $base, @ans) = split(/\s+/, $line);
            # $ans[0] = A043*, already done
            $callcode = "basrundist";
            &outstd($ans[1], $base);
        } elsif ($opt eq "K") { # =K=	A190427	[(bn+c)r]-b[nr]-[cr]	phi,2,1
            # A190775	null	[(bn+c)r]-b[nr]-[cr], where (r,b,c)=(sqrt(1/2),3,2) and [ ]=floor.	nonn,synth	132
            ($opt, $ans[0], $base, $expr) = split(/\t+/, $line);
            $callcode = "floor";
            my @vars = qw(mR mB mC);
            my $parm1 = "mR.multiply(mB.multiply(mN).add(mC)).floor().subtract(mR.multiply(mN).floor().multiply(mB)).subtract(mR.multiply(mC).floor())";
            $expr =~ m{([^\,]+)\,([^\,]+)\,([^\,]+)};
            my @list = ($1, $2, $3);
            # print "#1 " . join("|", @list) . "\n";
            my $parm2 = "~~  ";
            for (my $ipart = 0; $ipart < 3; $ipart ++) {
                my $part = $list[$ipart];
                $part =~ s{phi}{PHI}g;
                $part =~ s{1\/2}{HALF}g;
                # print "#2 $part\n";
                $part =~ s{(\d)}{"$anum[$1]"}eg;
                $part =~ s{sqrt\(([^\)]+)\)}{$1\.sqrt\(\)}g;
                # print "#3 $part\n";
                if ($ipart == 0) {
                    $parm2 .= "~~final CR $vars[$ipart] = CR.$part;"
                } else {
                    $parm2 .= "~~final Z $vars[$ipart] = Z.$part;"
                }
            } # for $ipart
            &outstd($ans[0], $parm1, $parm2);
        } elsif ($opt eq "L") {
            # nyi
        } elsif ($opt eq "M") { # superclass A194285
            my ($r, @rest);
            $rseqno   = "A194285";
            $callcode = "parm3";
            ($opt, $r, $var, $aseqno, @rest) = split(/[\s\.]+/, $line);
            $r = &crify($r);
            $var =~ s{\An\Z}{1};
            $var =~ s{\A2\*?n\Z}{2};
            $var =~ s{\An\^2\Z}{3};
            $var =~ s{\A2\^n\Z}{4};
            &outstd($aseqno, $rseqno, $var, $r);
        } elsif ($opt eq "N") { # superclass A208509
            # u(1,x)=1 and u(2,x)=a+b+c: u(n,x) = (a+e)u(n-1,x) + (bd-ae)u(n-2,x) + bf-ce+c.
            # v(1,x)=1 and v(2,x)=d+e+f: v(n,x) = (a+e)v(n-1,x) + (bd-ae)v(n-2,x) + cd-af+f.
            #                   a    	b    	c    	d    	e    	f    		code
            # =N=   A034839 u   1       1       0       1       x       0           CCOT
            my ($oa, $ob, $oc, $od, $oe, $of);
            my ($a, $b, $c, $d, $e, $f);
            my ($uv, @rest);
            $var = 1;
            ($opt, $aseqno, $uv, $oa, $ob, $oc, $od, $oe, $of, @rest) = split(/[\s\.]+/, $line);
            ($opt, $aseqno, $uv, $a , $b , $c , $d , $e , $f , @rest) = map {
                if (0) { #   1---1  2---------2
                } elsif (s{\A(\d+)?x([\+\-]\d+)?\Z}   {($2 || "0") . ", " . ($1 || "1")}e  ) {
                #            1---1     2---------2
                } elsif (s{\A(\d+)?x\+n([\+\-]\d+)?\Z}{($2 || "0") . ", " . ($1 || "1")}e  ) {
                    $var = 2;
                } elsif (s{\Ax\Z}{0,1}                                                     ) {
                } elsif (s{\A\-x\Z}{0,-1}                                                  ) {
                } else { # leave single [\+\-]\d+
                }
                s{\A0 *\+ *}{};
                s{\+}{}g;
                $_
                } split(/[\s\.]+/, $line);
            if (! defined($hash{$aseqno})) {
                $hash{$aseqno} = 1;
                $callcode = "uvpolx";
                my $rseqno = ($uv eq "u") ? "A208508" : "A208509";
                &outstd($aseqno, $rseqno, $var
                    , join(", ", map { "Polynomial.create($_)" } ($a, $b, $c, $d, $e, $f))
                    , "$oa,$ob,$oc,$od,$oe,$of");
            } else {
                print STDERR "# duplicate $line\n;"
            }
        } elsif ($opt eq "O") { # superclass A194368 etc.
            #     r..........p/q....s(m)<0....s(m)=0....[[m/q]]...s(m)>0
            #=O=  sqrt(2)....1/2....(empty)...A194368...A194369...A194370
            my ($r, $c);
            ($opt, $r, $c, @ans) = split(/[\s\.]+/, $line);
            @ans = map { (m{\AA\d+\Z}) ? $_ : "nnnn" } @ans;
            $r = &crify($r);
            $c = &crify($c);
            #=O=    tau.....   <tau>/2...A194461...(none)....(none)....A194462
            #=O=    tau.....   c...      A194463...(none)....(none)....A194464
            #=O=    sqrt(2)....1/r....   A194465...(none)....(none)....A194466
            #=O=    sqrt(3)....1/r....   A194467...(none)....(none)....A194468
            for (my $ians = 0; $ians < scalar(@ans); $ians ++) {
                $aseqno = $ans[$ians];
                if ($aseqno ne "nnnn") {
                    if (0) {
                    } elsif ($ians == 2) {
                        $rseqno   = $ans[$ians - 1];
                        $callcode = "dersimple";
                        outstd($aseqno, $rseqno
                            , ($c =~ m{HALF}) ? ".divide2()" : ".divide\(Z\.THREE\)"
                            );
                    } else {
                        $rseqno   = "A194368";
                        $callcode = "parm4";
                        outstd($ans[$ians], $rseqno, $ians + 1, $r, $c);
                    }
                } # if valid
            } # for $ians
        } elsif ($opt =~ m{[PQ]}) { # morphisms
            my ($morph);
            ($opt, $morph, @ans) = split(/\t/, $line);
            &out($ans[0], "morfps", "0", "anchor", $morph);
            &out($ans[1], "posins", $ans[0], 1, "0");
            &out($ans[2], "posins", $ans[0], 1, "1");
            if (0) {
            } elsif ($opt eq "P") {
                &out($ans[3], "posins", $ans[0], 1, "2");
            } elsif ($opt eq "P") {
                &out($ans[3], "partsum", "parm1", "parm2", "new $ans[0]()");
            }
        } elsif ($opt =~ m{R}) { # A297330 - down/up/total variation
            ($opt, $base, @ans) = split(/[\s\.]+/, $line);
            @ans = map { ($_ =~ m{\AA\d+\Z}) ? $_ : "nnnn" } @ans;
            &out($ans[0], "basvardut", $base, "getDownVariation" , "");
            &out($ans[1], "basvardut", $base, "getUpVariation"   , "");
            &out($ans[2], "basvardut", $base, "getTotalVariation", "");
        } elsif ($opt =~ m{S}) { # A297330 - compare down/up/total variations
            ($opt, $base, @ans) = split(/[\s\.]+/, $line);
            @ans = map { (m{\AA\d+\Z}) ? $_ : "nnnn" } @ans;
            &out($ans[0], "basvarsig", $base, -1     , "");
            &out($ans[1], "basvarsig", $base,  0     , "");
            &out($ans[2], "basvarsig", $base, +1     , "");
        } else { # unknown -a
        }
    } # line with =opt=
} # while <DATA>
#----
sub out {
    my ($aseqno, $callcode, $parm1, $parm2, $parm3) = @_;
    if ($aseqno ne "nnnn") {
        print join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $parm3) . "\n";
    }
} # out
#----
sub outstd {
    my ($aseqno, @parms) = @_;
    print join("\t", $aseqno, $callcode, $offset, @parms) . "\n";
} # outstd
#----
sub crify {
    my ($r) = @_;
    $r =~ s{pi}{CR\.PI}ig;
    $r =~ s{e}{CR\.E}g;
    $r =~ s{\(\-1\+sqrt\(3\)\/2}{\(CR\.THREE\.sqrt\(\)\.subtract\(CR\.ONE\)\.divide\(CR.TWO\)}g;
    $r =~ s{\<tau\>\/2}{CR\.PHI\.frac\(\)\.divide\(CR\.TWO\)}g;
    $r =~ s{\<tau\/2\>}{CR\.PHI\.divide\(CR\.TWO\)\.frac\(\)}g;
    $r =~ s{tau}{phi}g;
    $r =~ s{phi}{CR\.PHI}g;
    $r =~ s{1\/2}{CR\.HALF}g;
    $r =~ s{1\/3}{CR\.ONE_THIRD}g;
    $r =~ s{1\/r}{mR\.inverse\(\)}g;
    $r =~ s{\(\-1}{\(CR\.ONE\.negate\(\)}g;
    $r =~ s{sqrt\(([^\)]+)\)}{$1\.sqrt\(\)}g;
    $r =~ s{(\d+)}{($1 > 10) ? "CR\.valueOf\($1\)" : "CR\.$anum[$1]"}eg;
    $r =~ s{\/(.*)}{\.divide\($1\)}g;
    $r =~ s{\-(.+)}{\.subtract\($1\)};
    return $r;
} # cify
#--------
__DATA__
#--------------------------------
A296712		Numbers n whose base-10 digits d(m), d(m-1), ..., d(0) have #(rises) = #(falls); see Comments.		116
1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88, 99, 101, 102, 103, 104, 105, 106, 107, 108, 109, 111, 120, 121, 130, 131, 132, 140, 141, 142, 143, 150, 151, 152, 153, 154, 160, 161, 162, 163, 164, 165, 170, 171, 172, 173, 174, 175, 176, 180, 181 (list; graph; refs; listen; history; edit; text; internal format)
A rise is an index i such that d(i) < d(i+1); a fall is an index i such that d(i) > d(i+1).
The sequences A296712-A296714 partition the natural numbers.
***A296712
Base   #(rises) = #(falls)   #(rises) > #(falls)   #(rises) < #(falls)
    b      =       >       <
=F=	2 	A005408	nnnn 	A005843
=F=	3 	A296691	A296692	A296693
=F=	4 	A296694	A296695	A296696
=F=	5 	A296697	A296698	A296699
=F=	6 	A296700	A296701	A296702
=F=	7 	A296703	A296704	A296705
=F=	8 	A296706	A296707	A296708
=F=	9 	A296709	A296710	A296711
=F=	10	A296712	A296713	A296714
=F=	11	A296744	A296745	A296746
=F=	12	A296747	A296748	A296749
=F=	13	A296750	A296751	A296752
=F=	14	A296753	A296754	A296755
=F=	15	A296756	A296757	A296758
=F=	16	A296759	A296760	A296761
=F=	20	A296762	A296763	A296764
=F=	60	A296765	A296766	A296767
#--------------------------------
A296882		Numbers n whose base-10 digits d(m), d(m-1), ..., d(0) have #(pits) = #(peaks); see Comments.		68
1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67 (list; graph; refs; listen; history; edit; text; internal format)
A pit is an index i such that d(i-1) > d(i) < d(i+1); a peak is an index i such that d(i-1) < d(i) > d(i+1).
The sequences A296882-A296883 partition the natural numbers.
See the guides at A296712.  We have a(n) = A000027(n) for n=1..100 but not n=101.
Base   #(rises) = #(falls)   #(rises) > #(falls)   #(rises) < #(falls)
=G=	2            A296858             A296859               A296860
=G=	3            A296861             A296862               A296863
=G=	4            A296864             A296865               A296866
=G=	5            A296867             A296868               A296869
=G=	6            A296870             A296871               A296872
=G=	7            A296873             A296874               A296875
=G=	8            A296876             A296877               A296878
=G=	9            A296879             A296880               A296881
=G=	10           A296882             A296883               A296884
=G=	11           A296885             A296886               A296887
=G=	12           A296888             A296889               A296890
=G=	13           A296891             A296892               A296893
=G=	14           A296894             A296895               A296896
=G=	15           A296897             A296898               A296899
=G=	16           A296900             A296901               A296902
=G=	20           A296903             A296904               A296905
=G=	60           A296906             A296907               A296908
#--------------------------------
A297030		Number of pieces in the list d(m),d(m-1),...,d(0) of base-2 digits of n; see Comments		17
0, 1, 1, 2, 2, 2, 1, 2, 3, 3, 3, 3, 3, 2, 1, 2, 3, 4, 4, 4, 4, 4, 3, 3, 4, 4, 4, 3, 3, 2, 1, 2, 3, 4, 4, 5, 5, 5, 4, 4, 5, 5, 5, 5, 5, 4, 3, 3, 4, 5, 5, 5, 5, 5, 4, 3, 4, 4, 4, 3, 3, 2, 1, 2, 3, 4, 4, 5, 5, 5, 4, 5, 6, 6, 6, 6, 6, 5, 4, 4, 5, 6, 6, 6, 6, 6 (list; graph; refs; listen; history; edit; text; internal format)
The definition of "piece" starts with the base-b digits d(m), d(m-1), ..., d(0) of n.
First, an *ascent* is a list (d(i),d(i-1),...,d(i-h)) such that d(i)<d(i-1)<...<d(i-h), where d(i+1)>=d(i) if i<m, and d(i-h-1)>=d(i-h) if i>h.
A *descent* is a list (d(i),d(i-1),...,d(i-h)) such that d(i)>d(i-1)>...>d(i-h), where d(i+1)<=d(i) if i<m, and d(i-h-1)<=d(i-h) if i>h.
A *flat* is a list (d(i),d(i-1),...,d(i-h)), where h>0, such that d(i)=d(i-1)=...=d(i-h), where d(i+1)!=d(i) if i<m, and d(i-h-1)!=d(i-h) if i>h.
A *piece* is an ascent, a descent, or a flat.
Example:  235621103 has five pieces:  (2,3,5,6), (6,2,1), (1,1), (1,0), and (0,3); that's 2 ascents, 2 descents, and 1 flat.
For every b, the "piece sequence" includes every positive integer infinitely many times.
Guide to related sequences:
***A297030
Base   # pieces for n>=1
=H=	2         A297030
=H=	3         A297031
=H=	4         A297032
=H=	5         A297033
=H=	6         A297034
=H=	7         A297035
=H=	8         A297036
=H=	9         A297037
=H=	10        A297038
=H=	11        A297039
=H=	12        A297040
=H=	13        A297041
=H=	14        A297042
=H=	15        A297043
=H=	16        A297044
=H=	20        A297045
=H=	60        A297046
#--------------------------------
A297146		Numbers having an up-first zigzag pattern in base 10; see Comments.		17
12, 13, 14, 15, 16, 17, 18, 19, 23, 24, 25, 26, 27, 28, 29, 34, 35,
A number n having base-b digits d(m), d(m-1),..., d(0) such that d(i) != d(i+1) for 0 <= i < m shows a zigzag pattern of one or more segments, in the following sense.
Writing U for up and D for down, there are two kinds of patterns:  U, UD, UDU, UDUD, ... and D, DU, DUD, DUDU, ... .
In the former case, we say n has an "up-first zigzag pattern in base b"; in the latter, a "down-first zigzag pattern in base b".
Example:  2,4,5,3,0,1,4,2 has segments 2,4,5; 5,3,0; 0,1,4; and 4,2, so that 24530142, with pattern UDUD, has an up-first zigzag pattern in base 10,
whereas 4,2,5,3,0,1,4,2 has a down-first pattern.
The sequences A297146-A297148 partition the natural numbers.
In the following guide, column four, "complement" means the sequence of natural numbers not in the corresponding sequences in columns 2 and 3.
***A297146
Base          up-first    down-first  complement
=I=	2           (none)     A000975     A107907
=I=	3          A297124     A297125     A297126
=I=	4          A297128     A297129     A297130
=I=	5          A297131     A297132     A297133
=I=	6          A297134     A297135     A297136
=I=	7          A297137     A297138     A297139
=I=	8          A297140     A297141     A297142
=I=	9          A297143     A297144     A297145
=I=	10         A297146     A297147     A297148
#--------------------------------
A297770		Number of distinct runs in base-2 digits of n.		29
1, 2, 1, 2, 2, 2, 1, 2, 2, 2, 3, 2, 3, 2, 1, 2, 2, 3, 3, 3, 2, 3, 3, 2, 3, 3, 2, 2, 3, 2, 1, 2, 2, 3, 3, 2, 3, 4, 3, 3, 3, 2, 3, 4, 3, 3, 3, 2, 3, 4, 2, 4, 3, 2, 3, 2, 3, 3, 3, 2, 3, 2, 1, 2, 2, 3, 3, 3, 3, 4, 3, 3, 2, 3, 4, 3, 4, 4, 3, 3, 3, 3, 4, 3, 2, 3 (list; graph; refs; listen; history; edit; text; internal format)
OFFSET
1,2
COMMENTS
Every positive integers occurs infinitely many times.
***A297770
Guide to related sequences:
Base b      # runs    # distinct runs
=J=	   2        A005811       A297770
=J=	   3        A043555       A297771
=J=	   4        A043556       A297772
=J=	   5        A043557       A297773
=J=	   6        A043558       A297774
=J=	   7        A043559       A297775
=J=	   8        A043560       A297776
=J=	   9        A043561       A297777
=J=	  10        A043562       A297778
=J=	  11        A043563       A297779
=J=	  12        A043564       A297780
=J=	  13        A043565       A297781
=J=	  14        A043566       A297782
=J=	  15        A043567       A297783
=J=	  16        A043568       A297784
#--------------------------------
# Caution, this list is generated by the target "bnr" in internal/fischer/ck/makefile
=K=	A190427	[(bn+c)r]-b[nr]-[cr]	phi,2,1
=K=	A190431	[(bn+c)r]-b[nr]-[cr]	phi,3,1
=K=	A190436	[(bn+c)r]-b[nr]-[cr]	phi,3,2
=K=	A190440	[(bn+c)r]-b[nr]-[cr]	phi,4,0
=K=	A190445	[(bn+c)r]-b[nr]-[cr]	phi,4,1
=K=	A190451	[(bn+c)r]-b[nr]-[cr]	phi,4,2
=K=	A190457	[(bn+c)r]-b[nr]-[cr]	phi,4,3
=K=	A190483	[(bn+c)r]-b[nr]-[cr]	sqrt(2),2,1
=K=	A190487	[(bn+c)r]-b[nr]-[cr]	sqrt(2),3,0
=K=	A190491	[(bn+c)r]-b[nr]-[cr]	sqrt(2),3,1
=K=	A190496	[(bn+c)r]-b[nr]-[cr]	sqrt(2),3,2
=K=	A190544	[(bn+c)r]-b[nr]-[cr]	sqrt(2),4,0
=K=	A190549	[(bn+c)r]-b[nr]-[cr]	sqrt(2),4,1
=K=	A190555	[(bn+c)r]-b[nr]-[cr]	sqrt(2),4,2
=K=	A190561	[(bn+c)r]-b[nr]-[cr]	sqrt(2),4,3
=K=	A190669	[(bn+c)r]-b[nr]-[cr]	sqrt(3),2,0
=K=	A190672	[(bn+c)r]-b[nr]-[cr]	sqrt(3),2,1
=K=	A190676	[(bn+c)r]-b[nr]-[cr]	sqrt(3),3,0
=K=	A190683	[(bn+c)r]-b[nr]-[cr]	sqrt(3),3,1
=K=	A190688	[(bn+c)r]-b[nr]-[cr]	sqrt(3),3,2
=K=	A190693	[(bn+c)r]-b[nr]-[cr]	sqrt(3),4,0
=K=	A190698	[(bn+c)r]-b[nr]-[cr]	sqrt(3),4,1
=K=	A190704	[(bn+c)r]-b[nr]-[cr]	sqrt(3),4,2
=K=	A190710	[(bn+c)r]-b[nr]-[cr]	sqrt(3),4,3
=K=	A190762	[(bn+c)r]-b[nr]-[cr]	sqrt(1/2),2,1
=K=	A190766	[(bn+c)r]-b[nr]-[cr]	sqrt(1/2),3,0
=K=	A190770	[(bn+c)r]-b[nr]-[cr]	sqrt(1/2),3,1
=K=	A190775	[(bn+c)r]-b[nr]-[cr]	sqrt(1/2),3,2
#--------------------------------
Let s(n)=F(n+1), where F=A000045 (Fibonacci numbers), so that s=(1,2,3,5,8,13,21,...).
If c is a positive integer, there are infinitely many pairs (k,j) such that c divides s(k)-s(j).
The set of differences s(k)-s(j) is ordered as a sequence at A204922.
Guide to related sequences:
=L=	c	k......	j.....s(k)-s(j).[s(k)-s(j)]/c
=L=	2	A205837	A205838	A205839	A205840
=L=	3	A205842	A205843	A205844	A205845
=L=	4	A205847	A205848	A205849	A205850
=L=	5	A205852	A205853	A205854	A205855
=L=	6	A205857	A205858	A205859	A205860
=L=	7	A205862	A205863	A205864	A205865
=L=	8	A205867	A205868	A205869	A205870
=L=	9	A205872	A205873	A205874	A205875
=L=	10	A205877	A205878	A205879	A205880
#--------------------------------
# A194285 Triangular array:  g(n,k)=number of fractional parts (i*sqrt(2)) 
  in interval [(k-1)/n, k/n], for 1<=i<=n, 1<=k<=n.
Row n of A194285 counts fractional parts (i*r), for i=1,2,...,n, in each of the intervals indicated.  
It is of interest to count (i*r) for i=1,2,...,s(n) for various choices of s(n), such as 2n, n^2, and 2^n.  
In each case, (n-th row sum)=s(n).  Examples:

    r.................s(n)....g(n,k)
=M=	sqrt(2)...........n.......A194285
=M=	sqrt(2)...........2n......A194286
=M=	sqrt(2)...........n^2.....A194287
=M=	sqrt(2)...........2^n.....A194288
=M=	sqrt(3)...........n.......A194289
=M=	sqrt(3)...........2n......A194290
=M=	sqrt(3)...........n^2.....A194291
=M=	sqrt(3)...........2^n.....A194292
=M=	tau...............n.......A194293  tau=(1+sqrt(5))/2
=M=	tau...............2n......A194294
=M=	tau...............n^2.....A194295
=M=	tau...............2^n.....A194296
=M=	(-1+sqrt(3))/2....n.......A194297
=M=	(-1+sqrt(3))/2....2n......A194298
=M=	(-1+sqrt(3))/2....n^2.....A194299
=M=	(-1+sqrt(3))/2....2^n.....A194300
=M=	sqrt(5)...........n.......A194301
=M=	sqrt(5)...........2n......A194302
=M=	sqrt(5)...........n^2.....A194303
=M=	sqrt(5)...........2^n.....A194304
=M=	pi................n.......A194305
=M=	pi................2n......A194306
=M=	pi................n^2.....A194307
=M=	pi................2^n.....A194308
=M=	e.................n.......A194309
=M=	e.................2n......A194310
=M=	e.................n^2.....A194311
=M=	e.................2^n.....A194312
=M=	sqrt(6)...........n.......A194313
=M=	sqrt(6)...........2n......A194314
=M=	sqrt(6)...........n^2.....A194315
=M=	sqrt(6)...........2^n.....A194316
=M=	sqrt(8)...........n.......A194317
=M=	sqrt(8)...........2n......A194318
=M=	sqrt(8)...........n^2.....A194319
=M=	sqrt(8)...........2^n.....A194320
=M=	sqrt(1/2).........n.......A194321
=M=	sqrt(1/2).........2n......A194322
=M=	sqrt(1/2).........n^2.....A194323
=M=	sqrt(1/2).........2^n.....A194324
=M=	2-sqrt(2).........n.......A194325
=M=	2-sqrt(2).........2n......A194326
=M=	2-sqrt(2).........n^2.....A194327
=M=	2-sqrt(2).........2^n.....A194328
=M=	2-sqrt(3).........n.......A194329
=M=	2-sqrt(3).........2n......A194330
=M=	2-sqrt(3).........n^2.....A194331
=M=	2-sqrt(3).........2^n.....A194332
=M=	2-tau.............n.......A194333
=M=	2-tau.............2n......A194334
=M=	2-tau.............n^2.....A194335
=M=	2-tau.............2^n.....A194336
=M=	3-sqrt(5).........n.......A194337
=M=	3-sqrt(5).........2n......A194338
=M=	3-sqrt(5).........n^2.....A194339
=M=	3-sqrt(5).........2^n.....A194340
=M=	3-e...............n.......A194341
=M=	3-e...............2n......A194342
=M=	3-e...............n^2.....A194343
=M=	3-e...............2^n.....A194344
#--------------------------------
.........     a....b....c....d....e....f....code
=N=	A034839 u 1....1....0....1....x....0....CCOT
=N=	A034867 v 1....1....0....1....x....0....CEN
=N=	A210221 u 1....1....0....1....2x...0....BBFF
=N=	A210596 v 1....1....0....1....2x...0....BBFF
=N=	A105070 v 1....2x...0....1....1 ...0....BN      was b=1,d=2x
=N=	A207605 u 1....1....0....1....x+1..0....BCFFN
=N=	A106195 v 1....1....0....1....x+1..0....BCFFN
=N=	A207606 u 1....1....0....x....x+1..0....DNT
=N=	A207607 v 1....1....0....x....x+1..0....DNT
=N=	A207608 u 1....1....0....2x...x+1..0....N
=N=	A207609 v 1....1....0....2x...x+1..0....C
=N=	A207610 u 1....1....0....1....x....1....CF
=N=	A207611 v 1....1....0....1....x....1....BCF
=N=	A207612 u 1....1....0....1....2x...1....BF
=N=	A207613 v 1....1....0....1....2x...1....BF
=N=	A207614 u 1....1....0....1....x+1..1....CN
=N=	A207615 v 1....1....0....1....x+1..1....CFN
=N=	A207616 u 1....1....0....x....1....1....CE
=N=	A207617 v 1....1....0....x....1....1....CNO
=N=	A029638 u 1....1....0....x....x....1....CDNO
=N=	A029635 v 1....1....0....x....x....1....CDNOZ   was A207635
=N=	A207618 u 1....1....0....x....2x...1....N
=N=	A207619 v 1....1....0....x....2x...1....CFN
=N=	A207620 u 1....1....0....x....x+1..1....DET
=N=	A207621 v 1....1....0....x....x+1..1....DNO
=N=	A207622 u 1....1....0....2x...1....1....BT
=N=	A207623 v 1....1....0....2x...1....1....BN
=N=	A207624 u 1....1....0....2x...x....1....N
=N=	A102662 v 1....1....0....2x...x....1....CO
=N=	A207625 u 1....1....0....2x...x+1..1....T
=N=	A207626 v 1....1....0....2x...x+1..1....N
=N=	A207627 u 1....1....0....2x...2x...1....BN
=N=	A207628 v 1....1....0....2x...2x...1....BCE
=N=	A207629 u 1....1....0....x+1..1....1....CET
=N=	A207630 v 1....1....0....x+1..1....1....CO
=N=	A207631 u 1....1....0....x+1..x....1....DF
=N=	A207632 v 1....1....0....x+1..x....1....DEF
=N=	A207633 u 1....1....0....x+1..2x...1....F
=N=	A207634 v 1....1....0....x+1..2x...1....F
=N=	A207635 u 1....1....0....x+1..x+1..1....DN
=N=	A207636 v 1....1....0....x+1..x+1..1....CD
=N=	A160232 u 1....x....0....1....2x...0....BCFN
=N=	A208341 v 1....x....0....1....2x...0....BCFFN
=N=	A085478 u 1....x....0....1....x+1..0....CCOFT*
=N=	A078812 v 1....x....0....1....x+1..0....CEFN*
=N=	A208342 u 1....x....0....x....x....0....CCFNO
=N=	A208343 v 1....x....0....x....x....0....BBCDFZ
=N=	A208344 u 1....x....0....x....2x...0....CCFN
=N=	A208345 v 1....x....0....x....2x...0....CFZ
=N=	A094436 u 1....x....0....x....x+1..0....CFFN
=N=	A094437 v 1....x....0....x....x+1..0....CEFF
=N=	A117919 u 1....x....0....2x...1....0....BCNT
=N=	A135837 v 1....x....0....2x...1....0....BCET
=N=	A208328 u 1....x....0....2x...x....0....CCOP
=N=	A208329 v 1....x....0....2x...x....0....DPZ
=N=	A208330 u 1....x....0....2x...x+1..0....CNPT
=N=	A208331 v 1....x....0....2x...x+1..0....CN
=N=	A208332 u 1....x....0....2x...2x...0....CCE
=N=	A208333 v 1....x....0....2x...2x...0....DZ
=N=	A208334 u 1....x....0....x+1..1....0....CCNT
=N=	A208335 v 1....x....0....x+1..1....0....CCN*
=N=	A208336 u 1....x....0....x+1..x....0....CFNT*
=N=	A208337 v 1....x....0....x+1..x....0....ACFN*
=N=	A208338 u 1....x....0....x+1..2x...0....CNP
=N=	A208339 v 1....x....0....x+1..2x...0....BCNP
=N=	A202390 u 1....x....0....x+1..x+1..0....CFPTZ*
=N=	A208340 v 1....x....0....x+1..x+1..0....FNPZ*
=N=	A208508 u 1....x....0....1....1....1....CCES
=N=	A208509 v 1....x....0....1....1....1....BCO
=N=	A208510 u 1....x....0....1....x....1....CCCNOS*
=N=	A029653 v 1....x....0....1....x....1....BCDOSZ*
=N=	A208511 u 1....x....0....1....2x...1....BCFO
=N=	A208512 v 1....x....0....1....2x...1....BDFO
=N=	A208513 u 1....x....0....1....x+1..1....CCES*
=N=	A111125 v 1....x....0....1....x+1..1....COO*
=N=	A133567 u 1....x....0....x....1....1....CCOTT
=N=	A133084 v 1....x....0....x....1....1....BBCEN
=N=	A208514 u 1....x....0....x....x....1....CEFN
=N=	A208515 v 1....x....0....x....x....1....BCDFN
=N=	A208516 u 1....x....0....x....2x...1....CNN
=N=	A208517 v 1....x....0....x....2x...1....CCN
=N=	A208518 u 1....x....0....x....x+1..1....CFNT
=N=	A208519 v 1....x....0....x....x+1..1....NFFT
=N=	A208520 u 1....x....0....2x...1....1....BCTT
=N=	A208521 v 1....x....0....2x...1....1....BEN      was u
=N=	A208522 u 1....x....0....2x...x....1....CCN
=N=	A208523 v 1....x....0....2x...x....1....CCO
=N=	A208524 u 1....x....0....2x...x+1..1....CT*
=N=	A208525 v 1....x....0....2x...x+1..1....ACNP*
=N=	A208526 u 1....x....0....2x...2x...1....CEN
=N=	A208527 v 1....x....0....2x...2x...1....CCE
=N=	A208606 u 1....x....0....x+1..1....1....CCS
=N=	A208607 v 1....x....0....x+1..1....1....CNO
=N=	A208608 u 1....x....0....x+1..x....1....CFOT
=N=	A208609 v 1....x....0....x+1..x....1....DEN*
=N=	A208610 u 1....x....0....x+1..2x...1....CO
=N=	A208611 v 1....x....0....x+1..2x...1....DE
=N=	A208612 u 1....x....0....x+1..x+1..1....CFNS
=N=	A208613 v 1....x....0....x+1..x+1..1....CFN*
=N=	A105070 u 1....2x...0....1....1....0....BN
=N=	A207536 u 1....2x...0....1....1....0....BCT     was v
=N=	A208751 u 1....2x...0....1....x+1..0....CDPT
=N=	A208752 v 1....2x...0....1....x+1..0....CNP
=N=	A135837 u 1....2x...0....x....1....0....BCNT
=N=	A117919 v 1....2x...0....x....1....0....BCNT
=N=	A208755 u 1....2x...0....x....x....0....BCDEP
=N=	A208756 v 1....2x...0....x....x....0....BCCOZ
=N=	A208757 u 1....2x...0....x....2x...0....CDEP
=N=	A208758 v 1....2x...0....x....2x...0....CCEPZ
=N=	A208763 u 1....2x...0....2x...x....0....CDOP
=N=	A208764 v 1....2x...0....2x...x....0....CCCP
=N=	A208765 u 1....2x...0....2x...x+1..0....CE
=N=	A208766 v 1....2x...0....2x...x+1..0....CC
=N=	A208747 u 1....2x...0....2x...2x...0....CDE
=N=	A208748 v 1....2x...0....2x...2x...0....CCZ
=N=	A208749 u 1....2x...0....x+1..1....0....BCOPT
=N=	A208750 v 1....2x...0....x+1..1....0....BCNP*
=N=	A208759 u 1....2x...0....x+1..2x....0...CE
=N=	A208760 v 1....2x...0....x+1..2x....0...BCO
=N=	A208761 u 1....2x...0....x+1..x+1...0...BCCT*
=N=	A208762 v 1....2x...0....x+1..x+1...0...BNZ*
=N=	A208753 u 1....2x...0....1....1.....1...BCS
=N=	A208754 v 1....2x...0....1....1.....1...BO
=N=	A105045 u 1....2x...0....1....2x....1...BCCOS*
=N=	A208659 v 1....2x...0....1....2x....1...BDOSZ*
=N=	A208660 u 1....2x...0....1....x+1...1...CDS
=N=	A208904 v 1....2x...0....1....x+1...1...CNO
=N=	A208905 u 1....2x...0....x....1.....1...BCT
=N=	A208906 v 1....2x...0....x....1.....1...BNN
=N=	A208907 u 1....2x...0....x....x.....1...BCN
=N=	A208756 v 1....2x...0....x....x.....1...BCCE
=N=	A208755 u 1....2x...0....x....2x....1...CEN
=N=	A208910 v 1....2x...0....x....2x....1...CCE
=N=	A208911 u 1....2x...0....x....x+1...1...BCT
=N=	A208912 v 1....2x...0....x....x+1...1...BNT
=N=	A208913 u 1....2x...0....2x...1.....1...BCT
=N=	A208914 v 1....2x...0....2x...1.....1...BEN
=N=	A208915 u 1....2x...0....2x...x.....1...CE
=N=	A208916 v 1....2x...0....2x...x.....1...CCO
=N=	A208919 u 1....2x...0....2x...x+1...1...CT
=N=	A208920 v 1....2x...0....2x...x+1...1...N
=N=	A208917 u 1....2x...0....2x...2x....1...CEN     was e=2
=N=	A208918 v 1....2x...0....2x...2x....1...CCNP    was e=2
=N=	A208921 u 1....2x...0....x+1..1.....1...BC
=N=	A208922 v 1....2x...0....x+1..1.....1...BON
=N=	A208923 u 1....2x...0....x+1..x.....1...BCNO
=N=	A208908 v 1....2x...0....x+1..x.....1...BDN*
=N=	A208909 u 1....2x...0....x+1..2x....1...BN
=N=	A208930 v 1....2x...0....x+1..2x....1...DN
=N=	A208931 u 1....2x...0....x+1..x+1...1...BCOS
=N=	A208932 v 1....2x...0....x+1..x+1...1...BCO*
=N=	A207537 u 1....x+1..0....1....1.....0...BCO
=N=	A207538 v 1....x+1..0....1....1.....0...BCE
=N=	A122075 u 1....x+1..0....1....x.....0...CCFN*
=N=	A037027 v 1....x+1..0....1....x.....0...CCFN*
=N=	A209125 u 1....x+1..0....1....2x....0...BCFN*
=N=	A164975 v 1....x+1..0....1....2x....0...BF
=N=	A209126 u 1....x+1..0....x....x.....0...CDFO*
=N=	A209127 v 1....x+1..0....x....x.....0...DFOZ*
=N=	A209128 u 1....x+1..0....x....2x....0...CDE*
=N=	A209129 v 1....x+1..0....x....2x....0...DEZ
=N=	A102756 u 1....x+1..0....x....x+1...0...CFNP*
=N=	A209130 v 1....x+1..0....x....x+1...0...CCFNP*
=N=	A209131 u 1....x+1..0....2x...x  ...0...CDEP*   was d=x,e=x+1
=N=	A209132 v 1....x+1..0....2x...x  ...0...CNPZ*   was d=x,e=x+1
=N=	A209133 u 1....x+1..0....2x...2x ...0...CDN     was d=x,e=x+1
=N=	A209134 v 1....x+1..0....2x...2x ...0...CCN*    was d=x,e=x+1
=N=	A209135 u 1....x+1..0....2x...x+1...0...CN*
=N=	A209136 v 1....x+1..0....2x...x+1...0...CCS*
=N=	A209137 u 1....x+1..0....x+1..x.....0...CFFP*
=N=	A209138 v 1....x+1..0....x+1..x.....0...AFFP*
=N=	A209139 u 1....x+1..0....x+1..2x....0...CF*
=N=	A209140 v 1....x+1..0....x+1..2x....0...BF
=N=	A209141 u 1....x+1..0....x+1..x+1...0...BCF*
=N=	A209142 v 1....x+1..0....x+1..x+1...0...BFZ*
=N=	A209143 u 1....x+1..0....1....1.....1...CCE*
=N=	A209144 v 1....x+1..0....1....1.....1...COO*
=N=	A209145 u 1....x+1..0....1....x.....1...CCFN*
=N=	A122075 v 1....x+1..0....1....x.....1...CCFN*
=N=	A209146 u 1....x+1..0....1....2x....1...BCF*
=N=	A209147 v 1....x+1..0....1....2x....1...BF
=N=	A209148 u 1....x+1..0....1....x+1...1...CCO*
=N=	A209149 v 1....x+1..0....1....x+1...1...CDO*
=N=	A209150 u 1....x+1..0....x....1.....1...CCNT*
=N=	A208335 v 1....x+1..0....x....1.....1...CDNN*
=N=	A209151 u 1....x+1..0....x....x.....1...CFN*
=N=	A208337 v 1....x+1..0....x....x.....1...ACFN*
=N=	A209152 u 1....x+1..0....x....2x....1...CN*     was e=x
=N=	A208339 v 1....x+1..0....x....x.....1...BCN
=N=	A209153 u 1....x+1..0....x....x+1...1...CFT*    was e=x
=N=	A208340 v 1....x+1..0....x....x.....1...FNZ*    ? jointly with A209153 ?
=N=	A209154 u 1....x+1..0....2x...1.....1...BCT*
=N=	A209157 v 1....x+1..0....2x...1.....1...BNN
=N=	A209158 u 1....x+1..0....2x...x.....1...CN*
=N=	A209159 v 1....x+1..0....2x...x.....1...CO*
=N=	A209160 u 1....x+1..0....2x...2x....1...CN*
=N=	A209161 v 1....x+1..0....2x...2x....1...CE
=N=	A209162 u 1....x+1..0....2x...x+1...1...CT*
=N=	A209163 v 1....x+1..0....2x...x+1...1...CO*
=N=	A209164 u 1....x+1..0....x+1..1.....1...CC*
=N=	A209165 v 1....x+1..0....x+1..1.....1...CCN
=N=	A209166 u 1....x+1..0....x+1..x.....1...CFF*
=N=	A209167 v 1....x+1..0....x+1..x.....1...FF*
=N=	A209168 u 1....x+1..0....x+1..2x....1...CF*
=N=	A209169 v 1....x+1..0....x+1..2x....1...CF
=N=	A209170 u 1....x+1..0....x+1..x+1...1...CF*
=N=	A209171 v 1....x+1..0....x+1..x+1...1...CF*
=N=	A053538 u x....1....0....1....1.....0...BBCCFN
=N=	A076791 v x....1....0....1....1.....0...BBCDF
=N=	A209172 u x....1....0....1....2x....0...BCCFF
=N=	A209413 v x....1....0....1....2x....0...BCCFF
=N=	A094441 u x....1....0....1....x+1...0...CFFFN
=N=	A094442 v x....1....0....1....x+1...0...CEFFF
=N=	A054142 u x....1....0....x....x+1...0...CCFOT*
=N=	A172431 v x....1....0....x....x+1...0...CEFN*
=N=	A008288 u x....1....0....2x...1.....0...CCOO*
=N=	A035607 v x....1....0....2x...1.....0...ACDE*
=N=	A209414 u x....1....0....2x...x+1...0...CCS
=N=	A112351 v x....1....0....2x...x+1...0...CON
=N=	A209415 u x....1....0....x+1..x.....0...CCTN
=N=	A209416 v x....1....0....x+1..x.....0...ACN*
=N=	A209417 u x....1....0....x+1..2x....0...CC
=N=	A209418 v x....1....0....x+1..2x....0...BBC
=N=	A209419 u x....1....0....x+1..x+1...0...CFTZ*
=N=	A209420 v x....1....0....x+1..x+1...0...FNZ*
=N=	A209421 u x....1....0....1....1.....1...CCN
=N=	A209422 v x....1....0....1....1.....1...CD
=N=	A209555 u x....1....0....1....x.....1...CNN
=N=	A209556 v x....1....0....1....x.....1...CNN
=N=	A209557 u x....1....0....1....2x....1...BCN
=N=	A209558 v x....1....0....1....2x....1...BN
=N=	A209559 u x....1....0....1....x+1...1...CN
=N=	A209560 v x....1....0....1....x+1...1...CN      was e=2x
=N=	A209561 u x....1....0....x....1.....1...CCNNT*
=N=	A209562 v x....1....0....x....1.....1...CDNNT*
=N=	A209563 u x....1....0....x....x.....1...CCFT^
=N=	A209564 v x....1....0....x....x.....1...CFN^
=N=	A209565 u x....1....0....x....2x....1...CC^
=N=	A209566 v x....1....0....x....2x....1...BC^
=N=	A209567 u x....1....0....x....x+1...1...CNT*    was e=2x
=N=	A209568 v x....1....0....x....x+1...1...NNS*    was e=2x
=N=	A209569 u x....1....0....2x...1.....1...CNO*
=N=	A209570 v x....1....0....2x...1.....1...DNN*
=N=	A209571 u x....1....0....2x...x.....1...CCS^
=N=	A209572 v x....1....0....2x...x.....1...CN^
=N=	A209573 u x....1....0....2x...x+1...1...CNS
=N=	A209574 v x....1....0....2x...x+1...1...NO
=N=	A209575 u x....1....0....2x...2x....1...CC
=N=	A209576 v x....1....0....2x...2x....1...C
=N=	A209577 u x....1....0....x+1..1 ....1...CNNT     was d=2x,e=2x
=N=	A209578 v x....1....0....x+1..1 ....1...CNN      was d=2x,e=2x
=N=	A209579 u x....1....0....x+1..x.....1...CNNT
=N=	A209580 v x....1....0....x+1..x.....1...NN*
=N=	A209581 u x....1....0....x+1..2x....1...CN
=N=	A209582 v x....1....0....x+1..2x....1...BN
=N=	A209583 u x....1....0....x+1..x+1...1...CT*
=N=	A209584 v x....1....0....x+1..x+1...1...CN*
=N=	A121462 u x....x....0....x....x+1...0...BCFFNZ
=N=	A208341 v x....x....0....x....x+1...0...BCFFN
=N=	A209687 u x....x....0....2x...x+1...0...BCNZ
=N=	A208339 v x....x....0....2x...x+1...0...BCN
=N=	A115241 u x....x....0....1....1.....1...CDNZ*
=N=	A209688 v x....x....0....1....1.....1...DDN*     was A209668
=N=	A209689 u x....x....0....1....x.....1...FNZ^
=N=	A209690 v x....x....0....1....x.....1...FN^
=N=	A209691 u x....x....0....1....2x....1...BCZ^
=N=	A209692 v x....x....0....1....2x....1...BCC^
=N=	A209693 u x....x....0....1....x+1...1...NNZ*
=N=	A209694 v x....x....0....1....x+1...1...CN*
=N=	A209697 u x....x....0....x....x+1...1...BNZ
=N=	A209698 v x....x....0....x....x+1...1...BNT
=N=	A209699 u x....x....0....2x...1   ..1...BNNZ     was d=x,e=x+1
=N=	A209700 v x....x....0....2x...1  ...1...BDN      was d=x,e=x+1
=N=	A209701 u x....x....0....2x...x+1...1...NZ
=N=	A209702 v x....x....0....2x...x+1...1...N
=N=	A209703 u x....x....0....x+1..1.....1...FNTZ
=N=	A209704 v x....x....0....x+1..1.....1...FNNT
=N=	A209705 u x....x....0....x+1..x+1...1...BNZ*
=N=	A209706 v x....x....0....x+1..x+1...1...BCN*
=N=	A209695 u x....x+1..0....2x...x+1...0...ACN*
=N=	A209696 v x....x+1..0....2x...x+1...0...CDN*
=N=	A209830 u x....x+1..0....x+1..2x....0...ACF
=N=	A209831 v x....x+1..0....x+1..2x....0...BCF*
=N=	A209745 u x....x+1..0....x+1..x+1...0...ABF*
=N=	A209746 v x....x+1..0....x+1..x+1...0...BFZ*
=N=	A209747 u x....x+1..0....1....1.....1...ADE*
=N=	A209748 v x....x+1..0....1....1.....1...DEO
=N=	A209749 u x....x+1..0....1....x.....1...ANN*
=N=	A209750 v x....x+1..0....1....x.....1...CNO
=N=	A209751 u x....x+1..0....1....2x....1...ABN*
=N=	A209752 v x....x+1..0....1....2x....1...BN
=N=	A209753 u x....x+1..0....1....x+1...1...AN*
=N=	A209754 v x....x+1..0....1....x+1...1...NT*
=N=	A209755 u x....x+1..0....x....1.....1...AFN
=N=	A209756 v x....x+1..0....x....1.....1...FNO*
=N=	A209759 u x....x+1..0....x....2x....1...ACF^
=N=	A209760 v x....x+1..0....x....2x....1...CF^*
=N=	A209761 u x....x+1..0....x.....x+1..1...ABNS*
=N=	A209762 v x....x+1..0....x.....x+1..1...BNS*
=N=	A209763 u x....x+1..0....2x....1....1...ABN*
=N=	A209764 v x....x+1..0....2x....1....1...BNN
=N=	A209765 u x....x+1..0....2x....x....1...ACF^*
=N=	A209766 v x....x+1..0....2x....x....1...CF^
=N=	A209767 u x....x+1..0....2x....x+1..1...AN*
=N=	A209768 v x....x+1..0....2x....x+1..1...N*
=N=	A209769 u x....x+1..0....x+1...1....1...AF*
=N=	A209770 v x....x+1..0....x+1...1....1...FN
=N=	A209771 u x....x+1..0....x+1...x....1...ABN*
=N=	A209772 v x....x+1..0....x+1...x....1...BN*
=N=	A209773 u x....x+1..0....x+1...2x...1...AF
=N=	A209774 v x....x+1..0....x+1...2x...1...FN*
=N=	A209775 u x....x+1..0....x+1...x+1..1...AB*
=N=	A209776 v x....x+1..0....x+1...x+1..1...BC*
=N=	A210033 u 1....1....1....1.....x....1...BCN
=N=	A210034 v 1....1....1....1.....x....1...BCDFN
=N=	A210035 u 1....1....1....1.....2x...1...BBF
=N=	A210036 v 1....1....1....1.....2x...1...BBFF
=N=	A210037 u 1....1....1....1.....x+1..1...BCFFN   was e=2x
=N=	A210038 v 1....1....1....1.....x+1..1...BCFFN
=N=	A210039 u 1....1....1....x.....1....1...BCOT
=N=	A210040 v 1....1....1....x.....1....1...BCEN
=N=	A210042 u 1....1....1....x.....x....1...BCDEOT*
=N=	A124927 v 1....1....1....x.....x....1...BCDET*
=N=	A210041 u 1....1....1....x.....2x...1...BFO
=N=	A209758 v 1....1....1....x.....2x...1...BCFO
=N=	A210187 u 1....1....1....x.....x+1..1...DTF*
=N=	A210188 v 1....1....1....x.....x+1..1...DNF*
=N=	A210189 u 1....1....1....2x....1....1...BT
=N=	A210190 v 1....1....1....2x....1....1...BN
=N=	A210191 u 1....1....1....2x....x....1...CO*
=N=	A210192 v 1....1....1....2x....x....1...CCO*
=N=	A210193 u 1....1....1....2x....x+1..1...CPT
=N=	A210194 v 1....1....1....2x....x+1..1...CN
=N=	A210195 u 1....1....1....2x....2x...1...BOPT*
=N=	A210196 v 1....1....1....2x....2x...1...BCC*
=N=	A210197 u 1....1....1....x+1...1....1...BCOT
=N=	A210198 v 1....1....1....x+1...1....1...BCEN
=N=	A210199 u 1....1....1....x+1...x....1...DFT
=N=	A210200 v 1....1....1....x+1...x....1...DFO*
=N=	A210201 u 1....1....1....x+1...2x...1...BFP
=N=	A210202 v 1....1....1....x+1...2x...1...BF
=N=	A210203 u 1....1....1....x+1...x+1..1...BDOP
=N=	A210204 v 1....1....1....x+1...x+1..1...BCDN*
=N=	A210211 u x....1....1....1.....2x...1...BCFN
=N=	A210212 v x....1....1....1.....2x...1...BFN
=N=	A210213 u x....1....1....1.....x+1..1...CFFN
=N=	A210214 v x....1....1....1.....x+1..1...CFFO
=N=	A210215 u x....1....1....x.....x....1...BCDFT^
=N=	A210216 v x....1....1....x.....x....1...BCFO^
=N=	A210217 u x....1....1....x.....2x...1...CDF^
=N=	A210218 v x....1....1....x.....2x...1...BCF^
=N=	A210219 u x....1....1....x.....x+1..1...CNSTF*
=N=	A210220 v x....1....1....x.....x+1..1...FNNT*
=N=	A104698 u x....1....1....2x....  1..1...CENS*     e was x+1
=N=	A210220 v x....1....1....2x....x+1..1...DNNT*
=N=	A210223 u x....1....1....2x....x....1...CD^
=N=	A210224 v x....1....1....2x....x....1...CO^
=N=	A210225 u x....1....1....2x....x+1..1...CNP
=N=	A210226 v x....1....1....2x....x+1..1...NOT
=N=	A210227 u x....1....1....2x....2x...1...CDP^
=N=	A210228 v x....1....1....2x....2x...1...C^
=N=	A210229 u x....1....1....x+1...1....1...CFNN
=N=	A210230 v x....1....1....x+1...1....1...CCN
=N=	A210231 u x....1....1....x+1...x....1...CNT
=N=	A210232 v x....1....1....x+1...x....1...NN*
=N=	A210233 u x....1....1....x+1...2x...1...CNP
=N=	A210234 v x....1....1....x+1...2x...1...BN
=N=	A210235 u x....1....1....x+1...x+1..1...CCFPT*
=N=	A210236 v x....1....1....x+1...x+1..1...CFN*
=N=	A124927 u x....x....1....1.....1....1...BCDEET*
=N=	A210042 v x....1....1....x+1...x+1..1...BDEOT*
=N=	A210216 u x....x....1....1.....x....1...BCFO^
=N=	A210215 v x....x....1....1.....x....1...BCDFT^
=N=	A210549 u x....x....1....1.....2x...1...BCF^
=N=	A210550 v x....x....1....1.....2x...1...BDF^
=N=	A172431 u x....x....1....1.....x+1..1...CEFN*
=N=	A210551 v x....x....1....1.....x+1..1...CFOT*
=N=	A210552 u x....x....1....x.....1....1...BBCFNO
=N=	A210553 v x....x....1....x.....1....1...BNNFB
=N=	A208341 u x....x....1....x.....x+1..1...BCFFN
=N=	A210554 v x....x....1....x.....x+1..1...BNFFT
=N=	A210555 u x....x....1....2x....1....1...BCNN
=N=	A210556 v x....x....1....2x....1....1...BENP
=N=	A210557 u x....x....1....2x....x+1..1...CNP
=N=	A210558 v x....x....1....2x....x+1..1...N
=N=	A210559 u x....x....1....x+1...1....1...CEF
=N=	A210560 v x....x....1....x+1...1....1...OFNS
=N=	A210561 u x....x....1....x+1...x....1...BCNP^
=N=	A210562 v x....x....1....x+1...x....1...BDP*^
=N=	A210563 u x....x....1....x+1...2x...1...CFP^
=N=	A210564 v x....x....1....x+1...2x...1...DF^
=N=	A013609 u x....x....1....x+1...x+1..1...BCEPT*
=N=	A209757 v x....x....1....x+1...x+1..1...BCOS*
=N=	A209819 u x....2x...1....x+1...x....1...CFN^
=N=	A209820 v x....2x...1....x+1...x....1...DF^
=N=	A209996 u x....2x...1....x+1...2x...1...CP^
=N=	A209998 v x....2x...1....x+1...2x...1...DP^
=N=	A209999 u x....x+1..1....1.....x+1..1...FN*
=N=	A210287 v x....x+1..1....1.....x+1..1...CFT*
=N=	A210565 u x....x+1..1....x.....1....1...FNT*
=N=	A210595 v x....x+1..1....x.....1....1...FNNT
=N=	A210598 u x....x+1..1....x+1...2x...1...FN*
=N=	A210599 v x....x+1..1....x+1...2x...1...FN
=N=	A210600 u x....x+1..1....x+1...x+1..1...BF*
=N=	A210601 v x....x+1..1....x+1...x+1..1...BF*
=N=	A210597 u 2x...1....1....x+1...1....1...BF
=N=	A210601 v 2x...1....1....x+1...1....1...BFN*
=N=	A210603 u 2x...1....1....x+1...x+1..1...BF
=N=	A210738 v 2x...1....1....x+1...x+1..1...CBF*
=N=	A210739 u 2x...x....1....x+1...x....1...CF^
=N=	A210740 v 2x...x....1....x+1...x....1...DF*^
=N=	A210741 u 2x...x....1....x+1...x+1..1...BCFO
=N=	A210742 v 2x...x....1....x+1...x+1..1...CFO*
=N=	A210743 u 2x...x+1..1....x+1...1....1...F
=N=	A210744 v 2x...x+1..1....x+1...1....1...FN
=N=	A210747 u 2x...x+1..1....x+1...x+1..1...FF
=N=	A210748 v 2x...x+1..1....x+1...x+1..1...CFF*
=N=	A210749 u x+1..1....1....x+1...2x...1...BCF
=N=	A210750 v x+1..1....1....x+1...2x...1...BF
=N=	A210751 u x+1..x....1....x+1...2x...1...FNT
=N=	A210752 v x+1..x....1....x+1...2x...1...FN
=N=	A210753 u x+1..x....1....x+1...x+1..1...BNZ*
=N=	A210754 v x+1..x....1....x+1...x+1..1...BCT*
=N=	A210755 u x+1..2x...1....x+1...x+1..1...N*
=N=	A210756 v x+1..2x...1....x+1...x+1..1...CT*
=N=	A210789 u 1....x....0....x+2...x-1..0...CFFN
=N=	A210790 v 1....x....0....x+2...x-1..0...CEFF
=N=	A210791 u 1....x....0....x-1...x+2..0...CFNP    was 1....x....0....x+2...x-1..0
=N=	A210792 v 1....x....0....x-1...x+2..0...CF
=N=	A210793 u 1....x+1..0....x+2...x-1..0...CFNP
=N=	A210794 v 1....x+1..0....x+2...x-1..0...FPP
=N=	A210795 u 1....x....1....x+2...x-1..0...FN
=N=	A210796 v 1....x....1....x+2...x-1..0...FO
=N=	A210797 u 1....x....0....x+2...x-1..1...CF      was c=1
=N=	A210798 v 1....x....0....x+2...x-1..1...F       was c=1
=N=	A210799 u 1....x+1..1....x+2...x-1..0...FN
=N=	A210800 v 1....x+1..1....x+2...x-1..0...F
=N=	A210801 u 1....x+1..1....x+2...x-1..1...FN
=N=	A210802 v 1....x+1..1....x+2...x-1..1...F
=N=	A210803 u 1....x....0....x-1...x+3..0...F*      was c=1
=N=	A210804 v 1....x....0....x-1...x+3..0...F*      was c=1
=N=	A210805 u 1....x....0....x+2...x-1.-1...CFFN    was f=1
=N=	A210806 v 1....x....0....x+2...x-1.-1...FF      was f=1
=N=	A210858 u 1....x....0....x+n...x....0...CFT*
=N=	A210859 v 1....x....0....x+n...x....0...FN*
=N=	A210860 u 1....x+1..0....x+n...x....0...F
=N=	A210861 v 1....x+1..0....x+n...x....0...F*
=N=	A210862 u 1....x....1....x+n-1.x....0...FN
=N=	A210863 v 1....x....1....x+n-1.x....0...FS
=N=	A210864 u 1....x....1....x+n...x....0...FN
=N=	A210865 v 1....x....1....x+n...x....0...FT
=N=	A210866 u 1....x....0....x+n...x...-x...CFT
=N=	A210867 v 1....x....0....x+n...x...-x...FN
=N=	A210868 u 1....x....0....x+1...x-1..0...BCFN
=N=	A210869 v 1....x....0....x+1...x-1..0...BBCFNZ
=N=	A210870 u 1....x....0....x+1...x-1..1...CFFN
=N=	A210871 v 1....x....0....x+1...x-1..1...CFF      was 1....x....0....x.....x....1
=N=	A210872 u x....1...-1....x.....x....1...BDFZ^
=N=	A210873 v x....1...-1....x   ..x  ..1...BCFN^    was x....1...-1....x+1...x-1..1
=N=	A210876 u x....1....1....x.....x....x...BCCF^
=N=	A210877 v x....1....1....x.....x....x...BDFNZ^
=N=	A210878 u x....2x...0....x+1...x....1...DFZ^
=N=	A210879 v x....2x...0....x+1...x....1...FC*^
#--------------------------------
   	r..........p/q....s(m)<0....s(m)=0....[[m/q]]...s(m)>0
=O=	sqrt(2)....1/2....(empty)...A194368...A194369...A194370
=O=	sqrt(3)....1/2....A194371...A194372...(none)....A194373
=O=	sqrt(5)....1/2....(empty)...A194374...(none)....A194375
=O=	sqrt(6)....1/2....(empty)...A194376...(none)....A194377
=O=	sqrt(7)....1/2....A194378...A194379...(none)....A194380
=O=	sqrt(8)....1/2....A194381...A194382...A194383...A194384
=O=	sqrt(10)...1/2....(empty)...A194385...(none)....A194386
=O=	sqrt(11)...1/2....A194387...A194388...(none)....A194389
=O=	sqrt(12)...1/2....(empty)...A194390...(none)....A194391
=O=	sqrt(13)...1/2....A194392...A194393...(none)....A194394
=O=	sqrt(14)...1/2....A194395...A194396...(none)....A194397
=O=	sqrt(15)...1/2....A194398...A194399...(none)....A194400
=O=	tau........1/2....A194401...A194402...A194403...A194404
=O=	e..........1/2....A194405...A194406...(none)....A194407
=O=	Pi.........1/2....A194408...A194409...(none)....A194410
=O=	sqrt(2)....1/3....A194411...A194412...A194413...A194414
=O=	sqrt(3)....1/3....A194415...A194416...A194417...A194418
=O=	sqrt(5)....1/3....A194419...A194420...(none)....A194421
=O=	sqrt(2)....2/3....A194422...A194423...A194424...A194425
=O=	tau.....   <tau>/2...   A194461...(none)....(none)....A194462
=O=	tau.....   <tau/2>...   A194463...(none)....(none)....A194464
=O=	sqrt(2)....1/sqrt(2)....A194465...(none)....(none)....A194466
=O=	sqrt(3)....1/sqrt(3)....A194467...(none)....(none)....A194468
#--------------------------------
                            Morphism   Position sequences
=P=	0->012, 1->210, 2->021	A287385	A287386	A287387	A287388
=P=	0->012, 1->210, 2->102	A287397	A287398	A287399	A287400
=P=	0->012, 1->210, 2->120	A287401	A189728	A287403	A287404
=P=	0->012, 1->210, 2->201	A287407	A287408	A287409	A287410
=P=	0->012, 1->120, 2->021	A287411	A287412	A287413	A287414
=P=	0->012, 1->120, 2->102	A287418	A287419	A287420	A287421
=P=	0->012, 1->120, 2->201	A053838	A287435	A287436	A287437
=P=	0->012, 1->120, 2->210	A287438	A189728	A189670	A287441
=P=	0->012, 1->201, 2->021	A287443	A287444	A287445	A287446
=P=	0->012, 1->201, 2->102	A287447	A189724	A287449	A287450
=P=	0->012, 1->201, 2->120	A287451	A287452	A287453	A287454
=P=	0->012, 1->201, 2->210	A287455	A287456	A189666	A287458
=P=	0->012, 1->102, 2->021	A287516	A287517	A287518	A189630
=P=	0->012, 1->102, 2->120	A287520	A287521	A287522	A189630
=P=	0->012, 1->102, 2->201	A287524	A189724	A287526	A287527
=P=	0->012, 1->102, 2->210	A287528	A287529	A189670	A189634
#--------------------------------
A189576 is one of many 01-sequences fixed by morphisms.  It is helpful to classify a few such sequences:
Type 2,2:  morphism: 0->01, 1->10, A010060 (Thue-Morse)
..
Type 2,3:  Each row shows a morphism, followed by four sequences:
  (1) the fixed sequence a [starting from a(0)=0],
  (2) positions of 0 in a,
  (3) positions of 1 in a,
  (4) partial sums of a.
Some lower-numbered entries are conjectural.
=Q=	0->01, 1->001	A189572	A189573	A080652	A088462
=Q=	0->01, 1->010	A159684	A003152	A003151	A097508
=Q=	0->01, 1->011	A096270	A026352	A004956	A005206
=Q=	0->01, 1->100	A189476	A189477	A189478	A189575
=Q=	0->01, 1->101	A189479	A007066	A099267	A189480
=Q=	0->01, 1->110	A189576	A189577	A189578	A189579
=Q=	0->001, 1->01	A188432	A026351	A026352	A060144
=Q=	0->001, 1->10	A189624	A189625	A189626	A189627
=Q=	0->010, 1->01	A003849	A000201	A001950	A060144
=Q=	0->010, 1->10	A189661	A189662	A026356	A189663
=Q=	0->011, 1->01	A189687	A086377	A081477	A189688
=Q=	0->011, 1->10	A189702	A189703	A189704	A189705
#----
A189628 is one of many 01-sequences fixed by morphisms.  An extension of the list begun at A189576 is continued here with sequences of type 3,3.
Each row shows a morphism, followed by four sequences:
  (1) the fixed sequence a [starting from a(0)=0],
  (2) positions of 0 in a,
  (3) positions of 1 in a,
  (4) partial sums of a.
  Some lower-numbered entries are conjectural.
=Q=	0->001, 1->010	A189628	A189629	A189630	A189631
=Q=	0->001, 1->011	A116178	A189636	A189637	A189638
=Q=	0->001, 1->100	A189632	A189633	A189634	A189635
=Q=	0->001, 1->101	A189640	A026138	A026323	A189641
=Q=	0->001, 1->110	A064990	A189658	A189659	A189660
=Q=	0->010, 1->001	A189664	A189665	A189666	A189667
=Q=	0->010, 1->011	A080846	A026225	A026179	A189672
=Q=	0->010, 1->100	A189668	A189669	A189670	A189671
=Q=	0->010, 1->101	A000035	A005408	A005843	A004526
=Q=	0->010, 1->110	A189673	A026227	A026138	A189674
=Q=	0->011, 1->001	A189706	A189707	A189708	A189709
=Q=	0->011, 1->010	A156595	A189715	A189716	A189717
=Q=	0->011, 1->100	A189718	A189719	A189720	A189721
=Q=	0->011, 1->101	A189723	A189724	A189725	A189726
=Q=	0->011, 1->110	A189727	A189728	A189729	A189730
#--------------------------------
    Base b     {DV(n,b)}   {UV(n,b)}    {TV(n,b)}
=R=	2           A033264     A037800      A037834
=R=	3           A037853     A037844      A037835
=R=	4           A037854     A037845      A037836
=R=	5           A037855     A037846      A037837
=R=	6           A037856     A037847      A037838
=R=	7           A037857     A037848      A037839
=R=	8           A037858     A037849      A037840
=R=	9           A037859     A037850      A037841
=R=	10          A037860     A037851      A297330
=R=	11          A297231     A297232      A297233
=R=	12          A297234     A297235      A297236
=R=	13          A297237     A297238      A297239
=R=	14          A297240     A297241      A297242
=R=	15          A297243     A297244      A297245
=R=	16          A297246     A297247      A297248
For each b, let 
u = {n : UV(n,b) < DV(n,b)}, 
e = {n : UV(n,b) = DV(n,b)}, and 
d = {n : UV(n,b) > DV(n,b)}. 
The sets u,e,d partition the natural numbers.  A guide to the matching sequences for u, e, d follows:
***
Base b        Sequence u   Sequence e   Sequence d
=S=	2           A005843      A005408      (none)
=S=	3           A297249      A297250      A297251
=S=	4           A297252      A297253      A297254
=S=	5           A297255      A297256      A297257
=S=	6           A297258      A297259      A297260
=S=	7           A297261      A297262      A297263
=S=	8           A297264      A297265      A297266
=S=	9           A297267      A297268      A297269
=S=	10          A297270      A297271      A297272
=S=	11          A297273      A297274      A297275
=S=	12          A297276      A297277      A297278
=S=	13          A297279      A297280      A297281
=S=	14          A297282      A297283      A297284
=S=	15          A297285      A297286      A297287
=S=	16          A297288      A297289      A297290
#--------------------------------
#--------------------------------
#--------------------------------
#--------------------------------
