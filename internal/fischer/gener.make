#!make

# Makefile in gits/joeis-lite/internal/fischer: sequence generation and testing
# @(#) $Id$
# 2019-05-20, Georg Fischer: copied from makefile
#
GITS=../../..
JOEIS=$(GITS)/../gitups/joeis
COMMON=$(GITS)/OEIS-mat/common
LINREC=$(GITS)/OEIS-mat/linrec
LITE=$(GITS)/joeis-lite
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
RAMATH=java -cp $(GITS)/ramath/dist/ramath.jar org.teherba.ramath
MANY=999999
D=0
TO=4
N=16
OFS=1
WITHB=-b $(COMMON)/bfile -t $(TO)
JOPT=-Doeis.big-factor-limit=1000000000 -Xmx2g
BATLIT=java $(JOPT) -cp  $(LITE)/dist/joeis-lite.jar irvine.test.BatchTest -v $(WITHB)
BATJOE=java $(JOPT) -cp $(JOEIS)/build.tmp/joeis.jar irvine.test.BatchTest -v $(WITHB)
INIT=0
START=`grep -E "^A" batch.log | tail -n1 | cut -b1-7`
#----------------

all:
	# Possible targets:
	grep -E "^[a-z]" makefile
#----------------------------------
# Generation of groups of sequences
#----------------------------------
SOURCES=CoxeterSequence.java GeneratingFunctionSequence.java DeadSequence.java FiniteSequence.java LinearRecurrence.java PeriodicSequence.java \
	PrependSequence.java ReaderSequence.java Sequence.java SqrtContinuedFraction.java
joeis_push:
	cd $(LITE)/src/irvine/oeis  ; pwd ; cp -upv $(SOURCES) ../../../../../gitups/joeis/src/irvine/oeis/
joeis_pull:
	cd $(JOEIS)/src/irvine/oeis ; pwd ; cp -upv $(SOURCES) ../../../../../gits/joeis-lite/src/irvine/oeis/
#----
purge: # remove all oeis/annn directories
	rm -rf  ../../target/WEB-INF/classes/irvine/oeis/a???
	rm -vrf                    ../../src/irvine/oeis/a??? | grep directory
	rm -vf *.bak
dist:
	cd ../.. ; ant -silent dist 
update: purge
	cd ../.. ; find src | xargs -l -i{} cp -pv ../../gitups/joeis/{} {}
count:
	cd ../.. ; find src -iname "A??????.java" | wc -l
#==========================
remove: # parameter: CC
	rm -f remlist.tmp
	perl -ne 'm{^A(\d\d\d)(\d+)}; print "a$$1/A$$1$$2.java\n";' $(CC).gen > remlist.tmp
	cat remlist.tmp | xargs -l -i{} rm  -f ../../target/WEB-INF/classes/irvine/oeis/{} 
	cat remlist.tmp | xargs -l -i{} rm -vf                    ../../src/irvine/oeis/{} 
OFS=offset
select: # parameter: CC, OFS
	make -f gener.make $(CC)
	head -4 $(CC).gen
	wc -l   $(CC).gen
	make -f gener.make seq4 LIST=$(CC).gen
	$(DBAT) "UPDATE seq4 s \
		SET name    = (SELECT a.name    FROM asname a WHERE s.aseqno = a.aseqno) \
	    ,   offset  = (SELECT a.offset1 FROM asinfo a WHERE s.aseqno = a.aseqno)" 
	$(DBAT) -x "SELECT aseqno, callcode, $(OFS), parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
	$(DBAT) -x "SELECT COUNT(aseqno) FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM joeis)"
gener: # parameter MANY, CC
	head -n$(MANY) $(CC).gen      > ghead.tmp
	perl gen_seq4.pl -d $(D)        ghead.tmp
test: # parameter CC
	rm -f batch.log
	head -n$(MANY) $(CC).gen      > ghead.tmp
	make -f gener.make stripgr LIST=ghead.tmp
	make -f gener.make runbt
	make -f gener.make evaluate
stripgr: # attach terms from 'stripped' to A-numbers for BatchTest
	cut -b1-7  $(LIST) > aseqnos.tmp
	grep -f    aseqnos.tmp $(COMMON)/stripped \
	| head -n$(MANY) > strip.tmp
	wc -l      strip.tmp
runbt: # Run BatchTest for this group
	$(BATLIT)  strip.tmp 2>&1 | tee -a batch.log
evaluate:
	grep  pass batch.log >     $(CC).pass.log
	grep  FA   batch.log | tee $(CC).fail.log
	wc -l $(CC).*.log
