#!perl
# @(#) $Id$
# Generate integer-sided triangles
# 2024-04-03, Georg Fischer
use strict;
use integer;
use warnings;

while (<DATA>) {
    next if ! m{\AA\d+};
    my ($aseqno, $callcode, $offset, $parm1, $parm2, $parm3, $parm4, @rest) = split(/\t/);
    my $cond = "s -> true";
    while ($parm4 =~ s{(acute|isosceles|obtuse|right|scalene)}{xx}) {
      $cond .= " \&\& is" . ucfirst($1) . "(s)";
    }
    while ($parm4 =~ s{(relativ\w+ prime)}{xx}) {
      $cond .= " \&\& hasCoPrimeSides(s)";
    }
    while ($parm4 =~ s{(prime)}{xx}) {
      $cond .= " \&\& hasPrimeSides(s)";
    }
    while ($parm4 =~ s{(integ\w+ area)}{xx}) {
      $cond .= " \&\& hasIntArea(s)";
    }
    while ($parm4 =~ s{(integ\w+ inrad\w+)}{xx}) {
      $cond .= " \&\& hasIntInRadius(s)";
    }
    $cond =~ s{true *\&\& *}{};
    $parm4 =~s {with *perimeter|integer *triangle|side *lengths?}{}ig;
    print join("\t", $aseqno, $callcode, $offset, $parm1, $parm2, $cond, $parm4) . "\n";
} # while
__DATA__
A070090	parmof3	0	A070080	COND_N	cccc	Number of scalene integer triangles with perimeter n and prime side lengths.	nonn	1..90	expr_gen/lambda	_Reinhard Zumkeller_
A070091	parmof3	0	A070080	COND_N	cccc	Number of isosceles integer triangles with perimeter n and relatively prime side lengths.	nonn	1..81	nyi	_Reinhard Zumkeller_
A070092	parmof3	0	A070080	COND_N	cccc	Number of isosceles integer triangles with perimeter n and prime side lengths.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070093	parmof3	0	A070080	COND_N	cccc	Number of acute integer triangles with perimeter n.	nonn	1..1000	expr_gen/lambda	_Reinhard Zumkeller_
A070094	parmof3	0	A070080	COND_N	cccc	Number of acute integer triangles with perimeter n and relatively prime side lengths.	nonn	1..72	nyi	_Reinhard Zumkeller_
A070095	parmof3	0	A070080	COND_N	cccc	Number of acute integer triangles with perimeter n and prime side lengths.	nonn	1..90	expr_gen/lambda	_Reinhard Zumkeller_
A070096	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and relatively prime side lengths which are both acute and scalene.	nonn	1..75	nyi	_Reinhard Zumkeller_
A070097	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and prime side lengths which are both acute and scalene.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070098	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n which are acute and isosceles.	nonn	1..10000	deriv	_Reinhard Zumkeller_
A070099	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and relatively prime side lengths which are acute and isosceles.	nonn	1..85	nyi	_Reinhard Zumkeller_
A070100	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and prime side lengths which are acute and isosceles.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070101	parmof3	0	A070080	COND_N	cccc	Number of obtuse integer triangles with perimeter n.	nonn	1..1000	unkn	_Reinhard Zumkeller_
A070102	parmof3	0	A070080	COND_N	cccc	Number of obtuse integer triangles with perimeter n and relatively prime side lengths.	nonn	1..71	nyi	_Reinhard Zumkeller_
A070103	parmof3	0	A070080	COND_N	cccc	Number of obtuse integer triangles with perimeter n and prime side lengths.	nonn	1..90	expr_gen/lambda	_Reinhard Zumkeller_
A070104	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and relatively prime side lengths which are obtuse and scalene.	nonn	1..71	nyi	_Reinhard Zumkeller_
A070105	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and prime side lengths which are obtuse and scalene.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070106	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n which are obtuse and isosceles.	nonn	1..90	unkn	_Reinhard Zumkeller_
A070107	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and relatively prime side lengths which are obtuse and isosceles.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070108	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n and prime side lengths which are obtuse and isosceles.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070109	parmof3	0	A070080	COND_N	cccc	Number of right integer triangles with perimeter n and relatively prime side lengths.	nonn	1..20000	nyi	_Reinhard Zumkeller_
A070138	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with an integer area having relatively prime sides a, b and c such that a + b + c = n.	nonn	1..10000	nyi	_Reinhard Zumkeller_
A070139	parmof3	0	A070080	COND_N	cccc	Number of isosceles integer triangles with perimeter n having integral area.	nonn	1..1000	anopan	_Reinhard Zumkeller_
A070140	parmof3	0	A070080	COND_N	cccc	Number of acute integer triangles with perimeter n having integral area.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070141	parmof3	0	A070080	COND_N	cccc	Number of obtuse integer triangles with perimeter n having integral area.	nonn	1..90	nyi	_Reinhard Zumkeller_

