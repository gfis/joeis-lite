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