single:
	java -jar ../../dist/joeis-lite.jar $(SEQ) $(N) $(OFS)
#--------------------------
cfp_select: 
	make -f gener.make select CC=cfp
	make -f gener.make select CC=cfpcount
	make -f gener.make select CC=cfpleast
	make -f gener.make select CC=cfplen
	make -f gener.make select CC=cfplenmult
	make -f gener.make select CC=cfpmid0
	make -f gener.make select CC=cfpmid1
#----
# A010121	Continued fraction for sqrt(7).
# A040002	Continued fraction for sqrt(5).
cfs:
	perl -ne 'if (m{^(A\d+) Continued fraction for sqrt\((\d+)\)\.})   { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A041009 Denominators of continued fraction convergents to sqrt(7).
# A041010 Numerators of continued fraction convergents to sqrt(8).
cfsnum:
	perl -ne 'if (m{^(A\d+) Numerators of continued fraction convergents to sqrt\((\d+)\)\.})   { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
cfsden:
	perl -ne 'if (m{^(A\d+) Denominators of continued fraction convergents to sqrt\((\d+)\)\.}) { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A003285	Period of continued fraction for square root of n (or 0 if n is a square). 
# A097853	Period of continued fraction for square root of n (or 1 if n is a square).
cfp:
	perl -ne \
	'if (m{^(A\d+) Period of continued fraction for square root of n \(or (\-?\d+) if n is a square\)\.}) { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A013647	Period of continued fraction for sqrt(n) contains no 1's.
# A013648	Numbers n such that period of continued fraction for sqrt(n) contains a single 1.
# A013649	Period of continued fraction for sqrt(n) contains exactly two 1's.
# A013650	Period of continued fraction for sqrt(n) contains exactly three 1's.
# A013651	Period of continued fraction for sqrt(n) contains at least two 1's.
# A013652	Period of continued fraction for sqrt(n) contains at least three 1's.
# A020440	Period of continued fraction for sqrt(n) contains exactly four 1's.
# A020441	Period of continued fraction for sqrt(n) contains exactly five 1's.
# A020442	Period of continued fraction for sqrt(n) contains exactly six 1's.
# A020443	Period of continued fraction for sqrt(n) contains exactly seven 1's.
# A020444	Period of continued fraction for sqrt(n) contains exactly eight 1's.
# A020445	Period of continued fraction for sqrt(n) contains exactly nine 1's.
# A020446	Period of continued fraction for sqrt(n) contains exactly ten 1's.
# A031779	Period of continued fraction for sqrt(n) contains exactly 11 ones.
# A031780	Period of continued fraction for sqrt(n) contains exactly 12 ones.
# PARM1="==" PARM2=11 PARM3=1
cfpcount:
	perl -ne \
	'if (m{^(A\d+) (Numbers [nk] such that )?[Pp]eriod of continued fraction for sqrt\([kn]\) contains (exactly )?(\d+) (one)s\.}) { print "$$1\t$@\t1\t$$3\t$$4\t$$5\n" }' \
	$(COMMON)/names \
	| sed -e "s/\texactly /\t==/" -e "s/\tone/\t1/ " \
	> $@.gen
	perl callcode_wiki.pl -p 2 $@.gen > $@.wiki
#----
# A031700	Least term in period of continued fraction for sqrt(n) is 22.
# A031701	Numbers n such that the least term in the period of the continued fraction for sqrt(n) is 23.
# PARM1=22
cfpleast: 
	perl -ne \
	'if (m{^(A\d+) (Numbers n such that )?(the )?[Ll]east term in (the )?period of (the )?continued fraction for sqrt\(n\) is (\d+)\.}) { print "$$1\t$@\t0\t$$6\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A013643	Numbers n such that continued fraction for sqrt(n) has period 3.
