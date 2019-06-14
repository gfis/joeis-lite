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
#==========================
select: # parameter: CC
	make -f gener.make $(CC)
	head -4 $(CC).gen
	wc -l   $(CC).gen
	make -f gener.make seq4 LIST=$(CC).gen
	$(DBAT) "UPDATE seq4 s \
		SET name    = (SELECT a.name    FROM asname a WHERE s.aseqno = a.aseqno) \
	    ,   offset  = (SELECT a.offset1 FROM asinfo a WHERE s.aseqno = a.aseqno)" 
	$(DBAT) -x "SELECT aseqno, callcode, offset, parm1, parm2, parm3, parm4, name FROM seq4 ORDER BY 1" \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
	$(DBAT) -x "SELECT COUNT(aseqno) FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM joeis)"
gener: # parameter MANY, CC
	head -n$(MANY) $(CC).gen > ghead.tmp
	perl gen_seq4.pl -d $(D)   ghead.tmp
	cd ../.. ; ant -silent dist
test: # parameter CC
	rm -f batch.log
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
	make -f gener.make select CC=cfplen
	make -f gener.make select CC=cfpleast
	make -f gener.make select CC=cfpmidpar
#----
# A041009 Denominators of continued fraction convergents to sqrt(7).
# A041010 Numerators of continued fraction convergents to sqrt(8).
cfsnum:
	perl -ne 'if (m{^(A\d+) Numerators of continued fraction convergents to sqrt\((\d+)\)\.})   { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
cfsden:
	perl -ne 'if (m{^(A\d+) Denominators of continued fraction convergents to sqrt\((\d+)\)\.}) { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
#----
# A003285	Period of continued fraction for square root of n (or 0 if n is a square). 
# A097853	Period of continued fraction for square root of n (or 1 if n is a square).
cfp:
	perl -ne \
	'if (m{^(A\d+) Period of continued fraction for square root of n \(or (\-?\d+) if n is a square\)\.}) { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
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
#----
# A031700	Least term in period of continued fraction for sqrt(n) is 22.
# A031701	Numbers n such that the least term in the period of the continued fraction for sqrt(n) is 23.
# PARM1=22
cfpleast: 
	perl -ne \
	'if (m{^(A\d+) (Numbers n such that )?(the )?[Ll]east term in (the )?period of (the )?continued fraction for sqrt\(n\) is (\d+)\.}) { print "$$1\t$@\t0\t$$6\n" }' \
	$(COMMON)/names > $@.gen
#----
# A013643	Numbers n such that continued fraction for sqrt(n) has period 3.
# A013644	Numbers n such that the continued fraction for sqrt(n) has period 4.
# + A002522	a(n) = n^2 + 1 for period 1
cfplen:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has period (\d+)\.}) { print "$$1\t$@\t0\t$$3\n" }' \
	$(COMMON)/names > $@.gen
#----
# A064848	Period of continued fraction for sqrt(2)*n.
# Offset is 1
cfplenmult:
	perl -ne \
	'if (m{^(A\d+) Period (length )?of (the )?continued fraction for sqrt\((\d+)\)\*n\.}) { print "$$1\t$@\t0\t$$4\n" }' \
	$(COMMON)/names > $@.gen
#----
# A031598	Numbers n such that continued fraction for sqrt(n) has even period and central term 100.
# A031600	Numbers n such that continued fraction for sqrt(n) has odd period and central terms 12.
# A031413	Numbers n such that continued fraction for sqrt(n) has even period 2*m and the m-th term is 10.
# A031414	Numbers n such that continued fraction for sqrt(n) has odd period and a pair of central terms both equal to 1.
#           1                             2                                              3                 4           5                                            6                                      7                                     
cfpmidpar:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has (even|odd) period (2\*m )?and (the m\-th|central|a pair of central) terms? (is |both equal to |of the period is |)(\d+)\.}) { print "$$1\t$@\t0\t$$3\t$$7\n" }' \
	$(COMMON)/names \
	| sed -e "s/\teven/\t0/" -e "s/\todd/\t1/ " \
	> $@.gen
	# PARM1=parity, PARM2=central
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
#---
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
#--------------------
cf_convergents:
	grep "continued fraction convergents" $(COMMON)/names \
	| grep -P "sqrt\(\d+\)\." \
	>     $@.tmp
	wc -l $@.tmp
	make notin_joeis LIST=$@.tmp
#--------------------------
decexp: decexp_impl decexp_nimpl
decexp_impl: # names: Annnnnn Decimal expansion of ... and in jOEIS
	$(DBAT) "SELECT a.aseqno, n.name, j.superclass, a.keyword \
		FROM asinfo a, asname n, joeis j \
		WHERE a.aseqno = n.aseqno \
		  AND n.aseqno = j.aseqno \
		  AND keyword LIKE '%cons%' \
		ORDER BY 1" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
decexp_nimpl: # names: Annnnnn Decimal expansion of ... and NOT in jOEIS
	$(DBAT) "SELECT a.aseqno, n.name, a.keyword \
		FROM asinfo a, asname n\
		WHERE a.aseqno = n.aseqno \
		  AND n.aseqno NOT IN (SELECT aseqno FROM joeis) \
		  AND keyword LIKE '%cons%' \
		ORDER BY 1" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
decexp_extr:
	perl extract_decexp.pl decexp_nimpl.tmp \
	| grep -vE "^#" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
decexp_joeis:
	$(RAMATH).symbolic.ShuntingYard joeis -f decexp_extr.tmp \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
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
cfconv:
	grep -i "continued fraction convergents to sqrt" $(COMMON)/names \
	>     $@.tmp
	wc -l $@.tmp
	make -f gener.make -s njoeis LIST=$@.tmp
# A040966 Continued fraction for sqrt(998)
# A042932 num sign(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1968153802, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1)
# A042933 den sign(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1968153802, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1)
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
#--------
