#!perl

# notuples.pl - A211800	null	Number of ordered triples (w,x,y) with all terms in {1,...,n} and 2w^2<x^2+y<2.
# @(#) $Id$
# 2022-02-02, Georg Fischer

use strict;
use warnings;
use integer;

my ($aseqno, $callcode, $tuple, $range, $cond) = ("","","","","");
while (<>) {
    my $line = $_;
    $line =~ s{\s+\Z}{}; # chompr
    if (0) {
    } elsif ($line =~ m{\A(A\d+)\tnull\tNumber +of +[^\(]*\(([^\)]+)\) +(with +all +terms|such +that +x +and +y +are) +in +[\{\(]([^\}\)]+)[\}\)] +and +([^\.]+)}) {
        ($aseqno, $tuple, $range, $cond) = ($1, $2, $4, $5);
        my @terms = split(/\, */, $tuple);
        $callcode = scalar(@terms) == 4 ? "A210286" : "A211422";
        $cond =~ s{ }{}g;
        $cond =~ s{(\d)([a-z])}{$1\*$2}g;       # 2x
        $cond =~ s{([w-z])([w-z])}{$1\*$2}g;    # wx
        $cond =~ s{([w-z])([w-z])}{$1\*$2}g;    # yz
        $cond =~ s{([a-z])\^2}{$1\*$1}g;        # w^2
        $cond =~ s{(\([^\)]+\))\^2}{$1\*$1}g;   # (w+x)^2 
        $cond =~ s{([a-z])\^3}{$1\*$1\*$1}g;    # w^3
        $cond =~ s{([a-z])\^4}{$1\*$1\*$1\*$1}g;# w^4
        $cond =~ s{([\<\>\=\+\-]+)}{ $1 }g;
        $cond =~ s{ \= }{ \=\= }g;
        $cond =~ s{w ([\=\<\>]+) harmonicmeanof\{x\,y\,z\}}{w*(y*z + x*z + x*y) $1 3*x*y*z}g;
        $cond =~ s{w ([\=\<\>]+) \(geometricmeanofx\,y\,z\)}{w*w*w $1 x*y*z}g;
        if (0) {
        } elsif ($range =~ m{1\,\.\.\.\,n}) {
            $range = "n -> new Long[] { 1L, n }";
        } elsif ($range =~ m{\-n\,\.\.\.\,0\,\.\.\.\,n}) {
            $range = "n -> new Long[] { -n, n }";
        } elsif ($range =~ m{\-n\,\.\.\.\,\-1\,1\,\.\.\.\,n}) {
            $range = "n -> new Long[] { -n, -1, 1, n }";
            $callcode = "A211631";
        } else {
            # $range = "??$range??";
        }
        print join("\t", $aseqno, "parmof3", 0, $callcode, $range, "(n,$tuple) -> $cond") ."\n";
    } elsif ($line =~ m{\A(A\d+)\tnull\tXXXNumber of 2 [xX] 2 matri [^\(]*\(([^\)]+)\) with all terms in [\{\(]([^\}\)]+)[\}\)] and ([^\.]+)}) {
        ($aseqno, $tuple, $range, $cond) = ($1, $2, $3, $4);
        print join("\t", "#", $aseqno, "parmof3", 0, $callcode, $range, "(n,$tuple) -> $cond") ."\n";
    }
} # while
#----
__DATA__
A212151	null	Number of 2 X 2 matrices M of positive integers such that permanent(M) < n.	nonn,easy,	10001
A212240	null	Number of 2 X 2 matrices M of with all terms in {1,...,n} and permanent(M) >= n.	nonn,synth	34
A212241	null	Number of 2 X 2 matrices M of with terms in {1,...,n} such that permanent(M) > n.	nonn,synth	34

A211810	null	Number of ordered triples (w,x,y) with all terms in {1,...,n} and 2w^2>x^2+y^2.	nonn,synth	41
A211811	null	Number of ordered triples (w,x,y) with all terms in {1,...,n} and 2w^3>x^3+y^3.	nonn,synth	41
A211812	null	Number of 4-tuples (w,x,y,z) with all terms in {1,...,n} and w*x<=3*y*z.	nonn,synth	34
A211917	null	Number of (w,x,y,z) with all terms in {1,...,n} and w*x<3*y*z.	nonn,synth	34
A211918	null	Number of (w,x,y,z) with all terms in {1,...,n} and w*x>3*y*z.	nonn,synth	36
A211631	null	Number of ordered triples (w,x,y) with all terms in {-n,...-1,1,...,n} and w^2>x^2+y^2.	nonn,synth	38
A211632	null	Number of ordered triples (w,x,y) with all terms in {-n,...-1,1,...,n} and 2w^2>x^2+y^2.	nonn,synth	36

A211061	parmof3	0	A210286	n -> new Long[] { 1L, n }	(n, w, x, y, z) -> w*z - x*y >= n	d>=n

A212103	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w == harmonicmeanof{x,y,z}
A212104	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w <= harmonicmeanof{x,y,z}
A212105	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w > harmonicmeanof{x,y,z}
A212106	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w < harmonicmeanof{x,y,z}
A212107	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w >= harmonicmeanof{x,y,z}
A212108	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w*x - y*z < n
A212109	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w*x - y*z <= n
A212110	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w*x + y*z == n*n
A212111	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w*x + y*z < n*n
A212132	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w*x + y*z >= n*n
A212136	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w*x + y*z > n*n
A212141	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w < (geometricmeanofx,y,z)
A212142	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w >= (geometricmeanofx,y,z)
A212143	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w <= (geometricmeanofx,y,z)
A212144	parmof3	0	A210000	1,...,n	(n,w,x,y,z) -> w > (geometricmeanofx,y,z)