# A013644	Numbers n such that the continued fraction for sqrt(n) has period 4.
# + A002522	a(n) = n^2 + 1 for period 1
cfplen:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has period (\d+)\.}) { print "$$1\t$@\t0\t$$3\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A064848	Period of continued fraction for sqrt(2)*n.
# Offset is 1
cfplenmult:
	perl -ne \
	'if (m{^(A\d+) Period (length )?of (the )?continued fraction for sqrt\((\d+)\)\*n\.}) { print "$$1\t$@\t0\t$$4\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A031598	Numbers n such that continued fraction for sqrt(n) has even period and central term 100.
# A031600	Numbers n such that continued fraction for sqrt(n) has odd period and central terms 12.
# A031413	Numbers n such that continued fraction for sqrt(n) has even period 2*m and the m-th term is 10.
# A031414	Numbers n such that continued fraction for sqrt(n) has odd period and a pair of central terms both equal to 1.
# PARM1=parity, PARM2=central
#           1                             2                                              3                 4           5                                            6                                      7                                     
cfpmidpar:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has (even|odd) period (2\*m )?and (the m\-th|central|a pair of central) terms? (is |both equal to |of the period is |)(\d+)\.}) { print "$$1\t$@\t0\t$$3\t$$7\n" }' \
	$(COMMON)/names \
	| sed -e "s/\teven/\t0/" -e "s/\todd/\t1/ " \
	> $@.gen
	perl callcode_wiki.pl -p 2 $@.gen > $@.wiki
