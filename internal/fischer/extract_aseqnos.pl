#!perl

# Extract A-numbers
# @(#) $Id$
# 2021-08-19, Georg Fischer

use strict;
use integer;

my $lino = 0;
while(<>) {
    $lino ++;
    foreach my $aseqno ($_ =~ m{A\d{6}}g) {
        print join("\t", $aseqno, $lino) . "\n";
    }
} # while
__DATA__

R(m,n,s) = {integers that can be expressed as the sum of m n-th powers in s or more ways}												S(m,n,s) = {integers that can be expressed as the sum of m n-th powers in exactly s ways}										
Alter uses r(m,n,s) to denote the least such solution																						
Powers do not need to be distinct, but are all positive																						
Solutions do not need to be primitive																						
{}	Indicates an empty set, no solution is possible																					
	Indicates sequence is not present in the OEIS																					
	no known solution?																					
	Insufficient terms in R to distinguish from S																					
	Sequences created as part of this project																					
italic	Indicates the sequence is known to be finite																					
bold	Indicates the sequence is implemented in jOEIS																					
																						
n=2  (squares), s or more ways												n=2  (squares), exactly s ways										
m\s	1	2	3	4	5	6	7	8	9	10		m\s	1	2	3	4	5	6	7	8	9	10
1	A000290	{}	{}	{}	{}	{}	{}	{}	{}	{}		1	A000290	{}	{}	{}	{}	{}	{}	{}	{}	{}
