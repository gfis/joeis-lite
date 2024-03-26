#!perl

# dirarr.pl - extract for table 'dirarr'
# @(#) $Id$
# 2024-03-25, Georg Fischer

use strict;
use integer;
use warnings;

while (<>) {
    my ($aseqno, $superclass, $name, $keyword, $range, @rest) = split(/\t/); 
    next if ($aseqno !~ m{\AA\d+\Z});
    $range =~ s{\.\..*}{};
	if ($keyword =~ m{tab[lf]}) { 
		print join("\t", $aseqno, $range, $superclass) ."\n";
    }
} # while <>
__DATA__
A371067	LambdaSequence	E.g.f. satisfies A(x) = 1 + x*exp(x^2*A(x)^2).	nonn,new	0..20	2024-03-12/lambd	_Seiichi Manyama_
A371068	LambdaSequence	E.g.f. satisfies A(x) = 1 + x*exp(x^3*A(x)^3).	nonn,new	0..20	2024-03-12/lambd	_Seiichi Manyama_
A371069	nyi F	Positions of records in A370998.	nonn,hard,more,new	1..54	nyi	_Hugo Pfoertner_
A371070	nyi Fo	a(n) is the number of distinct volumes > 0 of tetrahedra with the sum of their integer edge lengths equal to n.	nonn,new	6..63	nyi	_Hugo Pfoertner_
