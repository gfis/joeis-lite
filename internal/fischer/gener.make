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
#----------------

all: 
	# Possible targets:
	grep -E "^[a-z]" makefile
#----------------
# Generation of groups of sequences
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
SOURCES=CoxeterSequence.java GeneratingFunctionSequence.java DeadSequence.java FiniteSequence.java LinearRecurrence.java PeriodicSequence.java PrependSequence.java ReaderSequence.java Sequence.java
joeis_push:
	cd $(LITE)/src/irvine/oeis  ; pwd ; cp -upv $(SOURCES) ../../../../../gitups/joeis/src/irvine/oeis/
joeis_pull:
	cd $(JOEIS)/src/irvine/oeis ; pwd ; cp -upv $(SOURCES) ../../../../../gits/joeis-lite/src/irvine/oeis/
#==========================
#----
#==========================
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
#--------