A070110	parmof3	0	A070080	FILTER	cccc	an integer triangle with relatively prime side lengths.	nonn	1..789	nyi	_Reinhard Zumkeller_
A070111	parmof3	0	A070080	FILTER	cccc	an integer triangle with prime sides.	nonn	1..65	nyi	_Reinhard Zumkeller_
A070112	parmof3	0	A070080	FILTER	cccc	a scalene integer triangle.	nonn	1..920	nyi	_Reinhard Zumkeller_
A070113	parmof3	0	A070080	FILTER	cccc	a scalene integer triangle with relatively prime side lengths.	nonn	1..596	nyi	_Reinhard Zumkeller_
A070114	parmof3	0	A070080	FILTER	cccc	a scalene integer triangle with prime side lengths.	nonn	1..40	nyi	_Reinhard Zumkeller_
A070115	parmof3	0	A070080	FILTER	cccc	an isosceles integer triangle.	nonn	1..365	nyi	_Reinhard Zumkeller_
A070116	parmof3	0	A070080	FILTER	cccc	an isosceles integer triangle with relatively prime side lengths.	nonn	1..56	nyi	_Reinhard Zumkeller_
A070117	parmof3	0	A070080	FILTER	cccc	an isosceles integer triangle with prime side lengths.	nonn	1..48	nyi	_Reinhard Zumkeller_
A070118	parmof3	0	A070080	FILTER	cccc	an acute integer triangle.	nonn	1..431	nyi	_Reinhard Zumkeller_
A070119	parmof3	0	A070080	FILTER	cccc	an acute integer triangle with relatively prime side lengths.	nonn	1..57	nyi	_Reinhard Zumkeller_
A070120	parmof3	0	A070080	FILTER	cccc	an acute integer triangle with prime side lengths.	nonn	1..47	nyi	_Reinhard Zumkeller_
A070121	parmof3	0	A070080	FILTER	cccc	an acute scalene integer triangle.	nonn	1..47	nyi	_Reinhard Zumkeller_
A070122	parmof3	0	A070080	FILTER	cccc	an acute scalene integer triangle with relatively prime side lengths.	nonn	1..229	nyi	_Reinhard Zumkeller_
A070123	parmof3	0	A070080	FILTER	cccc	an acute scalene integer triangle with prime side lengths.	nonn	1..1778	nyi	_Reinhard Zumkeller_
A070124	parmof3	0	A070080	FILTER	cccc	an acute isosceles integer triangle.	nonn	1..59	nyi	_Reinhard Zumkeller_
A070125	parmof3	0	A070080	FILTER	cccc	an acute isosceles integer triangle with relatively prime side lengths.	nonn	1..55	nyi	_Reinhard Zumkeller_
A070126	parmof3	0	A070080	FILTER	cccc	an acute isosceles integer triangle with prime side lengths.	nonn	1..46	nyi	_Reinhard Zumkeller_
A070127	parmof3	0	A070080	FILTER	cccc	an obtuse integer triangle.	nonn	1..724	nyi	_Reinhard Zumkeller_
A070128	parmof3	0	A070080	FILTER	cccc	an obtuse integer triangle with relatively prime side lengths.	nonn	1..55	nyi	_Reinhard Zumkeller_
A070129	parmof3	0	A070080	FILTER	cccc	an obtuse integer triangle with prime side lengths.	nonn	1..41	nyi	_Reinhard Zumkeller_
A070130	parmof3	0	A070080	FILTER	cccc	an obtuse scalene integer triangle.	nonn	1..53	nyi	_Reinhard Zumkeller_
A070131	parmof3	0	A070080	FILTER	cccc	an obtuse scalene integer triangle with relatively prime side lengths.	nonn	1..53	nyi	_Reinhard Zumkeller_
A070132	parmof3	0	A070080	FILTER	cccc	an obtuse scalene integer triangle with prime side lengths.	nonn	1..39	nyi	_Reinhard Zumkeller_
A070133	parmof3	0	A070080	FILTER	cccc	an obtuse isosceles integer triangle.	nonn	1..47	nyi	_Reinhard Zumkeller_
A070134	parmof3	0	A070080	FILTER	cccc	an obtuse isosceles integer triangle with relatively prime side lengths.	nonn	1..43	nyi	_Reinhard Zumkeller_
A070135	parmof3	0	A070080	FILTER	cccc	an obtuse isosceles integer triangle with prime side lengths.	nonn	1..35	nyi	_Reinhard Zumkeller_
A070136	parmof3	0	A070080	FILTER	cccc	a right integer triangle.	nonn	1..137	nyi	_Reinhard Zumkeller_
A070137	parmof3	0	A070080	FILTER	cccc	a right integer triangle with relatively prime side lengths.	nonn	1..35	nyi	_Reinhard Zumkeller_
A070142	parmof3	0	A070080	FILTER	ffff	an integer triangle with integer area.	nonn	1..41	nyi	_Reinhard Zumkeller_
A070143	parmof3	0	A070080	FILTER	ffff	an integer triangle with integer area, having relatively prime side lengths.	nonn	1..39	nyi	_Reinhard Zumkeller_
A070144	parmof3	0	A070080	FILTER	ffff	a scalene integer triangle with integer area.	nonn	1..38	nyi	_Reinhard Zumkeller_
A070145	parmof3	0	A070080	FILTER	ffff	an isosceles integer triangle with integer area.	nonn	1..36	nyi	_Reinhard Zumkeller_
A070146	parmof3	0	A070080	FILTER	ffff	an acute integer triangle with integer area.	nonn	1..35	nyi	_Reinhard Zumkeller_
A070147	parmof3	0	A070080	FILTER	ffff	an obtuse integer triangle with integer area.	nonn	1..38	nyi	_Reinhard Zumkeller_
A070148	parmof3	0	A070080	FILTER	ffff	an integer Heronian triangle having triangular area.	nonn	1..89	nyi	_Reinhard Zumkeller_

