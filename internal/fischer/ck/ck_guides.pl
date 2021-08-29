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
my ($opt, $base, @ans, $callcode, $expr);
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
        }
    } # line with =opt=
} # while <DATA>
#----
sub outstd {
    my ($aseqno, @parms) = @_;
    print join("\t", $aseqno, $callcode, $offset, @parms) . "\n";
} # outstd
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
The set of differences s(k)-s(j) is ordered as a sequence at A204922.  Guide to related sequences:
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
#--------------------------------
#--------------------------------
#--------------------------------
#--------------------------------
