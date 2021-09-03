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
        } elsif ($opt eq "M") {
            # u(1,x)=1 and u(2,x)=a+b+c: u(n,x) = (a+e)u(n-1,x) + (bd-ae)u(n-2,x) + bf-ce+c.
            # v(1,x)=1 and v(2,x)=d+e+f: v(n,x) = (a+e)v(n-1,x) + (bd-ae)v(n-2,x) + cd-af+f.
            #                   a    	b    	c    	d    	e    	f    		code
            # =M=   A034839 u   1       1       0       1       x       0           CCOT
            my ($a, $b, $c, $d, $e, $f, $uv, $code);
            ($opt, $ans[0], $uv, $a, $b, $c, $d, $e, $f, $code) = map { 
                s/ //g;
                s{(\d+)x}{$1\*x}g;
                $_ } split(/\t+/, $line);
            my ($a2, $n1, $n2, $c0, $d_with_n);
            $d_with_n = ($d =~ s{\+n}{\+7777}) ? "y" : "n"; # a bad trick: 7777 instead of n
            if ($uv eq "u") {
                $a2 = "$a+$b+($c)"; $n1 = "$a+$e"; $n2 = "($b)*($d)-($a)*($e)"; $c0 = "($b)*($f)-($c)*($e)+($c)";
            } else { # "v"
                $a2 = "$d+$e+($f)"; $n1 = "$a+$e"; $n2 = "($b)*($d)-($a)*($e)"; $c0 = "($c)*($d)-($a)*($f)+($f)";
            }
            my $aseqno = $ans[0];
            if (! defined($hash{$aseqno})) {
                $hash{$aseqno} = 1;
                $callcode = "uvpol${d_with_n}_a2";  &outstd($ans[0], $a2, $a2);
                $callcode = "uvpol${d_with_n}_n1";  &outstd($ans[0], $n1, $n1);
                $callcode = "uvpol${d_with_n}_n2";  &outstd($ans[0], $n2, $n2);
                $callcode = "uvpol${d_with_n}_c0";  &outstd($ans[0], $c0, $c0);
            }
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
# A208510 typifies arrays generated by paired recurrence equations of the following form:
u(n,x)=a(n,x)*u(n-1,x)+b(n,x)*v(n-1,x)+c(n,x)
v(n,x)=d(n,x)*u(n-1,x)+e(n,x)*v(n-1,x)+f(n,x).
...
These first-order recurrences imply separate second-order recurrences.  In order to show them, 
the six functions a(n,x),...,f(n,x) are abbreviated as a,b,c,d,e,f.
Then, starting with initial values u(1,x)=1 and u(2,x)=a+b+c: u(n,x) = (a+e)u(n-1,x) + (bd-ae)u(n-2,x) + bf-ce+c.
With initial values v(1,x)=1 and v(2,x)=d+e+f: v(n,x) = (a+e)v(n-1,x) + (bd-ae)v(n-2,x) + cd-af+f.
...
In the guide below, the last column codes certain sequences that occur in one of these ways: row, column, edge, 
row sum, alternating row sum.  Coding:
A: 1,-1,1,-1,1,-1,1.... A033999
B: 1,2,4,8,16,32,64,... powers of 2
C: 1,1,1,1,1,1,1,1,.... A000012
D: 2,2,2,2,2,2,2,2,.... A007395
E: 2,4,6,8,10,12,14,... even numbers
F: 1,1,2,3,5,8,13,21,.. Fibonacci numbers
N: 1,2,3,4,5,6,7,8,.... A000027
O: 1,3,5,7,9,11,13,.... odd numbers
P: 1,3,9,27,81,243,.... powers of 3
S: 1,4,9,16,25,36,49,.. squares
T: 1,3,6,10,15,21,38,.. triangular numbers
Z: 1,0,0,0,0,0,0,0,0,.. A000007
*: (eventually) periodic alternating row sums
^: has a limiting row; i.e., the polynomials "approach" a power series
This coding includes indirect and repeated occurrences; 
e.g. F occurs thrice at A094441: in column 1 directly as Fibonacci numbers, in row sums as odd-indexed Fibonacci numbers, 
and in alternating row sums as signed Fibonacci numbers.
                a    	b    	c    	d    	e    	f    		code
=M=	A034839	u	1    	1    	0    	1    	x    	0	    	CCOT
=M=	A034867	v	1    	1    	0    	1    	x    	0	    	CEN
=M=	A210221	u	1    	1    	0    	1    	2x   	0	    	BBFF
=M=	A210596	v	1    	1    	0    	1    	2x   	0	    	BBFF
# =M=	A105070	v	1    	1    	0    	1    	2x   	0	    	BN
=M=	A207605	u	1    	1    	0    	1    	x+1  	0	    	BCFFN
=M=	A106195	v	1    	1    	0    	1    	x+1  	0	    	BCFFN
=M=	A207606	u	1    	1    	0    	x    	x+1  	0	    	DNT
=M=	A207607	v	1    	1    	0    	x    	x+1  	0	    	DNT
=M=	A207608	u	1    	1    	0    	2x   	x+1  	0	    	N
=M=	A207609	v	1    	1    	0    	2x   	x+1  	0	    	C
=M=	A207610	u	1    	1    	0    	1    	x    	1	    	CF
=M=	A207611	v	1    	1    	0    	1    	x    	1	    	BCF
=M=	A207612	u	1    	1    	0    	1    	2x   	1	    	BF
=M=	A207613	v	1    	1    	0    	1    	2x   	1	    	BF
=M=	A207614	u	1    	1    	0    	1    	x+1  	1	    	CN
=M=	A207615	v	1    	1    	0    	1    	x+1  	1	    	CFN
=M=	A207616	u	1    	1    	0    	x    	1    	1	    	CE
=M=	A207617	v	1    	1    	0    	x    	1    	1	    	CNO
=M=	A029638	u	1    	1    	0    	x    	x    	1	    	CDNO
=M=	A207635	v	1    	1    	0    	x    	x    	1	    	CDNOZ
=M=	A207618	u	1    	1    	0    	x    	2x   	1	    	N
=M=	A207619	v	1    	1    	0    	x    	2x   	1	    	CFN
=M=	A207620	u	1    	1    	0    	x    	x+1  	1	    	DET
=M=	A207621	v	1    	1    	0    	x    	x+1  	1	    	DNO
=M=	A207622	u	1    	1    	0    	2x   	1    	1	    	BT
=M=	A207623	v	1    	1    	0    	2x   	1    	1	    	BN
=M=	A207624	u	1    	1    	0    	2x   	x    	1	    	N
=M=	A102662	v	1    	1    	0    	2x   	x    	1	    	CO
=M=	A207625	u	1    	1    	0    	2x   	x+1  	1	    	T
=M=	A207626	v	1    	1    	0    	2x   	x+1  	1	    	N
=M=	A207627	u	1    	1    	0    	2x   	2x   	1	    	BN
=M=	A207628	v	1    	1    	0    	2x   	2x   	1	    	BCE
=M=	A207629	u	1    	1    	0    	x+1  	1    	1	    	CET
=M=	A207630	v	1    	1    	0    	x+1  	1    	1	    	CO
=M=	A207631	u	1    	1    	0    	x+1  	x    	1	    	DF
=M=	A207632	v	1    	1    	0    	x+1  	x    	1	    	DEF
=M=	A207633	u	1    	1    	0    	x+1  	2x   	1	    	F
=M=	A207634	v	1    	1    	0    	x+1  	2x   	1	    	F
=M=	A207635	u	1    	1    	0    	x+1  	x+1  	1	    	DN
=M=	A207636	v	1    	1    	0    	x+1  	x+1  	1	    	CD
=M=	A160232	u	1    	x    	0    	1    	2x   	0	    	BCFN
=M=	A208341	v	1    	x    	0    	1    	2x   	0	    	BCFFN
=M=	A085478	u	1    	x    	0    	1    	x+1  	0	    	CCOFT*
=M=	A078812	v	1    	x    	0    	1    	x+1  	0	    	CEFN*
=M=	A208342	u	1    	x    	0    	x    	x    	0	    	CCFNO
=M=	A208343	v	1    	x    	0    	x    	x    	0	    	BBCDFZ
=M=	A208344	u	1    	x    	0    	x    	2x   	0	    	CCFN
=M=	A208345	v	1    	x    	0    	x    	2x   	0	    	CFZ
=M=	A094436	u	1    	x    	0    	x    	x+1  	0	    	CFFN
=M=	A094437	v	1    	x    	0    	x    	x+1  	0	    	CEFF
=M=	A117919	u	1    	x    	0    	2x   	1    	0	    	BCNT
=M=	A135837	v	1    	x    	0    	2x   	1    	0	    	BCET
=M=	A208328	u	1    	x    	0    	2x   	x    	0	    	CCOP
=M=	A208329	v	1    	x    	0    	2x   	x    	0	    	DPZ
=M=	A208330	u	1    	x    	0    	2x   	x+1  	0	    	CNPT
=M=	A208331	v	1    	x    	0    	2x   	x+1  	0	    	CN
=M=	A208332	u	1    	x    	0    	2x   	2x   	0	    	CCE
=M=	A208333	v	1    	x    	0    	2x   	2x   	0	    	DZ
=M=	A208334	u	1    	x    	0    	x+1  	1    	0	    	CCNT
=M=	A208335	v	1    	x    	0    	x+1  	1    	0	    	CCN*
=M=	A208336	u	1    	x    	0    	x+1  	x    	0	    	CFNT*
=M=	A208337	v	1    	x    	0    	x+1  	x    	0	    	ACFN*
=M=	A208338	u	1    	x    	0    	x+1  	2x   	0	    	CNP
=M=	A208339	v	1    	x    	0    	x+1  	2x   	0	    	BCNP
=M=	A202390	u	1    	x    	0    	x+1  	x+1  	0	    	CFPTZ*
=M=	A208340	v	1    	x    	0    	x+1  	x+1  	0	    	FNPZ*
=M=	A208508	u	1    	x    	0    	1    	1    	1	    	CCES
=M=	A208509	v	1    	x    	0    	1    	1    	1	    	BCO
=M=	A208510	u	1    	x    	0    	1    	x    	1	    	CCCNOS*
=M=	A029653	v	1    	x    	0    	1    	x    	1	    	BCDOSZ*
=M=	A208511	u	1    	x    	0    	1    	2x   	1	    	BCFO
=M=	A208512	v	1    	x    	0    	1    	2x   	1	    	BDFO
=M=	A208513	u	1    	x    	0    	1    	x+1  	1	    	CCES*
=M=	A111125	v	1    	x    	0    	1    	x+1  	1	    	COO*
=M=	A133567	u	1    	x    	0    	x    	1    	1	    	CCOTT
=M=	A133084	v	1    	x    	0    	x    	1    	1	    	BBCEN
=M=	A208514	u	1    	x    	0    	x    	x    	1	    	CEFN
=M=	A208515	v	1    	x    	0    	x    	x    	1	    	BCDFN
=M=	A208516	u	1    	x    	0    	x    	2x   	1	    	CNN
=M=	A208517	v	1    	x    	0    	x    	2x   	1	    	CCN
=M=	A208518	u	1    	x    	0    	x    	x+1  	1	    	CFNT
=M=	A208519	v	1    	x    	0    	x    	x+1  	1	    	NFFT
=M=	A208520	u	1    	x    	0    	2x   	1    	1	    	BCTT
=M=	A208521	u	1    	x    	0    	2x   	1    	1	    	BEN
=M=	A208522	u	1    	x    	0    	2x   	x    	1	    	CCN
=M=	A208523	v	1    	x    	0    	2x   	x    	1	    	CCO
=M=	A208524	u	1    	x    	0    	2x   	x+1  	1	    	CT*
=M=	A208525	v	1    	x    	0    	2x   	x+1  	1	    	ACNP*
=M=	A208526	u	1    	x    	0    	2x   	2x   	1	    	CEN
=M=	A208527	v	1    	x    	0    	2x   	2x   	1	    	CCE
=M=	A208606	u	1    	x    	0    	x+1  	1    	1	    	CCS
=M=	A208607	v	1    	x    	0    	x+1  	1    	1	    	CNO
=M=	A208608	u	1    	x    	0    	x+1  	x    	1	    	CFOT
=M=	A208609	v	1    	x    	0    	x+1  	x    	1	    	DEN*
=M=	A208610	u	1    	x    	0    	x+1  	2x   	1	    	CO
=M=	A208611	v	1    	x    	0    	x+1  	2x   	1	    	DE
=M=	A208612	u	1    	x    	0    	x+1  	x+1  	1	    	CFNS
=M=	A208613	v	1    	x    	0    	x+1  	x+1  	1	    	CFN*
=M=	A105070	u	1    	2x   	0    	1    	1    	0	    	BN
=M=	A207536	v	1    	2x   	0    	1    	1    	0	    	BCT
=M=	A208751	u	1    	2x   	0    	1    	x+1  	0	    	CDPT
=M=	A208752	v	1    	2x   	0    	1    	x+1  	0	    	CNP
=M=	A135837	u	1    	2x   	0    	x    	1    	0	    	BCNT
=M=	A117919	v	1    	2x   	0    	x    	1    	0	    	BCNT
=M=	A208755	u	1    	2x   	0    	x    	x    	0	    	BCDEP
=M=	A208756	v	1    	2x   	0    	x    	x    	0	    	BCCOZ
=M=	A208757	u	1    	2x   	0    	x    	2x   	0	    	CDEP
=M=	A208758	v	1    	2x   	0    	x    	2x   	0	    	CCEPZ
=M=	A208763	u	1    	2x   	0    	2x   	x    	0	    	CDOP
=M=	A208764	v	1    	2x   	0    	2x   	x    	0	    	CCCP
=M=	A208765	u	1    	2x   	0    	2x   	x+1  	0	    	CE
=M=	A208766	v	1    	2x   	0    	2x   	x+1  	0	    	CC
=M=	A208747	u	1    	2x   	0    	2x   	2x   	0	    	CDE
=M=	A208748	v	1    	2x   	0    	2x   	2x   	0	    	CCZ
=M=	A208749	u	1    	2x   	0    	x+1  	1    	0	    	BCOPT
=M=	A208750	v	1    	2x   	0    	x+1  	1    	0	    	BCNP*
=M=	A208759	u	1    	2x   	0    	x+1  	2x   	0   	CE
=M=	A208760	v	1    	2x   	0    	x+1  	2x   	0   	BCO
=M=	A208761	u	1    	2x   	0    	x+1  	x+1  	0   	BCCT*
=M=	A208762	v	1    	2x   	0    	x+1  	x+1  	0   	BNZ*
=M=	A208753	u	1    	2x   	0    	1    	1    	1   	BCS
=M=	A208754	v	1    	2x   	0    	1    	1    	1   	BO
=M=	A105045	u	1    	2x   	0    	1    	2x   	1   	BCCOS*
=M=	A208659	v	1    	2x   	0    	1    	2x   	1   	BDOSZ*
=M=	A208660	u	1    	2x   	0    	1    	x+1  	1   	CDS
=M=	A208904	v	1    	2x   	0    	1    	x+1  	1   	CNO
=M=	A208905	u	1    	2x   	0    	x    	1    	1   	BCT
=M=	A208906	v	1    	2x   	0    	x    	1    	1   	BNN
=M=	A208907	u	1    	2x   	0    	x    	x    	1   	BCN
=M=	A208756	v	1    	2x   	0    	x    	x    	1   	BCCE
=M=	A208755	u	1    	2x   	0    	x    	2x   	1   	CEN
=M=	A208910	v	1    	2x   	0    	x    	2x   	1   	CCE
=M=	A208911	u	1    	2x   	0    	x    	x+1  	1   	BCT
=M=	A208912	v	1    	2x   	0    	x    	x+1  	1   	BNT
=M=	A208913	u	1    	2x   	0    	2x   	1    	1   	BCT
=M=	A208914	v	1    	2x   	0    	2x   	1    	1   	BEN
=M=	A208915	u	1    	2x   	0    	2x   	x    	1   	CE
=M=	A208916	v	1    	2x   	0    	2x   	x    	1   	CCO
=M=	A208919	u	1    	2x   	0    	2x   	x+1  	1   	CT
=M=	A208920	v	1    	2x   	0    	2x   	x+1  	1   	N
=M=	A208917	u	1    	2x   	0    	2x   	2    	1   	CEN
=M=	A208918	v	1    	2x   	0    	2x   	2    	1   	CCNP
=M=	A208921	u	1    	2x   	0    	x+1  	1    	1   	BC
=M=	A208922	v	1    	2x   	0    	x+1  	1    	1   	BON
=M=	A208923	u	1    	2x   	0    	x+1  	x    	1   	BCNO
=M=	A208908	v	1    	2x   	0    	x+1  	x    	1   	BDN*
=M=	A208909	u	1    	2x   	0    	x+1  	2x   	1   	BN
=M=	A208930	v	1    	2x   	0    	x+1  	2x   	1   	DN
=M=	A208931	u	1    	2x   	0    	x+1  	x+1  	1   	BCOS
=M=	A208932	v	1    	2x   	0    	x+1  	x+1  	1   	BCO*
=M=	A207537	u	1    	x+1  	0    	1    	1    	0   	BCO
=M=	A207538	v	1    	x+1  	0    	1    	1    	0   	BCE
=M=	A122075	u	1    	x+1  	0    	1    	x    	0   	CCFN*
=M=	A037027	v	1    	x+1  	0    	1    	x    	0   	CCFN*
=M=	A209125	u	1    	x+1  	0    	1    	2x   	0   	BCFN*
=M=	A164975	v	1    	x+1  	0    	1    	2x   	0   	BF
=M=	A209126	u	1    	x+1  	0    	x    	x    	0   	CDFO*
=M=	A209127	v	1    	x+1  	0    	x    	x    	0   	DFOZ*
=M=	A209128	u	1    	x+1  	0    	x    	2x   	0   	CDE*
=M=	A209129	v	1    	x+1  	0    	x    	2x   	0   	DEZ
=M=	A102756	u	1    	x+1  	0    	x    	x+1  	0   	CFNP*
=M=	A209130	v	1    	x+1  	0    	x    	x+1  	0   	CCFNP*
=M=	A209131	u	1    	x+1  	0    	x    	x+1  	0   	CDEP*
=M=	A209132	v	1    	x+1  	0    	x    	x+1  	0   	CNPZ*
=M=	A209133	u	1    	x+1  	0    	x    	x+1  	0   	CDN
=M=	A209134	v	1    	x+1  	0    	x    	x+1  	0   	CCN*
=M=	A209135	u	1    	x+1  	0    	2x   	x+1  	0   	CN*
=M=	A209136	v	1    	x+1  	0    	2x   	x+1  	0   	CCS*
=M=	A209137	u	1    	x+1  	0    	x+1  	x    	0   	CFFP*
=M=	A209138	v	1    	x+1  	0    	x+1  	x    	0   	AFFP*
=M=	A209139	u	1    	x+1  	0    	x+1  	2x   	0   	CF*
=M=	A209140	v	1    	x+1  	0    	x+1  	2x   	0   	BF
=M=	A209141	u	1    	x+1  	0    	x+1  	x+1  	0   	BCF*
=M=	A209142	v	1    	x+1  	0    	x+1  	x+1  	0   	BFZ*
=M=	A209143	u	1    	x+1  	0    	1    	1    	1   	CCE*
=M=	A209144	v	1    	x+1  	0    	1    	1    	1   	COO*
=M=	A209145	u	1    	x+1  	0    	1    	x    	1   	CCFN*
=M=	A122075	v	1    	x+1  	0    	1    	x    	1   	CCFN*
=M=	A209146	u	1    	x+1  	0    	1    	2x   	1   	BCF*
=M=	A209147	v	1    	x+1  	0    	1    	2x   	1   	BF
=M=	A209148	u	1    	x+1  	0    	1    	x+1  	1   	CCO*
=M=	A209149	v	1    	x+1  	0    	1    	x+1  	1   	CDO*
=M=	A209150	u	1    	x+1  	0    	x    	1    	1   	CCNT*
=M=	A208335	v	1    	x+1  	0    	x    	1    	1   	CDNN*
=M=	A209151	u	1    	x+1  	0    	x    	x    	1   	CFN*
=M=	A208337	v	1    	x+1  	0    	x    	x    	1   	ACFN*
=M=	A209152	u	1    	x+1  	0    	x    	x    	1   	CN*
=M=	A208339	v	1    	x+1  	0    	x    	x    	1   	BCN
=M=	A209153	u	1    	x+1  	0    	x    	x    	1   	CFT*
=M=	A208340	v	1    	x+1  	0    	x    	x    	1   	FNZ*
=M=	A209154	u	1    	x+1  	0    	2x   	1    	1   	BCT*
=M=	A209157	v	1    	x+1  	0    	2x   	1    	1   	BNN
=M=	A209158	u	1    	x+1  	0    	2x   	x    	1   	CN*
=M=	A209159	v	1    	x+1  	0    	2x   	x    	1   	CO*
=M=	A209160	u	1    	x+1  	0    	2x   	2x   	1   	CN*
=M=	A209161	v	1    	x+1  	0    	2x   	2x   	1   	CE
=M=	A209162	u	1    	x+1  	0    	2x   	x+1  	1   	CT*
=M=	A209163	v	1    	x+1  	0    	2x   	x+1  	1   	CO*
=M=	A209164	u	1    	x+1  	0    	x+1  	1    	1   	CC*
=M=	A209165	v	1    	x+1  	0    	x+1  	1    	1   	CCN
=M=	A209166	u	1    	x+1  	0    	x+1  	x    	1   	CFF*
=M=	A209167	v	1    	x+1  	0    	x+1  	x    	1   	FF*
=M=	A209168	u	1    	x+1  	0    	x+1  	2x   	1   	CF*
=M=	A209169	v	1    	x+1  	0    	x+1  	2x   	1   	CF
=M=	A209170	u	1    	x+1  	0    	x+1  	x+1  	1   	CF*
=M=	A209171	v	1    	x+1  	0    	x+1  	x+1  	1   	CF*
=M=	A053538	u	x    	1    	0    	1    	1    	0   	BBCCFN
=M=	A076791	v	1    	1    	0    	1    	1    	0   	BBCDF	a was x
=M=	A209172	u	x    	1    	0    	1    	2x   	0   	BCCFF
=M=	A209413	v	x    	1    	0    	1    	2x   	0   	BCCFF
=M=	A094441	u	x    	1    	0    	1    	x+1  	0   	CFFFN
=M=	A094442	v	x    	1    	0    	1    	x+1  	0   	CEFFF
=M=	A054142	u	x    	1    	0    	x    	x+1  	0   	CCFOT*
=M=	A172431	v	x    	1    	0    	x    	x+1  	0   	CEFN*
=M=	A008288	u	x    	1    	0    	2x   	1    	0   	CCOO*
=M=	A035607	v	x    	1    	0    	2x   	1    	0   	ACDE*
=M=	A209414	u	x    	1    	0    	2x   	x+1  	0   	CCS
=M=	A112351	v	x    	1    	0    	2x   	x+1  	0   	CON
=M=	A209415	u	x    	1    	0    	x+1  	x    	0   	CCTN
=M=	A209416	v	x    	1    	0    	x+1  	x    	0   	ACN*
=M=	A209417	u	x    	1    	0    	x+1  	2x   	0   	CC
=M=	A209418	v	x    	1    	0    	x+1  	2x   	0   	BBC
=M=	A209419	u	x    	1    	0    	x+1  	x+1  	0   	CFTZ*
=M=	A209420	v	x    	1    	0    	x+1  	x+1  	0   	FNZ*
=M=	A209421	u	x    	1    	0    	1    	1    	1   	CCN
=M=	A209422	v	x    	1    	0    	1    	1    	1   	CD
=M=	A209555	u	x    	1    	0    	1    	x    	1   	CNN
=M=	A209556	v	x    	1    	0    	1    	x    	1   	CNN
=M=	A209557	u	x    	1    	0    	1    	2x   	1   	BCN
=M=	A209558	v	x    	1    	0    	1    	2x   	1   	BN
=M=	A209559	u	x    	1    	0    	1    	2x   	1   	CN
=M=	A209560	v	x    	1    	0    	1    	2x   	1   	CN
=M=	A209561	u	x    	1    	0    	x    	1    	1   	CCNNT*
=M=	A209562	v	x    	1    	0    	x    	1    	1   	CDNNT*
=M=	A209563	u	x    	1    	0    	x    	x    	1   	CCFT^
=M=	A209564	v	x    	1    	0    	x    	x    	1   	CFN^
=M=	A209565	u	x    	1    	0    	x    	2x   	1   	CC^
=M=	A209566	v	x    	1    	0    	x    	2x   	1   	BC^
=M=	A209567	u	x    	1    	0    	x    	2x   	1   	CNT*
=M=	A209568	v	x    	1    	0    	x    	2x   	1   	NNS*
=M=	A209569	u	x    	1    	0    	2x   	1    	1   	CNO*
=M=	A209570	v	x    	1    	0    	2x   	1    	1   	DNN*
=M=	A209571	u	x    	1    	0    	2x   	x    	1   	CCS^
=M=	A209572	v	x    	1    	0    	2x   	x    	1   	CN^
=M=	A209573	u	x    	1    	0    	2x   	x+1  	1   	CNS
=M=	A209574	v	x    	1    	0    	2x   	x+1  	1   	NO
=M=	A209575	u	x    	1    	0    	2x   	2x   	1   	CC
=M=	A209576	v	x    	1    	0    	2x   	2x   	1   	C
=M=	A209577	u	x    	1    	0    	2x   	2x   	1   	CNNT
=M=	A209578	v	x    	1    	0    	2x   	2x   	1   	CNN
=M=	A209579	u	x    	1    	0    	x+1  	x    	1   	CNNT
=M=	A209580	v	x    	1    	0    	x+1  	x    	1   	NN*
=M=	A209581	u	x    	1    	0    	x+1  	2x   	1   	CN
=M=	A209582	v	x    	1    	0    	x+1  	2x   	1   	BN
=M=	A209583	u	x    	1    	0    	x+1  	x+1  	1   	CT*
=M=	A209584	v	x    	1    	0    	x+1  	x+1  	1   	CN*
=M=	A121462	u	x    	x    	0    	x    	x+1  	0   	BCFFNZ
=M=	A208341	v	x    	x    	0    	x    	x+1  	0   	BCFFN
=M=	A209687	u	x    	x    	0    	2x   	x+1  	0   	BCNZ
=M=	A208339	v	x    	x    	0    	2x   	x+1  	0   	BCN
=M=	A115241	u	x    	x    	0    	1    	1    	1   	CDNZ*
=M=	A209668	v	x    	x    	0    	1    	1    	1   	DDN*
=M=	A209689	u	x    	x    	0    	1    	x    	1   	FNZ^
=M=	A209690	v	x    	x    	0    	1    	x    	1   	FN^
=M=	A209691	u	x    	x    	0    	1    	2x   	1   	BCZ^
=M=	A209692	v	x    	x    	0    	1    	2x   	1   	BCC^
=M=	A209693	u	x    	x    	0    	1    	x+1  	1   	NNZ*
=M=	A209694	v	x    	x    	0    	1    	x+1  	1   	CN*
=M=	A209697	u	x    	x    	0    	x    	x+1  	1   	BNZ
=M=	A209698	v	x    	x    	0    	x    	x+1  	1   	BNT
=M=	A209699	u	x    	x    	0    	x    	x+1  	1   	BNNZ
=M=	A209700	v	x    	x    	0    	x    	x+1  	1   	BDN
=M=	A209701	u	x    	x    	0    	2x   	x+1  	1   	NZ
=M=	A209702	v	x    	x    	0    	2x   	x+1  	1   	N
=M=	A209703	u	x    	x    	0    	x+1  	1    	1   	FNTZ
=M=	A209704	v	x    	x    	0    	x+1  	1    	1   	FNNT
=M=	A209705	u	x    	x    	0    	x+1  	x+1  	1   	BNZ*
=M=	A209706	v	x    	x    	0    	x+1  	x+1  	1   	BCN*
=M=	A209695	u	x    	x+1  	0    	2x   	x+1  	0   	ACN*
=M=	A209696	v	x    	x+1  	0    	2x   	x+1  	0   	CDN*
=M=	A209830	u	x    	x+1  	0    	x+1  	2x   	0   	ACF
=M=	A209831	v	x    	x+1  	0    	x+1  	2x   	0   	BCF*
=M=	A209745	u	x    	x+1  	0    	x+1  	x+1  	0   	ABF*
=M=	A209746	v	x    	x+1  	0    	x+1  	x+1  	0   	BFZ*
=M=	A209747	u	x    	x+1  	0    	1    	1    	1   	ADE*
=M=	A209748	v	x    	x+1  	0    	1    	1    	1   	DEO
=M=	A209749	u	x    	x+1  	0    	1    	x    	1   	ANN*
=M=	A209750	v	x    	x+1  	0    	1    	x    	1   	CNO
=M=	A209751	u	x    	x+1  	0    	1    	2x   	1   	ABN*
=M=	A209752	v	x    	x+1  	0    	1    	2x   	1   	BN
=M=	A209753	u	x    	x+1  	0    	1    	x+1  	1   	AN*
=M=	A209754	v	x    	x+1  	0    	1    	x+1  	1   	NT*
=M=	A209755	u	x    	x+1  	0    	x    	1    	1   	AFN
=M=	A209756	v	x    	x+1  	0    	x    	1    	1   	FNO*
=M=	A209759	u	x    	x+1  	0    	x    	2x   	1   	ACF^
=M=	A209760	v	x    	x+1  	0    	x    	2x   	1   	CF^*
=M=	A209761	u	x    	x+1  	0    	x     	x+1 	1   	ABNS*
=M=	A209762	v	x    	x+1  	0    	x     	x+1 	1   	BNS*
=M=	A209763	u	x    	x+1  	0    	2x    	1   	1   	ABN*
=M=	A209764	v	x    	x+1  	0    	2x    	1   	1   	BNN
=M=	A209765	u	x    	x+1  	0    	2x    	x   	1   	ACF^*
=M=	A209766	v	x    	x+1  	0    	2x    	x   	1   	CF^
=M=	A209767	u	x    	x+1  	0    	2x    	x+1 	1   	AN*
=M=	A209768	v	x    	x+1  	0    	2x    	x+1 	1   	N*
=M=	A209769	u	x    	x+1  	0    	x+1   	1   	1   	AF*
=M=	A209770	v	x    	x+1  	0    	x+1   	1   	1   	FN
=M=	A209771	u	x    	x+1  	0    	x+1   	x   	1   	ABN*
=M=	A209772	v	x    	x+1  	0    	x+1   	x   	1   	BN*
=M=	A209773	u	x    	x+1  	0    	x+1   	2x  	1   	AF
=M=	A209774	v	x    	x+1  	0    	x+1   	2x  	1   	FN*
=M=	A209775	u	x    	x+1  	0    	x+1   	x+1 	1   	AB*
=M=	A209776	v	x    	x+1  	0    	x+1   	x+1 	1   	BC*
=M=	A210033	u	1    	1    	1    	1     	x   	1   	BCN
=M=	A210034	v	1    	1    	1    	1     	x   	1   	BCDFN
=M=	A210035	u	1    	1    	1    	1     	2x  	1   	BBF
=M=	A210036	v	1    	1    	1    	1     	2x  	1   	BBFF
=M=	A210037	u	1    	1    	1    	1     	2x  	1   	BCFFN
=M=	A210038	v	1    	1    	1    	1     	x+1 	1   	BCFFN
=M=	A210039	u	1    	1    	1    	x     	1   	1   	BCOT
=M=	A210040	v	1    	1    	1    	x     	1   	1   	BCEN
=M=	A210042	u	1    	1    	1    	x     	x   	1   	BCDEOT*
=M=	A124927	v	1    	1    	1    	x     	x   	1   	BCDET*
=M=	A210041	u	1    	1    	1    	x     	2x  	1   	BFO
=M=	A209758	v	1    	1    	1    	x     	2x  	1   	BCFO
=M=	A210187	u	1    	1    	1    	x     	x+1 	1   	DTF*
=M=	A210188	v	1    	1    	1    	x     	x+1 	1   	DNF*
=M=	A210189	u	1    	1    	1    	2x    	1   	1   	BT
=M=	A210190	v	1    	1    	1    	2x    	1   	1   	BN
=M=	A210191	u	1    	1    	1    	2x    	x   	1   	CO*
=M=	A210192	v	1    	1    	1    	2x    	x   	1   	CCO*
=M=	A210193	u	1    	1    	1    	2x    	x+1 	1   	CPT
=M=	A210194	v	1    	1    	1    	2x    	x+1 	1   	CN
=M=	A210195	u	1    	1    	1    	2x    	2x  	1   	BOPT*
=M=	A210196	v	1    	1    	1    	2x    	2x  	1   	BCC*
=M=	A210197	u	1    	1    	1    	x+1   	1   	1   	BCOT
=M=	A210198	v	1    	1    	1    	x+1   	1   	1   	BCEN
=M=	A210199	u	1    	1    	1    	x+1   	x   	1   	DFT
=M=	A210200	v	1    	1    	1    	x+1   	x   	1   	DFO*
=M=	A210201	u	1    	1    	1    	x+1   	2x  	1   	BFP
=M=	A210202	v	1    	1    	1    	x+1   	2x  	1   	BF
=M=	A210203	u	1    	1    	1    	x+1   	x+1 	1   	BDOP
=M=	A210204	v	1    	1    	1    	x+1   	x+1 	1   	BCDN*
=M=	A210211	u	x    	1    	1    	1     	2x  	1   	BCFN
=M=	A210212	v	x    	1    	1    	1     	2x  	1   	BFN
=M=	A210213	u	x    	1    	1    	1     	x+1 	1   	CFFN
=M=	A210214	v	x    	1    	1    	1     	x+1 	1   	CFFO
=M=	A210215	u	x    	1    	1    	x     	x   	1   	BCDFT^
=M=	A210216	v	x    	1    	1    	x     	x   	1   	BCFO^
=M=	A210217	u	x    	1    	1    	x     	2x  	1   	CDF^
=M=	A210218	v	x    	1    	1    	x     	2x  	1   	BCF^
=M=	A210219	u	x    	1    	1    	x     	x+1 	1   	CNSTF*
=M=	A210220	v	x    	1    	1    	x     	x+1 	1   	FNNT*
=M=	A104698	u	x    	1    	1    	2x    	1   	1   	CENS*	e was x+1
=M=	A210220	v	x    	1    	1    	2x    	x+1 	1   	DNNT*
=M=	A210223	u	x    	1    	1    	2x    	x   	1   	CD^
=M=	A210224	v	x    	1    	1    	2x    	x   	1   	CO^
=M=	A210225	u	x    	1    	1    	2x    	x+1 	1   	CNP
=M=	A210226	v	x    	1    	1    	2x    	x+1 	1   	NOT
=M=	A210227	u	x    	1    	1    	2x    	2x  	1   	CDP^
=M=	A210228	v	x    	1    	1    	2x    	2x  	1   	C^
=M=	A210229	u	x    	1    	1    	x+1   	1   	1   	CFNN
=M=	A210230	v	x    	1    	1    	x+1   	1   	1   	CCN
=M=	A210231	u	x    	1    	1    	x+1   	x   	1   	CNT
=M=	A210232	v	x    	1    	1    	x+1   	x   	1   	NN*
=M=	A210233	u	x    	1    	1    	x+1   	2x  	1   	CNP
=M=	A210234	v	x    	1    	1    	x+1   	2x  	1   	BN
=M=	A210235	u	x    	1    	1    	x+1   	x+1 	1   	CCFPT*
=M=	A210236	v	x    	1    	1    	x+1   	x+1 	1   	CFN*
=M=	A124927	u	x    	x    	1    	1     	1   	1   	BCDEET*
=M=	A210042	v	x    	1    	1    	x+1   	x+1 	1   	BDEOT*
=M=	A210216	u	x    	x    	1    	1     	x   	1   	BCFO^
=M=	A210215	v	x    	x    	1    	1     	x   	1   	BCDFT^
=M=	A210549	u	x    	x    	1    	1     	2x  	1   	BCF^
=M=	A210550	v	x    	x    	1    	1     	2x  	1   	BDF^
=M=	A172431	u	x    	x    	1    	1     	x+1 	1   	CEFN*
=M=	A210551	v	x    	x    	1    	1     	x+1 	1   	CFOT*
=M=	A210552	u	x    	x    	1    	x     	1   	1   	BBCFNO
=M=	A210553	v	x    	x    	1    	x     	1   	1   	BNNFB
=M=	A208341	u	x    	x    	1    	x     	x+1 	1   	BCFFN
=M=	A210554	v	x    	x    	1    	x     	x+1 	1   	BNFFT
=M=	A210555	u	x    	x    	1    	2x    	1   	1   	BCNN
=M=	A210556	v	x    	x    	1    	2x    	1   	1   	BENP
=M=	A210557	u	x    	x    	1    	2x    	x+1 	1   	CNP
=M=	A210558	v	x    	x    	1    	2x    	x+1 	1   	N
=M=	A210559	u	x    	x    	1    	x+1   	1   	1   	CEF
=M=	A210560	v	x    	x    	1    	x+1   	1   	1   	OFNS
=M=	A210561	u	x    	x    	1    	x+1   	x   	1   	BCNP^
=M=	A210562	v	x    	x    	1    	x+1   	x   	1   	BDP*^
=M=	A210563	u	x    	x    	1    	x+1   	2x  	1   	CFP^
=M=	A210564	v	x    	x    	1    	x+1   	2x  	1   	DF^
=M=	A013609	u	x    	x    	1    	x+1   	x+1 	1   	BCEPT*
=M=	A209757	v	x    	x    	1    	x+1   	x+1 	1   	BCOS*
=M=	A209819	u	x    	2x   	1    	x+1   	x   	1   	CFN^
=M=	A209820	v	x    	2x   	1    	x+1   	x   	1   	DF^
=M=	A209996	u	x    	2x   	1    	x+1   	2x  	1   	CP^
=M=	A209998	v	x    	2x   	1    	x+1   	2x  	1   	DP^
=M=	A209999	u	x    	x+1  	1    	1     	x+1 	1   	FN*
=M=	A210287	v	x    	x+1  	1    	1     	x+1 	1   	CFT*
=M=	A210565	u	x    	x+1  	1    	x     	1   	1   	FNT*
=M=	A210595	v	x    	x+1  	1    	x     	1   	1   	FNNT
=M=	A210598	u	x    	x+1  	1    	x+1   	2x  	1   	FN*
=M=	A210599	v	x    	x+1  	1    	x+1   	2x  	1   	FN
=M=	A210600	u	x    	x+1  	1    	x+1   	x+1 	1   	BF*
=M=	A210601	v	x    	x+1  	1    	x+1   	x+1 	1   	BF*
=M=	A210597	u	2x   	1    	1    	x+1   	1   	1   	BF
=M=	A210601	v	2x   	1    	1    	x+1   	1   	1   	BFN*
=M=	A210603	u	2x   	1    	1    	x+1   	x+1 	1   	BF
=M=	A210738	v	2x   	1    	1    	x+1   	x+1 	1   	CBF*
=M=	A210739	u	2x   	x    	1    	x+1   	x   	1   	CF^
=M=	A210740	v	2x   	x    	1    	x+1   	x   	1   	DF*^
=M=	A210741	u	2x   	x    	1    	x+1   	x+1 	1   	BCFO
=M=	A210742	v	2x   	x    	1    	x+1   	x+1 	1   	CFO*
=M=	A210743	u	2x   	x+1  	1    	x+1   	1   	1   	F
=M=	A210744	v	2x   	x+1  	1    	x+1   	1   	1   	FN
=M=	A210747	u	2x   	x+1  	1    	x+1   	x+1 	1   	FF
=M=	A210748	v	2x   	x+1  	1    	x+1   	x+1 	1   	CFF*
=M=	A210749	u	x+1  	1    	1    	x+1   	2x  	1   	BCF
=M=	A210750	v	x+1  	1    	1    	x+1   	2x  	1   	BF
=M=	A210751	u	x+1  	x    	1    	x+1   	2x  	1   	FNT
=M=	A210752	v	x+1  	x    	1    	x+1   	2x  	1   	FN
=M=	A210753	u	x+1  	x    	1    	x+1   	x+1 	1   	BNZ*
=M=	A210754	v	x+1  	x    	1    	x+1   	x+1 	1   	BCT*
=M=	A210755	u	x+1  	2x   	1    	x+1   	x+1 	1   	N*
=M=	A210756	v	x+1  	2x   	1    	x+1   	x+1 	1   	CT*
=M=	A210789	u	1    	x    	0    	x+2   	x-1 	0   	CFFN
=M=	A210790	v	1    	x    	0    	x+2   	x-1 	0   	CEFF
=M=	A210791	u	1    	x    	0    	x+2   	x-1 	0   	CFNP
=M=	A210792	v	1    	x    	0    	x-1   	x+2 	0   	CF
=M=	A210793	u	1    	x+1  	0    	x+2   	x-1 	0   	CFNP
=M=	A210794	v	1    	x+1  	0    	x+2   	x-1 	0   	FPP
=M=	A210795	u	1    	x    	1    	x+2   	x-1 	0   	FN
=M=	A210796	v	1    	x    	1    	x+2   	x-1 	0   	FO
=M=	A210797	u	1    	x    	1    	x+2   	x-1 	1   	CF
=M=	A210798	v	1    	x    	1    	x+2   	x-1 	1   	F
=M=	A210799	u	1    	x+1  	1    	x+2   	x-1 	0   	FN
=M=	A210800	v	1    	x+1  	1    	x+2   	x-1 	0   	F
=M=	A210801	u	1    	x+1  	1    	x+2   	x-1 	1   	FN
=M=	A210802	v	1    	x+1  	1    	x+2   	x-1 	1   	F
=M=	A210803	u	1    	x    	1    	x-1   	x+3 	0   	F*
=M=	A210804	v	1    	x    	1    	x-1   	x+3 	0   	F*
=M=	A210805	u	1    	x    	0    	x+2   	x-1 	1   	CFFN
=M=	A210806	v	1    	x    	0    	x+2   	x-1 	1   	FF
=M=	A210858	u	1    	x    	0    	x+n   	x   	0   	CFT*
=M=	A210859	v	1    	x    	0    	x+n   	x   	0   	FN*
=M=	A210860	u	1    	x+1  	0    	x+n   	x   	0   	F
=M=	A210861	v	1    	x+1  	0    	x+n   	x   	0   	F*
=M=	A210862	u	1    	x    	1    	x+n-1 	x   	0   	FN
=M=	A210863	v	1    	x    	1    	x+n-1 	x   	0   	FS
=M=	A210864	u	1    	x    	1    	x+n   	x   	0   	FN
=M=	A210865	v	1    	x    	1    	x+n   	x   	0   	FT
=M=	A210866	u	1    	x    	0    	x+n   	x   	x   	CFT
=M=	A210867	v	1    	x    	0    	x+n   	x   	x   	FN
=M=	A210868	u	1    	x    	0    	x+1   	x-1 	0   	BCFN
=M=	A210869	v	1    	x    	0    	x+1   	x-1 	0   	BBCFNZ
=M=	A210870	u	1    	x    	0    	x+1   	x-1 	1   	CFFN
=M=	A210871	v	1    	x    	0    	x     	x   	1   	CFF
=M=	A210872	u	x    	1    	-1    	x     	x   	1   	BDFZ^
=M=	A210873	v	x    	1    	-1    	x+1   	x-1 	1   	BCFN^
=M=	A210876	u	x    	1    	1    	x     	x   	x   	BCCF^
=M=	A210877	v	x    	1    	1    	x     	x   	x   	BDFNZ^
=M=	A210878	u	x    	2x   	0    	x+1   	x   	1   	DFZ^
=M=	A210879	v	x    	2x   	0    	x+1   	x   	1   	FC*^
#--------------------------------
#--------------------------------
#--------------------------------
#--------------------------------