cfpmid0:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has (even) period (2\*m )?and (the m\-th|central|a pair of central) terms? (is |both equal to |of the period is |)(\d+)\.}) { print "$$1\t$@\t0\t$$7\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
cfpmid1:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has (odd) period (2\*m\s?\+\s?1)?and (the m\-th|central|a pair of central) terms? (is |both equal to |of the period is |)(\d+)\.}) { print "$$1\t$@\t0\t$$7\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
cfp_dww:
	# make -f gener.make select CC=cfpmidpar
	$(DBAT) "SELECT s.aseqno, s.parm1, s.parm2 , CAST(s.parm2 AS INT)*CAST(s.parm2 AS INT)+1, \
		substr(d.data, 1, 10) FROM seq4 s, asdata d \
		WHERE s.aseqno = d.aseqno \
		  AND substr(d.data, 1, 10) LIKE CAST(CAST(s.parm2 AS INT)*CAST(s.parm2 AS INT)+1 AS CHAR) || '%' \
		ORDER BY 1"
mod:
	perl -ne \
	'if (m{^(A\d+) Numbers that are congruent to \{?([0-9\-\,]+)}) { print "$$1\t$@\t1\t1\t1\t$$2\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#==========================
BaseTwoDigits:
	cat represented-by-2-digits.group > group.tmp
	make run PATTERN=$@
CoxeterSequence:
	cp  $(LINREC)/coxf1.tmp coxf1.txt
	cat           coxf1.txt \
	| sed -e "s/coxf/CoxeterSequence/" > group.tmp
	make run PATTERN=$@
FiniteSequence:
	cat finifu_check.txt > group.tmp
	make run PATTERN=$@
genf1:
	cp  $(LINREC)/catgf2.txt catgf2.txt
	make notin_joeis LIST=catgf2.txt
	cut -b1-7 notin_joeis.tmp > notin.tmp
	grep -f notin.tmp catgf2.txt \
	| grep -E "orgf" \
	| sed -e "s/orgf/GeneratingFunctionSequence/" > group.tmp
	wc -l group.tmp
	make run PATTERN=GeneratingFunctionSequence
genf2:
	cp  $(LINREC)/catgf2.txt catgf2.txt
	cat catgf2.txt \
	| grep -E "orgf" \
	| sed -e "s/\torgf\t/\tGeneratingFunctionSequence\t/" > group.tmp
	wc -l group.tmp
genf3:
	make run PATTERN=GeneratingFunctionSequence
#---------------------------
lrixall:
	$(DBAT) -x "SELECT DISTINCT 'A' || i.seqno \
		FROM  lrindx i \
		WHERE 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 1 " \
	>     $@.tmp
	wc -l $@.tmp
	make lrgroup LIST=$@.tmp INIT=0
lrstart:
	make lrgroup LIST=err-04-11.log
lrgroup: # parameter LIST, INIT
	make seq # LIST
	$(DBAT) -x "SELECT s.aseqno, 'LinearRecurrence2' \
	  , i.signature, d.data \
		FROM seq s, lrindx i, bfdata d \
		WHERE s.aseqno = 'A' || i.seqno \
		  AND s.aseqno = d.aseqno \
		ORDER BY 1" \
	> 			 $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	perl patch_parms.pl -a lrstrip -i $(INIT) $@.tmp \
	>        group.tmp
	head -n4 group.tmp
	wc   -l  group.tmp
	make run
#--------------------------
lrjoeis_test:
	$(DBAT) -x "SELECT j.aseqno \
		FROM joeis j \
		WHERE j.superclass = 'LinearRecurrence' \
		ORDER BY 1" \
	>        group.tmp
	wc -l    group.tmp
	make strip
#-------------------------
gen_mmac:
	# Caution, change .man -> .tmp next time!
	head -n$(MANY) $(LINREC)/mmac_err02.man \
	| perl patch_parms.pl -d $(D) \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
	perl gen_pattern.pl -n $(COMMON)/names $@.tmp
batch_mmac:
	cut -b1-7 errors-2019-04-02.txt > x.tmp
	grep -f x.tmp $(COMMON)/stripped > subset.tmp
	wc -l subset.tmp
	make test
batch_cfsqrt:
	cut -b1-7 cfsqrt_gen.log > x.tmp
	grep -f x.tmp $(COMMON)/stripped > subset.tmp
	wc -l subset.tmp
	make test
#--------------------------
basdig: basdig2 basdig2t basdig3
#----
# A043408 Numbers n such that number of 3's in base 7 is 4.	nonn,base,synth	1..35
# A043409 Numbers whose number of 4's in base 7 is 1.	nonn,base,easy,changed,synth	1..52
basdig1:
	perl -ne \
	'if (m{^(A\d+)\s+(Integers|Numbers) (such that|[a-z] such that|whose) number of (\d+).s in base (\d+) is (\d+)}) { print join("\t", $$1, "$@", 0, $$5, $$4, $$6) . "\n" }' \
	$(COMMON)/names \
	>   $@.gen
	echo "A043494	basdig1	1	10	1	1" >> $@.gen
	echo "A043509	basdig1	1	10	5	1" >> $@.gen
	cat $@.gen
#----
# A039092 Numbers whose base-9 representation has the same number of 2's and 4's.	nonn,base,easy,changed,synth
# A039093 Numbers n such that representation in base 9 has same number of 2's and 5's.	nonn,base,easy,synth
# A039124 Numbers n such that representation in base 10 has same number of 1's and 6's.	nonn,base,easy,synth	1..69
# A039125 Numbers n whose base-10 representation has the same number of 1's and 7's.	nonn,base,easy,	1..5000
basdig2:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers n such that representation in base (\d0?) has (the )?same (nonzero )?number of (\d)\Ds and (\d)\Ds}) { print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>   $@.gen
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [^b]+base.(\d0?) representation has (the )?same (nonzero )?number of (\d)\Ds and (\d)\Ds}) { print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>>  $@.gen
	cat $@.gen
#----
# A039603 Numbers n such that representation in base 12 has same nonzero number of 0's and 11's.
# A039225 Numbers n whose base-12 representation has the same number of 1's and 7's.
basdig2t:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers (n such that representation in base (\d[12])|whose base[ \-](\d[12]) representation) has (the )?same (nonzero )?number of (\d+)\D+(\d+)}) { print join("\t", $$1, "$@", 0, $$3, $$6, $$7, $$8) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	| tee $@.gen
#----
# A039589 Numbers n such that representation in base 6 has same number of 2's, 3's and 4's.
basdig3:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers n such that representation in base (\d0?) has (the )?same (nonzero )?number of (\d)\Ds\, (\d)\Ds and (\d)\Ds}) { print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>   $@.gen
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [^b]+base.(\d0?) representation has (the )?same (nonzero )?number of (\d)\Ds\, (\d)\Ds and (\d)\Ds}) { print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>>  $@.gen
	cat $@.gen
#---
# A043555 Number of runs in base-3 representation of n.	nonn,base,easy,	0..1000
basrun:
	perl -ne \
	'if (m{^(A\d+)\s+Number of runs in base.(\d+) representation of n}) { print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	cat $@.gen
#----
# A043569 Numbers n such that base 2 representation has exactly 2 runs.	nonn,base,	1..10000
basrunc:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers n such that base (\d+) representation has exactly (\d+) runs}) { print join("\t", $$1, "$@", 0, $$2, $$3) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	cat $@.gen
#----
# A043796 Number of runs in the base 3 representation of n is congruent to 5 mod 7.	nonn,base,changed,synth	1..46
# A043797 Numbers n such that number of runs in the base 3 representation of n is congruent to 6 mod 7.	nonn,base,synth	1..45
basrunm:
	perl -ne \
	'if (m{^(A\d+)\s+(Numbers [a-z] such that )?[Nn]umber of runs in the base (\d+) representation of [a-z] is congruent to (\d+) mod (\d+)}) { print join("\t", $$1, "$@", 0, $$3, $$4, $$5) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	cat $@.gen
#--------------------------
dex: dex_impl dex_nimpl
dex_sel: # names: Annnnnn Decimal expansion of ... and in jOEIS
	$(DBAT) "SELECT a.aseqno, substr(j.superclass, 1, 8), n.name, a.keyword \
		FROM asinfo a, bfinfo b, asname n LEFT JOIN joeis j ON n.aseqno = j.aseqno \
		WHERE a.aseqno = n.aseqno \
		  AND b.aseqno = n.aseqno \
		  AND a.keyword LIKE '%cons%' \
		  AND b.maxlen = 1 \
		ORDER BY 1" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
dex_extr:
	perl extract_dex.pl dex_nimpl.tmp \
	| grep -vE "^#" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
dex_joeis:
	$(RAMATH).symbolic.ShuntingYard joeis -f dex_extr.tmp \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
#--------
# A030801 [ exp(17/24)*n! ].
# A030802 a(n) = floor( exp(13/24)*n! ).
# A030810 Floor(exp(19/23) * n!).

flexfact:
	perl -ne \
	'if (m{^(A\d+)\s+\[\s*exp\((\d+)\/(\d+)\)\s*\*\s*n\s*\!\s*\]}) { print join("\t", $$1, "$@", 0, $$2, $$3) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl -ne \
	'if (m{^(A\d+)\s+(a\(n\)\s*\=\s*)?[fF]loor\s*\(\s*exp\(\s*(\d+)\/(\d+)\)\s*\*\s*n\!\s*\)}) { print join("\t", $$1, "$@", 0, $$3, $$4) . "\n" }' \
	$(COMMON)/names \
	| tee -a $@.gen
#--------
juxall:
	grep -Ei "(Champernowne|juxtapose)" $(COMMON)/names > $@.tmp
	head -4 $@.tmp
	wc -l   $@.tmp
#--------
jux: jux2n_1 juxdiff juxdig12b juxleast juxn juxncomp juxpos
#----
# A031057 Write 2n-1 in base 8 and juxtapose.	nonn,base,synth
jux2n_1:
	perl -ne \
	'if (m{^(A\d+)\s+Write (the odd numbers )?(2n\-1) in base (\d+) and juxtapose}) { print join("\t", $$1, "$@", 0, $$4) . "\n" }' \
	$(COMMON)/names                  > $@.gen
	echo "A031312	jux2n_1	0	10" >> $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030413 Write (n+1)st Fibonacci number in base 4 and juxtapose. nonn,synth
# A030604 Write the Fibonacci numbers in base 6 and juxtapose.    nonn,easy,base,synth
# A031027 Write the (n+1)st Fibonacci number in base 7 and juxtapose.     nonn,base,synth# A031027 Write the (n+1)st Fibonacci number in base 7 and juxtapose.
juxfib:
	perl -ne \
	'if (m{^(A\d+)\s+Write (the )?(\(n\s*\+\s*1\)st )?Fibonacci numbers? in base (\d+) (for \S+ )?and juxtapose}) { print join("\t", $$1, "$@", 0, $$4) . "\n" }' \
	$(COMMON)/names >                  $@.gen
	echo "A030324	juxfib	0	2"  >> $@.gen
	echo "A031324	juxfib	0	10" >> $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030349 (# 1's)-(# 0's) in first n terms of A030341.	nonn,synth
juxdiff:
	perl -ne \
	'if (m{^(A\d+)\s+\(\#\s*(\d+)[^\#]+\#\s*(\d+)\S+ in first n terms of (A\d+)}) { print join("\t", $$1, "$@", 0, $$2, $$3, $$4, substr(lc($$4), 0, 4)) . "\n" }' \
	$(COMMON)/names | tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
juxdig12b:
	perl -ne \
	'if (m{^(A\d+)\s+(Numbers n such that )?(\d+) and (\d+) occur juxtaposed in the base (\d+) representation of n but not of n([\-\+]1)\.}) { print join("\t", $$1, "$@", 1, $$3, $$4, $$5, $$6) . "\n" }' \
	$(COMMON)/names \
	| sed -e "s/\t\-1/\tsubtract/" -e "s/\t+1/\tadd/ " \
	> $@.gen
	wc -l $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A029494 Numbers n such that n divides the (left) concatenation of all numbers <= n written in base 25 (most significant digit on left).	nonn,base,synth
# A029495 Numbers n such that n divides the (right) concatenation of all numbers <= n written in base 2 (most significant digit on right).	nonn,base,bref,synth
# A061931 Numbers n such that n divides the (right) concatenation of all numbers <= n written in base 2 (most significant digit on right).	nonn,base,more,synth
juxdiv:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers \w such that \w divides the \((left|right)\) concatenation of all numbers \<\= \w written in base (\d+) \(most significant digit on (left|right)\)}) { print join("\t", $$1, "$@" . substr($$2, 0, 1) . substr($$4, 0, 1), 0, $$3) . "\n" }' \
	$(COMMON)/names \
	| perl -pe 'if (m{A06}) { s{juxdiv}{juxdjv} }' \
	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030304 Least k such that base 2 representation of n begins at s(k), where s=A030190 (or equally A030302).	nonn,base,synth
