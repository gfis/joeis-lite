#!make

# Makefile in gits/joeis-lite/internal/fischer: sequence generation and testing 
# @(#) $Id$
# 2019-04-15: makefile for gitups/joeis incorporated
# 2019-04-06: for joeis-lite
# 2019-03-28, Georg Fischer
#
GITS=../../..
JOEIS=$(GITS)/../gitups/joeis
COMMON=$(GITS)/OEIS-mat/common
LINREC=$(GITS)/OEIS-mat/linrec
LITE=$(GITS)/joeis-lite
WITHB=-b $(COMMON)/bfile 
JOPT=-Doeis.big-factor-limit=1000000000 -Xmx2g
BATLIT=java $(JOPT) -cp  $(LITE)/dist/joeis-lite.jar irvine.test.BatchTest -v $(WITHB)
BATJOE=java $(JOPT) -cp $(JOEIS)/build.tmp/joeis.jar irvine.test.BatchTest -v $(WITHB)
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
D=0
INIT=0
TO=6
MANY=999999
START=`grep -E "^A" batch.log | tail -n1 | cut -b1-7`
#----------------

all: 
	# Possible targets:
	grep -E "^[a-z]" makefile
#----
monitor: # Monitor a BatchTest running in githups/joies, started with make loop START=Annnnnn
	perl monitor.pl -t $(TO) -l $(JOEIS)/batch.log
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
#----------------
purge: # remove all oeis/annn directories
	rm -rf  ../../target/WEB-INF/classes/irvine/oeis/a???
	rm -vrf ../../src/irvine/oeis/a??? | grep directory
	rm -vf *.bak
dist:
	cd ../.. ; ant dist 
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
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	perl patch_parms.pl -a lrstrip -i $(INIT) $@.tmp \
	>        group.tmp
	head -n4 group.tmp
	wc   -l  group.tmp
	make run
#---
gen-compile-test: run
run: # parameter MANY, PATTERN, INIT
	rm -vf batch.log
	head -n$(MANY) group.tmp                       > ghead.tmp
	cut -b1-7 ghead.tmp > gaseqno.tmp
	grep -f gaseqno.tmp $(COMMON)/names > gnames.tmp
	perl gen_pattern.pl -d $(D)        -n gnames.tmp ghead.tmp
	cd ../.. ; ant -silent dist
	make stripgr LIST=group.tmp
	make test
	make evaluate
stripgr: # attach terms from 'stripped' to A-numbers for BatchTest
	cut -b1-7  $(LIST) > aseqnos.tmp
	grep -f    aseqnos.tmp $(COMMON)/stripped \
	| head -n$(MANY) > strip.tmp
	wc -l      strip.tmp
test: # Run BatchTest for this group
	$(BATLIT)  strip.tmp 2>&1 | tee -a batch.log
evaluate:
	grep  FA   batch.log | tee fail.log
	grep  pass batch.log | tee pass.log
	wc -l      fail.log pass.log
	cp         fail.log fail.$(INIT).log
	cut -b1-7  pass.log > pass.an.tmp
	cut -b1-7  fail.log > fail.an.tmp
	grep -f    pass.an.tmp group.tmp > group.pass.$(INIT).txt || :
	grep -f    fail.an.tmp group.tmp > group.fail.$(INIT).txt || :
	wc -l      *.log
tgz: # ZIP the generated sources for this group
	tar -czf   Gen.$(PATTERN).`date +%Y-%m-%d`.tgz ../../src/irvine/oeis/a* strip.tmp group.tmp fail.log pass.log batch.log
	tar -tzf   Gen.$(PATTERN).`date +%Y-%m-%d`.tgz | grep -E "A[0-9]*.java" | wc -l
	ls -al *.tgz
#--------------------------
SOURCES=CoxeterSequence.java GeneratingFunctionSequence.java DeadSequence.java FiniteSequence.java LinearRecurrence.java PeriodicSequence.java PrependSequence.java ReaderSequence.java Sequence.java
joeis_push:
	cd $(LITE)/src/irvine/oeis  ; pwd ; cp -upv $(SOURCES) ../../../../../gitups/joeis/src/irvine/oeis/
joeis_pull:
	cd $(JOEIS)/src/irvine/oeis ; pwd ; cp -upv $(SOURCES) ../../../../../gits/joeis-lite/src/irvine/oeis/
#==========================
#----
testloop:
	for number in 1 2 3 4 ; do \
		make testb ; \
	done
#----
batest:# Test against b-files, fallback stripped
	cut -b1-7 exclude.man | sed -e "s/\r//" | sort | uniq > exclude.tmp
	# START=`grep "restart point"   batch.log | tail -n1 | cut -b1-7` 
	# export START=`cat batch.log | tail -n1 | cut -b1-7`
	# echo START=`cat batch.log | tail -n1 | cut -b1-7`
	grep -vf  exclude.tmp strip.txt | head -n$(MANY) \
	| sed -n "/^$(START)/,/^A999999/p" > strip.tmp
	$(BATJOE) $(WITHB) -t $(TO) \
			strip.tmp   2>&1 | tee batch.log
	grep -E "FA|at *irvine|Exception"  batch.log | tee fail.log
	grep -E "pass"     batch.log >     pass.log
	cp  fail.log fail.`date +%Y-%m-%d.%H:%M:%S`.log
	wc -l  *.log
#----
tests: # Test against stripped only
	make testb WITHB=
#----
looptest:
		# for number in 1 2 3 4 ; do 
		while [ true ]; do \
			export START=`cat batch.log | tail -n1 | cut -b1-7` ; \
    	echo `date +%H:%M:%S` $$START ; \
    	sleep 2 ; \
		done