A070201	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n having integral inradius.	nonn	1..5000	nyi	_Reinhard Zumkeller_
A070202	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with integer inradius, perimeter n and relatively prime side lengths.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070203	parmof3	0	A070080	COND_N	cccc	Number of scalene integer triangles with perimeter n having integral inradius.	nonn	1..5000	nyi	_Reinhard Zumkeller_
A070204	parmof3	0	A070080	COND_N	cccc	Number of isosceles integer triangles with perimeter n having integral inradius.	nonn	1..5000	nyi	_Reinhard Zumkeller_
A070205	parmof3	0	A070080	COND_N	cccc	Number of acute integer triangles with perimeter n having integral inradius.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070206	parmof3	0	A070080	COND_N	cccc	Number of obtuse integer triangles with perimeter n having integral inradius.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070208	parmof3	0	A070080	COND_N	cccc	Number of integer triangles with perimeter n having integral area but not integral inradius.	nonn	1..90	nyi	_Reinhard Zumkeller_
A070209	parmof3	0	A070080	COND_N	cccc	Numbers n such that [A070080(n), A070081(n), A070082(n)] is an integer triangle with integer inradius.	nonn	1..38	nyi	_Reinhard Zumkeller_
A070210	parmof3	0	A070080	FILTER	cccc	integral inradii of integer triangles [A070080(A070209(n)), A070081(A070209(n)), A070082(A070209(n))].	nonn	1..84	nyi	_Reinhard Zumkeller_
A070200	parmof3	0	A070080	FILTER	cccc	Inradii of integer triangles [A070080(n), A070081(n), A070082(n)], rounded values.	nonn	1..90	nyi	_Reinhard Zumkeller_