juxleast:
	perl -ne \
	'if (m{^(A\d+)\s+(a\(n\)=)?[Ll]east k such that (the )?base (\d+) representation of n begins at s\(k\)\, where s=(A\d+)}) { print join("\t", $$1, "$@", 0, $$4, $$5, substr(lc($$5), 0, 4)) . "\n" }' \
	$(COMMON)/names | tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030998 Write n in base 7 and juxtapose.	nonn,base,cons,easy,tabf,synth
juxn:
	perl -ne \
	'if (m{^(A\d+)\s+(The almost\-natural numbers\: )?[Ww]rite n in base (\d+) and juxtapose}) { print join("\t", $$1, "$@", 0, $$3) . "\n" }' \
	$(COMMON)/names                  > $@.gen
	echo "A030190	juxn	0	2"  >> $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A031016 Write n in base 7, then complement each digit (d -> 6-d) and juxtapose.	nonn,base,synth
juxncomp:
	perl -ne \
	'if (m{^(A\d+)\s+Write n in base (\d+)\, (then )?complement each digit (\(d\s*\-\>\s*(\d+)\-d\) )?and juxtapose}) { print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names | tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030324 Triangle read by rows, where row k consists of the binary digits of Fibonacci(k+1)
juxnrev:
	perl -ne \
	'if (m{^(A\d+)\s+Triangle T\(n\,k\)\: [Ww]rite n in base (\d+)\, reverse order of digits}) { print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A262" \
 	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030318 Position of n-th 0 in A030317