#----
killbat:
	ps -efa | grep java | grep BatchTest | gawk -e '{ print $$2 }' | xargs -l echo kill -9 
#----
dirs:
	ls -al $(JOEIS)/t*.pl            $(JOEIS)/src/irvine/test/BatchTest* \
		$(LITE)/internal/fischer/t*.pl  $(LITE)/src/irvine/test/BatchTest* \
		$(LITE)/makefile               $(JOEIS)/makefile  
	grep "BatchTest V" $(JOEIS)/src/irvine/test/BatchTest*
	grep "timeguard V" $(JOEIS)/timeguard*
#----------------
copylite: # refresh BatchTest.java from joeis-lite
	cp -pv $(LITE)/makefile                           $(JOEIS)
	cp -pv $(LITE)/internal/fischer/timeguard.pl      $(JOEIS)
	cp -pv $(LITE)/src/irvine/test/BatchTest.java     $(JOEIS)/src/irvine/test/BatchTest.java 
	make dirs
#----
bastrip: # attach terms from 'stripped' to A-numbers for BatchTest
	cut -b1-7 joeis_list.txt > aseqnos.tmp
	grep -f   aseqnos.tmp $(COMMON)/stripped \
	>         $@.txt
	head -n4  $@.txt
	wc -l     $@.txt
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
#--------------------------
joeis_list: joeis_list1 joeis_list2
joeis_list1:
	find $(JOEIS)/src/irvine/oeis -iname "A??????.java" \
	| xargs -l grep -E "( extends | implements )" > joeis_list.1.tmp || :
	head -n4  joeis_list.1.tmp
	wc -l     joeis_list.1.tmp
joeis_list2:
	grep -E "^public class *A" joeis_list.1.tmp \
	| sed -e "s/public class *A/A/" \
			-e "s/ extends / /" \
			-e "s/ implements / /" \
			-e "s/ *[^A-Za-z0-9 ].*//" \
			-e "s/ /\t/" \
	>         joeis_list.txt
	head -n4  joeis_list.txt
	wc -l     joeis_list.txt
	cut -b1-7 joeis_list.txt | sort > joeis_aseqno.txt
#----
joeis_load: # populate a table with A-numbers and superclass names of implemented sequences
	$(DBAT) -f joeis.create.sql
	cat joeis_list.txt \
	| $(DBAT) -m csv -r joeis
	$(DBAT) -4 joeis
	$(DBAT) -n joeis
fail06:
	sort $(JOEIS)/*.2019-06-*.log | uniq \
	| grep -E "^A" \
	| sed -e "s/FAIL - timeout 2000\.*/FAtime2/" \
	| gawk -e '{ print $$1 "\t" $$3 }' \
	| grep -vE "start" \
	| tee $@.tmp
joeis_update:
	sort fail06.tmp | uniq > x.tmp
	make seq2 LIST=x.tmp
	$(DBAT) -v "UPDATE joeis j SET j.status = COALESCE((SELECT s.info FROM seq2 s WHERE s.aseqno = j.aseqno), ' ')"
joeis_test:
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE status <> 'pass' ORDER BY 1" \
	>       $@.tmp	
	head -4 $@.tmp	
	wc -l   $@.tmp	
#----
joeis_stat:
	$(DBAT) -x "SELECT count(superclass), superclass \
		FROM joeis \
		WHERE superclass NOT LIKE 'A______'  \
		GROUP BY superclass \
		ORDER BY 1 DESC" \
	>         $@.tmp
	head -n32 $@.tmp
	wc -l     $@.tmp
isin_joeis:
	sed -s "s/^\(A[0-9]*\) /\1\t/" $(LIST) > $@.1.tmp
	make seq2 LIST=$@.1.tmp
	$(DBAT) -x "SELECT j.aseqno, j.superclass, s.info \
		FROM joeis j, seq2 s \
		WHERE j.aseqno = s.aseqno \
		ORDER BY 1" \
	>        $@.tmp
	wc -l    $@.tmp
notin_joeis:
	sed -s "s/^\(A[0-9]*\) /\1\t/" $(LIST) > $@.1.tmp
	make seq2 LIST=$@.1.tmp
	$(DBAT) -x "SELECT s.aseqno, s.info \
		FROM  seq2 s \
		WHERE s.aseqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 1" \
	>        $@.tmp
	wc -l    $@.tmp
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
#--------------------
cf_convergents:
	grep "continued fraction convergents" $(COMMON)/names \
	| grep -P "sqrt\(\d+\)\." \
	>     $@.tmp
	wc -l $@.tmp
	make notin_joeis LIST=$@.tmp
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
#-------------------
power:
	perl -ne 'print if m{\AA\d+\s+a\(n\)\s*\=\s*\d+\*?n\^\d+\s*(\-|\+)\s*\d+[\.\s]*\Z}i' $(COMMON)/names
	# perl -ne 'print if m{\AA\d+\s+a\(n\)\s*\=\s*\d+\*?n\^\d+\s*(\-|\+)}i' $(COMMON)/names
# A158627 a(n) = 484*n^2-22.
# A158643 a(n) = 676*n^2 + 26.
# A158644 a(n) = 52*n^2 + 1.
# A158645 a(n) = 729*n^2 + 27.
# A158646 a(n) = 54*n^2 + 1.
#--------------------------
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
	java -cp ../../../ramath/dist/ramath.jar org.teherba.ramath.ContinuedFraction \
		-sqrt2 1 1000 > $@.tmp
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