# A084820		Numbers n such that n, sigma(n) and phi(n) form an integer triangle, where sigma=A000203 is the divisor sum and phi=A000010 the totient.
# A107572	nyi	List of triples a,b,c that are sidelengths of a scalene triangle; a<b<c, lexically by perimeter.	nonn,tabf	1..103	nyi	_Clark Kimberling_
# A107573	nyi	a(n)=least sidelength of n-th triangle listed at A107572.	nonn	1..105	nyi	_Clark Kimberling_
# A107574	nyi	a(n)=middle sidelength of n-th triangle listed at A107572.	nonn	1..95	nyi	_Clark Kimberling_
# A107575	nyi	a(n)=greatest sidelength of n-th triangle listed at A107572.	nonn	1..81	nyi	_Clark Kimberling_
# A107576	nyi	a(n)=perimeter of n-th triangle listed at A107572.	nonn	1..70	nyi	_Clark Kimberling_
# A107577	nyi	a(n)=greatest integer p such that a^p + b^p > c^p, where (a,b,c) is the n-th integer-sided triangle listed at A107572.	nonn	1..105	nyi	_Clark Kimberling_
%N A135622 16*Area^2 of integer triangles [€070080(n),€070081(n),€070082(n)].
%F A135622 a(n)=(u+v+w)*(-u+v+w)*(u-v+w)*(u+v-w), where u=€070080(n), v=€070081(n), w=€070082(n).
%e A135622 €070080(4)=1, €070081(4)=3, €070082(4)=3, so a(4)=(1+3+3)*(-1+3+3)*(1-3+3)*(1+3-3)=35.
%C A307894 Replacing the shorter legs with the sum and absolute difference of the shorter legs may result in an
%Y A307894 Cf. €070081, €070112.
%Y A316841 Other related sequences: A051493, €070080, €070081, €070082, €070110.
%Y A316842 Other related sequences: A051493, €070080, €070081, €070082, €070110.
%Y A333391 Cf. €070082.
%Y A367196 Cf. €316841, €070080 (triangle side lengths).
#N A068964 Numbers that define integer Heronian triangles [prime(a(n)), prime(a(n)+1), A068965(n)] with area A068966(n).
#N A068965 Sides of integer Heronian triangles [prime(A068964(n)), prime(A068964(n)+1), a(n)] with area A068966(n).
#N A068966 Areas of integer Heronian triangles [prime(A068964(n)), prime(A068964(n)+1), A068965(n)].
#N A068967 Numbers that define integer Heronian triangles [a(n), prime(a(n)), A068968(n)] with area A068969(n).
#N A068968 Sides of integer Heronian triangles [A068967(n), prime(A068967(n)), a(n)] with area A068969(n).
#N A068969 Areas of integer Heronian triangles [A068967(n), prime(A068967(n)), A068968(n)].
%N A316851 Consider integer triangles as listed in rows of table €316841. Sequence gives perimeters of these triangles in the same order.
%N A316852 Consider primitive integer triangles as listed in rows of table €316842. Sequence gives perimeters of these triangles in the same order.
%N A316853 Consider integer triangles as listed in rows of table €316841. Sequence gives 16*area^2 for these triangles in the same order.
%N A317181 Consider primitive integer triangles as listed in rows of table €316842. Sequence gives 16*area^2 for these triangles in the same order.
%N A317182 Consider integer triangles as listed in rows of table €316841. Sequence gives sorted and uniqued values of 16*area^2 for these triangles.
%N A317183 Consider primitive integer triangles as listed in rows of table €316842. Sequence gives sorted and uniqued values of 16*area^2 for these triangles.
%N A350038 Numbers that are the perimeter of a primitive 60-degree integer triangle.
%N A350039 Perimeters of more than one primitive 60-degree integer triangle.
%N A350045 Numbers that are the perimeter of a primitive 120-degree integer triangle.
%N A350047 Perimeters of more than one primitive 120-degree integer triangle.
%N A350347 Consider primitive 120-degree integer triangles with sides A < B < C = A002476(n). This sequence gives the values of B.