juxpos:
	perl -ne \
	'if (m{^(A\d+)\s+Position of n-th (\d+) in (A\d+)}) { print join("\t", $$1, "$@", 0, $$2, $$3, substr(lc($$3), 0, 4)) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A0209|A0540|A030298|A030496" \
	> $@.gen
	wc -l $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030305 Length of n-th run of 0's in A030302.	nonn,synth
# A030336 Length of n-th run of digit 0 in A003137.
juxrun:
	perl -ne \
	'if (m{^(A\d+)\s+Length of n\-th run of (digit )?(\d+)[^A]+(A\d+)}) { print join("\t", $$1, "$@", 0, $$3, $$4, substr(lc($$4), 0, 4)) . "\n" }' \
	$(COMMON)/names | tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#--------------------------
palb:
	perl -ne \
	'if (m{^(A\d+)\s+.*palindrom(es|ic)\s+in\s+base\s+(\d+)}) { print join("\t", $$1, "$@", 1, $$3) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	wc -l $@.gen
#--------------------------
polyn:
	cat $(COMMON)/names \
	| perl -ne 'if (! m{\.\.\.} and m{\A(A\d{6}\s+\w\(([a-z])\)\s*\=\s*[ \d\+\-\*\/\!ank\[\]\{\}\(\)\^]+)\.}) { print "$$1\n"; }' \
	| sed -e "s/ /\t/" -e "s/ //g" -e "y/[]{}/()()/" \
	| grep -v '\.\.' \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) "SELECT aseqno, info \
		FROM  seq2 \
		WHERE aseqno NOT IN (SELECT aseqno FROM JOEIS) \
		ORDER BY 1" \
	| tee $@.txt
	wc   -l $@.txt
#-------------------
power: # names: Annnnnn a(n) = (\d+)*n^(\d+) +- (\d+)
	perl -ne 'print if m{\AA\d+\s+a\(n\)\s*\=\s*\d+\*?n\^\d+\s*(\-|\+)\s*\d+[\.\s]*\Z}i' \
	$(COMMON)/names | tee $@.tmp
# A158627 a(n) = 484*n^2-22.
# A158643 a(n) = 676*n^2 + 26.
# A158644 a(n) = 52*n^2 + 1.
# A158645 a(n) = 729*n^2 + 27.
# A158646 a(n) = 54*n^2 + 1.
#-------------------
such_prime:
	grep Numbers $(COMMON)/names | grep -E 'such *that' | grep -E 'is *prime' \
	| grep -v '[BRZFGPofgd]' \
	| sed -e "s/ /\t/" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) "SELECT aseqno, info \
		FROM  seq2 \
		WHERE aseqno NOT IN (SELECT aseqno FROM JOEIS) \
		ORDER BY 1" \
	>       $@.txt
	wc   -l $@.txt
	$(DBAT) "SELECT j.aseqno, j.superclass \
		FROM  seq2 s, joeis j \
		WHERE s.aseqno = j.aseqno \
		ORDER BY 1" \
	>       $@.j.txt
	wc   -l $@.j.txt
#--------------------------
mmacall:
	make seq2 LIST=$(LINREC)/lrlink_mma2.tmp
	$(DBAT) -x "SELECT aseqno, info \
		FROM seq2 \
		WHERE aseqno NOT IN (SELECT aseqno FROM seq) \
		ORDER BY 1 " \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
gen_linrec:
	# rm -rf oeis
	# mkdir  oeis ||:
	perl gen_linrec.pl mmacall.txt
#--------------------------
mmacheck:
	sed -e "s/ /\t/g" mmacall.txt | cut -f1,3 > $@.tmp
	perl gen_linrec.pl mmacall.tmp
#--------------------------
indx_nojoeis:
	$(DBAT) "SELECT COUNT(seqno) \
	    FROM  lrindx i \
	    WHERE 'A' || seqno NOT IN (SELECT aseqno FROM joeis) \
	"
#----------------
finifu_check: # Sequences with keywords "fini,full"
	$(DBAT) -x "SELECT a.aseqno, 'FiniteSequence', d.data \
			, '# ' || a.termno || ' ' || n.name \
	    FROM  asinfo a, asdata d, asname n \
	    WHERE a.aseqno = d.aseqno \
	      AND a.aseqno = n.aseqno \
	      AND a.aseqno NOT IN (SELECT j.aseqno FROM joeis j) \
	      AND a.keyword LIKE '%fini%'  \
	      AND a.keyword LIKE '%full%'  \
	      AND (a.keyword LIKE '%synth%'  \
	       OR EXISTS  \
	              ( SELECT b.aseqno \
	                  FROM bfinfo b \
	                  WHERE b.aseqno = a.aseqno \
	                    AND b.bfimax - b.bfimin + 1 <= a.termno \
	              ) \
	      ) \
	    ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#
dummy:
		echo " \
	  "
#----
fininof_check: # Sequences with keywords "fini", but no "full"
	$(DBAT) -x "SELECT i.aseqno, i.termno \
	    FROM  asinfo i \
	    WHERE i.keyword     LIKE '%fini%'  \
	      AND i.keyword NOT LIKE '%full%'  \
	    ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#----
finibf_check: # Sequences with keywords "fini,full", but full terms are in b-file only
	$(DBAT) -x "SELECT i.aseqno, i.termno, b.bfimax - b.bfimin + 1 \
	    FROM  asinfo i \
	    LEFT JOIN bfinfo b ON b.aseqno = i.aseqno \
	    WHERE i.termno < b.bfimax - b.bfimin + 1 \
	      AND b.bfimax - b.bfimin + 1 <= 256 \
	      AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
	      AND i.keyword LIKE '%fini%'  \
	      AND i.keyword LIKE '%full%'  \
	    ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#---------------------------
cofr_joeis:
	$(DBAT) "SELECT COUNT(aseqno) \
	    FROM  asinfo i \
	    WHERE aseqno     IN (SELECT aseqno FROM joeis) \
	      AND i.keyword LIKE '%cofr%' \
	"
	$(DBAT) "SELECT COUNT(aseqno) \
	    FROM  asinfo i \
	    WHERE aseqno NOT IN (SELECT aseqno FROM joeis) \
	      AND i.keyword LIKE '%cofr%' \
	"
#---------------------------
cfsqrt: cfsqrt_prep cfsqrt_gen
cfsqrt_prep: cfsqrt1 cfsqrt2 cfsqrt3 cfsqrt4 # Generate sequences for continued fraction of sqrt(n)
cfsqrt1:
	$(RAMATH).ContinuedFraction -sqrt2 1 1000 > $@.tmp
cfsqrt2:
	sed -e "s/1\///g" -e "s/\; /\;/" cfsqrt1.tmp \
	| grep -e "\;" \
	| sort -k1 | tee $@.tmp
cfsqrt3:
	grep -E "Continued fraction for sqrt\([0-9][0-9]*\)" $(COMMON)/names \
	| grep -vE "sqrt\(2\)" \
	| sed -e "s/ Continued fraction for sqrt(\([0-9][0-9]*\)).*/\t\1\t\1/" \
	| sort -k2 | tee $@.tmp
cfsqrt4:
	join -1 1 -2 2 -t"	" -o 2.1,2.2,1.2 cfsqrt2.tmp cfsqrt3.tmp > $@.tmp
	grep -vf in_joeis.tmp $@.tmp \
	| sed -e "s/\;/\t/" \
	| tee cfsqrt5.tmp
	wc -l cfsqrt5.tmp
cfsqrt_gen:
	head -n$(MANY) cfsqrt5.tmp \
	| perl gen_pattern.pl -n $(COMMON)/names -p cfsqrtPattern.jav \
	| tee $@.log
#----
cfsall:
	grep -i "continued" $(COMMON)/names | grep sqrt \
	| sed -e "s/ /\t/" \
	>     $@.tmp
	wc -l $@.tmp
	make  -f gener.make joeis2 LIST=$@.tmp
#---------------------------
cofr_sqrt:
	grep -E "Continued fraction for sqrt\([0-9]" $(COMMON)/names \
	> $@.tmp
	make seq LIST=$@.tmp
	$(DBAT) "SELECT aseqno \
	    FROM  seq \
	    WHERE aseqno NOT IN (SELECT aseqno FROM joeis) \
	" \
	| tee $@.tmp
	wc -l $@.tmp
#----------------
seq: # parameter: $(LIST)
	$(DBAT) -f $(COMMON)/seq.create.sql
	cut -b1-7 $(LIST) | grep -E "^A" | $(DBAT) -m csv -r seq
	$(DBAT) -n seq
seq2: # parameter: $(LIST)
	$(DBAT) -f $(COMMON)/seq2.create.sql
	cat $(LIST) | grep -E "^A" | sort | uniq > seq2.tmp
	$(DBAT) -m csv -r seq2 < seq2.tmp
	$(DBAT) -4 seq2
	$(DBAT) -n seq2
seq4: # parameter: $(LIST) with aseqno, offset, parm1, parm2, parm3, parm4, name
	$(DBAT) -f seq4.create.sql
	cat $(LIST) | grep -E "^A" | sort | uniq > seq4.tmp
	$(DBAT) -m csv -r seq4 < seq4.tmp
	$(DBAT) -4 seq4
	$(DBAT) -n seq4
delseq: seq # parameters: $(TAB) $(LIST)
	$(DBAT) -v "DELETE FROM $(TAB) WHERE aseqno IN (SELECT aseqno FROM seq)"
#--------
njoeis: # LIST
	make seq
	$(DBAT) -x "SELECT COUNT(aseqno) FROM seq \
	WHERE aseqno NOT IN (SELECT aseqno FROM joeis)"
	$(DBAT) -x "SELECT j.aseqno, j.superclass FROM seq s, joeis j \
	WHERE s.aseqno = j.aseqno ORDER BY 1" \
	>       $@.tmp
	head -4 $@.tmp
	wc -l   $@.tmp
joeis2: # LIST
	make seq2
	$(DBAT) -x "SELECT s.aseqno, s.info FROM seq2 s \
	WHERE s.aseqno NOT IN (SELECT j.aseqno FROM joeis j) ORDER BY 1" \
	>       n$@.tmp
	head -4 n$@.tmp
	wc -l   n$@.tmp
	$(DBAT) -x "SELECT j.aseqno, j.superclass, s.info FROM seq2 s, joeis j \
	WHERE s.aseqno = j.aseqno ORDER BY 1" \
	>       $@.tmp
	head -4 $@.tmp
	wc -l   $@.tmp
#--------------------------
analog: analog1 analog2 analog3
analog1:
	perl normalize_name.pl $(COMMON)/names \
	| sed -e "s/ / -o- /" > $@.tmp
analog2:
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE superclass <> 'LinearRecurrence'" \
	| sed -e "s/\r//" > joeis_impl.txt
	grep -f joeis_impl.txt $(COMMON)/names \
	| perl normalize_name.pl \
	| sed -e "s/ / +j+ /" > $@.tmp
analog3:
	sort -k3 -k2 analog1.tmp analog2.tmp \
	      > $@.txt
	head -4 $@.txt
	wc -l   $@.txt
analog4:
	perl get_stretchables.pl analog3.txt \
	>       $@.txt
	head -4 $@.txt
	wc   -l $@.txt
#--------
