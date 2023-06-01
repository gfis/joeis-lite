#!make

# Makefile in gits/joeis-lite/internal/fischer: sequence generation and testing
# @(#) $Id$
# 2023-01-24: extract ./aman, ./sql subdirectories 
# 2022-07-13: MariaDB 10.6 has 'offset' as keyword
# 2022-06-21: old poeis -> noeis, new poeis for OEIS-prog
# 2022-06-17: select3, gengp
# 2021-10-29: distel
# 2020-06-21: test with BatchMonitor
# 2019-07-15: joeis parallel to joeis-lite
# 2019-05-20, Georg Fischer: copied from makefile
#----------------
GITS=../../..
LITE=$(GITS)/joeis-lite
HERE=../../joeis-lite/internal/fischer
JOEIS=$(GITS)/joeis
CA=$(GITS)/OEIS-mat/ca
CAS=$(GITS)/OEIS-mat/cas
DATA=$(GITS)/OEIS-mat/data
PROG=$(GITS)/OEIS-prog
CK=./ck
COMBSTRUCT=$(GITS)/OEIS-mat/combstruct
COMMON=$(GITS)/OEIS-mat/common
CONSTANT=$(GITS)/OEIS-mat/constant
CONTRIB=$(GITS)/OEIS-mat/contrib
COORS=$(GITS)/OEIS-mat/coors
ETA=$(GITS)/OEIS-mat/eta
HOLREC=$(GITS)/OEIS-mat/holrec
LINREC=$(GITS)/OEIS-mat/linrec
PL=$(CONTRIB)/pl
SDB=$(GITS)/OEIS-mat/sequencedb
TRIREC=$(GITS)/OEIS-mat/trirec
WEIDIS=$(GITS)/OEIS-mat/weidis
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
RAMATH=java -cp $(GITS)/ramath/dist/ramath.jar
ROBOT=$(GITS)/OEIS-mat/robot
JPREP=$(RAMATH)  org.teherba.ramath.sequence.JoeisPreparer
HOLT=$(RAMATH)   irvine.test.HolonomicRecurrenceTest
PFRACT=$(RAMATH) org.teherba.ramath.symbolic.PolyFraction
WORD=$(GITS)/OEIS-mat/word
BVA=$(RAMATH)    org.teherba.ramath.linear.BigVectorArray
NT=32
MANY=999999
CLASS=dummy.java
D=0
EL=0
TO=4
TOADD=4000
WAITM=100
GU=0
N=1000
NUM=999
EIT=
MATRIX=[[1,0],[0,1]]
SC=222221210100
NC=
BOFS=1
BF=
WITHB=-b $(COMMON)/bfile -t $(TO)
VERBOSE=false
# JOPT=-Ddebug=$(D) -Xmx2g -Xss1g -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
JOPT=-Ddebug=$(D) -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
ifeq ($(OS),Windows_NT)
    CPS=;
else
    CPS=:
endif
JAVA=java $(JOPT) -cp "$(LITE)/dist/joeis-lite.jar$(CPS)$(JOEIS)/build.tmp/joeis.jar"
JJAVA=java $(JOPT) -cp "$(JOEIS)/build.tmp/joeis.jar"
BATLIT=$(JAVA) irvine.test.BatchTest -vv $(WITHB) -d $(D) -t $(TO) -u $(GU)
INIT="1"
START=`grep -E "^A" batch.log | tail -n1 | cut -b1-7`
REMOTE=gfis@atair:~/work/gits/joeis-lite/internal/fischer
OFFSET=0

# Pattern rule: make Ammmmmmm Annnnnn ... from A*.man
%: aman/%.man
	grep -E "^A[0-9]" aman/$@.man > $@.gen
	head -n4 $@.gen
	wc -l $@.*
#----------------
all:
	# Possible targets:
	grep -E "^[a-z]" makefile | sort
#----
killmake:
	cmd /c tasklist | grep make | cut -b28-34 | xargs -l -innn cmd /c taskkill /F /PID nnn
#----------------------------------
# Test programs
seqt: # A=$(A) - print data up to 260 characters
	$(JAVA) irvine.oeis.SequenceFactory -a "Georg Fischer" -n $(NT) -o $(OFFSET) --data-length=4096  -D $(A) 2>&1   | tee x.tmp
seqte: # A=$(A) - test with errors
	$(JAVA) irvine.test.SequenceTest   -a $(A)             -n $(NT) -o $(OFFSET)                       2>&1   | tee x.tmp
seqtri: # A=$(A) - print data in triangle format
	$(JAVA) irvine.oeis.SequenceFactory -a "Georg Fischer" -r $(NT) --row-numbers -o $(OFFSET) -T $(A) 2>&1   | tee x.tmp
seqtris: # A=$(A) - print data in upper left triangle format
	$(JAVA) irvine.oeis.SequenceFactory -a "Georg Fischer" -r $(NT) --row-numbers -o $(OFFSET) -S $(A) 2>&1   | tee x.tmp
seqtrir: # A=$(A) - print data in upper right triangle format
	$(JAVA) irvine.oeis.SequenceFactory -a "Georg Fischer" -r $(NT) --row-numbers -o $(OFFSET) -R $(A) 2>&1   | tee x.tmp
seqtest: # A=$(A) NT=$(NT) OFFSET=$(OFFSET) - print b-file
	$(JAVA) irvine.oeis.SequenceFactory -a  --header -n $(NT) -o $(OFFSET) -B $(A)
# --priority "java,gp"
seqhelp: #
	$(JAVA) irvine.oeis.SequenceFactory --help
jseqtest: # A=$(A) $(NT)=; b-file from jOEIS only
	$(JJAVA) irvine.test.SequenceTest $(A) $(NT) | tee x.tmp
spectest:
	$(JAVA) irvine.math.z.QuadraticCongruence $(ARGS)
#	$(JAVA) irvine.oeis.cons.FoldedContinuedFraction $(ARGS)
crtest:
	$(JAVA) irvine.math.cr.CR $(NUM)
URI=https://oeis.org/b303116.txt 
uritest:
	$(JAVA) org.teherba.common.URIReader $(URI) UTF-8
ebtest:
	$(RAMATH) org.teherba.ramath.sequence.JoeisExpressionBuilder -d 1 -p CR.xpat "$(POST)"
Q="-1/1"
INIT="1"
#--
eps: epstest # 
epstest:
	$(JAVA) irvine.oeis.transform.EtaProductSequence  -d $(D) -n $(NT) -p "$(P)" -q $(Q) 
ettest:
	cat et.data.txt  | $(JAVA) irvine.oeis.transform.EulerTransform 
iettest:
	cat iet.data.txt | $(JAVA) irvine.oeis.transform.InverseEulerTransform 
#	$(JAVA) irvine.test.EulerTransformTest -n $(NT) -p $(P) -o 0
gramtest:
	$(JAVA) irvine.test.GramMatrixTest -n $(NT) -gm$(DIAG) "$(GM)" $(BF) $(EIT)
rstest:
	$(JAVA) irvine.oeis.transform.RootSequence  -d $(D) -n $(NT) -a "$(A)" -q "$(Q)" -s "$(S)" 
cptest:
	$(JAVA) irvine.oeis.transform.ConvolutionProduct -d $(D) -n $(NT) -a "$(A)" -q "$(Q)"
tptest:
	$(JAVA) irvine.oeis.triangle.Product -d $(D) -n $(NT) -a "$(A)"
titest:
	$(JAVA) irvine.oeis.triangle.Inverse -d $(D) -n $(NT) -a "$(A)"
vptest:
	$(JAVA) irvine.oeis.triangle.VectorProduct -d $(D) -n $(NT) -a "$(A)"
#--
tiletest:
	$(JAVA) org.teherba.tile.TilingSequence -n $(NT)
runjava: # CLASS= ARGS=
	$(JAVA) $(CLASS) $(ARGS)
pseudotest: # A=
	$(JAVA) irvine.oeis.producer.PseudoSequence $(A) 2>&1
tritest:
	$(JAVA) irvine.oeis.triangle.GeneratingFunctionTriangle $(NT) $(NUM) $(DEN)
ej:
	echo $(JAVA)
regtest: # CLASS= rerun all these classes
	grep -P "\AA\d+\t$(CLASS)" $(COMMON)/joeis_names.txt | cut -f1 > $(CLASS).gen
	wc -l $(CLASS).gen
	make CC=$(CLASS) test log
runpari:
	$(JAVA) org.teherba.extcas.RunPARI  $(CMD)
#----
ingit:
	git ls-tree -r master --name-only
#----------------------------------
# Generation of groups of sequences
#----------------------------------
SOURCES=ContinuedFractionOfSqrtSequence.java CoxeterSequence.java GeneratingFunctionSequence.java \
	DeadSequence.java FiniteSequence.java LinearRecurrence.java PeriodicSequence.java \
	PrependSequence.java ReaderSequence.java RunsBaseSequence.java Sequence.java
joeis_push:
	cd $(LITE)/src/irvine/oeis  ; pwd ; cp -upv $(SOURCES) ../../../../../gitups/joeis/src/irvine/oeis/
joeis_pull:
	cd $(JOEIS)/src/irvine/oeis ; pwd ; cp -upv $(SOURCES) ../../../../../gits/joeis-lite/src/irvine/oeis/
#----
from_joeis:
	cp -v ../../../joeis/src/main/java/irvine/oeis/HolonomicRecurrence.java     .. /../src/irvine/oeis
from_ramath:
	cp -v ../../../ramath/src/main/java/irvine/oeis/HolonomicRecurrence.java     ../../src/irvine/oeis
	cp -v ../../../ramath/src/main/java/irvine/test/HolonomicRecurrenceTest.java ../../src/irvine/test
to_ramath:
	cp -v ../../src/irvine/oeis/HolonomicRecurrence.java     ../../../ramath/src/main/java/irvine/oeis
	cp -v ../../src/irvine/test/HolonomicRecurrenceTest.java ../../../ramath/src/main/java/irvine/test
diff_ramath:
	diff -wC0 ../../../ramath/src/main/java/irvine/oeis/HolonomicRecurrence.java     ../../src/irvine/oeis || :
	# diff -wC0 ../../../ramath/src/main/java/irvine/test/HolonomicRecurrenceTest.java ../../src/irvine/test || :
diff_reflect:
	diff -wsy --suppress-common-lines ../../src/irvine/oeis/Recur*.java ../../../joeis/internal/irvine/oeis/
diff_factory:
	diff -wsy --suppress-common-lines ../../src/irvine/oeis/SequenceFactory.java ../../../joeis/src/irvine/oeis/
diff_joeis:
	unzip -v ../../dist/joeis-lite.jar | grep "irvine/oeis" | grep ".class" | sed -e "s/  */\t/g" \
	| grep -vP "oeis/a|\$\d+\." | cut -f9 | sed -e "s/.class/.java/" | tee $@.tmp \
	| xargs -innn diff -ws -C0 ../../../joeis/src/nnn ../../src/nnn \
	>> $@.tmp
diffrec:
	diff -wsy --suppress-common-lines ../../../joeis/src/irvine/oeis/recur/ConstantOrderRecurrence.java ../../src/irvine/oeis/recur || :
diffhr:
	diff -wy  ../../../joeis/src/irvine/oeis/HolonomicRecurrence.java   ../../src/irvine/oeis || :
#	diff -wC0 ../../../joeis/src/irvine/oeis/CompementaryEquationSequence.java   ../../src/irvine/oeis || :
update:
	cp -v     ../../../joeis/src/irvine/oeis/EulerTransform.java      ../../src/irvine/oeis || :
#	cd ../.. ; find src | xargs -l -i{} cp -pv ../../gits/joeis/{} {}
count:
	find ../../src -iname "A??????.java" | wc -l
list:
	find ../../src -iname "A??????.java" -ls
pack: pack1 pack2 pack3
pack1:
	cd ../.. ; find src -iname "A??????.java" > pack.$(CC).lst \
	; wc -l                                     pack.$(CC).lst \
	; find internal/fischer/$(CC).*.log      >> pack.$(CC).lst \
	; perl -e 'foreach my $$name (split(/\,/, "$(CLASS)")) { print "src/irvine/oeis/$$name.java\n"; }' \
	                                         >> pack.$(CC).lst \
	; echo internal/fischer/$(CC).gen        >> pack.$(CC).lst \
	; echo internal/fischer/$(CC).jpat       >> pack.$(CC).lst || : \
	; grep -vE "^\#" internal/fischer/packlist.man     >> pack.$(CC).lst || :
	cd ../.. ; tar --files-from=pack.$(CC).lst -cvzf $(CC).`date +%Y-%m-%d.%H`.tgz \
	| perl -pe "s{\/A\S*}{}" | uniq -c
pack2:
	git commit -a -m"`wc -l $(CC).pass.log`"
	git push origin master
pack3:
	find ../../src/irvine/oeis/a* -iname "*.java" -printf "%f\n" | cut -b1-7 > $@.tmp
	make seq LIST=$@.tmp
	$(DBAT) "SELECT s.aseqno, COALESCE(j.superclass, 'nyi') \
	  FROM seq s, joeis j WHERE s.aseqno = j.aseqno ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
rename:
	echo cfs*.jpat | xargs -l \
	  perl -i.bak -pe "s{ContinuedFractionOfSqrt([^S])}{ContinuedFractionOfSqrtSequence$1}g;"
#--------
noeis: nocre nodir # create a list of freshly implmented classes
nocre:
	# ---- $@ CC=$(CC)
	$(DBAT) -f $(COMMON)/noeis.create.sql
nodir:
	# ---- $@ CC=$(CC)
	find ../../src/irvine/oeis/a* -iname "A*.java" | perl -ne 'm{\/(A\d+)}; print "$$1\n";' \
	| $(DBAT) -r noeis
	$(DBAT) -4   noeis
	$(DBAT) -n   noeis
noins:
	# ---- $@ CC=$(CC)
	cut -b1-7 $(CC).gen \
	| sed -e "s/$$/\t$(CLASS)\t/" \
	| $(DBAT) -m csv -r noeis
	$(DBAT) -4 noeis
	$(DBAT) -n noeis
nodel: # CC= delete and export again
	# ---- $@ CC=$(CC)
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM noeis)";
	$(DBAT) -n         seq4
	$(DBAT) -x -444444 seq4 > $(CC).gen
bfresh: # CC=
	cd $(COMMON) ; make bfresh
#--
noeis_diff:
	$(DBAT) -x "SELECT LOWER(SUBSTR(aseqno, 1, 4)) || '/' || aseqno || '.java' FROM noeis ORDER BY 1" \
	| sed -e "s/\r//" > x.tmp
	cat x.tmp | xargs -l -innn diff -w -y --suppress-common-lines ../../../joeis/src/irvine/oeis/nnn ../../src/irvine/oeis/nnn
noeis_extend:
	$(DBAT) -x "SELECT aseqno, superclass FROM joeis j WHERE j.superclass IN (SELECT aseqno FROM noeis) ORDER BY 1"
noeis_replaces:
	$(DBAT) -x "SELECT p.aseqno, p.superclass, j.superclass FROM noeis p, joeis j WHERE p.aseqno = j.aseqno ORDER BY 1"
noeis_count:
	$(DBAT) -x "SELECT CAST(a AS CHAR) || ' classes = ' || SUBSTR(CAST(a/b * 100 AS CHAR),1,7) \
	    || '% out of ' || CAST(b AS CHAR) || ' sequences in noeis are replaced, ' || CAST(b - a AS CHAR) || ' are new' FROM \
	    ( (SELECT COUNT(j.aseqno) as a FROM noeis p, joeis j WHERE p.aseqno = j.aseqno) j1 \
	    , (SELECT COUNT(i.aseqno) as b FROM noeis i                                   ) j2)"
#==========================
rm_gp: # parameter: LIST
	echo all: > $@.tmp
	grep -vP "\t(pass|FATO|pato)\t" $(LIST) \
	| cut -b1-7 | sort | uniq \
	| perl -ne 'm{^A(\d\d\d)(\d+)}; print "\trm -v prog/gp/a$$1/A$$1$$2.gp\n";' | tee -a $@.tmp
	wc -l     $@.tmp
remove: # parameter: CC
	rm -f remlist.tmp
	perl -ne 'm{^A(\d\d\d)(\d+)}; print "a$$1/A$$1$$2.java\n";' $(CC).gen > remlist.tmp
	cat remlist.tmp | xargs -l -i{} rm  -f ../../target/WEB-INF/classes/irvine/oeis/{}
	cat remlist.tmp | xargs -l -i{} rm -vf                    ../../src/irvine/oeis/{}
mangen: # parameter: CC; copy all in CC.gen to fischer/manual
	rm -f coplist.tmp
	perl -ne 'm{^A(\d\d\d)(\d+)}; print "a$$1/A$$1$$2.java\n";' $(CC).gen > coplist.tmp
	cat coplist.tmp | xargs -l -i{} cp -v ../../../joeis/src/irvine/oeis/{} manual
	ls -al manual
sumall: # copy all generated in joeis-lite/src to ./manual
	find ../../src/irvine/oeis/a* -iname "*.java" | xargs -innn cp -pv nnn manual 
sumfail: # CC= copy all FAILed to ./manual
	grep FAIL $(CC).fail.log | cut -b1-7 | sed -e "s/\r//" | tee grep.tmp
	find ../../src/irvine/oeis/a* -iname "*.java" | grep -f grep.tmp | xargs -innn cp -pv nnn manual 
	cat grep.tmp | xargs -innn uedit64 manual/nnn.java
s4diff: # compare existing seqs. in joeis/src with selected ones in seq4
	$(DBAT) -x "SELECT LOWER(SUBSTR(aseqno, 1, 4)) || '/' || aseqno FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis) ORDER BY 1" \
	| sed -e "s/\r//" \
	| xargs -innn diff -s -C0 $(JOEIS)/src/irvine/oeis/nnn.java $(LITE)/src/irvine/oeis/nnn.java \
	| tee     $@.tmp
ccdiff: # compare seqs. in joeis/src with generated ones in joeis-lite/src
	cd ../.. ; find src/irvine/oeis -iname "A??????.java" \
	| xargs -innn diff -s -C0 ../joeis/nnn nnn \
	| tee     internal/fischer/$@.tmp
#--------
REMOTE=dummy
# git_remote:
	# scp ../../../joeis/src/irvine/oeis/BlockMultAddSequence.java             $(REMOTE)/joeis/src/irvine/oeis/
	# scp ../../../joeis/src/irvine/oeis/cons/DecimalExpansionSequence.java    $(REMOTE)/joeis/src/irvine/oeis/cons/
	# scp ../../../joeis/src/irvine/oeis/recur/CoxeterSequence.java            $(REMOTE)/joeis/src/irvine/oeis/recur/
	# scp ../../../joeis/src/irvine/oeis/triangle/BaseTriangle.java            $(REMOTE)/joeis/src/irvine/oeis/triangle/
	# scp ../../../joeis/internal/irvine/oeis/RecurrenceReflector.java         $(REMOTE)/joeis/internal/irvine/oeis/
#--------
ccall: select clean purge gener dist test pack # parameter: CC
#----
NOT=NOT
selexx:
	make select CC=$(CC) EX=xx
select: select1 select2 select3 # parameter: CC
select1:
	# ---- $@ CC=$(CC)
	make $(CC)
	head -n4 $(CC).gen
	wc   -l  $(CC).gen
EX=
PO=1
select2: # require not in joeis: JO= (default) / require not in noeis: PO=1 (default)
	# ---- $@ CC=$(CC) JO=$(EX) PO=$(PO)
	make seq4 LIST=$(CC).gen
	$(DBAT) -v -f sql/$(CC).sql > $(CC).sql.tmp || :
select3:
	$(DBAT) -x "SELECT s.aseqno, s.callcode, COALESCE(i.offset1, s.offset1) \
	    , s.parm1, s.parm2, s.parm3, s.parm4, s.parm5, s.parm6, s.parm7, s.parm8, \
	    COALESCE(SUBSTR(n.name, 1, 256), 'Name?') \
	    FROM seq4 s LEFT JOIN asinfo i ON s.aseqno = i.aseqno \
	                LEFT JOIN asname n ON i.aseqno = n.aseqno \
	    WHERE (s.aseqno NOT IN (SELECT CONCAT('$(EX)', aseqno) FROM joeis) OR s.callcode = 'pseudo') \
	      AND COALESCE(i.keyword, 'future') NOT LIKE '%dead%' \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
		  >  $(CC).gen
	head -n4 $(CC).gen
	wc -l    $(CC).gen
clean: purge # parameter: CC; $(CC).pass.log from previous test used to grep from $(CC).gen
	# ---- $@ CC=$(CC)
	grep -E "^A[0-9]" $(CC).pass.log | cut -b1-7 | sed -e "s/\r//" -e "s/^/\^/" > clean.grep.tmp
	grep -f clean.grep.tmp $(CC).gen > $(CC).clean.tmp
	cp -v $(CC).clean.tmp  $(CC).gen
	wc -l $(CC).gen $(CC).pass.log clean.grep.tmp $(CC).clean.tmp
cleanto: purge # parameter: CC; $(CC).pass.log and FATO with more than 20 from previous test used to from $(CC).gen
	# ---- $@ CC=$(CC)
	grep -E "^A[0-9]" $(CC).pass.log | cut -b1-7 | sed -e "s/\r//" -e "s/^/\^/" >  $@.grep.tmp || :
	grep -P "^A\d+\t(\d\d\d+|[32-9]\d)\tFATO\t" $(CC).fail.log | cut -b1-7 | sed -e "s/\r//" -e "s/^/\^/" >> $@.grep.tmp || :
	grep -f $@.grep.tmp $(CC).gen > $(CC).$@.tmp || :
	grep -vE "A092847|A198034|A226913" $(CC).$@.tmp > $(CC).gen || :
	wc -l $(CC).gen $(CC).pass.log $@.grep.tmp $(CC).$@.tmp
dirty: dirty0 # parameter: CC; $(CC).pass.log from previous test is stripped off $(CC).gen
	# ---- $@ CC=$(CC)
	cp -v $(CC).dirty.tmp $(CC).gen
	wc -l $(CC).gen
dirty0:
	wc -l $(CC).gen
	cp    $(CC).gen $(CC).old.tmp
	cut -b1-7 $(CC).pass.log > dirty.tmp
	grep -E "^A[0-9]" $(CC).pass.log | cut -b1-7 | sed -e "s/\r//" -e "s/^/\^/" > dirty.grep.tmp
	grep -vf dirty.grep.tmp $(CC).gen > $(CC).dirty.tmp
fatok:
	grep -E "^A[0-9]" $(CC).fail.log | grep FATOK | cut -b1-7 | sed -e "s/\r//" \
	| xargs -innn $(JAVA) irvine.test.SequenceTest -a nnn -n $(NT) -o $(OFFSET)
refresh: # generate a list of A-numbers whose b-files should be refreshed
	grep "read" $(CC).fail.log | cut -b1-24 | tee $(CONTRIB)/refresh.list.man
removelist: # remove all in removelist.man
	# ---- $@ CC=$(CC)
	find ../../src/irvine/oeis -iname "*.java" \
	| grep -f removelist.man \
	| xargs -l rm -v
copytemp: # parameter CC; copy FAILed ones to fischer/temp
	# ---- $@ CC=$(CC)
	cut -b1-7 $(CC).fail.log > dirty.tmp
	find ../../src/irvine/oeis -iname "*.java" \
	| grep -f dirty.tmp \
	| xargs -l -innn cp -v nnn temp/
logsel:# set the test results of CC= in column PARM=n
	# ---- $@ CC=$(CC)
	cut -f1,3 $(CC).fail.log $(CC).pass.log > logset.tmp
	make seq2 LIST=logset.tmp
	$(DBAT) "UPDATE seq4 s4 SET parm$(PARM)=COALESCE((SELECT info FROM seq2 s2 WHERE s2.aseqno = s4.aseqno), 'unknown');"
	$(DBAT) -x -99999 seq4 > $(CC).sel
	head -n4 $(CC).gen
	wc -l    $(CC).gen
info: # compare CC= with joeis_names.txt
	# ---- $@ CC=$(CC)
	cut -f1 $(CC).gen > info.tmp
	make seq LIST=info.tmp
	$(DBAT) "SELECT s.aseqno, j.superclass FROM seq s LEFT JOIN joeis j ON s.aseqno = j.aseqno;" \
	>        $(CC).inf
	head -n4 $(CC).inf
	wc -l    $(CC).inf
checkdir: # DIR=
	find $(DIR) -iname "*.java" | perl -pe 's{\A.*\/(A\d+).*}{$$1\n}' > $@.tmp
	make seq LIST=$@.tmp
	$(DBAT) "SELECT s.aseqno, COALESCE(j.superclass, 'nyi') FROM seq s LEFT JOIN joeis j ON s.aseqno = j.aseqno ORDER BY 1" \
	| tee    $@.tmp
#----
annotate: # add comments with names of the dependant sequences, and optionally with their data
	# ---- $@ CC=$(CC)
	perl annotate.pl -data 0 $(CC).gen > $(CC).ann.tmp
	uedit64 $(CC).ann.tmp
#----
control: # extract shorter descriptions for passed seqs.
	# ---- $@ CC=$(CC)
	cut -b1-7 $(CC).pass.log \
	| perl -ne ' s/\s+\Z//; print "\%. $$_ \n"; ' > $@.tmp
	grep -Ef $@.tmp $(COMMON)/cat25.txt \
	| perl -ne ' print substr($$_, 1) if m{\A\%[NCFtSTU]}; ' \
	| sed -e "s/^S /\#________________\nS /" \
	>        $(CC).$@.txt
	wc -l    $(CC).$@.txt
#----
# ... oeis\a062\A062724.java:23: error: no suitable method found for add(CR)
#
prune: purge # parameter: CC; dist.log from previous dist is stripped off $(CC).gen
	# ---- $@ CC=$(CC)
	cat dist.log \
	| perl -ne 'if (m{(A\d+)\.java\:\d*\:\s*error\:}) { print "$$1\n"; } '\
	| sed -e "s/\r//" > prune.grep.tmp
	wc -l    prune.grep.tmp
	grep -vf prune.grep.tmp $(CC).gen > $(CC).prune.tmp || :
	grep  -f prune.grep.tmp $(CC).gen > $(CC).javer.tmp || :
	sed -e "s/\r//" $(CC).prune.tmp > $(CC).gen
	wc -l $(CC).*
gener: # parameter: CC, MANY, NC; test sequences in $(CC).gen - generate for java (default)
	# ---- $@ CC=$(CC)
	head -n$(MANY) $(CC).gen      > ghead.tmp
	perl gen_seq4.pl -d $(D) -cc $(CC) $(NC) ghead.tmp
	# make -i $(CC).patch || :
purge: # remove all oeis/annn directories
	# ---- $@ CC=$(CC)
	rm -rf  ../../target/WEB-INF/classes/irvine/oeis/a???
	rm -rf                     ../../src/irvine/oeis/a???
	rm -vf *.bak
#--
gengp: # parameter: CC, MANY, NC; test sequences in $(CC).gen - generate for PARI
	# ---- $@ CC=$(CC)
	head -n$(MANY) $(CC).gen      > ghead.tmp
	perl gen_seq4.pl -d $(D) -cc $(CC) $(NC) -t ./prog/gp -x gp ghead.tmp
purgep: # remove all ./prog/gp/annn directories
	# ---- $@ CC=$(CC)
	rm -rf ./prog/gp/a???
#----
man: # copy sources that where manually edited
	# ---- $@ CC=$(CC)
	perl copyman.pl > $@.gen
	sort $@.gen $(CC).gen | uniq -w7 > $@.tmp
	mv $@.tmp $(CC).gen
#----
dist:
	# ---- $@ CC=$(CC)
	rm -f dist.log
	make dist1 2>&1 | tee dist.log
	wc -l dist.log | perl -ne 'm{(\d+)}; exit(1) if $$1 > 8;'
	#################################################################
dist1:
	cd ../.. ; ant -silent dist 2>&1
#----
deploy:
	cd ../.. ; ant         deploy 2>&1
#--
geditel: gener dist test log
maditel: man dist test    log
madital: man dist testall log
#--
batest: # parameter: CC
	# ---- $@ CC=$(CC)
	rm -f batch.log
	head -n$(MANY) $(CC).gen      > ghead.tmp
	make stripgr LIST=ghead.tmp
	make runbt evaluate
runbt: # Run BatchTest for this group
	# ---- $@ CC=$(CC)
	$(BATLIT) strip.tmp 2>&1 | tee -a batch.log
	# end of test
#========
test: test0 test2
test1:
	# ---- $@ CC=$(CC)
	rm -f batch.log
	echo $(A) >  ghead.tmp
	echo $(A) >> ghead.tmp
	make test2
test0:
	# ---- $@ CC=$(CC)
	rm -f batch.log
	head -n$(MANY) $(CC).gen \
	| grep -E "^A" \
	| perl -ne 'print if ! m{\AA\d+\tpseudo\s}; ' > ghead.tmp
test2:
	# ---- $@ TO=$(TO)
	make stripgr LIST=ghead.tmp
	echo 0x0 > seekpos.mon
	cp  seekpos.mon seekpos.tmp
	cat seekpos.mon
	while [ -r seekpos.mon ] ; do \
		cp seekpos.tmp seekpos.mon || : ; \
		echo restart at `date +%H:%M:%S` @`cat seekpos.mon` in strip.tmp \
			>> batch.log ; \
		$(BATLIT) -s seekpos.mon strip.tmp 2>&1 \
			| $(JAVA) irvine.test.BatchMonitor -s seekpos.mon -t $(TO)000 -w $(WAITM) -d $(DM) 2> seekpos.tmp \
			| tee -a batch.log ; \
	done
	make evaluate
	# end of test
testall: summon test2 # test all existing (generated) sequences in the subdirectories
summon:
	# ---- $@ MANY=$(MANY)
	rm -f batch.log
	find ../../src/irvine/oeis/a* -iname "*.java" -printf "%f\n" | cut -b1-7 \
	| head -n$(MANY) > ghead.tmp
	wc -l ghead.tmp
#========
batch:
	# ---- $@
	make seq3 LIST=batch.log
remlog: # CC=
	scp gfis@atair:~/work/gits/joeis-lite/internal/fischer/batch.log x.log
	cp -v x.log $(CC).`date +%Y-%m-%d.%H.%M`.log
	grep -vP "\tFATO\t" x.log > batch.log
	make evaluate log
log: # CC=; generate an HTML page for the failed tests
	# ---- $@ CC=$(CC)
	cd $(COMMON); make -f checks.make joeis_check LOG=$(CC)
logf: # CC=; generate an HTML page for the failed tests (but no "FATO")
	# ---- $@ CC=$(CC)
	cd $(COMMON); make -f checks.make joeis_fail LOG=$(CC)
loga: # CC=; generate an HTML page for the failed tests (but no "FATO")
	# ---- $@ CC=$(CC)
	cd $(COMMON); make -f checks.make joeis_all LOG=$(CC)
logp: # CC=; generate an HTML page for the PASSed tests
	# ---- $@ CC=$(CC)
	cd $(COMMON); make -f checks.make joeis_pass LOG=$(CC)
casstat:
	grep -P "\tFATO\t" $(CC).fail.log > FATO.tmp
	grep -P "\tFATO\t" $(CC).fail.log > FATO.tmp
	wc -l $(CC).pass.log FATO.tmp
retest: # run the failed ones again (with a higher timeout)
	# ---- $@ CC=$(CC)
	cut -b1-7 $(CC).fail.log > failed.tmp
	grep -f failed.tmp $(CC).gen > $(CC).gen.fail.tmp
	make stripgr LIST=$(CC).gen.fail.tmp
	$(BATLIT)  strip.tmp 2>&1 | tee batch.log
	grep  pass batch.log >>    $(CC).pass.log
	grep  FA   batch.log | grep -v "Exceptionnull" | tee $(CC).fail.log
stripgr: # attach terms from 'stripped' to A-numbers for BatchTest
	# ---- $@ LIST=$(LIST) MANY=$(MANY)
	cut -b1-7  $(LIST) > aseqnos.tmp
	grep -f    aseqnos.tmp $(COMMON)/stripped \
	| head -n$(MANY) > strip.tmp
	wc -l      strip.tmp
evaluate:
	# ---- $@ CC=$(CC)
	uniq -w7 batch.log | grep -P  "\tpass\t" >     $(CC).pass.log || :
	cat      batch.log | grep -v "Exceptionnull" | grep -E "fail|FA" | tee $(CC).fail.log || :
	wc -l $(CC).*.log
bfile:
	# ---- $@ SEQ=$(SEQ)
	echo make bfile SEQ=123456 N=1000 BOFS=1
	grep -E "^A$(SEQ)" $(COMMON)/names \
	| sed -e "s/A$(SEQ)/\#/" \
	>  $(CONTRIB)/b$(SEQ).txt
	java -jar ../../dist/joeis-lite.jar A$(SEQ) $(N) $(BOFS) \
	| grep -vi java \
	| sed -e "s/Generated by jOEIS/Generated by Georg Fischer with jOEIS/" \
	>> $(CONTRIB)/b$(SEQ).txt
	head -n 8 $(CONTRIB)/b$(SEQ).txt
	tail -n 4 $(CONTRIB)/b$(SEQ).txt
reverse:
	# ---- $@ CC=$(CC)
	perl -e 'print "\n\"[" . join(",",0,reverse($(SIG)),-1) . "]\"\n";'
#-------
overwrite: # SRC= TAR= inserts or replaces all records in TAR by the ones in SRC, key is aseqno
	# ---- $@ SRC="(SRC) TAR=$(TAR)
	grep -E "^A[0-9]" $(SRC) | cut -b1-7 > $@.sa.tmp
	grep -vf $@.sa.tmp $(TAR) > $@.tn.tmp || :
	sort $@.tn.tmp $(SRC) > $(TAR)
	wc -l $(TAR)
#--------
joeis_class:
	$(DBAT) -x "SELECT s.aseqno, COALESCE(j.superclass, 'nyi'), s.offset1, s.parm1, s.parm2, s.parm3, s.parm4, s.parm5 \
	  FROM seq4 s LEFT JOIN joeis j ON j.aseqno = s.aseqno \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
potential: # rerun all targets that have accelaration potential
	rm -f    $@.tmp
	#---- start of list of all candidates
	# echo anopan       >> $@.tmp
	echo decexro      >> $@.tmp # after cd cons ; make cons conjs decexro0
	echo inbase2      >> $@.tmp
	echo n2           >> $@.tmp
	echo posins       >> $@.tmp
	echo transpose    >> $@.tmp
	echo trimirror    >> $@.tmp
	#---- end of   list of all candidates
	cat $@.tmp | xargs -l -innn make $@1 TARGET=nnn
	cat $@.tmp | xargs -l -innn make $@2 TARGET=nnn
	make man
	find ../../src/irvine/oeis/a* -iname "*.java" | wc -l
	make dist testall
potential1:
	make CC=$(TARGET) select gener man dist test
	make CC=$(TARGET) clean
potential2:
	make CC=$(TARGET) gener
potential3:
	ls -tclr *.gen | tail -n7 | cut -b47- | sed -e "s/\.gen//" | xargs -l -innn make CC=nnn gener
#--------
robots:
	# prelude
	rm -f   robot.gen
	cp -v hold/*.java  manual || :
	make purge
	#-- all in action
	make   CC=charfun    robot1
	make   CC=diffseq    robot1
	make   CC=ogf        robot1
	  make CC=fract21    robot1
	  make CC=fract22    robot1
	make   CC=partprod   robot1
	make   CC=partsum    robot1
	make   CC=rowsums    robot1
	make   CC=triprod    robot1
	make   robot3
robot3:
	#-- postlude
	make CC=robot purge gener maditel TO=8
	wc -l   robot.gen
	mv -v   robot.gen robot.`date +%Y-%m-%d.%H`.gen
	make sumall
	mv -v manual/A*.java park1/
robot1:
	echo ======== $(CC) ========
	cd $(ROBOT) ; make $(CC)
	cp -v $(ROBOT)/$(CC).gen .
	make purge 
	make select2 select3 gener maditel TO=8
	mv -v $@.fail.log $(CC).faro.log || :
	make cleanto
	cat  $(CC).gen >> robot.gen
robot2:
	cd $(ROBOT) ; make $(CC)
	cp -v $(ROBOT)/$(CC).gen .
	make purge 
	make select2 select3 gener maditel TO=8
#--------
seqlist:
	cat $@.man | xargs -t -l -innn grep -iH Librandi $(COMMON)/ajson/nnn.json
similar:
	grep -E "^A" $(A).man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#================================================================
anabuild: # .2023-03-16: 
	make purge
	git add -v aman/A*.man sql/*.sql *.pl *.jpat
	rm -f aman/build.man build.tmp || :
	echo A030000 A062845 A068127 A080445 A213027  \
	| xargs -n1 echo | xargs -innn cat aman/nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > aman/build.man
	make CC=build      select gener EX=xx
	make CC=simbinom   select gener
	cp -pv hold/*.java manual || :
	make CC=man        man
	make CC=$@ dist testall TO=8 pack 
anabuild.2023-02-23: 
	make purge
	git add -v aman/A*.man sql/*.sql *.pl *.jpat
	rm -f aman/build.man build.tmp || :
	echo A064560 A115140  \
	| xargs -n1 echo | xargs -innn cat aman/nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > aman/build.man
	make CC=build      select gener EX=xx
	make CC=rootet     select gener
	make CC=convinv    select gener
	make CC=eisenprod  select gener
	make CC=finifull   select gener
	cp -pv hold/*.java manual || :
	make CC=man        man
	make CC=$@ dist testall TO=8 pack 
anabuild.2023-02-14: # *GH
	make purge
	git add -v aman/A*.man sql/*.sql *.pl *.jpat
	rm -f aman/build.man build.tmp || :
	echo A006553 A256326 A260558 A269227 \
	| xargs -n1 echo | xargs -innn cat aman/nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > aman/build.man
	make CC=build      select gener EX=xx
	make CC=prisuba    select gener
	cp -pv hold/*.java manual || :
	make CC=man        man
	make CC=$@ dist testall GU=3 pack 
anabuild.2022-12-31:
	make purge
	git add -v aman/A*.man sql/*.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A000001 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select gener EX=xx
	cp -pv hold/*.java manual || :
	make CC=man        man
	make CC=$@ dist testall pack 
	make CC=A093211 man dist testall pack
future:
	grep -P "power of \d+ dividing n\!\." jcat25.txt
A136test:
	grep -E "SquareDigit" $(COMMON)/joeis_names.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#================================================================
A001482:
	grep -E "^A" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A004050:
	grep -E "^A" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
a0330:
	cp -v $@.man $@.gen
#----
A000301: # 2021-09-29
	cp -v $@.man $@.gen
#----
A005754: # 2021-12-02
	grep -E "^A[0-9]" $@.man > $@.gen
#----
A007348: # < 2021-05-15
	perl $@.pl > $@.gen
#----
A015910: # 2021-09-29
	cp -v $@.man $@.gen
A018857: # < 2021-05-15
	perl $@.pl > $@.gen
	# cat      $@.gen
A032834: # 2021-05-29
	cp -v $@.man $@.gen
A033235: # 52, < 2021-05-15
	perl $@.pl > $@.gen
A033633: # 14, < 2021-05-15
	perl $@.pl > $@.gen
#----
A034939: # 2021-09-29
	cp -v $@.man $@.gen
	wc -l    $@.gen
#----
A035536: # < 2021-05-15
	cp -v $@.man $@.gen
A039832: # 2021-05-21
	grep -P "^A\d+" $@.man > $@.gen
A046966:
	grep -E "^A" $@.man > $@.gen
	wc -l    $@.gen
#----
A049884: # 2021-08-06
	grep -E "^A049[89]|A0500" $(COMMON)/joeis_names.txt | grep -P "a\(n\) *\= *\|?a\((n\-)?1\)" \
	| perl $@.pl \
	2>       $@.rest.tmp \
	>        $@.gen
	tail -n6 $@.gen
	wc -l    $@.gen $@.rest.tmp
a49:
	grep -P "2\^p *\< *n *\- *1 *\<\= *2\^\(p\+1\)" $(COMMON)/joeis_names.txt
#----
A050000: # 2021-08-06
	cp -v $@.man $@.gen
	# StepUp or StepDown positions for A050000 et al.
	cat $(COMMON)/joeis_names.txt \
	| perl -ne 'my $$line = $$_; if ($$line =~ m{that (A\d+)\([kn]\) *([\<\>]) *A\d+\([nk](\+1)\)\.}) {'\
	' print join("\t", substr($$line, 0, 7), "parm2", 0, ($$2 eq "<" ? "A050002" : "A050003"), "new $$1()") . "\n"; }'\
	>>       $@.gen
	# Positions of n
	cat $(COMMON)/joeis_names.txt \
	| grep -E "^A050" \
	| perl -ne 'my $$line = $$_; if ($$line =~ m{\A(A\d+)\s+\S*\s+a\(n\) *\= *position of n in (A\d+)}) {'\
	' print join("\t", $$1, "posofnin", 0, $$2) . "\n"; }'\
	>>       $@.gen
	cat $(COMMON)/joeis_names.txt \
	| grep -E "^A050" \
	| perl -ne 'my $$line = $$_; if ($$line =~ m{\A(A\d+)\s+\S*\s+a\(n\) *\= *least k satisfying [^A]*(A\d+)}) {'\
	' print join("\t", $$1, "posofnin", 0, $$2) . "\n"; }'\
	>>       $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A050201:
	perl anagen.pl -bs A118078 -rs A050201 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A051803: # nonzero multiplicative products
	grep -E "^A[0-9]" $@.man > $@.gen
	wc -l    $@.gen
#----
A052179: # Triangle recurrence with x,y
	grep -E "^A[0-9]" $(TRIREC)/$@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A056022: # 2021-12-29
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A060722:
	grep -E "^A" $@.man > $@.gen
	wc -l    $@.gen
#----
A062450: # 2022-06-14
	perl a062450.pl -u 2000 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A063nnn0: # Conjectures for A063081 Dimension of the space of weight 2n cusp forms for Gamma_0( 13 ).
	grep -E "^\?F A063[0-3]" $(COMMON)/jcat25.txt | grep -iE "(g\.f\.)" \
	| cut -b 4- \
	| perl -ne 's/ /\togfc\t1\t/; s/ //g; s/(Empirical|Conjectured?)\:?//i; s/g\.f\.\:? *//i; s/\[.*//; s/\.\Z//; print;' \
	| tee    $@.tmp
	wc -l    $@.tmp
A063nnn: # convert to num, den tuples with JPREP
	$(JPREP) -f aman/$@.man \
	>        $@.tmp
	grep -E "fract1" $@.tmp | sed -e "s/fract1/lingfcj/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A063nnn_den: # show the denominator coefficients
	cut -f1,3,5,12 A063nnn.gen | sort -k3.3 -k12.12 \
	| sed -e "s/Dimension of the space of weight//" \
	| tee    $@.tmp
#----
A063555: # 2021-05-29
	grep -E "^A[0-9]" $@.man > $@.gen
wraptr2:
	make seq  LIST=A071919.gen
	make seq4 LIST=wraptr.gen
	$(DBAT) -x "SELECT s.aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 s \
	    WHERE s.aseqno NOT IN (SELECT aseqno FROM seq) \
	    ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
wraptr3:
	cp -v wraptr2.tmp wraptr3.gen
#----
A072921:
	grep -E "^A" $@.man > $@.gen
	wc -l    $@.gen
A075497:
	grep -E "^A" $@.man > $@.gen
	wc -l    $@.gen
#----
A093211: # a(n) is the largest number such that all of a(n)'s length-n substrings are distinct and divisible by 11.	base,nonn,synth	1..11
	grep -P "^A0932[1-9][0-9]" $(COMMON)/joeis_names.txt \
	| grep -vE "A093210|A093245|A093290" \
	| perl -ne 'use strict; m{\A(A\d+)}; my $$aseqno = $$1; print join("\t", $$aseqno, "parm2", 1, "A093211", substr($$aseqno, 5, 2)) . "\n"; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A094969:
	cat $(COMMON)/joeis_names.txt \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); if (m{[Ff]loor\((\d+)\^n\/(\d+)\^n\)\.}) {'\
	' my ($$parm1, $$parm2) = ($$1, $$2); '\
	' print join("\t", $$aseqno, "parmof3", 0, "$@", $$parm1, $$parm2) . "\n"; } '\
	| grep -vE "A153725" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A090171: # T(n, k) = T(n-1, k) + T(n-1, k-1) + T(n-2, k) + T(n-2, k-1) + T(n-2, k-2) for n >= 2, a(0..2) = (0,1,0). Christian G. Bower
	grep -E "^A[0-9]" $(TRIREC)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A095072:
	grep -P "Primes in whose binary expansion" $(COMMON)/joeis_names.txt | cut -b1-120 \
	>        $@.tmp
#----
A095425:
	grep -E "^A094324" anastret.txt \
	| perl -ne 's/\s+\Z//; my ($$d1, $$aseqno, $$d2, @parms) = split(/\t/); '\
	' print join("\t", $$aseqno, "parm2", 0, $@, $$parms[0], $$parms[1]) . "\n"; '\
	>        $@.gen
	# A095426	parm2	1	A095425	11	a(n)= (\d+) written in base n						a(n) = 11 written in base n.
	grep A095426 $@.gen | sed -e "s/A095426/A035613/" -e "s/\t11\t/\t7\t/" \
	>>       $@.gen
	grep -E "written in base " $(COMMON)/joeis_names.txt \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); if (m{a\(n\) *\= *(\d+) written in base[\- ]*(\d+) *\- *n\.}) {'\
	' my ($$parm1, $$parm2) = ($$1, $$2); '\
	' print join("\t", $$aseqno, "parm3", 0, "A095437", $$parm1, $$parm2) . "\n"; } '\
	>>       $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A105471: # 2021-08-15
	grep -E "^A[0-9]" $@.man > $@.gen
#----
A105479: # 2021-12-04
	grep -E "^A[0-9]" $@.man > $@.gen
#----
A115422: # 2021-11-15
	grep -E "^A[0-9]" $@.man > $@.gen
#----
A127757:
	cp -v $@.man $@.gen
#----
A128367: # 2021-09-29
	cp -v $@.man $@.gen
#----
#================
# *.pa2
#
A061037: # Numerator of 1/4 - 1/n^2.
	grep -E "^A" $@.pa2 > $@.gen
	wc -l    $@.gen
A098941: # Numbers where 2 is the only even decimal digit.
	grep -E "^A" $@.pa2 > $@.gen
	wc -l    $@.gen
A169964: # Numbers whose decimal expansion contains only 0's and 5's.
	grep -E "^A" $@.pa2 > $@.gen
	wc -l    $@.gen
#================================
# A126043	null	Exponents p of the Mersenne primes 2^p - 1 (see A000043) read mod 3.	nonn,synth	1..47	nyi
a126043:
	cat $@.man \
	| perl -ne 'm{\A(A\d+)}; my $$aseqno = $$1; m{mod *(\d+)}; my $$mod = $$1;'\
	' print join("\t", $$aseqno, "parm2", 1, "A126043", $$mod) . "\n"; ' \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A135799: # 2021-12-08
	grep -E "^A[0-9]" $@.man > $@.gen
	wc -l    $@.gen
#--------
# A139149	null	A139149 a(n) = (n!+2)/2.
a139149:
	cat $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A144562:
	cd $(TRIREC) ; make $@
	grep -vE "^A1150(09|10)" $(TRIREC)/$@.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A151633:
	cp -v    $(CONTRIB)/rh/$@.tmp $@.gen
#--------
A157052:
	cp -v    $@.man $@.gen
#--------
# A157536 Half the number of length n integer sequences with sum zero and sum of squares 32.
a157536:
	grep -E "Half the number of length n integer sequences with sum" $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{sum (\w+) and sum of squares (\d+)\.}) { '\
	' my ($$s, $$ss) = ($$1, $$2); $$s =~ s{zero}{0}; '\
	' print join("\t", substr($$_, 0, 7), "$@", 0, $$s, $$ss) . "\n"; } '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
# A161440 Numbers m such that A160700(m) = 0.	nonn,easy,	1..10000	nyi
A161440:
	grep -E "^A" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A162500: # 2021-12-08, RING -> GeneratingFunctionSequence
	cp -v $@.man $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
# A165824	null	Totally multiplicative sequence with a(p) = 3.	nonn,mult,changed,	1..10000	nyi
A165824:
	cat      $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A172455_hol:
	$(DBAT) "SELECT s.aseqno, s.parm2 || ',' || s.parm3 || ',' || s.parm4, COALESCE(h.matrix, 'matrix?'), h.init, h.shift, h.gftype, h.keyword \
	FROM  seq4 s LEFT JOIN holref h ON s.aseqno = h.aseqno \
	ORDER BY 2 " > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
A176627:
	cp -v $(TRIREC)/$@.man $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A183194: # Final prime of first member of A019518 that is divisible by 3^n.
	grep -E "^A" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A183953: # RH*150, Number of strings of numbers x(i=1.. n) in 0..n with sum i^2*x(i)^1 equal to n^3
	perl $@.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A184887:
	cp -v $(CONTRIB)/ph/$@.man $@.gen
	grep -E "^A18"  $(CONTRIB)/ph/$@.man | cut -f1,4
#----
A189011: # Zero-one sequence based on triangular numbers: a(A000217(k))=a(k); a(A014132(k))=1-a(k); a(1)=0.
	cd ck; make $@
	head -n4 $@.gen
	wc -l    $@.gen
#--------
A190803: # Increasing sequence generated by these rules: a(1)=1, and if x is in a then 2x-1 and 3x-1 are in a.
	cd ck; make $@
#----
A192110: # 2021-11-16
	grep -E "^A[0-9]" $(CK)/$@.man > $@.gen
#----
A194285: # Triangular array:  g(n,k)=number of fractional parts (i*sqrt(2)) in interval [(k-1)/n, k/n], for 1<=i<=n, 1<=k<=n.
	cd ck; perl ck_guides.pl -a M \
	>        ../$@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A194368: # Numbers m such that Sum_{k=1..m} (<1/2 + k*r> - <k*r>) = 0, where r=sqrt(2) and < > denotes fractional part.
	cd ck; perl ck_guides.pl -a O \
	>        ../$@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A200313: # 2021-12-06
	grep -E "^A[0-9]" $@.man > $@.gen
	wc -l    $@.gen
#----
A202670: # self-fusion matrices = correlation triangles
	cd $(TRIREC); make trigB
	grep trig_b1 $(TRIREC)/trigB.tmp \
	| sed -e "s/\ttrig_b1\t/\tparm3\t/" -e "s/\trseqno\t/\tA202670\t/" \
	| sed -e "s/\tparm/\tparmof/" \
	| sort | uniq -w7 \
	| grep -vE "^A0" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A202692: # The first of three triangles counting 3-colored alternating permutations by their last value.	nonn,tabl,more,changed,synth	1..16	nyi
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A204892:
	perl $(CK)/$@.pl \
	| grep -vE "^(A205407)" \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A205558:
	perl $(CK)/ck_guides.pl -a V >  $@.tmp # A205558
	perl $(CK)/ck_guides.pl -a W >> $@.tmp # A205840
	sort $@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A214999: # Power ceiling-floor sequence of (golden ratio)^4.
	perl $(CONTRIB)/ck/ck_guides.pl -a b \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A216703: # 2021-11-17 EFF+2
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A231503: # 2021-11-19
	grep -E "^A[0-9]" $@.man > $@.gen
	wc -l    $@.gen
#----
A247750: # Numbers in decimal representation, such that in Czech their digits are in alphabetic order.
	grep -E "^A[0-9]" $(WORD)/$@.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
A251693: # 2021-12-06
	grep -E "^A" $@.man > $@.gen
	wc -l    $@.gen
#--------
A257606:
	grep -E "^A[0-9]" $(TRIREC)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
a266759:
	grep -P "\-1\,2\,\-2\,1\,"  $(COMMON)/asdata.txt | grep -P "\,1\,0\,0\,\-1\," || :
#----
A289064: # 2021-12-05
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#================================
adiveo0:
	grep -P "\ba\([i-n] *\/ *\d+\)" $(COMMON)/joeis_names.txt | grep nyi | cut -f1-5 | grep -vP "[Ss]um|[Ll]east|A\d+\(" \
	>        $@.tmp
	uedit64  $@.tmp
adiveo:
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
# A126358 Number of base 4 n-digit numbers with adjacent digits differing by one or less
adjacent:
	cp -v $(COMBSTRUCT)/adjacent2.tmp $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
ajrank: # adjusted joint rank sequences (CK)
	cd ck ; make $@
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
alsoprime:
	grep "is also prime" $(COMMON)/joeis_names.txt \
	| grep Primes \
	| grep -v revers \
	| perl alsoprime.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
amoda: # simple formula a(n) = Aqseno(n...) op Arseqno(n...)
	grep -Pi "a\(n\) *\= *A\d+\([^\)]+\) *([\+\-\*\/\^]|and|or|xor|xand|mod) *A\d+\([^\)]+\) *\." $(COMMON)/jcat25.txt \
	| grep -E "^%" \
	| cut -b 4- | sed -e "s/ /\t/" \
	| perl -ne 'if (m{\A(A\d+)\s+a\([^\)]+\) *\= *(A\d+)\(n\) *([\+\-\*\/\^]|and|or|xor|xand|mod) *(A\d+)\([^\)]+\)}i) {'\
	' print join("\t", $$1, $@, 0, $$2, $$4); my $$op = $$3;'\
	' $$op =~ s{\+}{add}; $$op =~ s{\-}{subtract}; $$op =~ s{\*}{multiply}; $$op =~ s{\/}{divide}; $$op =~ s{\^}{pow}; $$op = lc($$op);'\
	' print "\t$$op\n"; }'\
	>        $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
#---------------
andiv0: # simple formula: a(n) = Annnnnn(n) / n 
	grep -E "^\%" $(COMMON)/jcat25.txt | grep -E "a\(n\) *\=" | grep -P "a\(n\) *\= *A\d+\(n\) *[\+\-\*\/] *n" \
	| cut -b 4- | sed -e "s/ /\t/" \
	| perl -ne 'if (m{\A(A\d+)\s+a\([^\)]+\) *\= *(A\d+)\(n\) *([\+\-\*\/]) *(n)}i) {'\
	' print join("\t", $$1, $$2); my $$op = $$3;'\
	' $$op =~ s{\+}{add}; $$op =~ s{\-}{subtract}; $$op =~ s{\*}{multiply}; $$op =~ s{\/}{divide}; $$op =~ s{\^}{pow}; $$op = lc($$op);'\
	' print "\t$$op\n"; }'\
	>        $@.tmp
	make seq3 LIST=$@.tmp
andiv:
	$(DBAT) -x "SELECT s.aseqno, '$@', i.offset1, s.pattern, s.info \
	  FROM seq3 s, asinfo i \
	  WHERE s.aseqno = i.aseqno \
	    AND s.pattern IN (SELECT aseqno FROM joeis) \
	    ORDER BY 1" \
	| grep -vE "A160764" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
# simple formula a(n) = Aqseqno(n...) op Arseqno(n...)
anopan0:
	grep -Pi "\= *A\d+\([^\)]+\) *([\+\-\*\/\^]|and|or|xor|xand|mod) *A\d+\([^\)]+\)" $(DATA)/jcat28.txt \
	| grep -E "^\%[NFC]" | cut -b 4- | sort | uniq -w7 | sed -e "s/ /\t/" \
	>        $@.tmp
	wc -l    $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, 'anopan', i.offset1, REGEXP_SUBSTR(d.data, '[\-0-9]+(\,[\-0-9]+){8}'), s.info \
	  FROM seq2 s, asinfo i, asdata d \
	  WHERE s.aseqno = i.aseqno \
	    AND i.aseqno = d.aseqno \
	    ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
anopan1:
	perl anopan.pl anopan0.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	wc -l    $@.tmp $@.rest.tmp
	cut -f 2 $@.tmp | sort | uniq -c
anopan:
	grep -P "\tanopan\t" anopan1.tmp \
	| grep -vE "A068310|A121835|A123538|A130911|A137851|A178467|A185246|A262348|A274996|A277078" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
anopsn:
	grep -P "\tanopsn\t" anopan1.tmp \
	| grep -vE "A068310|A121835" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
anminan:
	grep -Pi "min\(A\d+\([^\)]+\) *\, *A\d+\([^\)]+\)\)" $(COMMON)/jcat25.txt \
	| grep -E "^\%[NFC]" | cut -b 4- | sort | uniq -w7 | sed -e "s/ /\t/" \
	| perl anminan.pl \
	2>       $@.rest.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
#----------------
apery:
	grep -E "^A[0-9]" $(HOLREC)/apery.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
aperz:
	grep -E "^A[0-9]" $(HOLREC)/aperz.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
aperz_update:
	perl -i.bak -pe 's{\tholos\t\d+\t}{\tholos\t0\t};' aperz.gen
#----------------
aritfun: # The arithmetic function ...
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
arsimple: # $(CONTRIB)/ar/recur.man
	grep -P "\tprev|\tsimple" $(CONTRIB)/ar/recur.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
bas: # only a few for basdig2
	make bas_all TARGET=select
	cat  bas*.gen > basall.gen
bas_all:
	make $(TARGET) CC=basdig1
	make $(TARGET) CC=basdig2
	make $(TARGET) CC=basdig3
	make $(TARGET) CC=basdig4
	make $(TARGET) CC=basrun
	make $(TARGET) CC=basruneq
	make $(TARGET) CC=basrunmod
	make $(TARGET) CC=basrunpar
	wc -l bas*.gen
#----
# A043408 Numbers n such that number of 3's in base 7 is 4.	nonn,base,synth	1..35
# A043409 Numbers whose number of 4's in base 7 is 1.	nonn,base,easy,changed,synth	1..52
# A043506 Integers n such that number of 4's in base 10 is 2.	nonn,base,synth	1..43
# A043509 Numbers that contain exactly one 5.	nonn,base,easy,	1..2000
basdig1:
	perl -ne \
	'if (m{^(A\d+)\s+(Integers|Numbers) (such that|[nk] such that|whose) number of (\d+).s in base (\d+) is (\d+)})'\
	'{ print join("\t", $$1, "$@", 0, 1, $$5, $$4, $$6) . "\n" }' \
	$(COMMON)/names \
	>        $@.tmp
	perl -ne \
	'if (m{^(A\d+)\s+(Integers|Numbers) ([nk] )?(that|which) contain (exactly one|a single) (\d+) in base (\d+)})'\
	'{ print join("\t", $$1, "$@", 0, 1, $$7, $$6, 1) . "\n" }' \
	$(COMMON)/names \
	>>       $@.tmp
	perl -ne \
	'if (m{^(A\d+)\s+(Integers|Numbers) ([nk] )?(that|which) contain (exactly one|a single) (\d+)\.})'\
	'{ print join("\t", $$1, "$@", 0, 1, 10, $$6, 1) . "\n" }' \
	$(COMMON)/names \
	>>       $@.tmp
	sort     $@.tmp \
	| sed -e "s/A043489\t$@\t0\t1/A043489\t$@\t0\t0/" \
	>        $@.gen
	# A043489 exceoptionally starts with 0
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A039092 Numbers whose base-9 representation has the same number of 2's and 4's.	nonn,base,easy,changed,synth
# A039093 Numbers n such that representation in base 9 has same number of 2's and 5's.	nonn,base,easy,synth
# A039124 Numbers n such that representation in base 10 has same number of 1's and 6's.	nonn,base,easy,synth	1..69
# A039125 Numbers n whose base-10 representation has the same number of 1's and 7's.	nonn,base,easy,	1..5000
# A039603 Numbers n such that representation in base 12 has same nonzero number of 0's and 11's.
# A039225 Numbers n whose base-12 representation has the same number of 1's and 7's.
# A039473 Numbers such that representation in base 11 has the same nonzero number of 4's and 6's.	nonn,base,easy,changed,synth	1..50
basdig2:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers ([nk] such that|such that|whose) representation in base.(\d+) has (the )?same (nonzero )?number of (\d+)\Ds and (\d+)\Ds})'\
	'{ print join("\t", $$1, "$@", 0, $$3, $$5, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>   $@.gen
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [^b]+base.(\d+) representation has (the )?same (nonzero )?number of (\d+)\Ds and (\d+)\Ds})'\
	'{ print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>>       $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A039589 Numbers n such that representation in base 6 has same number of 2's, 3's and 4's.
basdig3:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [nk] such that representation in base.(\d+) has (the )?same (nonzero )?number of (\d+)\Ds\, (\d+)\Ds and (\d+)\Ds})'\
	'{ print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>   $@.gen
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [^b]+base.(\d+) representation has (the )?same (nonzero )?number of (\d+)\Ds\, (\d+)\Ds and (\d+)\Ds})'\
	'{ print join("\t", $$1, "$@", 0, $$2, $$4, $$5, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	| perl -pe "s{nonzero}{count1 \!\= 0 \&\&}" \
	>>       $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A044966 Numbers n with property that in base 3 representation the numbers of 0's and 1's are 0 and 1, respectively.	nonn,base,synth	1..43
# A045004 In base 3 the numbers of 0's and 2's are 3 and 0, respectively.	nonn,base,synth	1..43
basdig4:
	perl -ne \
	'if (m{^(A\d+)\s+(Numbers [nk] with (the )?property that )?[Ii]n base.(\d+) '\
	'(representation )?the numbers of (\d+).s and (\d+).s are (\d+) and (\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$4, $$6, $$7, $$8, $$9) . "\n" }' \
	$(COMMON)/names \
	>     $@.gen
	# A044987 Numbers k whose base-3 representation has four 0's and two 1's.	nonn,base,changed,synth	1..42
	# A045181 Numbers whose base-5 representation contains two 0's and one 2.	nonn,base,changed,synth	1..46
	echo "A044987	basdig4	0	3	0	1	4	2" >> $@.gen
	echo "A045181	basdig4	0	5	0	2	2	1" >> $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A037454 a(n) = Sum_{i=0..m} d(i)*6^i, where Sum_{i=0..m} d(i)*3^i is the base 3 representation of n.
# %t A037314 Table[FromDigits[RealDigits[n, 3], 9], {n, 1, 100}]
# %t A037454 t = Table[FromDigits[RealDigits[n, 3], 6], {n, 0, 100}]
rebase0:
	grep -P "Table *\[ *FromDigits *\[ *RealDigits|a\(n\) *\= *fromdigits\(digits\(n\, *\d+\)\, *\d+\)" $(COMMON)/cat25.txt \
	| cut -b4- \
	| perl -ne 'use strict; m{\A(A\d+)\D+(\d+)\D+(\d+)}; '\
	' print join("\t", $$1, "$@", 0, $$2, $$3) . "\n"; '\
	>        rebase.tmp
	head -n4 rebase.tmp
	wc -l    rebase.tmp
rebase:
	cp -v rebase.tmp rebase.gen
find_rebase:
	perl $@.pl -n 64 | tee $@.txt
	grep A999 find_rebase.txt
rebase2:
	grep -vE "^A999" find_rebase.txt \
	| grep -E "^A" \
	| grep -vE "A004777|A039076|A039111|A039155|A039209|A039274|A047368|A047421|A047602|A059561" \
	| grep -vE "A065039|A081502|A081594|A081595|A081596|A081597|A081598|A081599|A081600|A088481" \
	| grep -vE "A111706|A145569|A156230|A171397|A187394|A228298|A244158|A247160|A245345|A248375" \
	| grep -vE "A272574|A272576|A277050|A292638|A309083|A322001|A324161" \
	>        rebase.tmp
	head -n4 rebase.tmp
	wc -l    rebase.tmp
rebasewi:
	perl wiki_tabs.pl -e $(EL) -d $(D) -x "&mdash;" rebase.witab \
	>        rebase.wiki
#---
# A043555 Number of runs in base-3 representation of n.	nonn,base,easy,	0..1000
basrun:
	perl -ne \
	'if (m{^(A\d+)\s+Number of runs in base.(\d+) representation of [nk]})'\
	'{ print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A043569 Numbers n such that base 2 representation has exactly 2 runs.	nonn,base,	1..10000
basruneq:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [nk] (such that|whose) (the )?base.(\d+) representation has exactly (\d+) runs})'\
	'{ print join("\t", $$1, "$@", 0, $$4, $$5) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A043569|A043570|A043638|A043675" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# look for more efficient advancing:
	# A043569 = 2 runs in base  2 up to 10000 - replace "10" by "11"?
	# A043569 = 3 runs in base  2 up to 10000 - varying number of "0" in the middle?
	# A043638 = 2 runs in base 10 up to 10000 - replace "777..77|" by "888..88|" ?
	# A043675 = 2 runs in base 16 up to 10000 - similiar
#----
# A043796 Number of runs in the base 3 representation of n is congruent to 5 mod 7.	nonn,base,changed,synth	1..46
# A043797 Numbers n such that number of runs in the base 3 representation of n is congruent to 6 mod 7.	nonn,base,synth	1..45
basrunmod:
	perl -ne \
	'if (m{^(A\d+)\s+(Numbers [nk] such that )?[Nn]umber of runs in (the )?base.(\d+) representation of [nk] is congruent (to )?(\d+) mod (\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$4, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
#A043705 Numbers n such that number of runs in the base 16 representation of n is even.	nonn,base,synth	1..60
#A043706 Numbers n such that number of runs in the base 3 representation of n is odd.	nonn,base,synth	1..59
#A043707 Numbers n such that number of runs in base 4 representation of n is odd.	nonn,base,synth	1..60
basrunpar:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [nk] such that number of runs in (the )?base.(\d+) representation of [nk] is (even|odd)})'\
	'{ print join("\t", $$1, "$@", 0, $$3, $$4) . "\n" }' \
	$(COMMON)/names \
	| sed -e "s/even/0/" -e "s/odd/1/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
basrunid: # Numbers whose base-3 expansions, read from left to right, have run lengths that strictly increase.
	grep -E "^A" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
# ck_guides

basraifal:
	perl $(CK)/ck_guides.pl -a F \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
baspitpeak:
	perl $(CK)/ck_guides.pl -a G \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
baspiece:
	perl $(CK)/ck_guides.pl -a H \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
basvar: # down/up/total variation
	cd ck ; make $@
	head -n4 $@.gen
	wc -l    $@.gen
#----
baszigzag:
	perl $(CK)/ck_guides.pl -a I \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
basrundist:
	perl $(CK)/ck_guides.pl -a J \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
beatty0: beatty1 beatty2 beatty3 # Beatty sequence of expr.
beatty1:
	grep -E "^[\%\#][N] A[0-9][0-9]* Beatty sequence" $(COMMON)/jcat25.txt \
	| cut -b4- | grep -vP '\, *where' \
	| perl -ne 's/ Beatty sequence (for|of) /\tpost\t0\t~~/; '\
	' s{([\.\;\,\:\=]|\(gamma is|where ).*}{}; s{ }{}g; s{(.)A001620}{$$1}g; s{goldenratio}{phi}; '\
	' s{zeta\((\d+)\)}{zeta__$$1}g; '\
	' if (! m{the|constant|cuberoot}) { print; } '\
	| cat - beatty.man \
	| gawk -e '{print $$1 "\t" $$2 "\t" $$3 "\t" $$4 "\t" $$4 }' \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
beatty1t:
	perl $(CONSTANT)/solvetab.pl -a t \
	>        beatty1.tmp \
	2>       x.tmp
beatty2:
	$(JPREP) -f beatty1.tmp | sed -e "s/\r//" \
	| perl -ne 's{\tpost\t}{\tinfix\t}; s{\~\~\;?}{}g; print; '\
	| perl -ne 's{zeta\(\;(\d+)\;zeta\)}{zeta__$$1}g; print; # shield zeta '\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
beatty3:
	$(JPREP) -p CR.xpat -f beatty2.tmp \
	| perl -ne 's{zeta\(}{Zeta.zeta\(}g; print; # expand zeta '\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	grep -i  zeta $@.tmp || :
	grep     '<?' $@.tmp || :
beatty:
	rm -f $@.rest.tmp
	touch $@.rest.tmp
	grep -P  '\<\?' beatty3.tmp \
	>>       $@.rest.tmp || :
	grep -vP '\<\?' beatty3.tmp \
	| grep -vE "A132222|A115181" \
	| perl -ne 'my $$r = ($$_ =~ m{REALS}) ? "r" : ""; $$_ =~ s{\tinfix\t}{\tbeatty2$$r\t}; print; '\
	| perl -ne 'if (m{^A329926}) { s{CR\.EIGHT}{CR\.NINE}; s{8\+sqrt}{9\+sqrt}; } print; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
	# | grep -vi zeta \
	#
beatty_old:
	make seq LIST=$@.lst
	$(DBAT) -x "SELECT l.aseqno, 'post', 0, n.name FROM seq l, asname n \
	    WHERE l.aseqno = n.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
beatty_diff:
	cut -b1-7 beatty1.tmp | sort > b1.tmp
	cut -b1-7 beatty.man  | sort > b2.tmp
	diff -y --width=32 b1.tmp b2.tmp
beatty_check:
	$(DBAT) -x "SELECT * FROM joeis j \
	  WHERE j.aseqno NOT in (SELECT aseqno FROM seq4) \
	    AND j.superclass LIKE 'Beatty%' \
	  ORDER BY 1;"
#--------------------------------
bindec:	# binary constants (characteristic functions) -> decimal
	grep -E "^A[0-9]" $(CONSTANT)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
smoothn:	# smooth <= n
	grep -E "^A[0-9]" $(CONSTANT)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# prog
pari_an2:
	cp -v $(PROG)/maint/pari/$@.tmp $@.gen
pari_an:
	make seq4 LIST=$(PROG)/maint/pari/$@.tmp
	make batlog LIST=pari_an.2022-07-01.*.log
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, s.parm2, s.parm3, s.parm4, '$(TO)' \
	  , CASE WHEN b.result = 'pass' THEN b.result ELSE b.idiff END, s.parm7 \
	  FROM seq4 s, batlog b \
	  WHERE s.aseqno = b.aseqno \
	    AND b.result LIKE 'pa%' \
	    AND s.aseqno NOT IN ((SELECT aseqno FROM poeis) UNION (SELECT aseqno FROM joeis)) \
	    ORDER BY 1" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
pari_isok_prog:
	make seq4 LIST=$(PROG)/maint/pari/pari_isok.tmp
	make batlog LIST=pari_isok.2022-06-24.*.log
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, s.parm2, s.parm3, s.parm4, '$(TO)' \
	  , CASE WHEN b.result = 'pass' THEN b.result ELSE b.idiff END, s.parm7 \
	  FROM seq4 s, batlog b \
	  WHERE s.aseqno = b.aseqno \
	    AND b.result LIKE 'pa%' \
	    AND s.aseqno NOT IN ((SELECT aseqno FROM poeis) UNION (SELECT aseqno FROM joeis)) \
	    ORDER BY 1" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
pari_isok:
	head -n$(MANY) $(PROG)/maint/pari/$@.tmp | sort | uniq -w7 > $@.gen
	wc -l    $@.gen
paritest:
	grep -E "^A[0-9]" $(CAS)/pari_an.tmp \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
parifail:
	gawk -e '{ print $$1 "\t" $$2 "\t" $$3 "\t" $$4 "\t0\t" $$5 "\t" }' paritest.log \
	| grep FAIL > $(COMMON)/joeis_check.txt
	cd $(COMMON) ; make -f checks.make html_check1 FILE=joeis_check
#----
paripat1: # insert 1 column
	# 0         1   2       3       4
	# A007117	7	FATO	4010 ms	19
	grep -E "^A[0-9]" paritest.4s.2022-06-19.22.00.log \
	| perl -ne 'my @f = split(/\t/); push(@f, $$f[4]); $$f[4] = ""; print join("\t", @f); '\
	>   paritest.4s.2022-06-20.00.00.log
#----
batlog: # LIST= store result logs in table 'batlog'
	$(DBAT) -f sql/batlog.create.sql
	cat $(LIST) \
	| grep -E "^A[0-9]" | grep -P "\t(pass|FATO)\t" | sort | uniq -w7 \
	| $(DBAT) -m csv -s "\t" -r batlog
	$(DBAT) "UPDATE batlog b SET b.timeout=$(TO) WHERE b.result='pass';"
	$(DBAT) "UPDATE batlog b SET b.result = 'pato' \
	    , b.expected =              COALESCE((SELECT termno FROM asdata d WHERE d.aseqno = b.aseqno), -1) \
	    WHERE b.result='FATO' AND b.idiff >= (SELECT termno FROM asdata d WHERE d.aseqno = b.aseqno);"
	$(DBAT) "SELECT result, COUNT(result) FROM batlog GROUP BY result ORDER BY 1;" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
PAT=concprod2.fail.log
batlog_populate: # PAT= fill test results into table 'batlog'
	$(DBAT) -f sql/batlog.create.sql
	grep -E "^A[0-9]" $(PAT) | sort | uniq -w7 \
	>        batlog.tmp
	$(DBAT) -m csv -s "\t" -r batlog < batlog.tmp
	$(DBAT) -n batlog
	$(DBAT) "SELECT result, COUNT(result) FROM batlog GROUP BY result ORDER BY 1;" \
	| tee    $@.tmp
batlog_eval:
	$(DBAT) "SELECT b.aseqno, b.result, s.parm1, s.parm2, s.parm3, s.parm4, s.parm5, s.parm6, s.parm7, s.name, b.expected, b.computed \
	  FROM seq4 s, batlog b \
	  WHERE s.aseqno = b.aseqno \
	    AND b.result LIKE 'FA%' \
	  ORDER BY 1"
batfato1:
	$(DBAT) -v "DELETE FROM batlog WHERE 0 = 1;"
batok: # select those that were ok: "pass" or "FATO" with idiff > termno
	$(DBAT) -x "SELECT b.aseqno, b.idiff, b.result, d.termno, b.timeout, b.computed \
	    FROM batlog b, asdata d \
	    WHERE d.aseqno = b.aseqno \
	      AND b.idiff > d.termno \
	    ORDER BY 1" \
	>        $(CC).$@.tmp
	head -n4 $(CC).$@.tmp
	wc -l    $(CC).$@.tmp
#----
prog_an:
	$(DBAT)    "DELETE FROM seq4 WHERE aseqno NOT IN       (SELECT b.aseqno  FROM batlog b WHERE b.result = 'pass'  );"
	$(DBAT)    "UPDATE seq4 s SET s.callcode='an', parm5 = (SELECT b.timeout FROM batlog b WHERE b.aseqno = s.aseqno);"
	$(DBAT) -x -$(MANY) "SELECT * FROM seq4 ORDER BY 1" \
	| perl -ne 'my @f = split(/\t/); $$f[3] = substr($$f[3], 2); $$f[3] .= ";" if ($$f[3] !~ m{\; *\Z}); print join("\t", @f); '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
prog_clean:
	grep -vE "start|pass" batch.log | cut -f1 \
	| perl -e 'while(<>) { my $$aseqno = substr($$_, 0, 7); my $$aseq = lc(substr($$aseqno, 0,4));'\
	' print "$$aseqno "; print unlink("./prog/gp/$$aseq/$$aseqno.gp") . "\n"; }'
#--------------------------------
ca.ari:
	grep -E "^A[0-9]" $(CA)/ari.gen > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
ca.1m:
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
decexp: # decimal expansion of expression
	grep -E "^A[0-9]" $(CONSTANT)/decexp4.tmp \
	| grep -vEE "A084257|A114041" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
decsolv:
	# cd $(CONSTANT) ; make $@
	grep -E "^A[0-9]" $(CONSTANT)/$@.gen \
	| grep -vE "A092290" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
getcr:
	grep -E "^A[0-9]" $(CONSTANT)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
solvetab:
	# cd $(CONSTANT) ; make $@
	grep -E "^A[0-9]" $(CONSTANT)/$@.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
deseq:
	grep -P  '\<\?' $(CONSTANT)/deseq4.tmp \
	>        $@.rest.tmp || :
	grep -vP '\<\?' $(CONSTANT)/deseq4.tmp \
	| perl -ne 'my $$r = ($$_ =~ m{REALS}) ? "r" : ""; $$_ =~ s{\tinfix\t}{\tdecexp$$r\t}; '\
	' my ($$aseqno, $$callcode, $$offset1, $$parm1, @rest) = split(/\t/); '\
	' if ((length($$offset1) <= 4) && ($$parm1 =~ m{\A[A-Z]})) { print; } '\
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
philo_tab:
	grep -E "^A[0-9]" $(CONSTANT)/philo_tab4.tmp \
	| sort | uniq -w7 \
	| perl -pe 's{\A(A\d+)\t(\w+)\t}{$$1\tdecexp\t}; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
philo_tab2:
	grep -E "^A[0-9]" $(CONSTANT)/philo_tab1.tmp \
	| sort | uniq -w7 \
	| grep -vE "sqrt|phi" | grep parmof4 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
mersenne_tab: # expansion of Mersenne primes
	grep -E "^A[0-9]" $(CONSTANT)/mersenne_tab1.tmp \
	| perl -pe 's{\A(A\d+)\t(\w+)\t}{$$1\tzbasex\t}; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
zbasex: # base expansion of a Z expression
	grep -E "^A[0-9]" $(CONSTANT)/zbasex.man \
	| perl -pe 's{\A(A\d+)\t(\w+)\t}{$$1\t$@\t}; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
powtower: # power tower - huge integers
	grep -E "^A[0-9]" $(CONSTANT)/powtower.man \
	| perl -pe 's{\A(A\d+)\t(\w+)\t}{$$1\t$@\t}; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
dechamp: # constant formed by the concatenation of the terms of a sequence
	grep -E "^A[0-9]" $(CONSTANT)/dechamp.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
decexro:
	grep -E "^A[0-9]" $(CONSTANT)/decexro2.tmp \
	| grep -vE "A102912|A306966|A317202" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
bellmod:
	grep -P "\Bell numbers " $(COMMON)/joeis_names.txt | grep -E "(read )?mod [0-9]" \
	| perl -ne 'm{\A(A\d+)}; my $$aseqno = $$1; m{mod (\d+)}; my $$mod = $$1; '\
	' print join("\t", $$aseqno, "parm2", 0, "A146093", $$mod) . "\n"; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
bincoef: # Binominal coeffients C(n,k)
	cp -v $(HOLREC)/$@.gen $@.gen
#--------------------------------
binom:
	grep -E "^A[0-9]" $@.man > $@.gen
#--------------------------------
binomin0: binomin1 binomin2 binomin3 binomin4
binomin1: # extract all single formulas containing binomial functions and/or factorials
	grep -E "^%[NFpto]" $(COMMON)/jcat25.txt \
	| grep -viE "[mk]\)|satisf|reap|flatten|nest|accum|while|fibon|sum|prod|add|sqrt|exp|coeff|abs|floor|ceil|transform|gcd|lcm|for\(|mod|prime|euler|phi|sigma|div" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
binomin234: binomin2 binomin3 binomin4
binomin2:
	perl binomin.pl -s 2 binomin1.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=binomin2.tmp
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis);"
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN ('A051154','A051155','A078186','A103562','A116213','A127670' \
	  ,'A128406','A128889','A128889','A133460','A237419','A276100','A338965');"
	$(DBAT)  -x "SELECT * FROM seq4 ORDER BY 1" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
binomin3: # convert the formula into hypergeometric parameters for HolonomicRecurrence
	perl $(COMMON)/callmap22.pl -t 2 -n 64 -p binomin.mpat binomin2.tmp \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
binomin4: # patch the initial terms - there may be no zero
	sort binomin3.tmp | uniq -w7 \
	| cut -f1-6 > $@.tmp
	cp -v $@.tmp $@.old.tmp
	make seq4 LIST=$@.tmp
	$(DBAT)  "UPDATE seq4 s \
	    SET s.parm4  = (SELECT SUBSTR(d.data, 1, 128) FROM asdata d WHERE d.aseqno = s.aseqno) \
	    ,   s.offset1 = (SELECT i.offset1              FROM asinfo i WHERE i.aseqno = s.aseqno);"
	$(DBAT)  -x "SELECT * FROM seq4 ORDER BY 1" \
	| perl binomin_patch.pl \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	grep -A2 -B1 syntax binomin3.tmp || :
binomin5: # select the ones that failed
	grep -P "^\# +A\d+\s+holof\s+" binomin3.tmp | sed -e "s/^# *//" \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis);"
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN ('A051154','A051155','A078186','A103562','A116213','A127670' \
	  ,'A128406','A128889','A128889','A133460','A237419','A276100','A338965');"
	$(DBAT)  -x "SELECT * FROM seq4 ORDER BY 1" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
binomin6: # convert by Maple
	perl $(COMMON)/callmaple.pl -t 2 -n 64 -p binomin.mpat binomin5.tmp \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
binomin7:
	grep -E "^A" binomin6.tmp \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
binomin:
	cat binomin4.tmp binomin.man | grep -P "^A[0-9]" | sort | uniq -w7\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
rhpart5: # A159355 Number of n X n arrays of squares of integers summing to 4.
	grep -E "^A[0-9]" $(CONTRIB)/rh/parts.tmp > binomin2.tmp
	make binomin3 binomin4
rhpart:
	cp binomin4.tmp $@.gen
#--------
qpoch0:
	grep -E "^\%p" $(COMMON)/jcat25.txt \
	| grep -Ei " pochhammer|gamma|factorial" | cut -b 4- | sed -e "s/ /\t/" > $@.tmp
qpoch:
	cp -v $@.man $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
ansect: # %F A334224 a(n) = A003418(2n-1) = A076100(n) for n>1.
	grep -P "a\(n\) *\= *A\d+\(\d*\*?n([\+\-]\d+)?\)" $(COMMON)/jcat25.txt | grep -E "^\%[NFCY] A[0-9]" \
	| perl ansect.pl \
	2>       $@.rest.tmp \
	| uniq > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
bisect0: # either take the 1st or the 2nd term from pairs of terms in the base sequence
	grep -Ei "section of " $(COMMON)/joeis_names.txt \
	| grep -vi intersection \
	| perl bisect0.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT)  "UPDATE seq4 s SET s.parm3 = (SELECT SUBSTR(d.data, 1,  64) FROM asdata d WHERE d.aseqno = s.aseqno) \
	                          , s.parm4 = (SELECT SUBSTR(d.data, 1,  64) FROM asdata d WHERE d.aseqno = s.parm1 );"
	$(DBAT)  -x "SELECT aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5 FROM seq4 ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp 
bisect:
	perl bisect.pl bisect0.tmp \
	2>       $@.rest.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
bisect_9:
	cat bisect0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
bitoper:
	grep -E "XOR| OR | AND " $(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
ca1elem:
	grep -E "^A[0-9]" $(COMMON)/../ca/$@.gen \
	| grep -v ca1other \
	| perl -ne 'print if substr($$_, 0, 7) ge "A038000";'\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
ca2elem:
	grep -E "^A[0-9]" $(COMMON)/../ca/$@.gen \
	| grep -v ca2other \
	| perl -ne 'print if substr($$_, 0, 7) ge "A038000";'\
	>        $@.tmp
	grep -E  "ca2on2" $@.tmp \
	| sed -e "s/$$/x/" > ca2on2.gen
	grep -vE "ca2on2" $@.tmp > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
ca2on2:
	head -n4 $@.gen
	wc -l    $@.gen
#--
caelem_alt:
	$(DBAT) -x "SELECT aseqno FROM seq4 WHERE parm2 <> 'nyi' ORDER BY 1" \
	>        $@.tmp
	perl copyalt.pl $@.tmp
#----
wa_stageb:
	grep -E "^A[0-9]" $(COMMON)/../ca/caelem.gen \
	| grep -v ca1other \
	| perl -ne 'print if substr($$_, 0, 7) ge "A050000";'\
	| grep ca1stageb \
	| sed -e "s/ca1stageb/$@/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
wa_staged:
	grep -E "^A[0-9]" $(COMMON)/../ca/caelem.gen \
	| grep -v ca1other \
	| perl -ne 'print if substr($$_, 0, 7) ge "A050000";'\
	| grep ca1staged \
	| sed -e "s/ca1staged/$@/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
carule0:
	perl -ne 'if ((m{cellular automat}) and (m{Rule (\d+)})) { print; }' \
	$(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
carule:
	perl carule.pl \
	$(COMMON)/names \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
caruniq:
	perl carule.pl -t \
	$(COMMON)/names \
	| sort | uniq -c \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#	perl -ne 'if ((m{cellular automat}) and ( m{Rule (\d+)})) { s{\"?Rule (\d+)\"?}{Rule 17}ig; print substr($$_, 8); }' \
#----
cacheck:
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE superclass = 'Cellular1DAutomaton' ORDER BY 1" | sed -e "s/\r//" \
	>        ghead.tmp
	make test2
#--------------------------------
cencube: # superclass is A005898
	grep "entered cube" $(COMMON)/joeis_names.txt \
	| grep -vE "A180082|A329636" \
	| perl -ne 's{\A(A\d+) *}{}; my $$aseqno = $$1; s/\+1/\#/g; m{(\d+)}; '\
	' my $$expon = $$1;  print join("\t", $$aseqno, "$@", 0, $$expon) . "\n";' \
	| tee    $@.gen
	wc -l    $@.gen
#--------------------------------
# new, using ContinuedFractionOfSqrtSequence
cfs:
	make cfs_all TARGET=gener
	cat $@?*.gen > $@.gen
	make dist
	make test CC=$@
	make pack CC=$@
cfs_sel:
	make cfs_all TARGET=select
	cat cfs*.gen > cfsall.gen
cfsall:
	rm -f cfsall.gen
	cat cfs*.gen > cfsall.gen
cfs_gen:
	make cfs_all TARGET=gener
cfs_all: # parameter: TARGET
	make $(TARGET) CC=cfsqrt
	make $(TARGET) CC=cfsqden
	make $(TARGET) CC=cfsqnum
	make $(TARGET) CC=cfsper
	make $(TARGET) CC=cfspercount
	make $(TARGET) CC=cfsperleast
	make $(TARGET) CC=cfsperlen
	make $(TARGET) CC=cfspercent0 TO=60
	make $(TARGET) CC=cfspercent1 TO=60
	make $(TARGET) CC=cfspertin
	wc -l cfs*.gen
#----
# A010121	Continued fraction for sqrt(7).
# A040002	Continued fraction for sqrt(5).
cfsqrt:
	perl -ne 'if (m{^(A\d+) Continued fraction for sqrt\((\d+)\)\.})   { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A041009 Denominators of continued fraction convergents to sqrt(7).
# A041010 Numerators of continued fraction convergents to sqrt(8).
cfsqnum:
	perl -ne 'if (m{^(A\d+) Numerators of continued fraction convergents to sqrt\((\d+)\)\.})   { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names \
	| grep -v "^A00" \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
cfsqden:
	perl -ne 'if (m{^(A\d+) Denominators of continued fraction convergents to sqrt\((\d+)\)\.}) { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names \
	| grep -v "^A00" \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A003285	Period of continued fraction for square root of n (or 0 if n is a square).
# A097853	Period of continued fraction for square root of n (or 1 if n is a square).
cfsper:
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
# PARM1="==" PARM2=11 PARM3=1
cfspercount:
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
cfsperleast:
	perl -ne \
	'if (m{^(A\d+) (Numbers n such that )?(the )?[Ll]east term in (the )?period of (the )?continued fraction for sqrt\(n\) is (\d+)\.}) { print "$$1\t$@\t0\t$$6\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A013643	Numbers n such that continued fraction for sqrt(n) has period 3.
# A013644	Numbers n such that the continued fraction for sqrt(n) has period 4.
# + A002522	a(n) = n^2 + 1 for period 1
cfsperlen:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has period (\d+)\.}) { print "$$1\t$@\t0\t$$3\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A064848 Period of continued fraction for sqrt(2)*n.
# A064927 Period of continued fraction for sqrt(23)*n.	nonn,synth	1..75
cfspertin:
	perl -ne \
	'if (m{^(A\d+) Period of continued fraction for sqrt\((\d+)\)\*n}) { print "$$1\t$@\t0\t$$2\n" }' \
	$(COMMON)/names > $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
	TO=10
#----
# A031598	Numbers n such that continued fraction for sqrt(n) has even period and central term 100.
# A031600	Numbers n such that continued fraction for sqrt(n) has odd period and central terms 12.
# A031413	Numbers n such that continued fraction for sqrt(n) has even period 2*m and the m-th term is 10.
# A031414	Numbers n such that continued fraction for sqrt(n) has odd period and a pair of central terms both equal to 1.
# PARM1=parity, PARM2=central
#           1                             2                                              3                 4           5                                            6                                      7
cfspercent0:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has (even) period (2\*m )?and (the m\-th|central|a pair of central) terms? (is |both equal to |of the period is |)(\d+)\.})'\
	'{ print "$$1\t$@\t0\t$$7\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
cfspercent1:
	perl -ne \
	'if (m{^(A\d+) Numbers [nk] such that (the )?continued fraction for sqrt\([kn]\) has (odd) period (2\*m\s?\+\s?1)?and (the m\-th|central|a pair of central) terms? (is |both equal to |of the period is |)(\d+)\.})'\
	'{ print "$$1\t$@\t0\t$$7\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#--------------------------------
# %F A238745 a(n) = A181819(A124859(n)).
chain2: # rather fruitless since not monotone or big distances in parm2
	grep -E "a\(n\) *= *A[0-9][0-9]*\(A[0-9][0-9]*\(n\)\)" $(COMMON)/cat25.txt \
	| perl -ne 'my $$line = $$_; '\
	'if ($$line =~ m{^\%\w (A\d+)\s*a\(n\) *= *(A\d+)\((A\d+)\(n\)\)\s*\.}) {'\
	'print join("\t", $$1, "$@", 0, $$2, $$3) . "\n"; }'\
	| uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, s.parm2, b.bfimax - b.bfimin + 1, d.data \
		FROM seq4 s, asdata d, bfinfo b \
		WHERE s.aseqno = d.aseqno \
		  AND d.aseqno = b.aseqno \
		  AND s.parm1      IN (SELECT aseqno FROM joeis) \
		  AND s.parm2      IN (SELECT aseqno FROM joeis) \
		  AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 1" \
	| sed -e "s/\r//" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A124697		Number of base 4 circular n-digit numbers with adjacent digits differing by 1 or less.
# k:=4; Table[Sum[(1+2*Cos[j*Pi/(k+1)])^n,{j,1,k}],{n,0,10}]
circdiff0: circdiff1 circdiff2
circdiff1:
	$(DBAT) -f sql/seq4.create.sql
	cat $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{\A(A\d+)\t\w+\tNumber of base.(\d+) circular n\-digit numbers with adjacent digits differing by (\d+) or less}) { '\
	' my ($$aseqno, $$base, $$diff) = ($$1, $$2, $$3); print join("\t", $$aseqno, "circdiff", 1, $$base, $$diff) . "\n"; } '\
	| $(DBAT) -r seq4
	$(DBAT) -x "SELECT s.aseqno, s.callcode, i.offset1, s.parm1, s.parm2, d.data \
		FROM seq4 s, bfdata d, asinfo i \
		WHERE s.aseqno = d.aseqno \
		  AND d.aseqno = i.aseqno \
		ORDER BY 1" \
	| sed -e "s/\r//" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
circdiff2:
	$(JPREP) -f circdiff1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
circdiff_old:
	grep -E "\[" circdiff2.tmp \
	| sed -e "s/\tcircdiff/\tholos/" > circdiff.gen
circdiff:
	cp -v $(COMMON)/../contrib/hardin/circdiff.gen .
circdiff4:
	$(DBAT) -x "SELECT s.aseqno, d.data FROM seq4 s, bfdata d \
	  WHERE s.aseqno = d.aseqno \
	  ORDER BY 1" \
	| perl circdiff4.pl \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
circdiffwi:
#---
	perl wiki_tabs.pl -e $(EL) -d $(D) -x "&mdash;" circdiff.witab \
	>        circdiff.wiki
#--------------------------------
compleq0: # complementary equations
	grep -iE "complementary eq" $(COMMON)/joeis_names.txt \
	| grep -vE "self\-complementary|musical|Golay|Beatty|A326665" \
	| perl compleq.pl -d $(D) \
	>        $@.tmp \
	2>       $@.rest.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
compleq9:
	grep -iE "complementary eq" $(COMMON)/joeis_names.txt \
	| grep -vE "self\-complementary|musical|Golay" \
	| perl -ne 'print if m{of the (near\-)complementary equation};'
#--
# compleq.man contains the manual corrections.
# CC=compleqa is set when $(PARM5) contains the complete body of method adjunct(n).
compleq:
	cut -b1-7 $@.man | grep -E "^A" > $@.grep.tmp
	grep -vEf $@.grep.tmp compleq0.tmp > $@.tmp
	sort $@.man $@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
complet:
	$(JAVA) irvine.oeis.ComplementaryEquationSequence -d $(D) -p $(MATRIX) -i $(INIT) -m $(NT)
compleq3:
	grep -E "^A" compleq3.man > compleq3.gen
#--------------------------------
# A036507 Smallest square containing exactly n 0's.	nonn,base,changed,synth	1..16
# A036518 Smallest triangular number containing exactly n 1's.	nonn,base,changed,synth	1..18
# A036527 Smallest cube containing exactly n 0's.	nonn,base,changed,synth	0..21
conexdig:
	grep -vE "^(A036507|A048345)" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
concsim0:
	grep -iP "concatenat|juxtapos" $(COMMON)/joeis_names.txt \
	| grep -ivE "product|square|\^2" \
	| grep -P "\tnyi" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	
# A030465 Numbers n such that n concatenated with n+1 is a square.
# A030466 Squares that are concatenations of two consecutive nonzero numbers.
# A030467 Numbers n such that n^2 is a concatenation of two successive numbers.
# A116353	null	Numbers n such that n times n+7 gives the concatenation of two numbers m and m+9.	nonn,base,synth	1..5
# A116354	null	n times n+8 gives the concatenation of two numbers m and m+9.	nonn,base,synth	1..23
# A115437	null	Numbers n such that the concatenation of n with n+4 gives a square.	base,nonn,synth	1..24
# A115438	null	Numbers n such that the square of n is the concatenation of two numbers k and k+4.	base,nonn,synth	1..25
# A115527	null	Numbers n such that the concatenation of n with 2*n gives a square.	nonn,base,synth	1..5
# A115528	null	Numbers n such that the square of n is the concatenation of two numbers m and 2*m.	nonn,base,synth	1..5
# A116094 Numbers n such that n concatenated with n-9 gives the product of two numbers which differ by 1.

# concatenation of twin numbers give a product of twins
concprod0:
	grep -iP "concatenat|juxtapos" $(COMMON)/joeis_names.txt \
	| grep -iE "product|square|\^2|two numbers|with itself|Giovanni Resta" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
concprod:
	perl concprod.pl concprod0.tmp \
	>        $@.gen \
	2>       $@.rest.tmp
	cat concprod.man >> $@.gen
	head -n4 $@.gen
	wc -l    $@*
	grep -E "^A11[56]" $@.rest.tmp || :
concadd:
	perl concprod.pl concprod0.tmp \
	| grep -P "\t[pc]a\t" \
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc -l    $@*
concmul:
	perl concprod.pl concprod0.tmp \
	| grep -P "\t[pc]m\t" \
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc -l    $@*
concprod_eval: 
	make batlog_populate PAT=concprod.fail.log
	make batlog_eval \
	| grep -E "^A[0-9]" \
	| tee    $@.tmp
	wc -l    $@.tmp
concprod_data:
	$(DBAT) -x "SELECT d.aseqno, d.data FROM bfdata d, seq4 s WHERE d.aseqno = s.aseqno AND s.parm1 LIKE '_a%' ORDER BY 1" \
	>        $@.tmp
	perl htmlize.pl $@.tmp > $@.htm
	cmd /c start             $@.htm
concprod_progs:
	$(DBAT) -x "SELECT s.aseqno, i.program, s.name FROM asinfo i, seq4 s WHERE i.aseqno = s.aseqno AND LENGTH(i.program) > 0 ORDER BY 1" \
	| tee    $@.tmp
concprod_subset: # select first of each decision branch (parm5)
	$(DBAT) -x "SELECT MIN(aseqno), s.callcode, s.offset1, s.parm1, s.parm2, s.parm3, s.parm4, s.parm5 FROM seq4 s \
	  GROUP BY s.parm5 \
	  ORDER BY 1" \
	| tee    $@.gen
	grep A116170 concprod.gen | tee -a $@.gen
#--------------------------------
crystalb:
	grep -iE "Crystal ball|Coordination sequence" $(COMMON)/joeis_names.txt | grep -i lattice \
	| perl -ne 'my ($$aseqno, $$superclass, $$name, @rest) = split(/\t/); '\
	' my $$cb = ($$name =~ m{rystal}) ? "crybs" : "coors"; '\
	' $$name =~ m{ sequence (for|of) (the )?([^\.\(\:\;]+)}; my $$latt = $$3 || "L?"; '\
	' print join("\t", $$aseqno, substr($$superclass, 0, 8), 0, $$latt, $$cb, $$name) . "\n"; '\
	| sort -k4 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
cumulcnt:
	grep -E "^A[0-9]" $(COMMON)/../contrib/A055187/gen.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
dance:
	grep -vE "^#" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
dancetest:
	$(JAVA) irvine.oeis.a079.A079922 $(G) $(H) | tee dance.$(G).$(H).txt
dance_hol:
	perl $(CONTRIB)/dance/a079908.pl > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
dead:
	$(DBAT) -x "SELECT i.aseqno, n.name, 0 \
	    FROM asinfo i, asname n \
	    WHERE i.aseqno = n.aseqno \
	      AND i.keyword LIKE '%dead%' \
	    ORDER BY 1" \
	| perl -ne 'my ($$aseqno, $$name, $$rest) = split(/\t/); $$name =~ m{(A\d\d\d+)}; my $$bseqno = $$1; '\
	' my $$code = lc(substr($$name, 0, 4)); $$code =~ s{inco|not |van |appa|appe}{erro}i; '\
	' print join("\t", $$aseqno, "$@", 0, $$bseqno, $$code, substr($$name, 0, 64)) . "\n";'\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	make seq4 LIST=$@.gen
dead_check: # Where are dead, erroneous sequences still referenced?
	$(DBAT) "SELECT r.aseqno, b.keyword, s.aseqno, s.parm2, a.keyword \
		FROM asxref r, seq4 s, asinfo a, asinfo b \
		WHERE r.aseqno = b.aseqno \
		  AND s.aseqno = r.rseqno \
		  AND s.aseqno = a.aseqno \
		  AND s.parm1 <> r.aseqno \
		  AND (s.parm2 =  'erro' OR s.parm2 =  'dupl') \
		  AND b.keyword NOT LIKE '%dead%' \
		ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#--------------------------------
dersimple:
	grep -E "\%[NF]" $(COMMON)/jcat25.txt \
	| grep -vE "\.\.\." \
	| cut -b4- | grep -Ei "^....... a" | sed -e "s/ /\t/" | sort | uniq -w7 \
	| perl dersimple.pl -d $(D) \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	cp -v $@.tmp $@.gen
deradapt:
	cp -v dersimple.gen $@.tmp
	perl deradapt.pl $@.tmp > dersimple.gen
#--------------------------------
cofr:
	grep -E "^A[0-9]" $(COMMON)/../sequencedb/contfrac_de.tmp \
	| perl -pe 's{\t\w+\t}{\t$@\t}; '\
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
decofr0:
	grep -B1 -E "Continued fraction" $(COMMON)/joeis_names.txt \
	| grep -B1 -P "\tnyi" | cut -b1-128 \
	| tee    $@.tmp
cofrman:
	grep -E "^A[0-9]" $(CONSTANT)/$@.man \
	>        $@.tmp
	grep -E "^A[0-9]" $(CONSTANT)/decofr1.man \
	>>       $@.tmp
	# 3 x FATOK _ loops?
	sed -e "s/decofr/cofr/" $@.tmp \
	| grep -vE "A244110|A265824|A265825" \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
cofrseq:
	grep -E "^A[0-9]" $@.man \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
decofr: # Continued fraction of real expression
	perl decofr.pl -i 0 $(COMMON)/joeis_names.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#--------------------------------
denrat0:
	$(DBAT) -x "SELECT i.aseqno, COALESCE(SUBSTR(j.superclass, 1, 7), 'denrat') \
	    , 0, i.aseqno, n.name, i.keyword, '[' || b.bfimin || '..' || b.bfimax || ']' \
	    FROM  asinfo i, asname n, bfinfo b LEFT JOIN joeis j ON j.aseqno = b.aseqno \
	    WHERE i.aseqno = n.aseqno \
	      AND n.aseqno = b.aseqno \
	      AND i.keyword LIKE '%frac%' \
	      AND i.keyword LIKE '%tabl%' \
	    ORDER BY 1 "\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
denrat:
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
deriv0: deriv1 deriv_rest # prepare derived sequences
deriv_rest: deriv2 deriv3 deriv4 deriv5 deriv6 deriv7
deriv1: # grep jcat25: (a(n) = )?aseqno
	grep -E "^\%[NF] A" $(COMMON)/jcat25.txt \
	| cut -b4- \
	| grep -P  "^A\d{6}[^A]*A\d{6}" \
	| sed -e "s/ /\t/" \
	| sed -e "s/\tTwice  *A/\t2\*A/" \
	| grep -vEi "sum|product|\!|\.\.\.|a\(n\) *[\<\>]" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
deriv2: # convert known functions, separate conditions, split in several formulas for one sequence
	perl deriv_exist.pl -d $(D) -f $(COMMON)/joeis_ofter.txt deriv1.tmp \
	| sort | uniq \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	cut -f1  $@.tmp | sort | uniq | wc -l
deriv3: # add offset1 from asinfo; aseqno, md5sum, offset1, ~~form, form, cond
	make seq4 LIST=deriv2.tmp
	$(DBAT) -v -f sql/deriv3.update.sql
	$(DBAT) -x "SELECT s.aseqno, 'postder', i.offset1, s.parm1, s.parm2, s.parm3, i.terms \
	    FROM  seq4 s, asinfo i\
	    WHERE s.aseqno = i.aseqno \
	      AND i.keyword NOT LIKE '%dead%' \
	      AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
	    ORDER BY 1" \
	| sed -e "s/\r//" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
deriv4: # remove all with X-numbers
	perl -ne 'my $$line = $$_; if (($$line =~ m{A\d{6}_\d}) '\
	' and ($$line !~ m{X\d{6}})) { print $$line; }' deriv3.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
deriv5: # convert to postfix, select the last of the shortest formula
	$(JPREP) -f deriv4.tmp \
	| perl deriv_select.pl \
	>        $@.tmp
	make seq4 LIST=deriv5.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, s.parm2, s.parm3, s.parm4 \
	    FROM  seq4 s \
	    ORDER BY 1" \
	| sed -e "s/\r//" \
	| grep -vE "^(A095775|A102954|A130517|A131241|A131783|A131784|A136489|A187791|A247270)" \
	>        $@.tmp
	tail -n4 $@.tmp
	wc   -l  $@.tmp
deriv6: # convert from postfix to Z-expressions
	perl post_infix.pl -p Z.xpat deriv5.tmp \
	2>       $@.rest \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.*
deriv7: # adapt the offsets and initial terms
	perl deriv_gen.pl deriv6.tmp \
	2>       $@.rest \
	| grep -vE "A065446|A070011|A145920|A178476|A277535|A185227|A185228|A185229|A255541|A282844" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@*.*
deriv:
	grep -vE "floor|ceil|round" deriv7.tmp \
	| grep -vE "Beatty" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.*
#--------------------------------
dex0: dex1 dex2 dex3 dex4
dex1: # names: Annnnnn Decimal expansion of ... and in jOEIS
	$(DBAT) "UPDATE asname SET name = 'Decimal expansion of 2*(5-3*exp(1/2))/(2*exp(1/2)-3).' WHERE aseqno = 'A108813'"
	$(DBAT) -x "SELECT a.aseqno, 'dex', a.offset1, n.name, a.keyword \
		FROM asinfo a, bfinfo b, asname n\
		WHERE a.aseqno = n.aseqno \
		  AND b.aseqno = n.aseqno \
		  AND n.aseqno NOT IN (SELECT aseqno FROM joeis) \
		  AND a.keyword    LIKE '%cons%' \
		  AND b.maxlen <= 2 \
		ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
dex2:
	perl extract_dex.pl dex1.tmp \
	| sed -e "s/pi log/pi\*log/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
dex3:
	$(JPREP) -f dex2.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
dex4:
	perl cr_infix.pl -d $(D) dex3.tmp \
	| grep -vE "^(A114054|A117853|A202955|A248622)" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	grep "#" $@.tmp \
	>        $@.rest || :
	head -n4 $@.rest
	wc   -l  $@.rest
dex:
	cp dex4.tmp dex.gen
#--------------------------------
# A163241	null	Simple self-inverse permutation: Write n in base 4, then replace each digit '2' with '3' and vice versa, then convert back to decimal.	nonn,base,easy,	0..1023
# A171013	null	In the sequence of prime numbers, replace all digits '1' with '0' and vice versa.	nonn,base,easy,	1..1000
# A171014	null	In the sequence of prime numbers, replace all the '2' digits with '0' and vice versa.	nonn,base,easy,	1..1000
# A222212	null	In the number n, replace all (decimal) digits '0' with '3' and vice versa.	nonn,base,easy,	0..1000
# A222213	null	Replace all (decimal) digits '0' with '4' and vice versa.	nonn,base,easy,	0..1000
# A222216	null	In the number n, replace all (decimal) digits 0 with 7 and vice versa.	nonn,base,easy,	0..1000
digexch:
	grep -E "vice versa" $(COMMON)/names \
	| perl -ne 'my $$base = 10; s{digits? }{}; my $$line = $$_; '\
	' ;'\
	' if (m{eplace\D*(\d)\D? with *\D?(\d)}) { my ($$dig1, $$dig2) = ($$1, $$2); '\
	'   if (m{ base +(\d+)}) { $$base = $$1; }; '\
	'   print join("\t", substr($$line, 0, 7), "digexch", 0, (($$line =~ m{prime num}) ? "a000\tA000040" : "a001\tA001477")'\
	'     , $$base,$$dig1, $$dig2) . "\n"; '\
	' }'\
	>       $@.gen
	head -4 $@.gen
	wc   -l $@.gen
#--------------------------------
# A063616	A031146	Smallest k >= 0 such that 8^k has exactly n 0's in its decimal representation.	base,nonn,synth	0..50
# A063617	null	Smallest k such that 8^k has exactly n 1's in its decimal representation.	base,nonn,synth	0..50
digpow: # unfinished - handy/a031/A031146.java as pattern
	grep -E "Smallest" $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; my $$line = $$_; $$line =~ s{\s+\Z}{}; '\
	'if ($$line =~ m{^(A\d+)\t\w+\tSmallest k[^s]*such that (\d+)\^k\D+(\d+)}) { '\
	'  my ($$aseqno, $$base, $$digit) = ($$1, $$2, $$3); '\
	'  print join("\t", $$aseqno, "$@", 0, $$base, $$digit, substr($$line, 8)) . "\n"; '\
	' } '\
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
digsets: # A037303	null	(sum of base 2 digits of n)=(sum of base 5 digits of n).	nonn,base,changed,	1..1000
	perl digsets.pl -d 0 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	cut -f4 digsets.gen | sed -e "s/^/\^/" | sort | uniq | tee $@.tmp
	grep -f $@.tmp $(COMMON)/joeis_names.txt
#--------------------------------
# A035170 Coefficients in expansion of Dirichlet series Product
diriprod_short:
	cat $(COMMON)/names \
	| perl dirichlet_product.pl -d 0 \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
diriprod0:
	cat $(COMMON)/jcat25.txt \
	grep -E "^\%[NFC]" | grep -E "Dirichlet|Kronecker" | cut -b4- \
	| perl dirichlet_product.pl -d 0 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
diriprod:
	cp -v diriprod0.tmp $@.gen
	wc -l    $@.gen
#--------------------------------
divpow:
	perl divpow.pl -d 0 $(COMMON)/joeis_names.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
doubled:
	grep "double" $(COMMON)/doubled1.tmp | grep -v nyi \
	| grep -vE "A108784|A164660" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
dupl_prep: dupl1 dupl2 dupl3 # duplicates
dupl1:
	perl -ne \
	'if (m{^\%\w (A\d+) (Duplicate of |Essentially the same as |Same as )(A\d+)})'\
	'{ print join("\t", $$1, "dupl", 0, $$3) . "\n" }' \
	$(COMMON)/cat25.txt \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
dupl2:
	make seq4 LIST=dupl1.tmp
	$(DBAT) -v "DELETE FROM seq4 \
	  WHERE aseqno    IN (SELECT aseqno FROM joeis) \
	     OR parm1 NOT IN (SELECT aseqno FROM joeis);"
dupl3:
	$(DBAT) -x "SELECT s.aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, s.name \
	    FROM seq4 s, asinfo i \
	    WHERE s.aseqno = i.aseqno \
	      AND i.keyword NOT LIKE '%dead%' \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#	| grep -vE "A082627|A174781"
dupl:
	cp -v dupl3.tmp $@.gen
#--------------------------------
emullin:
	cp -v emullin.man emullin.gen
#--------------------------------
engelex0:
	grep -iE "(Engel|Pierce) expansion of" $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; my ($$aseqno, $$superclass, $$name, $$keyword, $$range) = split(/\t/); '\
	'if ($$name =~ m{\A(Engel|Pierce) expansion of (.*)}) { my ($$cc, $$expr) = ($$1, $$2); '\
	' $$cc =~ s{Engel}{engelex}; $$cc =~ s{Pierce}{piercex}; $$range =~ s{\s}{}g; '\
	' print join("\t", $$aseqno, $$cc, 0, "VOID", "", $$superclass, $$range, $$expr) . "\n" }' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
engelex:
	grep -v VOID engelex.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
esf: # ElementarySymmetricFunctionSequence
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
etlen: etlen1 etlen2
etlen1:
	grep -E "Euler transform of length" $(COMMON)/cat25.txt \
	| cut -b4- \
	       > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
etlen2:
	cp etlen1.tmp $@.raw.tmp
	cut -b1-7 $@.raw.tmp | grep -E "^A" | sed -e "s/^/\^\%H /" > $@.grep.tmp
	grep -E "^%H " $(COMMON)/cat25.txt \
	| grep -f $@.grep.tmp | grep signature \
	| cut -b4- \
	| sed -e "s/ [^,]*, / /" >> $@.raw.tmp
	sort $@.raw.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
etper: etper1 etper2
etper1:
	grep -E "Euler transform of period" $(COMMON)/cat25.txt \
	| cut -b4- \
	       > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
etper2:
	cp etper1.tmp $@.raw.tmp
	cut -b1-7 $@.raw.tmp | grep -E "^A" | sed -e "s/^/\^\%H /" > $@.grep.tmp
	grep -E "^%H " $(COMMON)/cat25.txt \
	| grep -f $@.grep.tmp | grep signature \
	| cut -b4- \
	| sed -e "s/ [^,]*, / /" >> $@.raw.tmp
	sort $@.raw.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
etper3:
	cp etper1.tmp $@.raw.tmp
	cut -b1-7 $@.raw.tmp | grep -E "^A" | sed -e "s/^/\^/" > $@.grep.tmp
	grep -E "^A" $(COMMON)/joeis_names.txt \
	| grep -f $@.grep.tmp \
	>> $@.raw.tmp
	sort $@.raw.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
etper4:
	cp etper1.tmp $@.raw.tmp
	cut -b1-7 $@.raw.tmp | grep -E "^A" | sed -e "s/^/\^\%H /" > $@.grep.tmp
	grep -E "^%H " $(COMMON)/cat25.txt \
	| grep -f $@.grep.tmp | grep -iE "recurrence" \
	| cut -b4- \
	 >> $@.raw.tmp
	sort $@.raw.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
etaprod: # EtaProductSequence
	cat $(ETA)/etaprod.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
etalists: # lists from the literature
	# perl $(ETA)/acres.pl 
	# perl $(ETA)/martin.pl 
	# perl $(ETA)/moy.pl 
	# perl $(ETA)/williams2.pl 
	cat $(ETA)/etalists.lst \
	| grep -v A999999 | sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
rootet:
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
eisenprod:
	grep -P "\bE_(\d\d?)\b" $(COMMON)/jcat25.txt | grep -E "^\%[NFC]" \
	| perl eisenprod.pl \
	2>       $@.rest.tmp \
	>        $@.gen 
	head -n4 $@.gen
	wc -l    $@.gen $@.*tmp
#	| grep -vE "A288472|A288989|A289981|A290009|A290010|A290049|A290050" \
#----
convinv:
	cp -v $(COMMON)/$@.tmp $@.gen
convprom:
	grep -E "^A[0-9]" convprod.man > $@.gen
convprod:
	perl convprod.pl $(COMMON)/convprod.tmp \
	2>       $@.rest.tmp \
	>        $@.gen 
	head -n4 $@.gen
	wc -l    $@.gen $@.*tmp
#--------------------------------
eulerian:
	grep -E "\%[CFN]" $(COMMON)/cat25.txt | grep -E "Eulerian[\[]" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
# A006526 Egyptian fraction for 1/e.
# A248319 Egyptian fraction representation of sqrt(96) (A010547) using a greedy function.	nonn,changed,synth	0..8	null
egypfr:
	grep -iE "Egyptian fraction" $(COMMON)/joeis_names.txt \
	| perl egypfr.pl -d 0 \
	2>       $@.rest.tmp \
	>        $@.tmp
	grep -vE "^\#" $@.man >> $@.tmp
	sort     $@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen $@.rest.tmp
#--------------------------------
fiboluca:
	cp -v $(COMMON)/$@.tmp $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
finifull: # finite and full
	$(DBAT) -x "SELECT i.aseqno, '$@', i.offset1, d.data \
		FROM asinfo i, bfinfo b, bfdata d \
		WHERE i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND b.bfimax - b.bfimin  + 1 <= d.termno \
		  AND i.keyword like '%full%' \
		ORDER BY 1 " \
	>        $@.tmp
	wc -l    $@.tmp
	make finalize
#--
finifuma: # finite and full - manual
	grep -E "^A[0-9]" finifull.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# make finalize
finifubf: # create b-files for all in finifull.man
	grep -E "^A[0-9]" finifull.man \
	| cut -b2-7 \
	| xargs -l -innn make finifubf1 S=nnn
	wc -l bftmp/b05199*.txt
finifubf1:
	make seqtest A=A$(S) NT=1000 OFFSET=1 | grep -P "^\d+ \-?\d+\Z" \
	>                          bftmp/b$(S).txt
	perl -e 'print "\n\n";' >> bftmp/b$(S).txt
#----
noncomp: # similar to finifull and bref
	cat $(CONSTANT)/noncomp.man \
	| perl -ne 'if (m{\A(A\d+)}) { print join("\t", $$1, "noncomp". 0) . "\n"; } '\
	| sort | uniq -w7 \
	>        $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "SELECT i.aseqno, '$@', i.offset1, d.data \
		FROM seq4 s, asinfo i, bfinfo b, bfdata d \
		WHERE s.aseqno = i.aseqno \
		  AND i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND b.bfimax - b.bfimin  + 1 <= d.termno \
		  AND i.keyword like '%full%' \
		ORDER BY 1 " \
	>        $@.tmp
	wc -l    $@.tmp
	make finalize
noncomp_long:
	$(DBAT) "SELECT i.aseqno, '$@', i.offset1, SUBSTR(d.data, 1,64) || ' ...' \
		FROM asinfo i, bfinfo b, bfdata d \
		WHERE i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND b.bfimax - b.bfimin  + 1 > d.termno \
		  AND i.keyword like '%full%' \
		  AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 1;"
#----
# Sequences with keyword "bref", similar to finifull
bref:
	$(DBAT) -x "SELECT i.aseqno, '$@', i.offset1, d.data \
		FROM asinfo i, bfinfo b, bfdata d \
		WHERE i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND b.bfimax - b.bfimin  + 1 <= d.termno \
		  AND i.keyword like '%bref%' \
		ORDER BY 1 " \
	>        $@.tmp
	wc -l    $@.tmp
	make finalize
#----
finalize: # CC= ; insert "L" and "new Z(...)" if necessary
	#---- finalize CC=$(CC)
	perl finifull.pl $(CC).tmp \
	>        $(CC).gen
	head -n4 $(CC).gen
	wc -l    $(CC).gen
#----
fini_update: # select all (Brief|Finite|Noncomputable)Sequence for a retest
	$(DBAT) -x "SELECT aseqno, CASE \
	        WHEN superclass = 'BriefSequence'         THEN 'bref' \
	        WHEN superclass = 'FiniteSequence'        THEN 'finifull' \
	        WHEN superclass = 'NoncomputableSequence' THEN 'noncomp' \
	        ELSE 'nyi' END, 0 \
	    FROM joeis \
	    WHERE superclass IN ('BriefSequence','FiniteSequence','NoncomputableSequence') \
	    ORDER BY 1 " \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
sciconst:
	grep -E "^A[0-9]" $(CONSTANT)/$@.man \
	| perl -pe 's{\A(A\d+)}{$$1\tnoncomp\t0};' \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# old targets
noncomp0: # non-computable sequences, pseudo-finite/full
	wget https://oeis.org/wiki/The_multi-faceted_reach_of_the_OEIS?action=raw -O $@.wiki
noncomp_prep: noncomp1 noncomp2 noncomp3 noncomp4
noncomp1:
	perl multifacet.pl noncomp0.wiki \
	| grep -vE 'A261400|A115035|A098378|A047841|anthropology|archeology|architecture|boardgames|computerengineering|dance|darts|demography|dicegames|dominoandtilegames|electricalengineering|electroweaktheory|genetics|calendar|inorganicchemistry|internet|knottheory|logic|mancalagames|othertabletopgames|phyllotaxy|populationgenetics|representationtheory|statistics|thermodynamics|typography' \
	| sort | uniq -w7 | sort -k4 -k1 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
noncomp2:
	grep -Ei 'Czech|Danish|Dutch|Finnish|French|Hungarian|Italian|Norwegian|Polish|Portuguese|Russian|Slovak|Spanish|Swedish|Turkish|atomic|chemical elem|electron|mass |nuclear|periodic (table|system)|planet|birth |death |burial |popes?|roulette|melting|boiling|noble gases' \
	$(COMMON)/joeis_names.txt \
	| grep -viE "A212434|(di|tri)atomic|Latin square|reverse polish|fixed polyomino|domino" \
	| sed -e "s/\t.*/\tnoncomp\t0\tadditional/" \
	>        $@.tmp
	grep -Ei "A007656|A279797|A051385|A053407|A308681|A055069|A070729|A092478|A097618|indian" $(COMMON)/joeis_names.txt \
	| sed -e "s/\t/\tnoncomp\t0\tmanual\t/" noncomp.man \
	>>       $@.tmp
	sed -e "s/\t/\tnoncomp\t0\tmanual\t/" noncomp.man \
	>>       $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
noncomp3:
	# cat noncomp1.tmp noncomp2.tmp | sort | uniq -w7
	grep -E "^A[0-9]" $(CONSTANT)/noncomp.man \
	| grep -vE "A005646|A094871" \
	| cut -b1-7 | sed -e "s/$$/\tnoncomp\t0\t1/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) -n seq4
	#                                                   PARM1   PARM2    PARM3     PARM4     PARM5     PARM6
	$(DBAT) -x "SELECT s.aseqno, 'noncomp', i.offset1, d.data, s.parm1, b.bfimin, b.bfimax, d.termno, i.keyword, '', '', n.name \
	    FROM seq4 s, asname n, bfdata d, asinfo i, bfinfo b \
	    WHERE s.aseqno = n.aseqno \
	      AND n.aseqno = d.aseqno \
	      AND d.aseqno = i.aseqno \
	      AND i.aseqno = b.aseqno \
	      AND i.keyword NOT LIKE '%dead%' \
	      AND i.keyword NOT LIKE '%word%' \
	      AND i.keyword NOT LIKE '%frac%' \
	      AND b.aseqno NOT IN (SELECT aseqno from joeis) \
	      AND b.bfimax - b.bfimin + 1 <= 512 \
	    ORDER BY 4, 1" \
	>        $@.tmp
	wc -l    $@.tmp
	perl finifull.pl $@.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# make seq4 LIST=$@.gen
#--
noncomp4: # for info only
	$(DBAT) -x "SELECT s.aseqno, s.parm2, b.bfimin, b.bfimax, d.termno, i.keyword, n.name \
	    FROM seq4 s, asname n, bfdata d, asinfo i, bfinfo b \
	    WHERE s.aseqno = n.aseqno \
	      AND n.aseqno = d.aseqno \
	      AND d.aseqno = i.aseqno \
	      AND i.aseqno = b.aseqno \
	      AND i.keyword NOT LIKE '%dead%' \
	      AND i.keyword NOT LIKE '%word%' \
	      AND i.keyword NOT LIKE '%frac%' \
	      AND b.aseqno NOT IN (SELECT aseqno from joeis) \
	      AND LENGTH(i.program) = 0 \
	      AND b.bfimax -b.bfimin +1 <= 128 \
	    ORDER BY 2, 1" \
	| sed -e "s/\,changed//" -e "s/\,synth//" \
	>        $@.tmp
noncomp_old:
	# run (noncomp0 and) noncomp_prep before
#--------------------------------
flotest:
	grep -E "^A[0-9]" $@.man > $@.gen
#--
floor:
	grep -E "^A[0-9]" $(CONSTANT)/$@.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
floorn:
	grep -E "^A[0-9]" $(CONSTANT)/$@.gen \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
floorn_noeis:
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM noeis);"
	$(DBAT) -x -444444 seq4 > floorn.gen
#--
floorD:
	grep -E "^A[0-9]" $(CONSTANT)/$@.gen \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
floorK:
	perl $(CK)/ck_guides.pl -a K \
	| tee    $@.gen
	# head -n4 $@.gen
	wc -l    $@.gen
#--------
floold0: floold1 floold2 floold3 floold4 floold5
floold1:
	grep -E "\[|floor|ceil|round|fract" $(COMMON)/joeis_names.txt \
	| grep "null" \
	>        floold0.tmp
	perl -ne 'if (s{Nearest +integer +to +}{\~\~} > 0) { s{(\d)\.(\d)}{$$1\#$$2}g; '\
	' s{\~\~([^\.\;\:\,]+)(.*)}{round\($$1\)$$2}; s{\#}{\.}g; print; }' $(COMMON)/joeis_names.txt \
	| grep "null" \
	>>       floold0.tmp
	cat      floold0.tmp \
	| grep -viE "prime|sum|product|binomial|triangle|base|cofr|continued fraction|a?round(ed|ing|)|frac(\,|tal|tion |tions)|\!|\.\.\." \
	>        $@.tmp
	wc   -l  $@*.*
floold2:
	perl floor_split.pl   -d $(D) floold1.tmp \
	2>       $@.rest \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@*.*
	head -n4 $@.rest
	wc   -l  $@.rest
floold3:
	$(JPREP) -f floold2.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	grep "#" $@.tmp \
	>        $@.rest || :
	head -n4 $@.rest
	wc   -l  $@.rest
floold4:
	perl cr_infix.pl      -d    1 floold3.tmp 2>&1 \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	grep "#" $@.tmp \
	>        $@.rest || :
	head -n4 $@.rest
	wc   -l  $@.rest
floold5:
	perl floor_combine.pl -d $(D) floold4.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
floold: floold5
	grep A floold5.tmp \
	| grep -vE "A038126|A134903|A134909" \
	>        $@.gen
	# cp floold5.tmp $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
floceil:
	cat -v floceil.man \
	| grep -E "A|X197322|X197602|X197712|X219085|X197773|X197910|X197716|X197975" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
flosqrt:
	cat $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{\A(A\d+)\t\w+\tFloor\-Sqrt transform [^A]*(A\d{6})}) { '\
	' print join("\t", $$1, "flosqrt", 0, $$2, "") ."\n"; } '\
	| grep -v "A192662" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# %C A000726 Case k=4, i=3 of Gordon Theorem.
# %C A035937 Case k=3, i=1 of Gordon Theorem.
gordon: # Gordon Theorem
	cat $(COMMON)/cat25.txt \
	| perl -ne 'use strict; my $$line = $$_; if ($$line =~ m{\A\%C (A\d+) Case\D+(\d+)\D+(\d+) of Gordon Theorem}i) { '\
	'  my ($$aseqno, $$p1, $$p2) = ($$1, $$2, $$3); '\
	'  print join("\t", $$aseqno, "gordon", 0, "$$p1", $$p2) . "\n"; '\
	'} '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# HolonomicRecurrence
#----
DIST=0
OFF=0
GFTYPE=0
fholo:
	grep -E "^$(A)" $(COMMON)/asdata.txt
	grep $(A) holink.gen | tee x.tmp
	$(HOLT) -n $(NT) -f x.tmp
runholo:
	$(JAVA) irvine.test.HolonomicRecurrenceTest -n $(NT) -p "$(MATRIX)" -i "$(INIT)" -o $(OFF) -d $(D) -dist $(DIST) -t $(GFTYPE) $(GF)
parmholo:
	perl -e 'print join("\t", $(A), "holos", $(OFF), "$(MATRIX)", "$(INIT)", 0) . "\n";' >> $@.tmp
runmorf:
	$(JAVA) irvine.oeis.MorphismFixedPointSequence -i $(INIT) -a $(ANCHOR) -m "$(MAP)" -n $(NT) -d $(D)
runce:
	$(JAVA) irvine.oeis.ComplementaryEquationSequence -n $(NT) -p "$(MATRIX)" -i "$(INIT)" -o $(OFFSET) -d $(D) -dist $(DIST) -t $(GFTYPE)
holt: # parameter GEN=
	$(HOLT) -d $(D) -n $(NT) -f $(GEN)
#----------------
runbva:
	$(BVA) -recur "$(EXPR)"
#----------------
DISEMPOW=1
runpf:
	$(RAMATH).symbolic.PolyFraction -n $(NT) -r $(DISEMPOW) -parse "$(GF)"
#----------------
hamming:
	grep -E "^A[09]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
hiteval:
	cp -v $(HOLREC)/hiteval.gen $@.gen
#----------------
holco:
	grep -E "CoefficientList\[Series" $(COMMON)/cat25.txt \
	| grep -viE "Sum|Product|Bessel|Elliptic|Hyper|theta|catalan|Drop|Pochhammer|Lambert|Continued" \
	| cut -b4- \
	| uniq -w7 \
	| sed "s/ /\t$@\t0\t/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
hologfm: # ogf -> hol with FPS, Maple 2022
	grep -E "^A[0-9]" $(HOLREC)/hologf4.tmp \
	| grep -vE "A115399|A274254" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
hologf4: # ogf -> hol with FPS, Maple 2022
	grep -E "^A[0-9]" $(HOLREC)/hologf4.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# | grep -vE "A068246|A112951|A129155|A132058|A132059|A248426|A274254|A325918|A325920|Catalan" \
	#
#----------------
# A054122
# +(-8*n+4*n^2)*a(n-2) + (-4+12n-8n^2)*a(n-1) + (0-1*n+1n^2)*a(n)  = 0.
# make runholo MATRIX="[[0],[0,-8,4],[-4,12,-8],[0,-1,1]]" INIT="[1,3]"
# n*a(n) +3*(-3*n+2)*a(n-1) +12*(n-2)*a(n-2) +4*(-n+3)*a(n-3)=0. - R. J. Mathar, Jun 13 2013
#  (12-4n)*a(n-3) + (-24 + 12n)*a(n-2) + (6-9*n)*a(n-1) + (0+1n)*a(n) = 0
# make runholo MATRIX="[[0],[12,-4],[-24,12],[6,9],[0,1]]" INIT="[1,3,18]"
#----
holregen:
	cat $(HOLREC)/holregen.tmp \
	| grep -E "Linear|Holo" \
	| grep -v A145418 \
	>   $(HOLREC)/rectab4.tmp
holgf:
	cat $(HOLREC)/holgf2.tmp \
	| sed -e "s/\tholgf1\t/\tholos\t/" \
	>        $(HOLREC)/rectab4.tmp
	head -n4 $(HOLREC)/rectab4.tmp
	wc -l    $(HOLREC)/rectab4.tmp
holsq:
	cat $(HOLREC)/gfsqrt4.tmp \
	| sed -e "s/\tholos\t/\tholos\t/" \
	>        $(HOLREC)/rectab4.tmp
	head -n4 $(HOLREC)/rectab4.tmp
	wc -l    $(HOLREC)/rectab4.tmp
homgf:
	cat $(HOLREC)/homgf7.tmp \
	>        $(HOLREC)/rectab4.tmp
	head -n4 $(HOLREC)/rectab4.tmp
	wc -l    $(HOLREC)/rectab4.tmp
	# | perl -ne 'print if ! m{\te(gf)?\t};'
#----
homegf3:
	cat $(HOLREC)/homegf2.tmp \
	| perl -ne 'use strict; my $$line = $$_; my @parms = split(/\t/, $$line); '\
	' if (length($$parms[3]) > 6 && length($$parms[3]) < 4000 && ($$parms[3] !~ m{[\{\=_b-jl-z]})) { print $$line; } ' \
	| sort | uniq -w7 \
	>        $@.1.tmp
	head -n4 $@.1.tmp
	wc   -l  $@.1.tmp
	make seq4 LIST=$@.1.tmp
	# parm1=6*a(k)-a(k+1)   parm2=e       parm3=1/(1-6*x)
	# parm1=6*a(k)-a(k+1)   parm2=init    parm3=0   parm4=egf  parm5=1/(1-6*x)
	$(DBAT) "UPDATE seq4 s SET callcode='bva', parm5=parm3, parm3=0, parm4='egf'\
	, parm2=(SELECT SUBSTR(data,1,64) FROM asdata d WHERE s.aseqno = d.aseqno); "
	$(DBAT) -x -444444 seq4 \
	| perl -ne 'use strict; my $$line = $$_; my @parms = split(/\t/, $$line); '\
	' $$parms[4] =~ s{\,\-?\d*\Z}{}; print join("\t", @parms); ' \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
homegf4:
	cat homegf3.tmp \
	| $(JPREP) -f - \
	| perl -ne 'use strict; my @parms = split(/\t/); '\
	' $$parms[1] = "holos" . substr($$parms[6], 0, 1); print join("\t", @parms);' \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
homegf:
	cp -v homegf4.tmp $@.gen
	wc -l    $@.gen
#----
holfsig:
	cp -v $(HOLREC)/$@.gen $@.gen
holdfin:
	cp -v $(HOLREC)/$@.gen $@.gen
holgrep:
	cp -v $(HOLREC)/$@.gen $@.gen
holcomb: # combination of several holrec targets
	cat \
	$(HOLREC)/holfsig.gen \
	$(HOLREC)/holdfin.gen \
	$(HOLREC)/holgrep.gen \
	| sort | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
holman: # holonomic subsets generated by special Perl programs
	rm -f $@.gen
	perl $(HOLREC)/gen_mul_fact.pl | tee -a $@.gen
	# needs pfract conversion:
	# perl $(HOLREC)/gen_71951.pl    | tee -a $@.gen
#----
holos:
	# sed -e "s/\tholo[^\t]*\t/\tholos\t/" $(HOLREC)/recuf7.tmp \
	grep -E "holos" $(HOLREC)/rectab4.tmp \
	| sort | uniq -w 7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
LOG=holos
holosrem: hrem1 hrem2 hrem3 hrem4
hrem1:
	scp holos.gen $(REMOTE)
	ssh gfis@atair 'cd ~/work/gits/joeis-lite/internal/fischer ; make CC=holos purge gener dist test'
hrem2:
	scp $(REMOTE)/holos.????.log .
hrem3:
	cp holos.fail.log $(LOG).fail.log
	cp holos.pass.log $(LOG).pass.log
hrem4:
	cd $(COMMON) ; make -f checks.make joeis_check LOG=$(LOG)
hrem5:
	cp $(LOG).fail.log holos.fail.log
	cp $(LOG).pass.log holos.pass.log
hrem6:
	$(DBAT) "SELECT aseqno, SUBSTR(parm1, 1, 8), SUBSTR(parm2, 1, 8), parm4 FROM seq4 ORDER BY 1"
holpatch:
	make CC=holos NOT= select2
	$(DBAT) "UPDATE seq4
#---------------------
holfinit0: holfinit1 holfinit2
holfinit1:
	grep -E "[PDC]\-finite " $(COMMON)/cat25.txt \
	| cut -b4- \
	| grep -vEi "Conject|Empiric" \
	| grep -E "^A...... D\-finite with" \
	| sed -e "s/ /\t/" \
	| uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holfinit2:
	make seq2 LIST=holfinit1.tmp
	$(DBAT) -x "SELECT aseqno, info FROM seq2 WHERE aseqno NOT IN (SELECT aseqno FROM joeis) ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#---------------------
# new linrecs from OEIS-mat/lrindex - run make lrlink there
holink0: holink1 holink2 holink3 holink4
holink1:
	make seq2 LIST=holink.nadd.man
holink2:
	$(DBAT) -x "SELECT l.aseqno, 'holos', 0, l.sigorder \
	    , COALESCE((SELECT info FROM seq2 s WHERE l.aseqno = s.aseqno), -77) \
	    , l.signature, substr(d.data, 1, 256) \
	  FROM lrlink l, asdata d\
	  WHERE l.aseqno = d.aseqno \
	    AND l.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  ORDER BY 1" \
	| grep -v "88888888" \
	| sed -e "s/ //g" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holink3:
	sort     holink2.tmp | uniq -w7 \
	| head -n99999 \
	>        $@.tmp
holink4:
	perl holink.pl -d 1 -a 8 holink3.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@*.tmp
holink:
	grep -E "^A[0-9]" holink4.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# HolonomicSequence
holof: holof0 holof1
holof0:
	cat $(HOLREC)/recuf7.tmp \
	| grep holo \
	| grep -vE "A194566" \
	| sort | uniq -w 7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
holof1:
	grep -vE "A110041|A153180|A156924|A162010" holof.gen \
	>        holof.tmp
	make GEN=holof.tmp holt > $@.tmp
	head -n8 $@.tmp
	wc -l    $@.tmp
#----
holom:
	grep -E "^A[0-9]" $(HOLREC)/holom.man > holom.gen
holoman:
	cp -v $(HOLREC)/holom.gen $@.gen
	wc -l $@.gen
aphrec: # Recurrences from Maple programs of A.P.H.
	grep -E "^A" $(HOLREC)/aphrec3.tmp > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
recman: # Recurrences from Mathematica RecurrenceTable
	grep -E "^A" $(HOLREC)/recman3.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
holor: holor1 holor2
holor1:
	grep -vE "A110041|A153180|A156924|A162010" holof.gen \
	| sed -e "s/holos/holor/" \
	>        holor.tmp
	make GEN=holor.tmp holt > $@.tmp
	head -n8 $@.tmp
	wc -l    $@.tmp
holor2:
	sort -r holof1.tmp holor1.tmp \
	| grep -E "^A" \
	| grep -vE "xholo.1" > $@.tmp
	head -n8 $@.tmp
	grep -E "\-\-\-\-"     $@.tmp | wc -l
	grep holor1 $@.tmp | grep -v null | wc -l
#----
holog_test:
	$(HOLT) -d $(D) -n $(NT) -f $(LINREC)/raeval_holog.tmp
holog0:
	cat $(LIST) \
	>        $@.1.tmp
	head -n8 $@.1.tmp
	wc -l    $@.1.tmp
	$(HOLT) -d $(D) -n $(NT) -f $@.1.tmp \
	>        $@.2.tmp
	head -n8 $@.2.tmp
	wc -l    $@.2.tmp
holog1:
	make holog0 LIST=$(LINREC)/raeval_holog.tmp
holog2:
	$(DBAT) -x "SELECT a.aseqno, i.sigorder, i.signature, d.data \
		FROM  lrindx i, asinfo a, bfdata d \
		WHERE 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		  AND 'A' || i.seqno = a.aseqno \
		  AND 'A' || i.seqno = d.aseqno \
		  AND i.compsig  <> '88888888'  \
		  AND a.keyword      NOT LIKE '%dead%' \
		ORDER BY 1 " \
	| grep -vE "A289265|A101312" \
	| perl -ne 'use strict; s{\s+\Z}{}; my ($$aseqno, $$sigorder, $$signature, $$data) = split(/\t/); '\
	' my @signatures = split(/\, */, $$signature); my @initerms = split(/\, */, $$data); pop(@initerms); '\
	' splice(@initerms, $$sigorder + 8, scalar(@initerms)); '\
	' if ($$sigorder + 2 > scalar(@initerms)) { '\
	'     print "# $$aseqno - too few: sigorder=$$sigorder, initerms=" . scalar(@initerms) . "\n"; '\
	' } else { '\
	'     print join("\t", $$aseqno, "holog", 0, "[". join(",", reverse(@signatures)) . "]", '\
	'           "[" . join(",", @initerms) . "]", 0, $$sigorder) ."\n"; '\
	' }'\
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	make holog0 LIST=$@.tmp
holog:
	sed -e "s/holog1/holos/" \
	-e "s/  //" holog0.2.tmp \
	>        $@.gen
#----
holol0: holol1 holol2 holol3
# get all from lrlink which are not in joeis
holol1:
	$(DBAT) -x "SELECT l.aseqno, 'holog', i.offset1, l.signature, d.data, '0' \
	    FROM lrlink l, asinfo i, asdata d \
	    WHERE l.aseqno = i.aseqno \
	      AND l.aseqno = d.aseqno \
	      AND l.aseqno NOT IN (select aseqno FROM joeis) \
	      AND l.sigorder < 64 AND l.sigorder >= 1 \
	      AND l.signature <> '88888888' \
	      ORDER BY 1" \
	| perl $(LINREC)/reverse_signature.pl -h -i 3 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holol2:
	head -n$(MANY) holol1.tmp \
	>                             $@.1.tmp
	$(HOLT) -d $(D) -n $(NT) -f $@.1.tmp \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holol3:
	grep -vE "\?\?" holol2.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holol:
	sed -e "s/holog1/holos/" holol3.tmp \
	>        $@.gen
holold:
	sed -e "s/holog1/holos/" -e "s/  //" holol3.tmp \
	>        $@.gen
#----------------
sqrtext:
	grep -E "^A[0-9]" $(HOLREC)/$@2.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
holsq2:
	cat $(HOLREC)/holsq2.gen \
	| sed -e "s/\tholos\t/\tholos\t/" \
	| tee    holos.gen
	wc -l    holos.gen
holsq3:
	#               1        2                 34                      5                            6                          7
	perl -ne \
	'if (m{\A\%\w\s+(A\d+)\s+(Expansion of\s*)?(([EO]\.)?G\.f\.\:?\s*)?(\d+)\/\s*sqrt\(1\s*[\+\-]\s*(\d*)\s*\*?\s*x\s*[\+\-]\s*(\d*)\s*\*?\s*x\^2\)\s*\.}i) { \
	my $$b = $$6 / 2; my $$d = $$7; my $$bm2 = - $$b*$$b; my $$dm = - $$d; \
	print join("\t", $$1, "holos", 0, "[[0]],\[$$dm,$$d],\[$$b,$$bm2],[0,1]]", "[1,$$b]", 0) . "\n" }' \
	$(COMMON)/cat25.txt      > $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----------------
homapgf:
	grep -E "^%p" $(COMMON)/cat25.txt | grep -iE "gf *:=" \
	| cut -b 4- | sed -e "s/ /\t/" | sort | uniq -w7 > x.tmp
	make seq2 LIST=x.tmp
	$(DBAT) "SELECT * FROM seq2 WHERE aseqno NOT IN (SELECT aseqno FROM joeis) \
	  ORDER BY aseqno " \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
hermite:
	grep -E "Numerator of Hermite" $(COMMON)/joeis_names.txt \
	| perl gen_hermite.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
hermite_conj:
	cut -b1-7 hermite.gen \
	| xargs -l -innn grep -EiH "Conject" $(COMMON)/ajson/nnn.json \
	| perl -ne 's{^[^A]+(A\d+)\.json\:\s*}{$$1 }; print; ' \
	| tee    $@.tmp
	wc -l    $@.tmp
#--------
# A157799 null    Numerator of Bernoulli(n, 1/3).
# A157800 null    Denominator of Bernoulli(n, 1/3).
bernoulli:
	grep -E "(Numer|Denomin)ator of Bernoulli\(" $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{\A(A\d+)\s+\w+\s+((Numer|Denomin)ator of [Bb]ernoulli\(n\,\s*(\-?\d+)\s*(\/\s*(\d+)\))?)}) { '\
	' my @parms = ($$1, "bernoulli", 0, lc(substr($$2, 0, 3)), $$4, $$6 || 1, $$2, "dummy"); '\
	' print join("\t", @parms) . "\n"; } '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
eulerp:
	grep -E "(Numer|Denomin)ator of Euler\(" $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{\A(A\d+)\s+\w+\s+((Numer|Denomin)ator of [Ee]uler\(n\,\s*(\-?\d+)\s*(\/\s*(\d+)\))?)}) { '\
	' my @parms = ($$1, "eulerp", 0, lc(substr($$2, 0, 3)), $$4, $$6 || 1, $$2, "dummy"); '\
	' print join("\t", @parms) . "\n"; } '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
laguerre:
	grep -E "(Numer|Denomin)ator of Laguerre\(" $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{\A(A\d+)\s+\w+\s+((Numer|Denomin)ator of [Ll]aguerre\(n\,\s*(\-?\d+))}) { '\
	' my @parms = ($$1, "parm3", 0, "A160621", (substr($$2, 0, 3) eq "Num") ? "true" : "false", $$4, $$2, "dummy"); '\
	' print join("\t", @parms) . "\n"; } '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
# Holonomic reflection
holrefa: holref1 holref2 holref3 holref4
holref0: # grep the parameters of HolonomicRecurrence from jOEIS sources
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE superclass LIKE 'Holonomic%'" \
	| perl -ne 's/\s+\Z//; print "../../../joeis/src/irvine/oeis/" . lc(substr($$_, 0, 4)) . "/$$_.java\n";' \
	| xargs -l -innn grep -EH "super\(" nnn \
	| sed -e 's/^.*A/A/'  -e 's/\.java:[ \t]*super./\tholos\t/' \
	      -e 's/, \"/\t/' -e 's/\", \"/\t/' -e 's/\", /\t/' -e 's/.\;//' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	# sed -e "s/\t/\tholos\t/" holrefl1.tmp > $@.tmp
holref1: # select sequences which are holonomic
	$(DBAT) -x "SELECT j.aseqno, LOWER(SUBSTR(j.superclass, 1, 5)), i.offset1, i.terms \
	  FROM joeis j, asinfo i \
	  WHERE j.aseqno = i.aseqno \
	    AND superclass IN ('UndefinedClass' \
	      , 'BlockMultAddSequence' \
	      , 'ContinuedFractionOfSqrtSequence' \
	      , 'CoordinationSequence' \
	      , 'CoxeterSequence'\
	      , 'FiniteSequence'\
	      , 'GeneratingFunctionSequence' \
	      , 'HolonomicRecurrence' \
	      , 'LatticeCoordinationSequence' \
	      , 'LinearRecurrence' \
	      , 'PaddingSequence' \
	      , 'PeriodicSequence' \
	      , 'PolynomialRootSequence' \
	      , 'PrependSequence' \
	      , 'WeylGroupSequence' \
	      )" \
	>        $@.tmp
	head -n4 $@.tmp
	cut -f2  $@.tmp | sort | uniq -c
	wc -l    $@.tmp
holref2: # extract parameters by reflection
	# perl keep_first.pl -n 4444444 holref1.tmp
	cat holref1.tmp \
	| $(JAVA) irvine.oeis.RecurrenceReflector - \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp
holref2a: # extract parameters by reflection
	cat holref1.tmp \
	| grep -E "A32435" \
	| $(JAVA) irvine.oeis.RecurrenceReflector - \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp
holref3: # postprocess the rest
	grep -vE "conti|record length" holref2.rest.tmp \
	>        $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@.tmp
holref4: # generate a *.gen file
	# unify the callcode
	perl keep_first.pl -n 4444444 holref2.tmp \
	| perl -ne 'use strict; s/\s+\Z//; my ($$aseqno, $$callcode, @parms) = split(/\t/); $$parms[5] = $$callcode; '\
	' $$callcode = "holos" . ($$parms[4] == 1 ? "e" : ""); '\
	' print join("\t", $$aseqno, $$callcode, @parms, "x", "y") . "\n"; '\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holshift:
	cut -f6  holref4.tmp | sort | uniq -c
#----
holshorten:
	grep -P "\tholos\t" holref.txt \
	| sed -e "s/\tholos\t/\tholog\t/" \
	| $(HOLT) -d $(D) -f - 2>&1 \
	| sed -e "s/\tholog\t/\tholos\t/" \
	>        $@.tmp
	grep " shortened by " $@.tmp | tee $@.1.tmp
	head -n4 $@.tmp
	wc -l    $@*.tmp
holshort:
	grep -vE " shortened by " holshorten.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
holref:
	cat holref4.tmp \
	| grep -vE "xprepe" \
	>        $@.gen
	wc -l    $@.gen
	cut -f1-8 holref4.tmp \
	>        holref.txt
	head -n4 holref.txt
	wc -l    holref.txt
holrefscp:
	scp holref.txt gfis@teherba.org:/var/www/html/teherba.org/OEIS-mat
holref_populate:
	$(DBAT) -f sql/holref.create.sql
	$(DBAT) -r holref < holref.txt
	$(DBAT) -n holref
	$(DBAT) -4 holref
#----
holrefhy: # sort hypergeom parameters
	perl hypergeom_eval.pl holrefl1.tmp \
	| sort -k2n -k3n \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--
holrefc: # which sequences are constant and in jOEIS not by recurrence
	$(DBAT) -x "SELECT 'A' || l.seqno, COALESCE(j.superclass, 'null'), n.name \
	    FROM asname n, lrindx l LEFT JOIN joeis j ON 'A' || l.seqno = j.aseqno \
	    WHERE l.signature = '1' \
	      AND 'A' || l.seqno = n.aseqno \
	    ORDER BY 1"
holref_check:
	cat holref.gen \
	| perl -ne 'm{(conti\w+)}; my $$contin = $$1; m{sqrt\((\d+)\)}; $$n = $$1; m{\A(\w+)}; my $$aseqno = $$1;'\
	' print join("\t", $$n) . "\n"; '\
	| sort -n -k1 | uniq -c \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	grep -v " 3 " $@.tmp
#----
holref_deris:
	$(DBAT) -x "SELECT j.aseqno, h.aseqno, h.keyword, n.name \
	  FROM joeis j, holref h, asname n \
	  WHERE j.aseqno     = n.aseqno \
	    AND j.superclass = h.aseqno \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp

#---- $@.tmp
holrefix: holrefix1 holrefix2 # which are in lrindx joined with their implementation in joeis
holrefix1:
	$(DBAT) -x "SELECT i.aseqno, COALESCE(j.superclass, 'nyi'), i.offset1, l.signature, n.name, d.data \
	  FROM asinfo i, lrindx l, asname n, asdata d LEFT JOIN joeis j ON j.aseqno = d.aseqno \
	  WHERE i.aseqno = n.aseqno \
	    AND n.aseqno = d.aseqno \
	    AND i.aseqno = 'A' || l.seqno \
	    AND i.keyword NOT LIKE '%dead%' \
	    AND LENGTH(l.signature) > 0 \
	    AND COALESCE(j.superclass, 'undef') NOT IN ('UndefinedClass' \
	      , 'BlockMultAddSequence' \
	      , 'ContinuedFractionOfSqrtSequence' \
	      , 'CoordinationSequence' \
	      , 'CoxeterSequence'\
	      , 'FiniteSequence'\
	      , 'GeneratingFunctionSequence' \
	      , 'HolonomicRecurrence' \
	      , 'LatticeCoordinationSequence' \
	      , 'LinearRecurrence' \
	      , 'PaddingSequence' \
	      , 'PeriodicSequence' \
	      , 'PrependSequence' \
	      ) ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holrefix2:
	grep -P "\tnyi\t"  holrefix1.tmp \
	|perl -ne 's{\t(\w+)\t}{\tholos\t}; print; ' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
holrefsup: holrefsu1 holrefsu2
holrefsu1:
	$(DBAT) -x "SELECT LOWER(SUBSTR(j.aseqno, 1, 4)) || '/' || j.aseqno || '.java' \
	  FROM joeis j\
	  WHERE superclass IN ('UndefinedClass' \
	      , 'PrependSequence' \
	      )" \
	| sed -e "s/\r//g" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
holrefsu2:
	cat      holrefsu1.tmp \
	| xargs -l -innn grep -EH "super" $(JOEIS)/src/irvine/oeis/nnn \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
holrefpow:
	# make seq2 LIST=holref1.tmp
	$(DBAT) "SELECT j.aseqno, j.superclass, s.info FROM seq2 s, joeis j \
	    WHERE s.aseqno = j.superclass \
	      ORDER BY 1;" \
	| tee    $@.tmp
	wc -l    $@.tmp
#--------
# get all signatures form lrindex recreation
holsig:
	grep -E "^A[0-9]" $(COMMON)/../lrindex/lrindx_nyi_check.txt \
	| perl sig_matrix.pl \
	>        $@.gen \
	2>       $@.holo.run
	head -n4 $@.gen
	wc -l    $@.gen
#----
holsig2: # get signatures from jcat25
	grep "Index entries for linear recurrences with constant coefficients" $(COMMON)/jcat25.txt \
	| perl -ne 'use strict; if (m{\A\%H (A\d+)[^\#]+\#order_([0-4]\d)[^\(]+\(([^\)]+)\)}) {'\
	' my ($$aseqno, $$order, $$signature) = ($$1, $$2, $$3); $$signature =~ s{ }{}g; $$order =~ s{\A0+}{};'\
	' print join("\t", $$aseqno, "holsig", 0, $$signature, $$order, $$order) . "\n"; }' \
	| perl sig_matrix.pl \
	2>       $@.holo.run \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen	
#--------------------------------
hygsolve0:
	grep -E "runholo" $(HOLREC)/hygsolve2.tmp \
	| perl parmholo.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
hygsolve:
	grep -E "^A[0-9]" hygsolve2.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
hygsolve_eval:
	# make batlog LIST=hygsolve.pass.log
	$(DBAT) -x "SELECT l.aseqno, '+' || LPAD(l.idiff, 6, ' ') \
	  , RPAD(COALESCE((SELECT j.superclass FROM joeis j WHERE j.aseqno = l.aseqno), 'nyi'), 24, ' ') || '.'  \
	  , CASE WHEN COALESCE(c.aseqno, '_') = '_' THEN '.....' ELSE 'cojec' END \
	  , s.parm1, s.parm2 \
	  FROM seq4 s, batlog l \
	  LEFT JOIN cojec c ON c.aseqno = l.aseqno \
	  WHERE s.aseqno = l.aseqno \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#	  LEFT JOIN joeis j ON l.aseqno = j.aseqno \
#----
hygeom:
	# grep -E "^A[0-9]" $(HOLREC)/$@.java ???
	grep -E "^A[0-9]" $(HOLREC)/$@.tmp \
	| grep -P "\thyge[omn]+\t" \
	| sed -e "s/\thygen\t/\thygeo\t/" | sed -e "s/\thygeon\t/\thygeom\t/" \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
revert:
	grep -iE "series reversion|series inversion|inverse series|revert transform" joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
iaronson:
	grep -E "^A" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
naronson:
	grep -E "^A" $@.man \
	| grep naronson \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
runaron:
	$(JAVA) irvine.oeis.NumericalAronsonSequence -d $(D) $(BF) -n $(NT) -s $(A) -o $(OFFSET)
testaron: # A= B=
	$(DBAT) -x "(SELECT b.aseqno, i.offset1, b.data FROM bfdata b, asinfo i WHERE b.aseqno = '$(A)' AND b.aseqno = i.aseqno) UNION \
	            (SELECT b.aseqno, i.offset1, b.data FROM bfdata b, asinfo i WHERE b.aseqno = '$(B)' AND b.aseqno = i.aseqno)" \
	| tee    $@.tmp
	perl test_aan.pl $@.tmp
#--------------------------------
inidig:
	grep -E "^A" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
interleave:
	grep -E "^A[0-9]" $@.man \
	| perl -ne 'use strict; my @asns = m{(A\d\d+)}g; if (scalar(@asns) >= 3) { print join("\t", $$asns[0], "$@", 0, $$asns[1], $$asns[2], "". "") . "\n"; } '\
	| sort | uniq -w7 \
	| grep -vE "A083924|A113685|A181363|A256252|A256253" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
inverse:
	perl inverse.pl > $@.gen 2> $@.rest.tmp
	head -n4 $@.gen
	wc -l    $@.*
#--------------------------------
inverti: # InverseInvertTransform
	grep -E "^A[0-9]" $@.man \
	| grep -vE "A089836|A141308|A141314|A182216|A216040|A255906" \
	> $@.gen
	head -n4 $@.gen
	wc -l    $@.*
#--------------------------------
ASMIN=300
ASMAX=400
jall: # parms = ASMIN, ASMAX - test a block of implemented jOEIS sequences
	$(DBAT) -x "SELECT aseqno, '$@', 0, 0 FROM joeis WHERE aseqno >= 'A$(ASMIN)000' AND aseqno <= 'A$(ASMAX)999' ORDER BY 1" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
jallrm:
	make CC=jall EX=EX select ASMIN=$(ASMIN) ASMAX=$(ASMAX)
	scp      jall.gen $(REMOTE)
	ssh gfis@atair 'cd ~/work/gits/joeis-lite/internal/fischer ; make CC=jall purge dist test'
	scp      $(REMOTE)/batch.log .
	make CC=jall.a$(ASMIN)-a$(ASMAX) evaluate
# jall.a030-a034.fail.log:A030657 10000   FAIL    ,0      computed:       ,1
# jall.a030-a034.fail.log:A032350 361     FAIL    ,31213,31313,31413,31513        computed:       ,31113,31213,31313,31413
jallrest:
	grep FAIL jall.*.log | grep -v timeout \
	| perl -ne 'm{\:(A\d+)[^\,]+(\S*)}; print join("\t", $$1, "jallrest1", 0,0,0,$$2) . "\n";' \
	>        jallrest1.gen
	head -n4 jallrest1.gen
	wc -l    jallrest1.gen
	make  CC=jallrest1 select EX=EX TO=32 test log
jallrest1:
	head -n1 jallrest1.gen
#--------------------------------
# A102709 Join[{1,3125,1075,985},LinearRecurrence[{-1,-2,-2,-2,-1,0,1,2,2,2,1,1},{580,1281,295,1305,580,925,631,1305,220,1305,655,901},45]](*_RayChandler_,Sep082015*)
joinlr:
	perl -ne \
	's/ //g; '\
	'if (m{^(A\d{6})\t\tJoin\[\{([^\}]+)\}\,LinearRecurrence\[\{([^\}]+)\}\,\{([^\}]+)\}}) {'\
	' my ($$aseqno, $$joins, $$recur, $$inits) = ($$1, $$2, $$3, $$4); '\
	' my @recur = reverse(split(/\,/, $$recur)); '\
	' my @inits =         split(/\,/, $$inits) ; '\
	' my @joins =         split(/\,/, $$joins) ; '\
	' if (scalar(@inits) > scalar(@recur)) { '\
	'   @joins = join(@joins, splice(@inits, 0, scalar(@inits) - scalar(@recur))); '\
	' }'\
	' $$joins = "new long[] {" . join("L,", @joins) . "L}"; '\
	' if (scalar(@joins) == 0) { $$joins = "EMPTY"; } '\
	' $$inits = "new long[] {" . join("L,", @inits) . "L}";'\
	' $$recur = "new long[] {" . join("L,", @recur) . "L}";'\
	' print join("\t", $$aseqno, "$@"    , 0, 0, 0, $$recur, $$inits, $$joins) . "\n";'\
	'}' \
	mma_joeis.txt \
	| grep -vE "A064584|A18718|A286069|A288917" \
	>        $@.gen
	wc -l    $@.gen
	#--
	perl -ne \
	's/ //g; '\
	'if (m{^(A\d{6})\t\tLinearRecurrence\[\{([^\}]+)\}\,\{([^\}]+)\}}) {'\
	' my ($$aseqno, $$recur, $$inits) = ($$1, $$2, $$3); '\
	' my @recur = reverse(split(/\,/, $$recur)); '\
	' my @inits =         split(/\,/, $$inits) ; '\
	' my @joins = (); '\
	' if (scalar(@inits) > scalar(@recur)) { '\
	'   @joins = splice(@inits, 0, scalar(@inits) - scalar(@recur)); '\
	' }'\
	' $$joins = "new long[] {" . join("L,", @joins) . "L}"; '\
	' if (scalar(@joins) == 0) { $$joins = "new long[] {}"; } '\
	' $$inits = "new long[] {" . join("L,", @inits) . "L}";'\
	' $$recur = "new long[] {" . join("L,", @recur) . "L}";'\
	' print join("\t", $$aseqno, "$@"    , 0, 0, 0, $$recur, $$inits, $$joins) . "\n";'\
	'}' \
	mma_joeis.txt \
	| grep -vE "A064584|A18718|A286069|A288917" \
	>>       $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
idigits:
	sed -e "s/^xxxx *//" $@.pl \
	| perl $@.pl -d 0 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#---------
inbase2:
	grep -E "A[0-9]* in (binary|base 2)" $(COMMON)/joeis_names.txt \
	| perl -ne 'm{(A\d+) in (binary|base 2)}; my $$aseqno = $$1; '\
	' print join("\t", substr($$_, 0, 7), "inbase2", 0, $$1, substr($$_, 8)); '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A059376 null    Jordan function J_3(n). nonn,mult,easy,changed, 1..1000 nyi
jordan: # J_k(n)
	grep -E "Jordan " $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{null\tJordan function J_(\d+)}) { my $$num = $$1; s/\tnyi[^\t]*\t.*/\tparm2\t1\tA059376\t$$num/; print; } '\
	>        $@.gen
	head -n44 $@.gen
	wc -l    $@.gen
#----
jk_j1: # J_k(n)/J_1(n) for k=3..17
	grep -vE "^#" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
jux:
	make jux_nodep TARGET=gener
	cat $@?*.gen > $@.gen
	make dist
	make test CC=$@
	make pack CC=$@
jux_sel:
	rm -f jux*.gen
	make jux_nodep TARGET=select
	# cat jux*.gen > juxnodep.gen
	# make jux_isdep TARGET=select
jux_nodep: # parameter: TARGET
	make $(TARGET) CC=jux2n_1
	make $(TARGET) CC=juxdig12b
	make $(TARGET) CC=juxdigost
	# make $(TARGET) CC=juxdiv  # later, all involve huge numbers
	make $(TARGET) CC=juxfib
	make $(TARGET) CC=juxn
	make $(TARGET) CC=juxncomp
	make $(TARGET) CC=juxnrev
jux_isdep: # parameter: TARGET
	make $(TARGET) CC=juxdiff
	make $(TARGET) CC=juxleast
	make $(TARGET) CC=juxpos
	make $(TARGET) CC=juxrun
	wc -l jux*.gen
juxgrep:
	grep -Ei "(Champernowne|juxtapose)" $(COMMON)/names > $@.tmp
	head -4 $@.tmp
	wc -l   $@.tmp
#--------
# A031057 Write 2n-1 in base 8 and juxtapose.	nonn,base,synth
jux2n_1:
	perl -ne \
	'if (m{^(A\d+)\s+Write (the odd numbers )?(2n\-1) in base (\d+) and juxtapose})'\
	'{ print join("\t", $$1, "$@", 0, $$4) . "\n" }' \
	$(COMMON)/names                  > $@.gen
	echo "A031312	jux2n_1	0	10" >> $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
juxconv:
	grep -E "^A" $@.man \
	>       $@.gen
	head -4 $@.gen
	wc -l   $@.gen
#----
# A030413 Write (n+1)st Fibonacci number in base 4 and juxtapose. nonn,synth
# A030604 Write the Fibonacci numbers in base 6 and juxtapose.    nonn,easy,base,synth
# A031027 Write the (n+1)st Fibonacci number in base 7 and juxtapose.     nonn,base,synth#
juxfib:
	perl -ne \
	'if (m{^(A\d+)\s+Write (the )?(\(n\s*\+\s*1\)st )?Fibonacci numbers? in base (\d+) (for \S+ )?and juxtapose})'\
	'{ print join("\t", $$1, "$@", 0, $$4) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "^A030604" \
	>                  $@.gen
	echo "A030324	juxfib	0	2"  >> $@.gen
	# echo "A031324	juxfib	0	10" >> $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030349 (# 1's)-(# 0's) in first n terms of A030341.	nonn,synth
juxdiff:
	perl -ne \
	'if (m{^(A\d+)\s+\(\#\s*(\d+)[^\#]+\#\s*(\d+)\S+ in first n terms of (A\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$2, $$3, $$4, substr(lc($$4), 0, 4)) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "^A0306(18|21)" \
	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A043099 Numbers n such that 1 and 2 occur juxtaposed in the base 3 representation of n but not of n-1.	nonn,base,synth	1..50
# A043100 0 and 1 occur juxtaposed in the base 4 representation of n but not of n-1.	nonn,base,synth	1..48
juxdig12b:
	perl -ne \
	'if (m{^(A\d+)\s+(Numbers [nk] such that )?(\d+) and (\d+) occur juxtaposed in the base (\d+) representation of [nk] but not of [nk]([\-\+]1)\.})'\
	'{ print join("\t", $$1, "$@", 1, $$3, $$4, $$5, $$6) . "\n" }' \
	$(COMMON)/names \
	| sed -e "s/\t\-1/\tsubtract/" -e "s/\t+1/\tadd/ " \
	> $@.gen
	wc -l $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A044074 Numbers n such that string 3,1 occurs in the base 4 representation of n but not of n-1.	nonn,base,synth	1..47
# A044075 Numbers k such that the string 3,2 occurs in the base-4 representation of k but not of k-1.	nonn,base,easy,changed,	1..10000
juxdigost:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [nk] such that (the )?string (\d+),(\d+) occurs in (the )?base.(\d+) representation of [nk] but not of [nk]([\-\+]1)\.})'\
	'{ print join("\t", $$1, "$@", 1, $$3, $$4, $$6, $$7) . "\n" }' \
	$(COMMON)/names \
	| sed -e "s/\t\-1/\tsubtract/" -e "s/\t+1/\tadd/ " \
	> $@.gen
	# A044140 Numbers k such that substring "02" occurs in the base-7 representation of k but not of k-1.	nonn,base,changed,synth	1..42
	# A044416 Numbers n such that string '84' occurs in the base 10 representation of n but not of n-1.	nonn,base,synth	1..39
	echo "A044140	juxdigost	0	0	2	7	subtract" >> $@.gen
	echo "A044416	juxdigost	0	8	4	10	subtract" >> $@.gen
	wc -l $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A029494 Numbers n such that n divides the (left) concatenation of all numbers <= n written in base 25 (most significant digit on left).	nonn,base,synth
# A029495 Numbers n such that n divides the (right) concatenation of all numbers <= n written in base 2 (most significant digit on right).	nonn,base,bref,synth
# A061931 Numbers n such that n divides the (right) concatenation of all numbers <= n written in base 2 (most significant digit on right).	nonn,base,more,synth
juxdiv:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers \w such that \w divides the \((left|right)\) concatenation of all numbers \<\= \w written in base (\d+) \(most significant digit on (left|right)\)})'\
	'{ print join("\t", $$1, "$@" . substr($$2, 0, 1) . substr($$4, 0, 1), 0, $$3) . "\n" }' \
	$(COMMON)/names \
	| perl -pe 'if (m{A06}) { s{juxdiv}{juxdjv} }' \
	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030304 Least k such that base 2 representation of n begins at s(k), where s=A030190 (or equally A030302).	nonn,base,synth
juxleast:
	perl -ne \
	'if (m{^(A\d+)\s+(a\(n\)=)?[Ll]east k such that (the )?base (\d+) representation of n begins at s\(k\)\, where s=(A\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$4, $$5, substr(lc($$5), 0, 4)) . "\n" }' \
	$(COMMON)/names \
	| grep -v "^A030611" \
	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030998 Write n in base 7 and juxtapose.	nonn,base,cons,easy,tabf,synth
juxn:
	perl -ne \
	'if (m{^(A\d+)\s+(The almost\-natural numbers\: )?[Ww]rite n in base (\d+) and juxtapose})'\
	'{ print join("\t", $$1, "$@", 0, $$3) . "\n" }' \
	$(COMMON)/names                  > $@.gen
	echo "A030190	juxn	0	2"  >> $@.gen
	cat $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A031016 Write n in base 7, then complement each digit (d -> 6-d) and juxtapose.	nonn,base,synth
juxncomp:
	perl -ne \
	'if (m{^(A\d+)\s+Write n in base (\d+)\, (then )?complement each digit (\(d\s*\-\>\s*(\d+)\-d\) )?and juxtapose})'\
	'{ print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names | tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030324 Triangle read by rows, where row k consists of the binary digits of Fibonacci(k+1)
juxnrev:
	perl -ne \
	'if (m{^(A\d+)\s+Triangle T\(n\,k\)\: [Ww]rite n in base (\d+)\, reverse order of digits})'\
	'{ print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A262" \
 	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030318 Position of n-th 0 in A030317
juxpos:
	perl -ne \
	'if (m{^(A\d+)\s+Position of n-th (\d+) in (A\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$2, $$3, substr(lc($$3), 0, 4)) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A0209|A0540|A030298|A030496" \
	| grep -vE "A0306(05|06|07|08|09|10)|A0313(25|26|27|28|29|30|31|32|33|34)" \
	> $@.gen
	wc -l $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----
# A030305 Length of n-th run of 0's in A030302.	nonn,synth
# A030336 Length of n-th run of digit 0 in A003137.
juxrun:
	perl -ne \
	'if (m{^(A\d+)\s+Length of n\-th run of (digit )?(\d+)[^A]+(A\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$3, $$4, substr(lc($$4), 0, 4)) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A0306(12|13|14|15|16)" \
	| tee $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#--------------------------------
# A056643 null    Numbers n such that n | 4^n + 3^n + 2^n + 1^n.  nonn,synth      1..43   nyi
kdivpsum:
	grep -E "Numbers [nk] such that [nk] \| " $(COMMON)/joeis_names.txt \
	| perl $@.pl -a A015889 \
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
kpytha:
	perl kpytha.pl -a gen > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
kpytha_tab:
	$(DBAT) -x "SELECT i.aseqno, s.parm1, s.parm2, s.parm3, s.parm4, i.terms \
	  FROM asinfo i, seq4 s WHERE i.aseqno = s.aseqno ORDER BY 1"
kpytha_grep:
	grep -E "\-[Pp]ythagorean triple" $(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	perl -ne 'print if m{\(\-3\/4\)};' $@.tmp
#----
kpytha_compare: kpytha_check kpytha_regen kpytha_diff kpytha_eval
kpytha_check:
	perl kpytha.pl -a check > $@.tmp
kpytha_regen: kpytha_check
	perl kpytha.pl -a regen -m 100 > $@.tmp
kpytha_diff:
	diff -wy --width=64 --expand-tabs kpytha_check.tmp kpytha_regen.tmp \
	| perl -ne 'print if ! m{[\>\<]};' \
	>        $@.tmp || :
	head -n8 $@.tmp
	wc -l    $@.tmp
	grep -E "prim" $@.tmp | wc -l
kpytha_eval:
	perl kpytha_diff.pl kpytha_diff.tmp \
	| tee $@.txt
	grep -E "prim" $@.txt | wc -l
	grep -E "\|"   $@.txt | wc -l
#----
kpytha_bad:
	perl kpytha.pl -a comp -t -b 65536 -m 100 -k 1/5 \
	| grep -E "9   [0-9]" | tee $@.1-5.tmp
#--------------------------------
leastk:
	grep -P "[Ll]east +\w[ \>\=\d]+such that" $(COMMON)/joeis_names.txt \
	| grep -P "\tnyi[^\t]*\t" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
# Linear Recurrences and generating functions
linr_count:
	$(DBAT) "SELECT COUNT(aseqno) FROM joeis j \
		WHERE superclass LIKE 'LinearRecurrence%' \
		   OR superclass LIKE 'GeneratingFunction%' "
linrgf:
	$(DBAT) "SELECT aseqno FROM joeis j \
		WHERE superclass LIKE 'LinearRecurrence%' \
		   OR superclass LIKE 'GeneratingFunction%' \
		ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
linr1:
	$(DBAT) "SELECT 'A' || i.seqno, i.sigorder, i.signature, n.name \
		FROM lrindx i, asname n, asinfo a \
		WHERE 'A' || i.seqno = n.aseqno \
		  AND 'A' || i.seqno = a.aseqno \
		  AND 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		  AND i.compsig <> '88888888' \
		  AND a.keyword NOT LIKE '%dead%' \
		ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
mixed:
	cat \
	juxconv.man \
	pisot.gen \
	subsele.gen \
	| grep -E "^A" \
	| grep -v "^A036507" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# conexdig.man \
	# basrunid.man \
	#
#--------------------------------
mma_single: # single line MMA statement(s)
	grep -E "^%t" $(COMMON)/cat25.txt \
	| perl mma_single.pl \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mma_joeis: #
	make seq2 LIST=mma_single.tmp
	$(DBAT) "SELECT m.aseqno, SUBSTR(j.superclass, 1, 3), m.info FROM seq2 m LEFT JOIN joeis j ON m.aseqno = j.aseqno \
		ORDER BY 3" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#--------------------------------
modi:
	grep -E "^%" $(COMMON)/jcat25.txt \
	| perl -ne 'if (m{\A\%[NFC] +(A\d+)\s+a\(n\) *\= *(A\d+)\([^\)]+\) *mod *([\w\+\-\(\)\*\/\^]+) *[\.\=]}i) {'\
	' print join("\t", $$1, $@, 0, $$2, $$3, $$_); }' \
	| tee    $@.gen
	wc -l    $@.gen
#--------------------------------
TF=Mobius
trafo0: # select all transforms
	# grep -E "^%[NFC]" $(COMMON)/jcat25.txt | grep -Pi " (Binomial|Euler|M..?bius|Invert|Logarithmic|Revert|Weigh|Witt) transform" 
	grep -E "^%[NFC]" $(COMMON)/jcat25.txt | grep -Pi " \w+ transform" \
	>        $@.tmp
	wc -l    $@.tmp
trafo: # TF= select a specific transform
	cut -b4- trafo0.tmp | sed -e "s/ /\t/" \
	| perl trafo.pl -tf "$(TF)" \
	2>       $@.rest.tmp \
	>        $@.gen
	grep -E "^A[0-9]" trafo.man >> $@.gen || :
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
moebius:
	cut -b 4- | sed -e "s/ /\t/" \trafo0.tmp \
	| perl moebius.pl \
	| tee    $@.gen
	wc -l    $@.gen
#--------------------------------
morfix:
	CLASS=MorphismSequence
	perl -ne \
	'my $$line = $$_;'\
	'if ($$line =~ m{^(A\d+)\s+.*([Ff]ixed (point )?(under |of )|Iterate |Substitution |generated by |[Rr]esult of |closed under )'\
	'(the )?(mapping |map |morphism |morphing |\:|)([ 0-9\-\>\,\;\{\}\(\)\[\]]+)} )'\
	'{ my ($$aseqno, $$map) = ($$1, $$7); $$map =~ s{\s}{}g; $$map =~ tr{\[\]\(\)}{\{\}\{\}};'\
	'  $$map =~ s{\}\,}{\}\;}g; $$map =~ s{[\,\;]\Z}{}; if ($$map =~ m{[\}\;]}) { $$map =~ s{[\{\}\,]}{}g; };'\
	'  $$map =~ s{\;}{\,}g; $$map =~ m{\A(\d+)}; my $$start = ""; '\
	'if ($$line =~ m{(start |starting |apply |applied )(with |from |to |at )([a-z]\(\d\)\D*)?(\d+)}i) { $$start = $$4; }'\
	'if ($$line =~ m{\-\>}) { print join("\t", $$aseqno, "$@", 0, $$start, "", $$map) . "\n"; }}' \
	$(COMMON)/names \
	| grep -vE "A106437|A119647|A176416|A30549[56]|A317198|A32092[67]" \
	>         $@.gen
	# mortix:
	perl -ne \
	'my $$line = $$_;'\
	'if ($$line =~ m{^(A\d+)\s+.*([Tt]rajectory of (\d+) |Image of (\d+) |(\d+)\-limiting word |[Ll]imiting (\d+)\-word )'\
	'(under (repeated applications? of )?|of )(the )?'\
	'(mapping|map|morphism)\:? ([ 0-9\-\>\,\;\{\}\(\)\[\]]+)})'\
	'{ my ($$aseqno, $$start, $$map) = ($$1, $$2, $$11); $$map =~ s{\s}{}g; $$map =~ tr{\[\]\(\)}{\{\}\{\}};'\
	'  $$map =~ s{\}\,}{\}\;}g; $$map =~ s{[\,\;]\Z}{}; if ($$map =~ m{[\}\;]}) { $$map =~ s{[\{\}\,]}{}g; };'\
	'  $$map =~ s{\;}{\,}g; $$map =~ m{\A(\d+)}; $$start =~ s{\D}{}g; '\
	'  print join("\t", $$aseqno, "morfix", 0, $$start, $$start, $$map) . "\n"; }' \
	$(COMMON)/names \
	| grep -vE "A007001|A119647|A176416|A229830" \
	| perl -pe 'while (m{\-\>((\d\,){2,})(\d+)\-\>}) { my ($$p1, $$p2, $$p3) = ($$1, $$2, $$3); $$o1 = $$p1;'\
	'   $$p1 =~ s{\,}{}g; s{\-\>$$o1$$p3\-\>}{\-\>$$p1,$$p3\-\>}; }'\
	>>       $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
morrest:
	echo xx \
	| perl  -pe "s/morfix	\d	0	0	0\-\>1(\d*)\,1/morfix	1	1	1	0->1\1,1/;" \
	| grep -vE "A106437|A119647|A176416|A30549[56]|A317198" \
	> x.tmp
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
morfix_test:
	java -cp ../../dist/joeis-lite.jar irvine.oeis.MorphismSequence $(NT) $(SC)
morfix_grep:
	perl -ne \
	'if ((m{\-\>}) and (m{^(A\d+)\D+(\d[ 0-9\-\>\,\;\{\}\(\)\[\]]{9,})})) { print; }' \
	$(COMMON)/joeis_names.txt | tee x.tmp
	wc -l x.tmp
#--------
morfps0: morfps1 morfps2
morfps1:
	perl morfps.pl $(COMMON)/names \
	>        $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
morfps2:
	$(DBAT) "UPDATE seq4 s SET s.parm2 = (SELECT REPLACE(SUBSTR(i.terms, 1, 8), ',', '') \
	  FROM asinfo i WHERE s.aseqno = i.aseqno);"
	$(DBAT) "UPDATE seq4 s SET s.parm1 = '0' WHERE LENGTH(parm1) = 0;"
	$(DBAT) -x 44444 seq4 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
morfps:
	CLASS=MorphismFixedPointSequence
	grep -P "\d\-\>\d" morfps2.tmp > $@.gen
	cat morfps.man >> $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
morferr:
	grep "MorphismSeq" $(COMMON)/joeis_names.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
mordiff:
	cut -b1-7 morferr.gen > morfe.tmp
	cut -b1-7 morfps.gen  > morfp.tmp
	diff -y --width=30 --suppress-common-lines morfe.tmp morfp.tmp
#----
# 2021-09-20
morfck: # morphisms from CK guides
	cd ck ; make $@
	mv $@.gen                       $@.tmp
	cat morwiki.gen              >> $@.tmp
	grep -E "^A[0-9]" morfps.man >> $@.tmp
	sort $@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# 2021-09-23
mortra: # MorphismTransform
	grep -P "\d\-\>" $(COMMON)/names \
	| perl morfps.pl \
	| grep mortra \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
morwiki:
	perl $@.pl \
	| sort | uniq -w7 > $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.info FROm seq2 s \
	  WHERE s.aseqno NOT IN (SELECT aseqno FROM joeis) \
	    AND s.aseqno NOT IN (SELECT aseqno FROM seq4 ) \
	    ORDER BY 1;" \
	| sed -e "s/ /\t/g" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
mult0: mult1 mult3  # Multiplicative with ...
mult1: # grep nyi from jcat25
	grep -Pi "Multiplicative with" $(COMMON)/jcat25.txt \
	| grep -E "^\%" | cut -b4- \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mult2: 
	make seq LIST=mult1.tmp
	$(DBAT) -x "SELECT i.aseqno, n.name \
	  FROM asinfo i, asname n \
	  WHERE i.keyword LIKE '%mult%' \
	    AND i.aseqno = n.aseqno \
	    AND i.aseqno NOT IN (SELECT aseqno FROM seq) \
	    AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mult3: 
	sort -k2 mult1.tmp \
	| perl multprep.pl \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mult4:
	perl multext.pl mult2.gen \
	| sort | uniq -w7 \
	| tee    $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
mult5:
	perl multsplit.pl -j mult3.java \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
mult:
	perl multsplit.pl -j mult5.java \
	| grep -P "\tmultb?\t" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
multb:
	perl multsplit.pl -j mult5.java \
	| grep -P "\tmultb\t" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
multm:
	grep -E "^A[0-9]" mult1.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
multkey:
	$(DBAT) "SELECT COUNT(*) FROM asinfo i WHERE i.keyword LIKE '%mult%';"
multnyi:
	$(DBAT) "SELECT i.aseqno, i.offset1, n.name FROM asinfo i, asname n \
	WHERE i.aseqno = n.aseqno \
	  AND i.keyword LIKE '%mult%' \
	  AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  ORDER BY 1;" \
	| tee    $@.tmp
	wc -l    $@.tmp
#--------------------------------
n2:
	cat $(COMMON)/jcat25.txt \
	| perl -ne 'if (m{a\(n\) *\= *(A\d+)\((\d+)\*?n([ \+\-]\d+)?\)\.}) {'\
	'  print join("\t", substr($$_, 3, 7), "n2", 0, $$1, $$3 || 0, $$2) . "\n"; }' \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
num1dig: # A126207 null    Number of 5's in decimal expansion of 5^n.
	# grep -P "Number of (\d+\'s|zeroe?s|ones) " $(COMMON)/joeis_names.txt > $@.tmp
	# grep -vE "^#" $@.man > $@.gen
	perl $@.pl \
	| grep -v A160380 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A043001	null	n-th base 3 palindrome that starts with 1.	nonn,base,synth	1..46	nyi
# A043002	null	n-th base 3 palindrome that starts with 2.	nonn,base,synth	1..44	nyi
# A043004	null	Base-4 palindromes that start with 2.	nonn,base,synth	1..43	nyi
# A043045	null	a(n)=(s(n)+2)/3, where s(n)=n-th base 3 palindrome that starts with 1.	nonn,base,synth	1..51	nyi
palin:
	grep palindrome $(COMMON)/joeis_names.txt \
	| perl -ne 'my ($$aseqno, $$superclass, $$name, @rest) = split(/\t/); my ($$base, $$start) = (0,0);'\
	' if    ($$name =~ m{\An\-th base\D+(\d+) palindrome (that|which) starts with (\d)\.} ) { ($$base, $$start) = ($$1,$$3); } '\
	' elsif ($$name =~ m{\ABase\D+(\d+) palindromes? (that|which) start with (\d)\.}    ) { ($$base, $$start) = ($$1,$$3); } '\
	' if ($$base != 0) { print join("\t", $$aseqno, "palin", 1, "A043001", $$base, $$start, $$name) . "\n"; } '\
	  >      $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	grep palindrome $(COMMON)/joeis_names.txt \
	| perl -ne 'my ($$aseqno, $$superclass, $$name, @rest) = split(/\t/); '\
	' if ($$name =~ m{\A(a\(\w\) *\= *)?\(s\(\w\) *([\+\- ]+\d+)\) *\/ *(\d+)\, where s\(\w\) *\= *n\-th base\D+(\d+) palindrome (that|which) starts with (\d)\.} ) { '\
	' my ($$add, $$div, $$base, $$start) = ($$2, $$3, $$4, $$6); '\
	' print join("\t", $$aseqno, "palins", 1, "A043045", $$add, $$div, $$base, $$start) . "\n"; } '\
	  >>     $@.gen
	tail -n4 $@.gen
	wc -l    $@.gen
#----
palidsum:
	cp -v $@.man $@.gen
fact1dig:
	cp -v $@.man $@.gen
#----
period1: # select a few PeriodicSequence with offset != 0
	$(DBAT) "SELECT i.aseqno, 'period1', i.offset1, n.name \
	  FROM asinfo i, asname n \
	  WHERE i.aseqno = n.aseqno \
	    AND i.aseqno IN (SELECT aseqno FROM joeis WHERE superclass = 'PeriodicSequence') \
	    AND i.offset1 <> 0 \
	  ORDER BY 1" \
	| tee $@.tmp
#----
perman: # Permanents with A085244
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
pisot:
	grep -P "null\s+Pisot sequence" $(COMMON)/joeis_names.txt \
	| perl -ne 'm{\A(A\d+)\tnyi[^\t]*\tPisot sequence (\w)\((\d+)\, *(\d+)}; my ($$aseqno, $$p1, $$p2, $$p3) = ($$1, $$2, $$3, $$4); '\
	' my $$callcode = "pisot" . (($$p1 eq "L") ? "l" : ""); '\
	' print join("\t", $$aseqno, $$callcode, 0, $$p2, $$p3) . "\n"; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
##--------------------------------
# A191017 null    Primes with Kronecker symbol (p|14) = 1.
# A191020 null    Primes p with Kronecker symbol (p|2*11) = 1.
# A191023 null    Primes p which have Kronecker symbol (p|30) = 1.
# A191025 null    Primes p which have Kronecker symbol (p|34) = 1.
# A191028 null    Primes p with Kronecker symbol (p|38) = 1.
prikron:
	grep "Primes " $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; my $$line = $$_; '\
	'if ($$line =~ m{^(A\d+)\t\w+\tPrimes [^K]+Kronecker symbol \(p[\|\,\/]([\d\*]+)\)\s*\=\s*(\-?\d+)}) { '\
	'  my ($$aseqno, $$mod, $$value) = ($$1, $$2, $$3); $$mod =~ s{2\*(\d+)}{2 * $$1}e; '\
	'  print join("\t", $$aseqno, "$@", 0, $$mod, $$value) . "\n"; } '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A045391	null	Primes congruent to {1, 2} mod 7.	nonn,easy,changed,	1..1000
# A045392	null	Primes congruent to 2 mod 7.	nonn,easy,changed,	1..1000
# A129806	null	Primes congruent to +-5 mod 18.
primod:
	grep "Primes congruent " $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; my $$line = $$_; $$line =~ s{\s+\Z}{}; '\
	'if ($$line =~ m{^(A\d+)\t\w+\tPrimes congruent[^\{\d\+\-]+(\{[^\}]+\}|\+?\-?\d+) +mod +(\d+)}) { '\
	'  my ($$aseqno, $$list, $$mod) = ($$1, $$2, $$3); $$list =~ s{[\{\} ]}{}g; $$list =~ s{\+\-(\d+)}{"$$1\," . ($$mod-$$1)}e; '\
	'  $$list = join(" \|\| ", map { "r == " . $$_ } split(/\,/, $$list)); '\
	'  print join("\t", $$aseqno, "$@", 0, $$mod, $$list, substr($$line, 8)) . "\n"; '\
	' } '\
	| grep -vE "A057204|A271265" \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
pricongr:
	grep -i prime $(COMMON)/jcat25.txt | grep mod \
	| perl pricongr.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	grep -E "^A[0-9]" $@.man >> $@.tmp
	sort $@.tmp | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.tmp $@.rest.tmp
prisqua:
	# grep -i prime $(COMMON)/jcat25.txt | grep -E "(square|Jacobi)" \
	# | perl prisqua.pl \
	# 2>       $@.rest.tmp \
	# >        $@.tmp
	grep -E "^A[0-9]" $@.man > $@.tmp || :
	sort $@.tmp | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.tmp $@.rest.tmp
prijacob:
	grep -i prime $(COMMON)/jcat25.txt | grep -E "(square|Jacobi)" \
	| perl prijacob.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	grep -E "^A[0-9]" $@.man >> $@.tmp || :
	sort $@.tmp | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.tmp $@.rest.tmp
prikronf:
	grep -i prime $(COMMON)/jcat25.txt | grep -E "(square|Jacobi|Kronecker)" \
	| perl prikronf.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	grep -E "^A[0-9]" $@.man >> $@.tmp || :
	sort $@.tmp | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.tmp $@.rest.tmp
pribuild: # 2022-01-06
	make purge nocre
	make CC=pricongr select EX=xx gener noins CLASS=CongruenceForm
	make CC=A038702  select EX=xx gener noins CLASS=A038702
	grep A1910 pricongr.gen | cut -b1-64
	make CC=prikronf select EX=xx gener noins CLASS=KroneckerForm
	make CC=pricongr man noeis_count dist testall log
priquad2: # select all MMA calls of QuadPrimes2
	grep -P "QuadPrimes2\[\d" $(COMMON)/jcat25.txt \
	| perl priquad2.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@*.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "UPDATE seq4 s SET parm6 = COALESCE((SELECT j.superclass FROM joeis j WHERE s.aseqno = j.aseqno), 'nyi');"
	$(DBAT) -x -44444 seq4 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
priquad3: # insert the ones covered by CC=pricongr (CongruenceForm)
	make seq LIST=pricongr.gen
	$(DBAT) "UPDATE seq4 s SET parm6 = 'CongruenceForm' WHERE EXISTS (SELECT a.aseqno FROM seq a WHERE s.aseqno = a.aseqno);"
	$(DBAT) -x -44444 seq4 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
priquad4:
	grep -E "^A[0-9]" priquad2.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#	| sed -e "s/priquad2/priquad4/" \
#
priquad_guess: # guess the remaining residues in priquad3.gen
	perl priquad_guess.pl priquad3.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@*.tmp
priquad:
	cp -v priquad_guess.tmp $@.gen
	head -n4 $@.gen
	wc -l    $@.gen

pricotest:
	$(JAVA) irvine.oeis.prime.CongruenceForm -m $(MOD) 2>&1
binquadtest:
	$(JAVA) irvine.oeis.prime.BinaryQuadraticForm $(PARMS) 2>&1
#--------------------------------
# A216777 null    Primes p such that x^64 = -2 has no solution mod p.     nonn,easy,      1..1000
# A216862 null    Primes p such that x^5 = 20 has a solution mod p.       nonn,easy,      1..1000
# A040034 (PARI): forprime(p=2, 10^3, if(#polrootsmod(x^3-2, p)==0, print1(p, ", ")))
primsol:
	grep "Primes p such that " $(COMMON)/joeis_names.txt | grep -E "has (a|no|) solution" \
	| perl -ne 'use strict; my $$line = $$_; $$line =~ s{\s+\Z}{}; '\
	'if ($$line =~ m{^(A\d+)\t\w+\t(Primes[^x]+x\^(\d+) *\= *(\-?\d+) +has +(a|no|) solution mod p)\.}) { '\
	'  my ($$aseqno, $$name, $$pow, $$y, $$bool) = ($$1, $$2, $$3, $$4, $$5 || "a"); $$bool =~ s{a}{true}; $$bool =~ s{no}{false}; '\
	'  print join("\t", $$aseqno, "$@", 1, "A040028", $$pow, $$y, $$bool, $$name) . "\n"; '\
	' } '\
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A038873	null	Primes p such that 2 is a square mod p; or, primes congruent to {1, 2, 7} mod 8.	nonn,easy,	1..10000
# A038874	null	Primes p such that 3 is a square mod p.	nonn,easy,	1..1000
# A038875	PrependSequence	Primes p with legendre(3,p) = -1.	nonn,	1..1000
# A038876	null	Primes p such that 6 is a square mod p.	nonn,	1..1000
# A038877	null	Primes p such that 6 is not a square mod p.	nonn,easy,	1..1000
prisquare:
	grep -E "^A038" $(COMMON)/joeis_names.txt \
	| perl -ne  'if (m{(\d+) is (not )?a square mod p}) { print join("\t", substr($$_, 0,7), "$@", 0, "A038873", $$1, $$2 || "true") . "\n"; } '\
	| sed -e "s/not */false/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
prod1_xk:
	grep -iE "^\%[NFtpo]" $(COMMON)/jcat25.txt \
	| grep -iE "prod" \
	| grep -vE "produce" \
	| perl prod_polish.pl \
	| perl prod1_xk.pl -a \
	2>       $@.rest.tmp \
	| sort -k2 -k5 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
	sort     $@.tmp | uniq -w7 \
	>        $@.gen
prod1_xk_db_old:
	make seq4 LIST=$@.tmp
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis);"
	$(DBAT) -10000 seq4 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
prodet:
	cp -v prodet.man $@.tmp
	perl prodet.pl prod1_xk.tmp \
	>>       $@.tmp
	grep -E "^A" $@.tmp | sort | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
prodet3:
	cat prodet3.gen
prodetm:
	grep -E "^A" prodet.man > prodetm.gen
#----
#========
# Caution: if advanceH(k) is used, the k in advanceF and advancdG formulas must be replaced by mKh !
#========
genet: # parameters for GeneralizedEulerTransform
	cat prod1_xk.tmp prod1_xk.man \
	| grep -E "^A[0-9]" \
	| grep -vEi "y" \
	| sed -f $@.sed \
	| perl genet.pl \
	>        $@.tmp \
	2>       $@.rest.tmp
	grep -E "^A" $@.tmp \
	| grep -vE "genetxxxh"  \
	| sort | uniq -w7   \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
	cut -f2  $@.rest.tmp | sort | uniq -c
genetm:
	grep -E "^A[0-9]" genet.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
genet_plerr:
	perl -ne 'if (m{(\?[0-9A-Z]\w+)}) { print "$$1\n";}' genet.pl | sort | uniq -c
genet_joeis_names:
	make seq LIST=genet.pass.log
	$(DBAT) "UPDATE joeis j SET superclass = 'GeneralizedEulerTransform' WHERE j.aseqno IN (SELECT aseqno FROM seq);"
	$(DBAT) "INSERT INTO joeis (SELECT s.aseqno, 'GeneralizedEulerTransform', 1, 'genet', 'Georg' FROM seq s WHERE s.aseqno NOT IN (SELECT aseqno FROM joeis));"
	cd $(COMMON); make joeis_names
genet_follow:
	grep -A8 GeneralizedEulerTransform $(COMMON)/joeis_names.txt \
	>        $@.tmp
genet_status:
	cut -f1,3 genet.fail.log | grep -E "^A" > $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) "UPDATE seq4 s4 SET s4.parm7 = COALESCE((SELECT s2.info FROM seq2 s2 WHERE s4.aseqno = s2.aseqno), 'v');"
	$(DBAT) -x -44444 seq4 > genet.gen
genet_check:
	cut -f1,10,8-9 genet.gen
#----
# Generalized ET
a151668:
	cp -v $@.man $@.gen
#--------
prodsi: # A323545 a(n) = Product_{k=0..n} (k^7 + (n-k)^7). nonn 0..79
	grep -Pi "a\(n\) *\= *Prod(uct)?_\{" $(COMMON)/joeis_names.txt \
	| perl prodsi.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
#	| sort -k5,5 --field-separator="	" \
#
prodsi2:
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
prodsim:
	grep -E "^A[0-9]" prodsi.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
prodskj:
	perl $(CK)/ck_guides.pl -a T \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
quots:
	perl quots.pl $(COMMON)/joeis_names.txt \
	2>       $@.rest.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
quotm:
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
#----
sumsi2: # A323545 a(n) = Product_{k=0..n} (k^7 + (n-k)^7). nonn 0..79
	grep -Pi "a\(n\) *\= *Sum_\{" $(COMMON)/joeis_names.txt \
	| perl prodsi.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
#	| sort -k5,5 --field-separator="	" \
#
sumsi0:
	grep -E "^\%[NF]" $(COMMON)/jcat25.txt | cut -b4- | grep -iE "sum_\{" | sed -e "s/ /\tsumsi\t0\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
sumsi:
	grep -P "\ta\(n\) *\= *Sum" sumsi0.tmp \
	| perl prodsi.pl \
	2>       $@.rest.tmp \
	| sort -k7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
partsum:
	cat sumsi.gen \
	| perl -ne 'use strict; my @f = split(/\t/); if ($$f[6] =~ s{\A(A\d+)\([i-nI-N]+\)\Z}{$$1}) { '\
	' print join("\t", $$f[0], "partsum", 0, $$f[6], "", "new $$f[6]()", "") . "\n"; }' \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
sumsim:
	grep -E "^A[0-9]" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
sumgcdm:
	grep -E "^A[0-9]" sumgcd.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
ggpartsum: # Sean 2022-06-23
	$(DBAT) -f $(COMMON)/seq2.create.sql
	sed -e "s/ /\t/" partial_sum_stage2.out.ut \
	| $(DBAT) -r seq2
gg2:
	$(DBAT) "(SELECT s.aseqno, ' -> ', s.info   FROM asxref x, seq2 s \
	           WHERE s.aseqno = x.aseqno AND s.info = x.rseqno) \
	UNION    (SELECT s.aseqno, ' <- ', s.info   FROM asxref x, seq2 s \
	           WHERE s.aseqno = x.rseqno AND s.info = x.aseqno) \
	UNION    (SELECT s.aseqno, ' ?? ', s.info   FROM seq2 s \
	           WHERE s.info   NOT IN (SELECT x.rseqno FROM asxref x WHERE x.aseqno = s.aseqno) \
	             AND s.aseqno NOT IN (SELECT x.rseqno FROM asxref x WHERE x.aseqno = s.info  ) ) \
	ORDER BY 1"
#--------------------------------
peravoid:
	grep -iP "permutations of \[?n\]? avoiding " $(COMMON)/joeis_names.txt | grep null \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
#--------------------------------
prodfin0: prodfin1 prodfin
prodfin1:
	grep -iE "^\%[NFtpo]" $(COMMON)/cat25.txt \
	| grep -iE "prod" \
	| grep -ivE "produce|dot product|Multiplicative|gamma|sum|binomial|indices|E\.g\.f\.|Conjecture" \
	| perl -ne 'if (m{prod.*=\d+\.\.\d+\}}i) { print join("\t", substr($$_, 3, 7), "prodfin", 0, substr($$_, 11)); } ' \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis);"
	$(DBAT) -x -10000 seq4 > $@.tmp
# A075511	prodfin	0	G.f.: 1/Product_{k=1..6} (1 - 2*k*x).
# A075512	prodfin	0	G.f.: 1/Product_{k=1..7} (1 - 2*k*x).
# A075515	prodfin	0	G.f.: 1/Product_{k=1..5} (1 - 3*k*x).
prodfin:
	cat prodfin1.tmp \
	| perl -ne 's/\s*\Z//; my ($$aseqno, $$callcode, @parms) = split(/\t/); if ($$parms[1] =~ m{_\{k\=1\.\.(\d+)\} *\(1 *\- *(\d+)\*k}) {'\
	' $$parms[2] = $$1; $$parms[3] = $$2; '\
	' $$parms[1] = 'A075511'; print join("\t", $$aseqno, $$callcode, splice(@parms, 0, 4)) . "\n"; }'\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
recip:
	grep -i "Sign diagram" $(COMMON)/cat25.txt \
	| perl recip.pl \
	| grep -E "^A0491[567]" | grep -vE "^A04917[1-9]" \
	>        $@.gen
	grep -E "^A" recip.man >> $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
yves_martin: ym0 ym1
ym0:
	wget "http://oeis.org/A030203/a030203.txt" -O $@.tmp
ym1:
	cat      ym0.tmp \
	| perl -ne 'if (m{\A\d+\,}) { s/\, /\t/; s/\, /\t/; s/\]\, /]\t/; my ($$no, $$code, $$prod, $$aseqno) = split(/\t/); '\
	' print join("\t", $$aseqno, "ym", 0, $$no, $$code, $$prod) . "\n"; } ' \
	>        $@.tmp
	make seq LIST=$@.tmp
ym2:
	$(DBAT) -x "SELECT s.aseqno, j.superclass \
	    FROM seq s LEFT JOIN joeis j ON s.aseqno = j.aseqno \
	    ORDER BY 1"
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
# %F A238745 a(n) = A181819(A124859(n)).
seqop: # ???
	grep -E "a\(n\) *= *A[0-9][0-9]*(\([a-z]\))? *[\+\-\*\/m]" $(COMMON)/cat25.txt \
	| perl -ne 'my $$line = $$_; $$line =~ s{\s+\Z}{}; '\
	'if ($$line =~ m{^\%\w (A\d+)\s*a\(n\) *= *(A\d+)(\(\w\))?\s*([\+\-\*\/]|mod)\s*([a-z0-9])\.}) { '\
	'my ($$aseqno, $$bseqno, $$op, $$term) = ($$1, $$2, $$4, $$5); $$term =~ s{n}{mN}; '\
	'my %ops = ("+","add", "-", "subtract", "*", "multiply", "/", "divide", "mod", "mod(Z.valueOf"); '\
	'my $$suffix = "$$ops{$$op}($$term)" . ($$op eq mod ? ")" : ""); '\
	'print join("\t", $$aseqno, "$@", 0, lc(substr($$bseqno,0,4)), $$bseqno, $$suffix) . "\n"; } '\
	| uniq -w7 \
	>         $@.tmp
	head -n16 $@.tmp
	wc -l     $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, s.parm2, s.parm3 \
		, (SELECT i.offset1 FROM asinfo i WHERE s.parm2 = i.aseqno) \
		, j.superclass\
		FROM seq4 s LEFT JOIN joeis j ON s.aseqno = j.aseqno \
		WHERE parm2        IN (SELECT aseqno FROM joeis) \
		  AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 1"\
	>         $@.gen
	head -n4  $@.gen
	wc -l     $@.gen
#-------------------------------
# Triangles
# A038220 Triangle whose (i,j)-th entry is binomial(i,j)*3^(i-j)*2^j.	nonn,tabl,easy,	0..8000
# A038226 Triangle read by rows: (i,j)-th entry is binomial(i,j)*3^(i-j)*8^j.	nonn,tabl,easy,synth	0..36
trigf:
	perl -ne \
	'if (m{^(A\d+) Triangle (whose |read by rows\: )\(i\,j\)\-th entry is binomial\(i\,j\)\*(\d+)\^\(i\-j\)\*(\d+)\^j})'\
	'{ print join("\t", $$1, "$@", 0, 1, "1,-$$3,-$$4") . "\n" }' \
	$(COMMON)/names \
	>        trigf.gen
	tail -n4 trigf.gen
	wc -l    trigf.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
trigfm:
	cp trigfm.man trigfm.gen
#----
dhdop:
	sed -e "s/dhd/trigf/" $(TRIREC)/dhd_gf.tmp \
	>        $@.gen
	tail -n4 $@.gen
	wc -l    $@.gen
#----
rio:
	grep -E  "fract21"  $(TRIREC)/rio3.tmp \
	| sed -e "s/fract21/trigf/" \
	>        $@.gen
	tail -n4 $@.gen
	wc -l    $@.gen
fract21:
	grep -E  "fract21"  $(TRIREC)/fract2.tmp \
	| sed -e "s/fract21/trigf/" \
	>        $@.gen
	tail -n4 $@.gen
	wc -l    $@.gen
fract22:
	grep -E  "fract22"  $(TRIREC)/fract2.tmp \
	| sed -e "s/fract22/trigf/" \
	>        $@.gen
	tail -n4 $@.gen
	wc -l    $@.gen
#----
binomialx:
	cp -v $(TRIREC)/$@.gen $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
invbinom:
	cp -v $(TRIREC)/$@.tmp $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
trideleh:
	cp -v $(TRIREC)/$@.man $@.gen
#----
triprod:
	# cp -v $(TRIREC)/triprod2.tmp $@.gen
	cat $(ROBOT)/triprod.gen triprod.man > $@.gen
triprom:
	grep -E "^A[0-9]" $@.man | sort | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
trisimple:
	cp -v $(TRIREC)/$@.java $@.gen
#------------------------------------------------------
triselect: # use TriangleSelector
	grep -E "^A[0-9]" $@.man > $@.gen
	wc -l $@.gen
trisel2:
	make seq4 LIST=$(TRIREC)/cdrof.tmp
	$(DBAT) "DELETE FROM seq4 WHERE parm2 <> 'null' OR parm1 NOT IN (SELECT aseqno FROM joeis);"
	$(DBAT) -x -44444 seq4 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
triusage:
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE superclass in ('Triangle','UpperLeftTriangle');" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#------------------------------------------------------
negpos: # all done
	cat ../../../fasces/oeis/A131393/negpos.gen \
	| grep -E "ak|dk" \
	| sed -e "s/\t/\tnegpos\t0\t/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
# %C A070365 Period 6: repeat [1, 5, 4, 6, 2, 3].
# %F A118822 Period 8 sequence: [2,-1,0,-1,-2,1,0,1].
# %C A175408 Period of length 10: {7,2,6,3,5,4,4,5,3,1}.
# %N A257931 Period length 24 sequence [0, 1, 1, 0, -2, -1, 0, 1, 0, 0, -1, -1, 0, 1, 1, 0, 0, -1, 0, 1, 2, 0, -1, -1].
periodic: # PeriodicSequence
	perl -ne \
	' if (m{^(\%\w) (A\d+)\s+Period [^\{\(\[]*[\{\(\[]([\- \d\,]+)}) {'\
	' my ($$aseqno, $$list) = ($$2, $$3); $$list =~ s{ }{}g; '\
	' print join("\t", $$aseqno, "period", 0, $$list) . "\n"; }' \
	  $(COMMON)/cat25.txt \
	| grep -v A210188 \
	>        $@.gen
	head -n2 $@.gen
	tail -n2 $@.gen
	wc -l    $@.gen
#-------------------------------
# Positions of ... in (the decimal expansion of |Annnnnn)
posins: posins1 posins2
posins1:
	grep -E "Indices|Indexes|Positions of " $(COMMON)/jcat25.txt \
	| grep -E "^\%[NCF]" \
	| grep -v "of records" \
	| cut -b4- | sed -e "s/ /\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
posins2:
	perl posins.pl -d 0 posins1.tmp \
	2>       posins.rest.tmp \
	| sort | uniq -w7 \
	>        posins.gen
	head -n4 posins.gen
	head -n2 posins.rest.tmp
	wc -l    posins.gen posins.rest.tmp
	# perl callcode_wiki.pl -p 1 posins.gen > posins.wiki
posind:
	grep -E "^A[0-9]" posind.man > $@.gen
#----------------
charf:
	grep -E "^%" $(COMMON)/jcat25.txt \
	| perl -ne 'if (m{\A\%[NFY] +(A\d+)\s+Characteristic *function *of *(A\d+)[\.\,\:]}i) {'\
	' print join("\t", $$1, $@, 0, $$2, $$_); }' \
	| uniq -w7 \
	| tee    $@.gen
	wc -l    $@.gen
charfm:
	grep -E "^A" charf.man \
	| tee    $@.gen
	wc -l    $@.gen
#================================
# Derived sequences processed with deris.pl
#
DEROPT=
deris0: deris1 # charfun2
	rm -rf   deris2.gen
	ls -1 *.deris.tmp | sed -e "s/\.deris\.tmp//" \
	| xargs -l -innn make -i deris2 TARGET=nnn
	head -n4 deris2.gen
	wc -l    deris2.gen
deris1:
	rm -f *.deris.tmp
	echo -n "binomial"                         > binomx.deris.tmp
	echo -n "characteristic|indicator"         > charfun.deris.tmp
	# bad echo -n "complement"                       > compseq.deris.tmp
	echo -n "difference"                       > diffseq.deris.tmp
	echo -n "dirichlet"                        > dirichinv.deris.tmp
	echo -n "dirichlet"                        > dirichcon.deris.tmp
	echo -n "essent|same|identical|duplicate|apart" > essent.deris.tmp
	echo -n "euler"                            > eulerx.deris.tmp
	echo -n "euler"                            > eulerix.deris.tmp
	echo -n "m.e?bius"                         > moebiusx.deris.tmp
	echo -n "m.e?bius"                         > moebiusix.deris.tmp
	echo -n "partial product"                  > partprod.deris.tmp
	echo -n "partial sum"                      > partsum.deris.tmp
	echo -n "prime"                            > primepos.deris.tmp
	echo -n "prime"                            > primeval.deris.tmp
	# bad echo -n "record"                           > recordpos.deris.tmp
	echo -n "record"                           > recordval.deris.tmp
	echo -n "stirling"                         > stirling2.deris.tmp
	echo -n "weigh"                            > weighx.deris.tmp
# -n:  no trailing newline!
deris2:
	#================================ $(TARGET) ====
	grep -E "^\%[NCF] A[0-9]*" $(COMMON)/jcat25.txt charfun2.tmp \
	| grep -iEf $(TARGET).deris.tmp \
	| sed -e "s/ /\t/" -e "s/ /\t/" -e "s/^[^\%]*\%/\%/" \
	| perl deris.pl $(DEROPT) -cc $(TARGET) -f $(COMMON)/joeis_ofter.txt \
	>        $(TARGET).tmp \
	2>       $(TARGET).rest.tmp
	sort     $(TARGET).tmp | uniq -w7 \
	>        $(TARGET).gen
	head -n4 $(TARGET).gen
	wc -l    $(TARGET).gen $(TARGET).rest.tmp
	cat      $(TARGET).gen \
	>>       $@.gen
#----
deris:
	# sort     deris2.gen compseq.man | uniq -w7
	# sort     deris2.gen | uniq -w7 \
	# | grep -vf not_same.man \
	# | grep -vE "^(A318680|A318681|A214329|A219658|A237046|A087471|A214305|A239348)" \
	# | cut -b1-512 \
	sort     deris2.gen charfuman.man | uniq -w7 \
	>        deris.gen
	head -n4 $@.gen
	wc -l    $@.gen
deris_shuffle:
	perl -i.bak deris_shuffle.pl -d $(D) deris.gen
deris_ok:
	grep -P "^A\d+" deris.ok | cut -b1-7 | sed -e "s/^/\^/" > $@.tmp
	grep -Ef $@.tmp deris.gen > $@.gen
	wc -l    $@.gen
#----
compseqm:
	grep -E "^A[0-9]" compseq.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
insect:
	grep -iE "(Intersection|Union) of" $(COMMON)/jcat25.txt \
	| grep -E "^\%[NFC]" | cut -b 4- | sed -e "s/ /\t/" \
	| perl insect.pl -d 0 \
	| grep -VE "A185188|A281627"
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
xfmpad0:
	grep -E "^\%[NCF] A[0-9]*" $(COMMON)/cat25.txt \
	| grep -iE " transform of[\(\[\{ ]*\-?[0-9][0-9]*\," \
	| sed -e "s/ /\t/" -e "s/ /\t/" -e "s/^[^\%]*\%/\%/" \
	| perl xfmpad.pl \
	2>       $@.rest.tmp \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
xfmpad:
	cp -v xfmpad0.tmp $@.gen
binomx:
	cp -v $@.man $@.gen
charfuman:
	grep -E "^A" $@.man \
	| grep -v A294905 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
charfun3:
	grep -E "Characteristic function " $(COMMON)/joeis_names.txt \
	| grep -E "null" \
	| perl -ne 's{\tnyi[^\t]*\tCharacteristic function (of|for) }{\tcharfun\t0\t};'\
	' s{(.)(A\d{6})}{$$1$$2\t\t}; print; '\
	>        $@.tmp
	wc -l    $@.tmp
diffseq:
	cp -v $@.man $@.gen
dirichcon:
	cut -f1 $@.man | sed -e "s/\r//" -e "s/^/\^/" > $@.grep.tmp
	cp -v   $@.man $@.gen
	# grep -vEf $@.grep.tmp deris2.gen >> $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
essent:
	cp -v $@.man $@.gen
moebiusx:
	cp -v $@.man $@.gen
stirling2: # A052856, A052875, A069321, A140585 manually mod.
	cp -v $@.man $@.gen
#----
# unimportant:
deris3:
	cut -f2  deris2.gen | sort | uniq -c
deris4:
	grep -E "^\%[NCF] A[0-9]*" ../../../OEIS-mat/common/cat25.txt charfun2.tmp \
	| grep -iE "`cat charfun.deris.tmp`"
deris5:
	echo -n "A054521" > x.tmp
	grep -iE "`cat x.tmp`" charfun2.tmp
#----
charfun2: # Characteristic function of rseqno
	perl charfun_index.pl \
	| grep -vE "A167393" \
	>        $@.tmp
	cat charfun.rest.man >> $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
charfun3_nu:
	cat      $@.tmp \
	| perl deris.pl $(DEROPT) -cc charfun -f $(COMMON)/joeis_ofter.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
#----
aratus:
	$(DBAT) -x "SELECT i.aseqno, COALESCE(j.superclass, 'nyi'), i.offset1, n.name \
	  FROM asinfo i, asname n LEFT JOIN joeis j ON j.aseqno = n.aseqno \
	  WHERE i.aseqno = n.aseqno \
	    AND i.author LIKE '%Alex Ratushnyak%' \
	  ORDER BY 1" \
	>        $@.tmp
	wc -l    $@.tmp
#----
vpost: vpost1 vpost2 vpost3
vpost1:
	$(DBAT) -x "SELECT i.aseqno, i.offset1, d.data \
	  FROM asinfo i, asname n, asdata d \
	  WHERE i.aseqno = n.aseqno \
	    AND n.aseqno = d.aseqno \
	    AND i.author LIKE '_Jonathan Vos Post%' \
	    AND LOWER(n.name) LIKE '%partial sums %' \
	  ORDER BY 1" \
	>        $@.tmp
	wc -l    $@.tmp
vpost2:
	perl vpost_incr.pl vpost1.tmp \
	| tee    $@.tmp
	wc -l    $@.tmp
vpost3:
	cp -v    vpost2.tmp  $(COMMON)/nonincr.txt
	cd $(COMMON) ; make -f checks.make -s html_check1 FILE=nonincr
	rm -vf $(COMMON)/nonincr.txt
#================================
rectoproc:
	grep -E "^A[0-9]" $(HOLREC)/rectopost.tmp \
	| grep -vE "A110908|A261141" \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen

#----
dfinite:
	grep -E "^A[0-9]" $(CONTRIB)/rm/df_prep.tmp \
	| grep -vE "A110908|A261141" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
shownin:
	grep -E "^A" $(COMMON)/names \
	| grep -P "^A\d{6}[^A]*A\d{6}" \
	| perl -ne 'if (m{^(A\d{6}) (Sequence |Array |Bit\-masks of |)(A\d{6}) (shown |written |)in (quaternary|octal|binary|base \d+)}) { '\
	' my ($$aseqno, $$rseqno, $$base) = ($$1, $$3, $$5); $$base =~ s{octal}{8}; $$base =~ s{binary}{2}; $$base =~ s{base *}{}; '\
	' if ($$base != 10) { print join("\t", $$aseqno, "shownin", 0, $$rseqno, $$base) . "\n"; }}' \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------
sigma0: # grepped a(k) = A000005(Annnnnn(k)) = sigma_0(Annnnnn)
	perl $@.pl $(COMMON)/joeis_names.txt \
	2>       $@.rest.tmp \
	| grep -vE "A108504|A181801|A216326|A294880|A322584|A342929" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
sigma0_2:
	grep -P " A000005\(A\d+" $(COMMON)/jcat25.txt | grep -E "^\%[NFC]" \
	| cut -b4- \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigman0: # manually a(k) = A000005(Annnnnn(k))
	grep -E "^A[0-9]" $@.man | sort | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
sigman1: # manually a(k) = A000203(Annnnnn(k))
	grep -E "^A[0-9]" $@.man | sort | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#----
simbinom:
	grep -E "^A[0-9]+" $@.man > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
simple:
	grep -E "^A[0-9]+" $@.man > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
simple3:
	grep -E "^A[0-9]+" $@.man \
	| grep -vE "A234599|A286299|A308867|A349606" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#----
knestpark: # remember A-numbers in ./park
	ls -1 park | sed -e "s/\./\t1\t/" > $@.tmp
	make seq3 LIST=$@.tmp
	dbat -4  seq3
	dbat -n  seq3
knest: # known nested functions
	grep -E "^\%[NFC]" $(COMMON)/jcat25.txt \
	| perl $@.pl \
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
knest2: # repair skipping of underlying sequences
	perl repair_head.pl -n 3 -s knest-1.fail.log | tee sql/$@.sql
	$(DBAT) -f sql/$@.sql
	make select3 # CC= must be set
knestm:
	grep -E "^A[0-9]" aman/$@.man > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
# A320124 null    Number of integer solutions to a^2 + b^2 + 2*c^2 + 3*d^2 = n
nisolut:
	grep -E "solution|Gram matrix" $(COMMON)/cat25.txt | cut -b4- \
	| perl nisolut.pl -d 0 -e \
	2>       $@.rest.tmp \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.*
nisolut_eval:
	grep -E "\^2" nisolut.rest.tmp \
	| grep -vE "\^[3-9]" \
	| grep -E "umber of" \
	>        $@.tmp
	wc -l    $@.tmp
	grep -E "Gram matrix" nisolut.rest.tmp \
	>>       $@.tmp
	wc -l    $@.tmp
nisoman:
	cp -v nisolut.man $@.gen
theta3_epsig:
	cat gramdiag.man \
	| perl $(ETA)/theta3_epsig.pl -d 0 \
	| perl $(ETA)/norm_epsig.pl -d 0 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
psipsik_epsig:
	  perl $(ETA)/psipsik_epsig.pl -d 0 \
	| perl $(ETA)/norm_epsig.pl -d 0 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------
# For ContinuedFractionSequence, determine the underlying DecimalExpansionSequence
cofrefl: cofrefl1 cofrefl2
cofrefl1:
	$(DBAT) -x "SELECT a.aseqno, 'cofr', a.offset1 \
	  FROM asinfo a, joeis j \
	  WHERE a.aseqno = j.aseqno \
	    AND j.superclass = 'ContinuedFractionSequence' \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
cofrefl2:
	cat cofrefl1.tmp \
	| $(JAVA) irvine.oeis.ConstantReflector -f - 
	2>       $@.err.tmp \
	| tee    $@.tmp
	wc -l    $@*.tmp
#--------
# For ContinuedFractionSequence, determine the underlying DecimalExpansionSequence
dexrefl: dexrefl1 dexrefl2
dexrefl1:
	$(DBAT) -x "SELECT a.aseqno, 'exp', a.offset1 \
	  FROM asinfo a, joeis j \
	  WHERE a.aseqno = j.aseqno \
	    AND j.superclass = 'DecimalExpansionSequence' \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
dexrefl2:
	grep -vE "A002210|A00471[0-7]|A00559[67]|A013705|A027606|A028999|A030171|A051762|A111197|A258815" dexrefl1.tmp \
	| $(JAVA) irvine.oeis.ConstantReflector -f - \
	2>       $@.err.tmp \
	| tee    $@.tmp
	wc -l    $@*.tmp
#--------
# Extract minimal linear recurrences for all not in table holref
lrixamine: purge dist lrixamine1 lrixamine2 lrixamine4
lrixamine1: # select the eligible programs
	$(DBAT) -x "SELECT a.aseqno, '$@', a.offset1, i.signature, 0, j.superclass \
	  FROM asinfo a, lrindx i, joeis j \
	  WHERE a.aseqno = 'A' || i.seqno \
	    AND a.aseqno = j.aseqno \
	    AND a.aseqno NOT IN (SELECT aseqno FROM holref) \
	    AND LENGTH(i.signature) >= 1 \
	    AND i.signature NOT LIKE '%.%' \
	  ORDER BY 1" \
	| sed -e "s/ //g" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
lrixamine2: #   run the LinearRecurrenceInspector and determine the parameters for HolonomicRecurrence
	cat lrixamine1.tmp \
	| grep -vE "A001224" \
	| grep -vE "A005784|A005785|A005943|A036517|A048345|A068616|A068617|A079921"
	| $(JAVA) irvine.oeis.LinearRecurrenceInspector -f - -n 16 \
	2>       $@.err.tmp \
	| tee    $@.tmp
	wc -l    $@.tmp
lrixamine_test: # run the LinearRecurrenceInspector with a few test cases
	$(JAVA) irvine.oeis.LinearRecurrenceInspector -d 2 -n 16 -f lrixamine1.man \
	| tee x.tmp
lrixamine3:
	sort lrixamine2.tmp \
	| grep -vE "A005785|A157074" \
	| uniq -w7 > $@.gen
lrixamine4: # full test
	make CC=lrixamine3 select EX=xx gener distel
#--------
# Check whether SequenceWithOffset returns the proper offset
offinspect: offinspect_update offinspect1 offinspect2
offinspect_update:
	# $(DBAT) "UPDATE asinfo SET offset1 = 1 WHERE aseqno IN ('A049032','A102156','A102768','A155809','A157202','A188459');"
offinspect1: # select the eligible programs
	$(DBAT) -x "SELECT i.aseqno, i.offset1, j.superclass FROM asinfo i, joeis j WHERE i.aseqno = j.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
offinspect2: # run the  OffsetInspector and determine old and new offsets
	$(JAVA) irvine.oeis.OffsetInspector offinspect1.tmp \
	| tee    $@.tmp
	wc -l    $@.tmp
	cp -v    $@.tmp $@.txt
	cut -f3 offinspect2.tmp | sort | uniq -c | sort -n \
	| tee -a $@.txt
	# | grep -vP "\A\s+1\s" \
	#
#----
offinspectall:
	$(DBAT) -x "SELECT i.aseqno, i.offset1, j.superclass \
	  FROM asinfo i LEFT JOIN joeis j ON i.aseqno = j.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	zip offinspectall.zip offinspectall.tmp
#----
offrepair: # copy all with failing offset into ./manual and open them in Uedit64
	grep -E "^A[0-9]" offinspect2.tmp | cut -b1-7 | head -n111111 | xargs -l cmd /c jom
#----
offholon: # put it in table seq
	grep Holonom offinspect.dec1.txt | grep -E "^A[0-9]" | cut -f1 > $@.tmp
	cd $(COMMON) ; make seq LIST=$(HERE)/$@.tmp
offholrem: # remove all that are not in offinspect.txt
	$(DBAT) -x -v "DELETE FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM seq);"
offcount: # SUPER= count the different offsets for some jOEIS superclass
	$(DBAT) -x "SELECT COUNT(i.offset1), i.offset1 FROM asinfo i, joeis j WHERE i.aseqno = j.aseqno AND j.superclass LIKE '$(SUPER)%' GROUP BY i.offset1 ORDER BY 1"
#--------
finspect: finspect1 finspect2
finspect1:
	$(DBAT) -x "SELECT b.aseqno, b.bfimax - b.bfimin + 1 \
	FROM bfinfo b, joeis j \
	WHERE b.aseqno = j.aseqno \
	  AND j.superclass IN ('FiniteSequence','NoncomputableSequence') \
	ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
finspect2: # run the FiniteInspector and check the number of terms
	$(JAVA) irvine.oeis.FiniteInspector finspect1.tmp \
	| tee    $@.tmp
	wc -l    $@.tmp
	cp -v    $@.tmp $@.txt
	cut -f3 finspect2.tmp | sort | uniq -c | sort -n \
	| tee -a $@.txt
#--------
compareall0:
	find ../../src/irvine/oeis/a* -iname "*.java" | cut -b7- | xargs -innn diff -C0 ../../nnn ../../../joeis/nnn \
	> $@.1.tmp
compareall1:
	cut -b1-7 baddex.man \
	| perl -ne 's/\s//g; print "src/irvine/oeis/" . lc(substr($$_, 0, 4)) . "/$$_.java\n";'\
	| xargs -innn diff -C0 ../../nnn ../../../joeis/nnn \
	| tee $@.tmp
compareall:
	grep -vP "^(\*\*\*\*|\*\*\*\s\d|\!\s+\/\/|\!\s+super\(|\-\-\- )" $@.1.tmp | tee $@.2.tmp
#----
# patches for various superclasses
poffhol:
	grep -E "Holonomic" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
poffdex:
	make purge
	grep -E "DecimalExpansionSequence" offinspect2.txt \
	| grep -v BinaryToDecimal \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
podex99:
	cut -b1-7 baddex.man \
	| perl -ne 's/\s//g; print "src/irvine/oeis/" . lc(substr($$_, 0, 4)) . "/$$_.java\n";'\
	| xargs -innn rm -v ../../nnn  test2 log
	make dist testall log TO=8 GU=8
	make CC=$@ pack1
poffgf:
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE superclass = 'GeneratingFunctionSequence' ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	cp -v $@.tmp ghead.tmp
	rm -f batch.log
	make CC=$@ test2 log
poffca_show:
	$(DBAT) "SELECT j.aseqno, i.offset1, j.superclass FROM asinfo i, joeis j \
	  WHERE i.aseqno = j.aseqno \
	    AND j.superclass LIKE '%DAutomaton' \
	    AND offset1 <> 0 ORDER BY 1" \
	| tee $@.tmp
poffca:
	grep -P "DAutomaton" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffalt:
	grep -P "AlternatingSequence" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffloor:
	grep -P "FloorSeq" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffgf2:
	grep -P "\tGenera" offinspect2.txt | cut -b1-7 | xargs -l perl genman.pl -h 
poffmix1:
	# grep -E "PolynomialRoot|BinaryToDecimalExpansion|GeneratingFunctionSequence" offinspect2.txt
	grep -E "GeneratingFunctionSequence" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poff19:
	grep -E "A019899" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poff796:
	grep -E "A000796" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poff1113:
	grep -E "A001113" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffet:
	grep -E "EulerTransform" offinspect2.txt | grep -v "EulerTransformSequence" \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffiet:
	grep -P "InverseEulerTransform" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffcor:
	grep -E "ConstantOrderRecurrence" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffcos:
	grep -E "CoordinationSequence" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffbdex:
	grep -E "BinaryToDecimal" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
poffegf:
	make purge
	grep -E "ExponentialGeneratingFunction" offinspect2.txt \
	| perl patch_offset.pl -d 1 \
	| tee $@.tmp
	find ../../src/irvine/oeis/a* -iname "A*.java" | xargs -innn cp -v nnn manual
	# make dist testall log TO=8 GU=8
poffpos:
	grep -E "PositionSequence" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
#----
packprep:
	find ../../src -iname "*.java" \
	| cut -b7- | grep -vE "seqbox|Batch|Test" \
	| tee $@.tmp
#--------------------------------
wraptr: # WrappedRecurrence
	cd $(TRIREC); make wraptr
	head -n4 $@.gen 
	wc   -l  $@.gen
#--
tricodiff: # ConstantDifferenceTriangle
	cd $(TRIREC); make tricodiff
	head -n4 $@.gen
	wc   -l  $@.gen
#--
triconst: # WrappedConstantTriangle
	cd $(TRIREC); make triconst
	head -n4 $@.gen
	wc   -l  $@.gen
#--
trimultab: # Multiplication tables
	grep -E "^A[0-9]" $(TRIREC)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--
sumpown: # Sums of two powers of m
	cd $(TRIREC); make sumpown
	cp -v $(TRIREC)/$@.tmp $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
sumpown_check:
	$(DBAT) "SELECT s.aseqno, 'bfimin=', b.bfimin FROM seq4 s, bfinfo b WHERE s.aseqno = b.aseqno;"
	$(DBAT) "SELECT s.aseqno, 'offset1=', s.offset1 FROM seq4 s;"
#----
pastri_deprecated: # GeneralizedPascalTriangle
	grep -E "^A[0-9]" $(TRIREC)/pascal.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
A256890:
	perl $(TRIREC)/tri_guides.pl -a A \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
tricons:
	grep -E "^A[0-9]" $(TRIREC)/const.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
modpas: # 2021-10-08; formerly A071919
	grep -E "^A[0-9]" $(TRIREC)/modpas2.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
modpas2: # 2021-11-12
	grep -E "^A[0-9]" $(TRIREC)/modpas2.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
triuple: # 2021-10-25
	# cd $(TRIREC); make triuple
	grep -E "^A(0[4-9]|[1-9])[0-9]+" $(TRIREC)/triuple.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
triupcp: # 2021-10-26
	cd  $(TRIREC); make trigB
	grep -E "trig_b2" $(TRIREC)/trigB.tmp \
	| grep -vE "^A00|A99999|A087062" \
	| perl -pe 's{\ttrig_b2\t}{\tparmof2\t}; s{\trseqno\t(A\d+)}{\tA203991\tnew $$1\(\)}; '\
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
triupcp_old: # 2021-10-25
	cd  $(TRIREC); make triupcp
	cat $(TRIREC)/triupcp.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
rowsums:
	sort $(TRIREC)/$@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
A054445: # partial row sums
	grep -E "^A[0-9]" $(TRIREC)/$@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
tricolk:
	sort $(TRIREC)/$@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
triman:
	grep -E "^A[0-9]" $(TRIREC)/triman.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
trimirror:
	cd $(TRIREC) ; make $@
	cp -v $(TRIREC)/$@.tmp $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
transpose:
	make seq4 LIST=$(TRIREC)/$@.tmp
	$(DBAT) -x "DELETE FROM seq4 \
	  WHERE aseqno    IN (SELECT aseqno FROM joeis) \
	     OR parm1 NOT IN (SELECT aseqno FROM joeis)"
	$(DBAT) -x -44444 seq4 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
transpose_check:
	$(DBAT) -x "SELECT aseqno, callcode, offset1, parm1, parm2, parm3 \
	  FROM seq4 WHERE parm2 <> parm3 ORDER BY 1"
#--------------------------------
# A163493 Number of binary strings of length n which have the same number of 00 and 01 substrings.
# cf. Zeilberger: https://arxiv.org/pdf/1112.6207.pdf
#
rpseqhol0: rpseqhol1 rpseqhol2
rpseqhol1: # extract all word pairs
	grep -E "Number of binary strings of length n "  $(COMMON)/joeis_names.txt \
	| perl rpseqhol.pl \
	2>       $@.rest.tmp \
	| head -n88888 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp
rpseqhol2: # convert the word pairs into P-finite recurrences
	perl $(COMMON)/callmaple.pl -t 4 -n 64 -p rpseqhol.mpat rpseqhol1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
rpseqhol:
	cat rpseqhol2.tmp | grep -P "^A[0-9]" | sort | uniq -w7\
	| perl -ne 's/\[\]/\[0\]/g; print; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
greprec3:
	cd $(HOLREC) ; make holminit LIST=$@.gen
	grep -vE "^A176186" $(HOLREC)/holminit.tmp > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
maplass:
	grep -E "^A" $(HOLREC)/maplass4.tmp \
	| grep -v "/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
# A118351 Central terms of pendular triangle A118350
# G.f. A=A(x) satisfies: A = 1 - 3*x*A + 3*x*A^2 + x*A^3.
#
satishol0: satishol1 satishol2
satishol1: # merge with initial terms
	make seq4 LIST=$(HOLREC)/satis.gen
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, d.data \
	  FROM  seq4 s, bfdata d \
	  WHERE s.aseqno = d.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
satishol2: # convert algebraic equation into P-finite recurrences
	perl $(COMMON)/callmap22.pl -t 6 -n 16 -p satishol.mpat satishol1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
satishol:
	cat satishol2.tmp | grep -P "^A\d+\t" | grep -v FAIL | sort | uniq -w7\
	| perl -ne 's/\[\]/\[0\]/g; print; '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# targets for sequencedb
#
SDBaffine:
	grep -E "^A" $(SDB)/affine3.tmp \
	| sort | uniq -w7 \
	| sed -e "s/\t[0-9]*\t/\tpanext\t/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
SDBdiff1: # A056526 03      9999    Δ[A000960(n)]
	grep -P "\tΔ\[A\d+\(n\)\]\t" $(SDB)/seqdb4.tmp \
	| tee $@.tmp
#--------
sdb_simple:
	cat $(SDB)/simple2.tmp \
	| grep -vE "A174841|A340519" \
	| perl -ne 's{\tinfix\t}{\t$@\t}; print;' \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A136811 Numbers n such that n and the square of n use only the digits 0, 1, 2, 3 and 5.
squaredig: # Jonathan Wellons A136nnn
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [nk] such that [nk] and the square of [nk] (use|contains?) only the digits ([^\.]+)\.}) '\
	'{ my ($$aseqno, $$subset) = ($$1, $$3); '\
	'$$subset =~ s{\D}{}g; print join("\t", $$aseqno, "$@", 0, $$subset) . "\n"; }' \
	$(COMMON)/names \
	>        $@.gen
	head -n2 $@.gen
	tail -n2 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
squaredig4: # A053880 ff.: digits required in square only
	grep -E "digits +\{ *[0-9]" $(COMMON)/joeis_names.txt \
	| perl squaredig4.pl \
	| grep squaredig4 \
	>        $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
squaredig2:
	grep -E "SquareDigitsSequence" $(COMMON)/joeis_names.txt \
	>        $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
squaredig_test:
	$(JAVA) irvine.oeis.SquareDigitsSequence -s $(S) -d $(D) -m $(M) -n $(NT)
squaredig_width:
	$(DBAT) "SELECT b.aseqno, b.maxlen, n.name FROM bfinfo b, seq4 s, asname n \
	WHERE b.aseqno = s.aseqno \
	  AND s.aseqno = n.aseqno \
	  ORDER BY 1" | tee @$.tmp
#----
triangdig4: # A119033 ff.: digits required in triangular numbers only
	grep -E "digits +\{ *[0-9]" $(COMMON)/joeis_names.txt \
	| perl squaredig4.pl \
	| grep triangdig4 \
	| sed -e "s/triangdig4/squaredig4/" \
	>        $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
#--------------------------------
subsetmod:
	grep -P "^A\d+" $@.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
tileprep: tilepre1 tilepre2 tilepre3
tilepre1:
	# DO NOT select by bfimax - we need all
	$(DBAT) -x "SELECT c.aseqno, 'tile1', 0, c.galid, c.stdnot, c.vtype, c.tarots, c.tilingno \
	  FROM coors c \
	  ORDER BY c.tilingno, c.galid" \
	| perl tile_collect.pl \
	>        $@.tmp
	tail -n8 $@.tmp
	wc -l    $@.tmp
tilepre2:
	sort tilepre1.tmp \
	| perl genuniq.pl 2> tilepre2.dupl.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
tilepre3:
	make seq4 LIST=tilepre2.tmp
	$(DBAT) "DELETE FROM seq4 WHERE aseqno IN (SELECT aseqno FROM joeis);"
	$(DBAT) -x "SELECT aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5 \
	  FROM seq4 \
	  ORDER BY CAST(parm5 AS INT), parm4" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
tilepre4:
	perl tile_reduce.pl tilepre3.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
tile:
	cp tilepre4.tmp tile.gen
tilepre5:
	grep -vf tilepre2.tmp tilepre1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.2.tmp
	$(DBAT) -x "SELECT aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 \
	    WHERE (aseqno NOT IN (SELECT aseqno FROM joeis)) \
	    ORDER BY parm5, parm4" \
	| perl -pe "s{\'\'}{\'}g" \
		  >  $@.tmp
	head -4  $@.tmp
	wc -l    $@.tmp
tile2:
	$(DBAT) -x "SELECT c.aseqno, 'tile', 0, c.galid, c.stdnot, c.vtype, c.tarots, c.tilingno \
	  FROM coors c \
	  WHERE c.aseqno NOT IN (SELECT j.aseqno FROM joeis j) \
	  ORDER BY c.aseqno, c.tilingno, c.galid" \
	| perl tile_collect.pl tile.tmp \
	| perl genuniq.pl 2> tile_skipped.gen \
	perl tile_reduce.pl tile.3.tmp \
	>        $@.gen
	tail -n8 $@.gen
	wc -l    $@*.gen
#----
tilecheck1:
	cut -b1-7 tile.tmp | sort | uniq -c | grep -vE "^  *1 "
tilecheck2:
	cd $(COMMON) ; make seq LIST=../coors/duplicates.man
	$(DBAT) -x "SELECT c.aseqno, c.galid \
	  FROM coors c, seq s \
	  WHERE c.aseqno = s.aseqno \
	  ORDER BY c.tilingno, c.galid" \
	| sort \
	| tee    $@.tmp
	wc -l    $@.tmp
#----
TARGET=$(LITE)/src/org/teherba/tile
tilepack:
	# rm -rf $(TARGET)
	mkdir -p $(TARGET)
	find $(COORS) -name "*.java" -printf "%P\n" \
	| grep -vE "^(BFile|SVGFile|TilingTest|Sequence|Tiler[12]|Z)\.java" \
	| xargs -l -i{} perl tilepack.pl -t -p org.teherba.tile $(COORS)/{} $(TARGET)/{}
#--------------------------------
trecpas: # received from $(TRIREC)/trecpas.tmp
	grep -E "^A[0-9]" $@.tmp \
	| grep -vE "A090971|A127156|A128134" \
	| sort | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
# A151255 Number of walks within N^2 (the first quadrant of Z^2) starting at (0,0)
#   and consisting of n steps taken from {(-1, -1), (-1, 1), (1, 0)}	nonn,walk,synth	0..34
# A151373 Number of walks within N^2 (the first quadrant of Z^2) starting
#   and ending at (0,0) and consisting of n steps taken from {(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, 0), (1, 1)}	nonn,walk,synth	0..26
# A151508 Number of walks within N^2 (the first quadrant of Z^2) starting at (0,0)
#   , ending on the vertical axis and consisting of n steps taken from {(-1, -1), (-1, 0), (-1, 1), (0, -1), (1, -1), (1, 0)}.	nonn,walk,	0..440
# A147999 Number of walks within N^3 (the first octant of Z^3) starting at (0,0,0)
#   and consisting of n steps taken from {(-1, -1, -1), (-1, -1, 1), (-1, 1, 0), (1, 0, 0)}	nonn,walk,synth	0..33
# A151254 Number of walks within N^3 (the first octant of Z^3) starting at (0,0,0)
#   and consisting of n steps taken from {(-1, 0, 0), (1, 0, 0), (1, 0, 1), (1, 1, 0), (1, 1, 1)}	nonn,walk,synth	0..25
walk23:
	perl -ne \
	'if (m{^(A\d+)\s+Number of walks within N\^(\d) \(the first \w+ of Z\^\d\) starting '\
	'(at \([^\)]+\) |and ending at \([^\)]+\) |at \([^\)]+\)\, ending on the vertical axis )'\
	'and consisting of ((\d)[ \*]*)?[nk] steps taken from \{([^\}]+)\}})'\
	'{ my ($$aseqno, $$dim, $$endCode, $$dummy, $$factor, $$stepCode) = ($$1,$$2,$$3,$$4,$$5 || 1,$$6);'\
	'$$endCode =~ s{\W}{}g; $$endCode =~ s{^at0+}{}; $$endCode =~ s{andendingat0}{e}; $$endCode =~ s{endingonthev.*}{ey};'\
	'$$stepCode =~ s{\-1}{2}g; $$stepCode =~ s{\D}{}g; my $$noSteps = length($$stepCode) / $$dim;'\
	'print join("\t", $$aseqno, "$@", 0, $$dim, $$noSteps, $$endCode, $$factor, $$stepCode) . "\n" }' \
	$(COMMON)/names \
	>        $@.gen
	cut -f 4 $@.gen | sort | uniq -c
	head -n2 $@.gen
	tail -n2 $@.gen
	# cut -f6  $@.gen | sort | uniq -c | grep -v " 1 " || :
	cut -f4-6  $@.gen | sed -e "s/[ \t]*//g" | sort | uniq -c
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
walktest:
	java -cp ../../dist/joeis-lite.jar irvine.oeis.WalkCubeSequence $(NT) 3 $(SC)
	# perl -ne "print if m{\t2\t3\t\t};" walk23.gen > walk23en.gen
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
#-----------------------------
egf: egf1 egf2
egf0:
	grep -E "^\#[A-Za-z] A[0-9][0-9]* (Expansion of e|E)\.g\.f\." $(COMMON)/jcat25.txt \
	| cut -b4- \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
egf1:
	grep -E "^\%[A-Za-z] A[0-9][0-9]* (Expansion of e|E)\.g\.f\." $(COMMON)/jcat25.txt \
	| cut -b4- \
	| perl -ne 's{ (Expansion of e|E)\.g\.f\.\:? *}{\tegf\t0\t}; s{(\. .*|\.\Z| \- _.*)}{}; s{ }{}g; '\
	' if (! m{for|of|satis|where|column|Lambert|Root|Sum|Prod|[EPRIjklmy\!\;\:]|A\(|\^\^|e\^|\.\.\.|\)\=}) {'\
	' s{z}{x}g; s{[\.\=]}{}g; print if m{x}; }' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
egfsi0: egfsi1 egfsi2 egfsi3 egfsi4
egfsi1:
	grep -E "^\%[A-Za-z] A[0-9][0-9]* (Expansion of e|E)\.g\.f\." $(COMMON)/jcat25.txt \
	| cut -b4- \
	| perl egfsi.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfsi2:
	$(JPREP) -p RING.ttab -f egfsi1.tmp -cc post1 \
	>        $@.1.tmp
	grep -E  "\?" $@.1.tmp > $@.rest.tmp || :
	grep -vE "\?" $@.1.tmp > $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfsi3:
	perl ring_improve.pl egfsi2.tmp \
	>        $@.tmp
	grep -E  "\?" $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
ring_improve_test:
	grep -E "^A[0-9]" ring_improve.pl
	perl ring_improve.pl ring_improve.pl        | tee $@.1.tmp
	$(JPREP) -p RING.ttab -f $@.1.tmp -cc trans | tee $@.2.tmp
egfsi4:
	$(JPREP) -p RING.ttab -f egfsi3.tmp -cc trans \
	>        $@.1.tmp
	grep -E  "\?" $@.1.tmp > $@.rest.tmp || :
	grep -vE "\?" $@.1.tmp > $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfsi:
	grep -Ev "\?" egfsi4.tmp \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
egfu0: egfu1 egfu2 egfu3 egfu4
egfu1:
	grep -E "^\%[A-Za-z] A[0-9][0-9]* (Expansion of e|E)\.g\.f\.|InverseSeries|serreverse" $(COMMON)/jcat25.txt \
	| cut -b4- \
	| perl egfsi.pl \
	2>       $@.rest.tmp \
	| sed -e "s/\tegfsi/\tegfu/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfu2:
	grep -E "^A" egfum.man >> egfu1.tmp
	$(JPREP) -p RING.ttab -f egfu1.tmp -cc post1 \
	>        $@.1.tmp
	grep -E  "\?" $@.1.tmp > $@.rest.tmp || :
	grep -vE "\?" $@.1.tmp > $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfu3:
	perl ring_improve.pl egfu2.tmp \
	>        $@.tmp
	grep -E  "\?" $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfu4:
	$(JPREP) -p RING.ttab -f egfu3.tmp -cc trans \
	>        $@.1.tmp
	grep -E  "\?" $@.1.tmp > $@.rest.tmp || :
	grep -vE "\?" $@.1.tmp > $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
egfu:
	grep -Ev "\?" egfu4.tmp \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
egfsim: # simple e.g.f.s, manually, *.pl because of bracketing
	grep -E "^A[0-9]" $@.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
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
#----
lingf:
	uniq -w7 $(HOLREC)/lingf2.tmp \
	| sed -e "s/lingfo/lingf/" \
	| grep -vE "A055911" \
	> lingf.gen
lingf_offset:
	cp   lingf.gen lingf.gen.bak
	perl lingf_offset.pl lingf.gen > x.tmp
	cp   x.tmp     lingf.gen
	diff -w -C0 lingf.gen.bak lingf.gen || :
#----
tilegf:
	uniq -w7 $(COORS)/tilegf.tmp \
	| sed -e "s/lingfo/lingf/" \
	> tilegf.gen
#--------------------------------
# A176832 Sequence defined by the recurrence formula a(n+1)=sum(a(p)*a(n-p)+k,p=0..n)+l for n>=1, with here
# a(0)=1, a(1)=5, k=1 and l=-1.
# A176854 Sequence defined by the recurrence formula a(n+1)=sum(a(p)*a(n-p)+k,p=0..n)+l for n>=1, with here
# a(0)=1, a(1)=0, k=-1 and l=0.
choulet: choulet1 choulet2 choulet3
choulet1:
	perl -ne \
	'my $$line = $$_; if ($$line =~ m{^(A\d+)\s+Sequence defined by the recurrence formula a})'\
	'{ my $$aseqno = $$1;  '\
	'$$line =~ m{a\(0\)\s*\=\s*(\-?\d+)\s*\,\s*a\(1\)\s*\=\s*(\-?\d+)\s*\,\s*k\s*\=\s*(\-?\d+)\s*and\s*l\s*\=\s*(\-?\d+)};'\
	'my ($$a0, $$a1, $$k, $$l) = ($$1, $$2, $$3, $$4);'\
	'print join("\t", $$aseqno, "$@", 0, $$a0, $$a1, $$k, $$l) . "\n" }' \
	$(COMMON)/names \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
choulet2:
	make seq4 LIST=choulet1.tmp
	$(DBAT) "UPDATE seq4 s SET parm5 = (SELECT substr(d.data, 1, 32) FROM asdata d WHERE s.aseqno = d.aseqno)"
	$(DBAT) -x "SELECT aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5 \
	    FROM seq4 \
	    ORDER BY 1" \
		  > $@.tmp
	head -4 $@.tmp
	wc -l   $@.tmp
choulet3:
	perl choulet.pl choulet2.tmp | tee holos.gen
choulet_bf:
	$(JAVA) irvine.test.SequenceTest A176604 $(N) 0
#--------------------------------
# %F A008544 Conjecture: a(n) + (1-3*n)*a(n-1) + a(n-2) + (7-3*n)*a(n-3) = 0. - _R. J. Mathar_, Nov 14 2011
conjmath:
	perl -ne \
	'my $$line = $$_; if ($$line =~ m{^\%\w (A\d+)\s+Conjecture\:\s*([an0-9 \+\-\*\(\)\^\=]+)\.}) { '\
	'my ($$aseqno, $$re, $$date) = ($$1, $$2, "yyyy mm dd"); '\
	'if ($$line =~ m{Mathar\_?\,?\s*(\w+ \d+ \d+)}) { $$date = $$1; '\
	'$$re =~ s{ }{}g; $$re =~ s{\=}{\=\=}; $$re =~ s{a\(n([\+\-]\d+)?\)}{a\[n$$1\]}g; '\
	'print join("\t", $$aseqno, "$@", 0, $$date, $$re) . "\n" }}' \
	$(COMMON)/cat25.txt \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
conjmath2:
	$(DBAT) "SELECT s.aseqno, j.superclass \
	    FROM seq4 s, joeis j \
	    WHERE s.aseqno = j.aseqno \
	    ORDER BY 1" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
eulerixxx:
	echo "$(PER)" | tr , '\n' | $(JAVA) irvine.oeis.InverseEulerTransformSequence $(SKIP)
#--
euleri: # manual EulerInvTest
	$(JAVA) irvine.test.EulerTransformTest -v -p $(PER) -n $(NT)
#----
weighi:
	grep -E "^A" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
ieuler:
	# cp ieuler.man ieuler.gen
	find manual -iname "*.java" | xargs -l -innn \
	perl -i*.bak -e 'while (<>) { s{EulerTransformSequence}{EulerTransform}g; print; }' nnn
#----
INIT="1"
TYPE=2
euler: # manual EulerTest PER="1,0,1" INIT="1" NT=32 TYPE=2
	$(JAVA) irvine.test.EulerTransformTest -p $(PER) -s $(TYPE) -n $(NT) -i $(INIT)
#-----
eulerper2:
	grep "Euler transform of a period" jcat25.txt | grep -E "^%"
#----
eulerper0:
	perl eulerper.pl $(COMMON)/cat25.txt \
	  2>     $@.rest.tmp \
	>        $@.tmp
	sort     $@.tmp eulerper.man \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.rest*
	wc -l    $@.gen
eulerper:
	cp -v eulerper.man2 eulerper.gen
#--------------------------------
eulerx0: # grep cat25 - takes some time
	grep -E "Euler|partitions" $(COMMON)/cat25.txt \
	| perl eulerxfm.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	wc -l    $@.tmp $@.rest.tmp
eulerx: eulerx1 eulerx2 eulerx3
eulerx1: # append manual ones and uniq
	# grep -E "^A[0-9]" eulerxfm.man > $@.1.tmp
	sort     eulerx0.tmp \
	| uniq -w7 \
	>        $@.2.tmp
	head -n4 $@.2.tmp
	wc -l    $@.2.tmp
	make seq4 LIST=$@.2.tmp
	$(DBAT) "UPDATE seq4 s SET \
	  parm2 = (SELECT SUBSTR(data, 1, 64) FROM asdata d WHERE s.aseqno = d.aseqno) \
	, name  = (SELECT name                FROM asname n WHERE s.aseqno = n.aseqno) \
	;"
	$(DBAT) -4 seq4 | cut -b1-80
eulerx2:
	$(DBAT) -x -99999 seq4 \
	>        $@.1.tmp
	$(JAVA) irvine.test.EulerTransformTest -d $(D) -m 16 -f $@.1.tmp \
	>        $@.2.tmp \
	2>       $@.2.rest.tmp
eulerx3: # LIST= postprocess (seqtype, prefix, period)
	make eulerx4 LIST="eulerx2.2.tmp eulerxfm.man"
eulerx4:
	perl eulerxfm_post.pl $(LIST) \
	>        $@.1.tmp \
	2>       $@.1.rest.tmp
	sort     $@.1.tmp | uniq -w7 \
	>        $@.2.tmp
	head -n4 $@.2.tmp
	wc -l    $@.2.tmp
	wc -l    $@.*rest.*
eulerxfm:
	grep    "???" eulerx4.2.tmp || :
	grep -v "???" eulerx4.2.tmp > $@.gen || :
eulerxm:
	grep -E "^A[0-9]" eulerx.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
etman:
	grep -P "\tEuler"        iet.man \
	| perl -ne 'use strict; my $$line = $$_; '\
	' if ($$line =~ s{\A(A\d+)}{}) { my $$aseqno = $$1; my $$rseqno = "A000045"; '\
	' if ($$line =~ m{\b(A\d+)}  ) {    $$rseqno = $$1; }'\
	' print join("\t", $$aseqno, "$@", 0, $$rseqno) . "\n"; }' \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
ietman:
	grep -P "\tInverse Euler" iet.man \
	| perl -ne 'use strict; my $$line = $$_; '\
	' if ($$line =~ s{\A(A\d+)}{}) { my $$aseqno = $$1; my $$rseqno = "A000045"; '\
	' if ($$line =~ m{\b(A\d+)}  ) {    $$rseqno = $$1; }'\
	' print join("\t", $$aseqno, "$@", 0, $$rseqno) . "\n"; }' \
	| grep -vE "A000679|A029726|A094448|A116653" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
euguess_all: euguess0 euguess1 euguess2 euguess_check
euguess0: # aseqno, cc, ofs, keyw, data
	$(DBAT) -x "SELECT i.aseqno, 'euleri', 0, i.keyword, d.data \
	  FROM asinfo i, bfdata d \
	WHERE i.aseqno = d.aseqno \
	  AND i.keyword NOT LIKE '%base%' \
	  AND i.keyword NOT LIKE '%cons%' \
	  AND i.keyword NOT LIKE '%word%' \
	  AND i.keyword NOT LIKE '%dead%' \
	  AND i.keyword NOT LIKE '%,tab%' \
	  AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  AND LENGTH(d.data) >= 16 \
	ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
euguess1: # aseqno, "euleri", ofs, "nonn", prepend, termlist, "term"
	perl cut_prepend.pl euguess0.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
euguess2: # aseqno, "euleri"  , ofs, "nonn", prepend, termlist, "term"
	# ->    aseqno, "eulerixf", ofs, "nonn", prepend, invlist , "term"
	$(JAVA) irvine.test.EulerTransformTest -v -m 512 -d $(D) -f euguess1.tmp \
	| cut -f1- \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
euguess_check: # aseqno, "euleri" , ofs, "nonn", prepend, invlist  ,            "term"
	# ->         aseqno, "euguess", ofs, 3     , prepend, left-init, right-pad, "term"
	#            0       1          2    3       4        5
	perl -e 'print join("\t", "aseqno", "callcode", "ofs", "seqtype", "prepend", "left-init", "right-pad", "original terms", "term") . "\n";' \
	>        $@.txt
	sed -e "s/eulerixf/euguess/" -e "s/\tnonn\t/\t3\t/" euguess2.tmp \
	| perl find_period.pl -n 5 -d $(D) \
	>>       $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
	cp -v    $@.txt $(COMMON)
	cd $(COMMON) ; make -f checks.make -s html_check1 FILE=$@
	rm -vf $(COMMON)/$@.txt
etpart: # manually selected "Number of partition ... " with Indicatorsequence
	grep -E "^A" etpart.man > etpart.gen
	head -n4 $@.gen
	wc -l    $@.gen
euguess: #       aseqno, "euguess", ofs, "nonn", prepend, left-init, right-pad, "term"
	# ->         aseqno, "euguess", ofs, "nonn", prepend, left-init, right-pad, "term"
	perl eulerxfm_post.pl euguess_check.txt \
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc -l    $@.*
euguess_control:
	cut -f1-2 euguess.pass.log \
	>        $@.a.tmp
	make seq2 LIST=$@.a.tmp
	$(DBAT) "UPDATE seq4 s4 SET parm8 = 'pass', parm7 = (SELECT s2.info FROM seq2 s2 WHERE s2.aseqno = s4.aseqno);"
	cut -f1,3 euguess.fail.log \
	>        $@.b.tmp
	make seq2 LIST=$@.b.tmp
	$(DBAT) "UPDATE seq4 s4 SET parm8 = (SELECT s2.info FROM seq2 s2 WHERE s2.aseqno = s4.aseqno);"
euguess_show:
	$(DBAT) -x "SELECT aseqno, parm8, parm7, parm4, name FROM seq4 ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
euguess_sh2:
	grep -vE "^#" euguess_show.man \
	| grep -vE "FAIL" \
	| cut -b1-7 \
	>        $@.tmp
	wc -l    $@.tmp
	make seq LIST=$@.tmp
	make CC=euguess select
	$(DBAT) -v "DELETE FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM seq);"
euguman:
	$(DBAT) -x "SELECT s.aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 s, asinfo i \
	    WHERE s.aseqno = i.aseqno \
	      AND (s.aseqno NOT IN (SELECT aseqno FROM joeis)) \
	      AND i.keyword NOT LIKE '%dead%' \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
	  >      $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
euguman2:
	cp -v    $@.man $@.gen
eugpolym:
	cp -v    $@.man $@.gen
#--
euguess_short8: # remove all with numbers that are too big
	perl -ne 'print if ! m{\,\-?\d{8}};' euguess2.tmp \
	| sed -e "s/\tnonn\t/\t3\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--
eumapgf0: eumapgf1 eumapgf2
eumapgf1:
	make seq4 LIST=euguess2.tmp
	$(DBAT) "DELETE FROM seq WHERE aseqno IN (SELECT aseqno FROM joeis);"
	$(DBAT) -4 seq4
	$(DBAT) -n seq4
eumapgf2:
	$(DBAT) -x "SELECT aseqno, 'fractv', 0, parm2, parm3 FROM seq4 ORDER BY 1" \
	>        $@.1.tmp
	head -n4 $@.1.tmp
	wc   -l  $@.1.tmp
	perl $(COMMON)/callmaple.pl -t 4 -n 16 -p eumapgf.mpat $@.1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
eumapgf3:
	cat eumapgf2.tmp \
	| grep x | grep -E "\/" | grep -E "\, ogf" | grep -vE "hyperge|Error|\^\(" \
	| sed -e "s/eumapgf/fractv/" \
	| perl -ne 'use strict; s/\r?\n//; my ($$aseqno, $$callcode, $$offset1, $$parm1, $$parm2) = split(/\t/); '\
	' $$callcode =~ s/eumapgf/fractv/; $$parm2 =~ s/[\[\]]//g; $$parm2 =~ s/\, ogf//; '\
	' print join("\t", $$aseqno, $$callcode, $$offset1, $$parm2, $$parm1) . "\n";' \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
eumapgf4:
	$(PFRACT) -f eumapgf3.tmp \
	| perl -ne 's{fractv}{eumapgf}; s{\t\[}{\t\"\[}; s{\]\t}{\]\"\t}; s{\]\,\[}{\]\"\, \"\[}; s{\r}{}g; print;' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
eumapgf:
	grep -vE "A078463|A167991|A337080|A337244" eumapgf4.tmp > $@.gen
eumapgf5:
	grep -E "FATO|pass" eumapgf.all.log \
	>        $@.tmp
	make seq2 LIST=$@.tmp
#--------
moliena:
	# cp -v molien.man molien.save.man
	rm -f            molien.man
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A027672.gf
	perl gengf.pl -f molien.man -d 1 -r 3 $(CONTRIB)/A083024.gf
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A092069.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092070.gf
	perl gengf.pl -f molien.man -d 1 -r 2 $(CONTRIB)/A092071.gf
	perl gengf.pl -f molien.man -d 1 -r 6 $(CONTRIB)/A092072.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092201.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092203.gf
	perl gengf.pl -f molien.man -d 1 -r 2 $(CONTRIB)/A092354.gf
	perl gengf.pl -f molien.man -d 1 -r 6 $(CONTRIB)/A092355.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092496.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092497.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092544.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092545.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092546.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092547.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092548.gf
	perl gengf.pl -f molien.man -d 1 -r 8 $(CONTRIB)/A099595.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A099720.gf
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A099748.gf
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A099750.gf
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A099752.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A099757.gf
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A100023.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A100024.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A100025.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A105319.gf
	perl gengf.pl -f molien.man -d 1 -r 4 $(CONTRIB)/A144060.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A246983.gf
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A246984.gf
mol1:
	perl gengf.pl -f molien.man -d 1 -r 1 $(CONTRIB)/A092203.gf
molien:
	perl keep_last.pl $@.man \
	| grep -vE "x092203|A144060" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
moldiff:
	diff
#--------
etgeneric:
	grep -E "^A[0-9]" $@.man > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
etsmall1:
	perl grep_small.pl -n 5 euguess2.tmp \
	| cut -f1,6 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.info, n.name \
	  FROM seq2 s, asname n \
	  WHERE s.aseqno = n.aseqno \
	    AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
etlin0:
	$(DBAT) "SELECT i.aseqno, n.name \
	  FROM asinfo i, asname n \
	  WHERE n.name LIKE '%roduct%' \
	    AND i.aseqno = n.aseqno \
	    AND SUBSTR(i.author, 2, 6) = 'Vaclav' \
	  ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
#--------
etpsymm:
	cd $(ETA) ; make ecalc
	grep -E "p" $(ETA)/ecalc.tmp \
	| grep -vE "etproot" \
	| grep -vE "^A999999" \
	| grep -vE "unknown" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	make seq2 LIST=$(ETA)/ein1sk.tmp
etpsymm_eval: batch
	$(DBAT) -x "SELECT s4.aseqno, s4.callcode, s4.offset1, s4.parm1, s3.info, s4.parm4, s4.parm5, s4.parm6 FROM seq4 s4, seq3 s3 \
	  WHERE s3.aseqno = s4.aseqno \
	    AND s4.callcode LIKE '%' ORDER BY 1" \
	| grep -vE "eulerps|etpadd0" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
mckay0: mckay1 mckay2 mckay
mckay1:
	$(DBAT) -x "SELECT n.aseqno, 'mckay', a.offset1, b.bfimax - b.bfimin + 1, COALESCE(j.superclass, 'nyi') \
	  , a.terms, SUBSTR(n.name, 32) \
	  FROM asname n \
	  LEFT JOIN asinfo a ON n.aseqno = a.aseqno \
	  LEFT JOIN bfinfo b ON a.aseqno = b.aseqno \
	  LEFT JOIN joeis  j ON b.aseqno = j.aseqno \
	  WHERE n.name LIKE '%McKay%' \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mckay2:
	perl mckay_prep.pl mckay1.tmp \
	2>       $@.rest.tmp \
	| sort -k4n \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	cut -f5  $@.tmp | sort | uniq -c
mckay:
	cat mckay2.tmp \
	| perl -ne 'use strict; my ($$aseqno, $$callcode, @parms) = split(/\t/); '\
	' if ($$parms[1] =~ m{[A-K]}) { print; } '\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A003295	mckay	-1	1002	McKayThompsonSequence	1,-5,17,46,116,252,533,1034	11A for the Monster group with a(0) = -5.
mckay3: # merge with etpsymm
	cut -f1,5,7 mckay1.tmp \
	| perl -ne 'use strict; s{\s+\Z}{}; my ($$aseqno, $$superclass, $$code) = split(/\t/); '\
	' my $$add0 = 0; if ($$code =~ m{with\s+a\(0\)\s*\=\s*(\-?\d+)}) { $$add0 = $$1; } '\
	' $$code =~ s{\A(\w+).*}{$$1}; print join("\t", $$aseqno, $$superclass, "$$code,$$add0") . "\n";' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	cd $(COMMON) ; make seq3 LIST=$(HERE)/$@.tmp
mckay4: # already in jOEIS + additional ones by etpsymm
	$(DBAT) -x "SELECT t.aseqno, t.info, t.pattern, s.callcode, s.parm5, s.parm6 \
	  FROM seq3 t \
	  LEFT JOIN seq4 s ON s.aseqno = t.aseqno \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mckay5: # nyi and not in etpsymm
	grep -E "nyi" mckay4.tmp \
	| grep -vE "eulerps|etp" \
	| sed -e "s/\,0//" -e "s/\t/\tT/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mckay6: # McKayThompsonSequence and not in etpsymm
	grep -E "McKayThompsonSequence" mckay4.tmp \
	| grep -vE "eulerps|etp" \
	| sed -e "s/\,0//" -e "s/\t/\tT/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
mckay_java:
	perl mckay_tables.pl > McKayThompsonTables.java
	javac McKayThompsonTables.java
	mv McKayThompsonTables.class irvine/oeis
	java -cp . irvine.oeis.McKayThompsonTables
	cp -v McKayThompsonTables.java ../../src/irvine/oeis
mctest:
	$(JAVA) irvine.oeis.McKayThompsonSequence -d $(D)  -n $(NT) $(ARGS)
#--------
nest0:
	grep -E "a\(n\) *\= *A[0-9][0-9]*\(A[0-9]" $(COMMON)/jcat25.txt \
	| grep -P "\%[NFC]" \
	| cut -b4- | sed -e "s/ /\t/" -e "s/\. - _.*/\./" \
	| perl nest.pl \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
nest:
	cp -v nest0.tmp nest.gen
#--------
weylgr0:
	cat $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; if (m{reduced words of length n in the Weyl group ([ABD])_(\d+)}) { '\
	' my ($$group, $$grno) = ($$1, $$2); $$_ =~ m{\A(A\d+)}; my $$aseqno = $$1; '\
	' print join("\t", $$aseqno, "weylgr", 0, $$group, $$grno) . "\n"; } ' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
weylgr:
	cp -v weylgr0.tmp weylgr.gen
weyljo1:
	cut -b1-7 weylgr0.tmp \
	| perl -ne 's/\s+\Z//; print "../../../joeis/src/irvine/oeis/" . lc(substr($$_, 0, 4)) . "/$$_.java" . "\n";' \
	| xargs -l -innn grep -iHE "super\(" nnn 2>&1 \
	| sed -e "s/^grep: //" \
	| cut -b37- \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
weyljo2:
	sort weylgr0.tmp weyljo1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
weylgr1:
	$(DBAT) "SELECT n.aseqno, b.bfimax - b.bfimin + 1, COALESCE(j.superclass, 'not_in_joeis'), n.name \
	  FROM asname n \
	  LEFT JOIN bfinfo b on n.aseqno = b.aseqno \
	  LEFT JOIN joeis  j on b.aseqno = j.aseqno \
	  WHERE n.name LIKE '%Weyl group%' \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
symbol0:
	cat $(COMMON)/bfdata.txt \
	| perl -ne 'use strict; my $$line = $$_; s/\s+\Z//; my @fields = split(/\t/); '\
	' if ($$fields[2] =~ m{\A(0|1|\-1)(\,(0|1|\-1))*\Z}) { '\
	' print $$line; } ' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq LIST=$@.tmp
symbol1:
	$(DBAT) -x "SELECT s.aseqno, n.name \
	  FROM seq s, asname n \
	  WHERE s.aseqno = n.aseqno \
	    AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
	    AND n.name NOT LIKE 'allocated %' \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
evtlper0:
	cat $(COMMON)/bfdata.txt \
	| perl -ne 'use strict; s/\s+\Z//; my @fields = split(/\t/); if (scalar(@fields) >= 3) { '\
	' print join("\t", $$fields[0], "$@", 0, 3, $$fields[1], $$fields[2], "a", "b", "c") . "\n"; } ' \
	| perl find_repeat.pl -d $(D) 2>&1 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
evtlper1:
	make seq4 LIST=evtlper0.tmp
	$(DBAT) "SELECT s.aseqno, b.bfimax - b.bfimin + 1, s.parm4, s.parm3, COALESCE(j.superclass, 'not_in_joeis'), n.name \
	  FROM seq4 s \
	  LEFT JOIN asname n ON s.aseqno = n.aseqno \
	  LEFT JOIN bfinfo b on n.aseqno = b.aseqno \
	  LEFT JOIN joeis  j on b.aseqno = j.aseqno \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
evtlper2:
	grep "not_in_joeis" evtlper1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
evtlper:
#--------------------------------
# PaddingSequence
#--
pad_all: pad_prep \
	pad1for \
	pad1mma \
	pad1par \
	pad1sam \
	pad_post \
	padding
pad_prep:
	rm -vf pad1*.tmp
pad_post:
	sort  pad1*.tmp > $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, i.offset1, s.parm1, b.bfimax - b.bfimin + 1, d.data, n.name \
	  FROM seq4 s \
	  LEFT JOIN asinfo i ON s.aseqno = i.aseqno \
	  LEFT JOIN asname n ON i.aseqno = n.aseqno \
	  LEFT JOIN bfdata d ON n.aseqno = d.aseqno \
	  LEFT JOIN bfinfo b on d.aseqno = b.aseqno \
	  WHERE b.aseqno NOT IN (SELECT j.aseqno FROM joeis j) \
	  ORDER BY 1,2" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	cut -b1-7 $@.tmp | sort | uniq -c | grep -v " 1 " || :
#--
padding:
#	A173014	Right,{1},80,{7,0,3,4}
	perl padding_prep.pl pad_post.tmp \
	>        $@.tmp \
	2>       $@.rest.tmp
	sort     $@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
#----
pad1for:
	cat $(COMMON)/cat25.txt | grep -viE "(appears that|Conjecture)" \
	|   perl -ne 'use strict; if (m{\A...(A\d{6}) *a\(n\) *\=* *(\-?\d+) *for *n *(\>\=? *\-?\d+) *\.}) { '\
	' print join("\t", $$1,      "$@", 0, "=$$2 for $$3") . "\n"; } '\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
pad1sam:
	# a(n+5) = a(n).
	cat $(COMMON)/cat25.txt | grep -viE "(appears that|Conjecture)" \
	| perl -ne 'use strict; if (m{\A\%\w (A\d{6}) *a\(n *[\+\-] *(\d+)\) *\=* a\(n\) *\.}) { '\
	' print join("\t", $$1,      "$@", 0, "n+$$2=n") . "\n"; } '\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
pad1mma:
	# %t A235944 PadRight[{},120,{4,1,9,7,4,4,9,4,4,7,9,1}] (* _Harvey *)
	cat $(COMMON)/cat25.txt \
	| perl -ne 'use strict; if (m{\A\%t (A\d+)}) { my $$aseqno = $$1; '\
	' if (m{ Pad(Right|Left) *\[ *(\{ *[\}0-9][^\]]+)\]}) { '\
	' my ($$dir, $$pad) = ($$1, $$2); $$pad =~ s{ }{}g; if ($$pad !~ m{[\#\@\%A-Za-z]}) { '\
	' print join("\t", $$aseqno, "$@", 0, "$$dir,$$pad") . "\n"; }}} ' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
pad1par:
	# A088689 (PARI) a(n)=[0, 1, 1, 0, 2, 2][n%6+1] \\ _Charles
	cat $(COMMON)/cat25.txt \
	| perl -ne 'use strict; if (m{\A\%o (A\d+)}) { my $$aseqno = $$1; '\
	' if (m{\(PARI\) +a\(n\) *= *\[([^\]]*)\] *\[n *\% *(\d+) *\+ *1\] *[\;\\]}) { '\
	' my ($$pad, $$len) = ($$1, $$2); $$pad =~ s{ }{}g; if ($$pad !~ m{[\#\@\%]}) { '\
	' print join("\t", $$aseqno, "$@", 0, "$$pad") . "\n"; }}} ' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
fptest: # test of find_period.pl
	perl find_period.pl -d $(D) find_period.pl
#----
aliquot1:
	cat $(COMMON)/names \
	| perl -ne 'if (m{\A(A\d+) Aliquot sequence starting at (\d+)}) { '\
	' print join("\t", $$1, "aliquot", 0, $$2) . "\n"; } ' \
	| tee    $@.tmp
	wc -l    $@.tmp
aliquot2:
	cat $(COMMON)/names \
	| perl -ne 'if (m{\A(A\d+) Aliquot sequence starting at (\d+)}) { '\
	' print join("\t", $$1) . "\n"; } ' \
	>        $@.a.tmp
	wc -l    $@.a.tmp
	grep -Ef $@.a.tmp $(COMMON)/bfdata.txt \
	>        $@.tmp \
	2>       $@.rest.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	# | perl find_period.pl -n 2 \
	#
#----
period0:
	cat $(COMMON)/bfdata.txt \
	| perl find_period.pl -n 2 \
	>        $@.tmp \
	2>       $@.rest.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
period:
	cat period0.tmp \
	| perl -ne 'use strict; my @parms = split(/\t/); '\
	' print join("\t", $$parms[0], "padding", 0, $$parms[2], $$parms[3]) . "\n"; ' \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
period3:
	grep -E "^A[0-9]" period.control.man \
	| cut -b1-7 \
	>        $@.a.tmp
	grep -Ef $@.a.tmp period.clean.gen \
	>        $@.b.tmp
	make padding
	cat padding.gen >> $@.b.tmp
	wc -l    $@.b.tmp
	sort $@.b.tmp | uniq -w7 > $@.tmp
	wc -l    $@.tmp
period4:
	grep -vE "^A305493" period3.tmp \
	>        $@.gen
	wc -l    $@.gen
#--------------------------------
eulerix3:
	$(DBAT) -x -444444 seq4 > $@.tmp
	$(JAVA) irvine.test.EulerTransformTest -d $(D) -f $@.tmp \
	>        $@.gen
	grep -E "\?\?" $@.gen || :
	head -n4 $@.gen
	wc -l    $@.gen
#--------
eulercall:
	$(DBAT) -x "SELECT aseqno FROM joeis \
	  WHERE superclass LIKE 'EulerTr%' \
	  ORDER BY 1" \
	| perl -ne 'use strict; m{\A(A\d+)}; my $$aseqno = $$1; \
	  print "src/irvine/oeis/" . lc(substr($$aseqno, 0, 4)) . "/$$aseqno\n";' \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	cat $@.tmp | xargs -l -innn grep -HE '\@author| super' $(JOEIS)/nnn.java \
	| tee    $@.txt
	head -n4 $@.txt
#----
euler_old1:
	grep "EulerTransformSequence" $(COMMON)/joeis_names.txt \
	| sed -e "s/\r//" \
	| tee $@.tmp
euler_old2:
	cut -b1-7 euler_old1.tmp \
	| perl -ne 'print lc(substr($$_, 0, 4)) . "/" . $$_;' \
	| xargs -l -innn grep -iHE "  super|Generated " $(JOEIS)/src/irvine/oeis/nnn.java \
	| tee $@.tmp
#--
euleri_old1:
	grep "InverseEulerTransformSequence" $(COMMON)/joeis_names.txt \
	| sed -e "s/\r//" \
	| tee $@.tmp
euleri_old2:
	cut -b1-7 euleri_old1.tmp \
	| perl -ne 'print lc(substr($$_, 0, 4)) . "/" . $$_;' \
	| xargs -l -innn grep -iHE "  super|Generated " $(JOEIS)/src/irvine/oeis/nnn.java \
	| tee $@.tmp
#-----------------
euleras: # difficult initial terms
	perl -ne \
	'my $$line = $$_; if (($$line =~ m{Euler transform of (A\d+)}) and ($$line !~ m{Inverse Euler}i)) { '\
	'my ($$adepend) = ($$1); '\
	'if (1) {'\
	'$$line =~ m{^\%\w (A\d+)}; my $$aseqno = $$1;'\
	'print join("\t", $$aseqno, "$@", 0, lc(substr($$adepend, 0,4)), $$adepend) . "\n" }}' \
	$(COMMON)/cat25.txt \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
eulern: # EulerTransform; difficult initial terms
	grep -iE "Euler transform" $(COMMON)/cat25.txt | cut -b4- \
	| uniq -w7 \
	| perl eulern.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
eulerasinv: # about 24, with difficult initial terms
	perl -ne \
	'my $$line = $$_; if (($$line =~ m{Inverse Euler transform of (A\d+)}i)) { '\
	'my ($$adepend) = ($$1); '\
	'if (1) {'\
	'$$line =~ m{^\%\w (A\d+)}; my $$aseqno = $$1;'\
	'print join("\t", $$aseqno, "$@", 0, lc(substr($$adepend, 0,4)), $$adepend) . "\n" }}' \
	$(COMMON)/cat25.txt \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
eulerasi0:
	perl -ne \
	'my $$line = $$_; if (($$line =~ m{Inverse Euler transform of (A\d+)}i)) { '\
	'my ($$adepend) = ($$1); '\
	'if (1) {'\
	'$$line =~ m{^\%\w (A\d+)}; my $$aseqno = $$1;'\
	'print join("\t", $$aseqno, "$@", 0, lc(substr($$adepend, 0,4)), $$adepend) . "\n" }}' \
	$(COMMON)/cat25.txt \
	| uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
eulerasi:
	cp -v eulerasi0.tmp eulerasi.gen
euleras_dep:
	$(DBAT) "DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis);"
	$(DBAT) -x "SELECT aseqno, callcode, offset1, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 \
	    WHERE aseqno NOT IN (SELECT aseqno FROM joeis) \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
#--------------------------------
evconst: # 6 remaining
	perl evconst.pl \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
#--------------------------------
get1pseq: # Generalized Euler transform of 1/(1+x^k)^Aseqno
	cp -v $@.man $@.gen
	head -4 $@.gen
	wc -l   $@.gen
#--------------------------------
kblocks: # all done
	perl kblocks.pl \
	| tee   $(CC).gen
	wc -l   $(CC).gen
#----------------
# A008378	CoordinationSequ	Coordination sequence for D_10 lattice.	nonn,easy,	0..1000
# A008383	CoordinationSequ	Coordination sequence for A_4 lattice.	nonn,easy,	0..1000
# A008399	CoordinationSequ	Coordination sequence for E_6 lattice.	nonn,easy,	0..1000
# A008401	CoordinationSequ	Coordination sequence for {E_6}* lattice.	nonn,nice,	0..1000
# A008420	CoordinationSequ	Coordination sequence for 10-dimensional cubic lattice.	nonn,easy,	0..10000
# A008458	CoordinationSequ	Coordination sequence for hexagonal lattice.	nonn,easy,nice,changed,	0..1000
# A019557	Sequence	Coordination sequence for G_2 lattice.	nonn,easy,changed,synth	0..59
# A019558	Sequence	Coordination sequence for F_4 lattice.	nonn,easy,	0..10000
# A022154	LinearRecurrence	Coordination sequence for root lattice B_12.	nonn,easy,	0..1000
# A035471	LinearRecurrence	Coordination sequence for lattice D*_4 (with edges defined by l_1 norm = 1).	nonn,easy,changed,	0..1000
# A035748	HolonomicRecurre	Coordination sequence for C_11 lattice.	nonn,easy,	0..10000
# A126898	GeneratingFuncti	Coordination sequence for 8-dimensional cyclotomic lattice Z[zeta_15].	nonn,synth	0..27
latcoors0: # LatticeCoordinationSequence
	cat $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; s{\s+\Z}{}; my $$line = $$_; if ($$line =~ m{ lattice|diamond}) { $$line =~ s{[\{\}]}{}g; '\
	'if ($$line =~ m{\A(A\d+)\s+\w+\s+Coordination sequence for *(root )?(lattice |diamond structure )?([A-G][\*\^\+\_\d]+|hexagonal|\d+\-dimensional (cubic|cyclotomic.*))}) { '\
	'  my ($$aseqno, $$type) = ($$1, $$4); my $$order = 0; my $$zeta = ""; my $$code;'\
	'  if (0) {'\
	'  } elsif ($$type =~ m{hexagonal})                  { $$order = 2;   $$code = "A"; '\
	'  } elsif ($$type =~ m{(\d+)\-dimensional cubic})   { $$order = $$1; $$code = "Q"; '\
	'  } elsif ($$type =~ m{(\d+)\-dimensional cyclotomic\D*(\d+)}) { $$order = $$1; $$zeta = ", $$2"; $$code = "Z"; '\
	'  } elsif ($$type =~ m{[A-G][\*\^\+\_\d]*})         { $$type =~ m{(\d+)}; $$order = $$1; $$type =~ s{[\_\d]}{}g; $$code = $$type; '\
	'  } '\
	'  print join("\t", $$aseqno, "latcoors", 0, "$$code", $$order, $$zeta, $$type, $$line) . "\n" if ($$code ne "X"); '\
	'}} '\
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
latcoors:
	perl -ne 'print if m{\t(A|A\*|B|C|D|D\*|D\^\+|Q)\t}' latcoors0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
latcoas:
	perl -ne 'print if m{\tAs\t}'  latcoors0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
latcoa:
	perl -ne 'print if m{\tA\t}'   latcoors0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
latcob:
	perl -ne 'print if m{\tB\t}'   latcoors0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
latcod:
	perl -ne 'print if m{\tD\t}'   latcoors0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
latcoddp:
	perl -ne 'print if m{\tD\^}'   latcoors0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
latriang:
	cat $@.man | tee $@.gen
#----
list1:
	cp -v list1.man list1.gen
#----------------
loda:
	grep -P "\tloda\t" $(GITS)/OEIS-prog/maint/loda/compile_loda.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
logmod:
	head -n4 $@.gen
	wc -l    $@.gen
#----------------
linrec0: linrec1 linrec
linrec1:
	$(DBAT) -x "SELECT a.aseqno, 'linrec2', 0, i.signature, SUBSTR(d.data,1,256) \
		FROM  lrindx i, asinfo a, bfdata d \
		WHERE 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		  AND 'A' || i.seqno = a.aseqno \
		  AND 'A' || i.seqno = d.aseqno \
		  AND i.compsig  <> '88888888'  \
		  AND a.keyword      NOT LIKE '%dead%' \
		ORDER BY 1 " \
	| grep -vE "A289265" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
linrec:
	perl patch_parms.pl -a lrstrip -i $(INIT) linrec1.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#----
linmangf: # g.f.s in $(LINREC)/linrec.man -> lingf
	grep -E "^A[0-9]" $(LINREC)/linman.gen \
	| perl -ne 'if (length($$_) <= 1024) { print $$_; } else { print STDERR $$_; }'\
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc   -l  $@.gen
linman_old: # g.f.s in $(LINREC)/linrec.man -> holos
	grep -E "^A[0-9]" $(LINREC)/linman.gen \
	| perl -ne 'if (length($$_) <= 1024) { print $$_; } else { print STDERR $$_; }'\
	>        $@.gen \
	2>       $@.rest.tmp
	head -n4 $@.gen
	wc   -l  $@.gen
linall:
	make purge
	make CC=linman select gener
	make CC=holom  select gener
	make CC=man man dist testall log
#----
lrixall:
	$(DBAT) -x "SELECT DISTINCT 'A' || i.seqno \
		FROM  lrindx i, asinfo a \
		WHERE 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		  AND 'A' || i.seqno = a.aseqno \
		  AND i.compsig  <> '88888888'  \
		  AND a.keyword      NOT LIKE '%dead%' \
		ORDER BY 1 " \
	>     $@.tmp
	wc -l $@.tmp
	make lrgroup LIST=$@.tmp INIT=0
lrstart:
	make lrgroup LIST=err-04-11.log
lrgroup: # parameter LIST, INIT
	make seq # LIST
	$(DBAT) -x "SELECT s.aseqno, 'linrec2', 0, i.signature, d.data \
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
	# make run
#--------------------------
lrjoeis_test:
	$(DBAT) -x "SELECT j.aseqno \
		FROM joeis j \
		WHERE j.superclass = 'LinearRecurrence' \
		ORDER BY 1" \
	>        group.tmp
	wc -l    group.tmp
	make strip
#--------------------------------
gen_mmac:
	# Caution, change .man -> .tmp next time!
	head -n$(MANY) $(LINREC)/mmac_err02.man \
	| perl patch_parms.pl -d $(D) \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	perl gen_pattern.pl -n $(COMMON)/names $@.tmp
#--------------------------------
# A030801 [ exp(17/24)*n! ].
# A030802 a(n) = floor( exp(13/24)*n! ).
# A030810 Floor(exp(19/23) * n!).
flexfact: # all done
	grep -E "^%[NF]" $(COMMON)/jcat25.txt \
	| perl -ne \
	'if (m{^(A\d+)\s+\[\s*exp\((\d+)\/(\d+)\)\s*\*\s*n\s*\!\s*\]}) { print join("\t", $$1, "$@", 0, $$2, $$3) . "\n" }' \
	>        $@.tmp
	grep -E "^%[NF]" $(COMMON)/jcat25.txt \
	| perl -ne \
	'if (m{^(A\d+)\s+(a\(n\)\s*\=\s*)?[fF]loor\s*\(\s*exp\(\s*(\d+)\/(\d+)\)\s*\*\s*n\!\s*\)}) { print join("\t", $$1, "$@", 0, $$3, $$4) . "\n" }' \
	>>       $@.tmp
	sort     $@.tmp | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#-------------------
# A095140 null    Triangle formed by reading Pascal's triangle (A007318) mod 5.
# A126058 null    Exponents p of the Mersenne primes 2^p - 1 (see A000043) read mod 18.   nonn,more,synth 1..47
# A126812 null    Ramanujan numbers (A000594) read mod 4. nonn,   1..65537
moderiv: # names: Annnnnn a(n) = (\d+)*n^(\d+) mod (\d+)
	grep -E "^%[NF]" $(COMMON)/jcat25.txt \
	| perl -ne 'my ($$aseqno, $$dummy, $$name, @rest) = split(/\t/, $$_); '\
	'$$name =~ s{Pascal.s triangle}{A007318}; '\
	'$$name =~ s{(A\d{6})}{\($$1\)}g; '\
	'if ($$name =~ m{ }) { '\
	'if ($$name =~ m{\D mod (\d+)\.}) { my $$mod = $$1; '\
	'if ($$name =~ m{(A\d{6})}) { my $$rseqno = $$1; '\
	'  print join("\t", $$aseqno, "$@", 0, $$rseqno, $$mod, $$name) . "\n"; '\
	'}}}' \
	>        $@.tmp
	# 0123456789012
	# %F A123456 a(n) =
	grep -E "^%F" $(COMMON)/cat25.txt \
	| perl -ne 'my $$aseqno = substr($$_, 3, 7); my $$name = substr($$_, 11); '\
	'if ($$name =~ m{\= *(A\d{6})\(n\) +mod +(\d+)\.}) { my $$rseqno = $$1; my $$mod = $$2; '\
	'  print join("\t", $$aseqno, "$@", 0, $$rseqno, $$mod, "\%F $$name") . "\n"; '\
	'}' \
	>>       $@.tmp
	sort $@.tmp | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#-------------------
# A109718 Periodic sequence with period {0,1,0,3}, or n^3 mod 4.
# A109720 Periodic sequence {0,1,1,1,1,1,1} or n^6 mod 7.
# A109753 n^3 mod 8; the periodic sequence {0,1,0,3,0,5,0,7}.
# A159852 n^2 mod 60.
# A167129 n^7 mod 21.
# A167166 a(n) = n^7 mod 16.
# all done
modpow: # names: Annnnnn a(n) = (\d+)*n^(\d+) mod (\d+)
	grep -E "^%[NF]" $(COMMON)/jcat25.txt \
	| perl -ne \
	'if (m{[^\(a-z]n\^(\d+) mod (\d+)(.)}) { '\
	'if ($$3 ne "^") { '\
	'print join("\t", substr($$_, 3, 7), "$@", 0, $$1, $$2, $$3) . "\n"; }}' \
	| uniq -w 7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#-------------------
# A036160	null	3^n mod 223.	nonn,easy,synth	1
# A036161	null	a(n) = 2^n mod 227.	nonn,easy,changed,	1
modpow2: # names: Annnnnn [a(n) = ](\d+)^n mod (\d+)
	# all done
	grep -E "^%[NF]" $(COMMON)/jcat25.txt \
	| perl -ne \
	' if (m{\A.. (A\d+)\s+(a\(n\)\s*\=\s*)?(\d+)\^n\s+mod\s+(\d+)([^\.]*)\.}) {'\
	' my ($$aseqno, $$base, $$mod, $$rest) = ($$1, $$3, $$4, $$5); $$rest =~ s{\s}{}g;'\
	' if ($$rest eq "" or $$rest eq "^n") {'\
	' print join("\t", $$aseqno, ($$rest eq "" ? "modpow2" : "modpow3"), 0, $$base, $$mod) . "\n"; }}' \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#-------------------
jasinski:
	$(DBAT) "SELECT n.aseqno, b.bfimin || '..' || b.bfimax, n.name FROM asname n, asinfo i, bfinfo b \
	  WHERE n.aseqno = i.aseqno \
	    AND i.aseqno = b.aseqno \
	    AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
	    AND i.author LIKE '%Jasinski%' \
	    ORDER BY 1" \
	| tee $@.tmp
	wc -l    $@.tmp
	# head -n4 $@.tmp
nthprime:
	# perl -ne 'my @parts = split(/\t/); print if $$parts[3] ne ""; ' $@.man
	perl $@.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
nthprime2:
	$(DBAT) -x "SELECT n.aseqno, 'nthprime', 1, '', '', '', '', n.name, a.keyword, b.tail, b.bfimax \
	FROM  asinfo a, asname n, bfinfo b \
	WHERE a.aseqno = n.aseqno \
	  AND a.aseqno = b.aseqno \
	  AND a.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  AND n.name LIKE '%-th prime%' \
	ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" > $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#--------------------------
palb: # 54
	perl -ne \
	'if (m{^(A\d+)\s+.*palindrom(es|ic)\s+in\s+base\s+(\d+)}) { print join("\t", $$1, "$@", 1, $$3) . "\n" }' \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
parshift0: # Paradigm Shift
	grep -f parshift.grep $(COMMON)/jcat25.txt \
	| grep -E "^[\%\#]F" | grep -P "a\(n\) *\= *\d" | sed -e "s/Recursive\: *//" -e "s/ all / /" \
	| tee $@.tmp
parshift:
	perl parshift.pl parshift0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
partion0:
	$(DBAT) -x "SELECT n.aseqno, '$@', 0, '', SUBSTR(a.author,2,4), n.name, b.bfimax \
	FROM  asinfo a, asname n, bfinfo b \
	WHERE a.aseqno = n.aseqno \
	  AND a.aseqno = b.aseqno \
	  AND a.aseqno NOT IN (SELECT aseqno FROM joeis) \
	  AND n.name LIKE 'Number of partitions %' \
	ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
	| sed -e "s/Number of partitions //" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
partion1:
	cut -b1-7 partion0.tmp \
	| sed -e "s/^/\^/" \
	>        $@.a.tmp
	grep -Ef $@.a.tmp euguess2.tmp \
	| sed -e "s/eulerixf/partion1/" \
	>        $@.b.tmp
	sort partion0.tmp partion1.b.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
partion:
	head -n4 $@.gen
	wc -l    $@.gen
#----
# A035534 Number of partitions of n with equal number of parts congruent to each of 0 and 1 (mod 3)
partcond:
	grep -E "Number of partitions " $(COMMON)/joeis_names.txt \
	| perl partcond.pl -cc partcond \
	>        $@.gen \
	2>       $@.rest.tmp
	perl -e 'print join("\t", "A097242", "partcapp", 0, "A161039", "2") . "\n"; ' >> $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
partcapp: partcond
	grep partcapp partcond.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# | grep A161026 \
	#
partcap1:
	grep "#"  partcapp.gen | cut -b3- | sed -e "s/partcapp/partcap1/" \
	| tee    $@.tmp
#--------------------------
partmod11:
	cp -v partmod11.man partmod11.gen
#--------------------------
partprod: # partprod from ./robot
	sort $(ROBOT)/$@.gen | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
partprom: # manual partprod
	sort $@.man | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
partsumm: # manual partsum
	sort $@.man | uniq -w7 > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
partsum2:
	grep -iP "partials? sums? of A\d+" $(COMMON)/jcat25.txt | grep -E "^%[NFCY]" | cut -b4- | sort | uniq -w7 \
	| perl -ne 'use strict; if (m{\A(A\d+) +Partials? sums? of (A\d+)}) { '\
	' print join("\t", $$1, "partsum2", 1, $$2, "") . "\n"; }'\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
# PL's PartitionTransform
partran0: # select those pairs where the finding does not occur too often
	make seq4 LIST=$(PL)/ptsr_join.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset1, s.parm1, i.author, n.name \
	  FROM seq4 s, asinfo i, asname n \
	  WHERE s.aseqno = i.aseqno \
	    AND i.aseqno = n.aseqno \
	    ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--
partran: # PartitionSTransformTriagle from some generator sequence
	cp -v partran0.tmp $@.gen
	# cat A180177.man >> $@.gen
partram: # manual ones
	cat partran.man >> $@.gen
partrapl:
	grep -vE "A31920" $(CONTRIB)/pl/check_extract.tmp > $@.gen
#--
partralr: # check the ones with ls != 1(,1)+ and rs == 1(,1)+
	grep -P "\tName\t" $(TRIREC)/modlr.tmp \
	| sed -e "s/Name/partralr/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
partrarl: # check the ones with ls == 1(,1)+ and rs != 1(,1)+ and transpose them
	grep -P "\tName\t" $(TRIREC)/modrl.tmp \
	| sed -e "s/Name/partrarl/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
partralr_eval:
	grep FATAL partralr.fail.log | cut -b1-7 \
	| sed -e "s/^/\^/" \
	| tee    $@.1.tmp
	grep -E --file=$@.1.tmp $(TRIREC)/modlr.tmp | grep -E "LeftSide|Name" \
	| perl -pe "s/^[^\:]:\://" \
	>        $@.2.tmp
	perl partra_join.pl -lr -md $@.2.tmp \
	| tee    $@.tmp
	wc -l    $@.tmp
#--------------------------
polyn0:
	cat $(COMMON)/jcat25.txt \
	| perl -ne \
	'if (! m{\.\.\.} and m{\A\%[NF] (A\d{6}\s+\w\(([a-z])\)\s*\=\s*[ \d\+\-\*\/\!ank\[\]\{\}\(\)\^]+)\.})'\
	'{ print "$$1\n"; }' \
	| sed -e "s/ /\t/" -e "s/ //g" -e "y/[]{}/()()/" \
	| grep -v '\.\.' \
	>        $@.tmp
	head -n2 $@.tmp
	wc   -l  $@.tmp
polyn:
	cp -v polyn0.tmp $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
#-------------------
power: # names: Annnnnn a(n) = (\d+)*n^(\d+) +- (\d+)
	perl -ne 'print if m{\AA\d+\s+a\(n\)\s*\=\s*\d+\*?n\^\d+\s*(\-|\+)\s*\d+[\.\s]*\Z}i' \
	$(COMMON)/names \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
# A158627 a(n) = 484*n^2-22.
# A158643 a(n) = 676*n^2 + 26.
# A158644 a(n) = 52*n^2 + 1.
# A158645 a(n) = 729*n^2 + 27.
# A158646 a(n) = 54*n^2 + 1.
#-------------------
primen0: # Numbers derived from primes
	grep -iE "prime|square|cube" $(COMMON)/joeis_names.txt \
	| perl primen.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp
primen1:
	$(JPREP) -p Z.ttab -f primen0.tmp -cc postrans \
	>        $@.1.tmp
	grep -E  "\?" $@.1.tmp > $@.rest.tmp || :
	grep -vE "\?" $@.1.tmp > $@.tmp || :
	head -n4 $@.tmp
	wc -l    $@*.tmp
primen:
	grep -E "^A[0-9]+" primen1.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#-------------------
# Binary quadratic forms - Wiki has 695
qfb: qfb0
qfb0:
	wget https://oeis.org/wiki/Binary_Quadratic_Forms_and_OEIS?action=raw -O $@.raw.tmp
qfb1:
	cat qfb0.raw.tmp | perl -ne 'use strict; foreach my $$aseqno (m{(A\d{6})}g) { print "$$aseqno\n"; } '\
	| sort | uniq \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------------
# A272999 %t Select[Range[0, 100000], PrimeQ[ (85*10^# + 473)/9 ] &]
# A272999 Numbers k such that (11*10^k + 49)/3 is prime.
pfprime:
	perl -ne \
	's/ /\t/; '\
	'if (m{^(A\d{6})\t(Numbers|Integers) \w such that[^\(\d]*\(?(\d+)\s*\*\s*(\d+)\^\w\s*([\+\-0-9 ]+)\)?\s*(\/\s*(\d+))? is (a )?prime\.}) {'\
	' my ($$aseqno, $$num, $$base, $$add, $$div) = ($$1, $$3, $$4, $$5, $$7); '\
	' $$add =~ s{ }{}g; if (length($$div) == 0) { $$div = 1; } '\
	' print join("\t", $$aseqno, "$@", 0, 0, $$num, $$base, $$add, $$div) . "\n" }' \
	$(COMMON)/names \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
	# A101001 Indices of primes in sequence defined by A(0) = 91, A(n) = 10*A(n-1) + 11 for n > 0.
	# => Numbers n such that (830*10^n - 11)/9 is prime
	perl -ne \
	's/ /\t/; '\
	'if (m{^(A\d{6})\tIndices of primes in sequence defined by'\
	' A\(\d\)\s*\=\s*(\d+)\,\s*A\(\w\)\s*\=\s*(\d+)\*A\(n\s*\-\s*\w\)\s*([\+\-0-9 ]+)\s*for}) {'\
	' my ($$aseqno, $$num, $$base, $$add, $$div) = ($$1, $$2, $$3, $$4, 9); '\
	' $$add =~ s{ }{}g; $$num = $$num * $$div + $$add; $$add = -$$add; '\
	' print join("\t", $$aseqno, "$@", 0, 0, $$num, $$base, $$add, $$div) . "\n" }' \
	$(COMMON)/names \
	>>       $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
	sort     $@.tmp \
	| grep -vE "A098466|A098467" \
	>        $@.gen
#--
pfprime99:
	make seq4 LIST=$(CC).gen
	$(DBAT) "UPDATE seq4 s SET PARM1 = \
	    (SELECT SUBSTR(data, 1, INSTR(data, ',') - 1) FROM asdata d WHERE d.aseqno = s.aseqno)"
	$(DBAT) "UPDATE seq4 s SET PARM5 = 1 WHERE PARM5 = 0"
	$(DBAT) -x "SELECT * FROM seq4 \
	    ORDER BY aseqno" \
	>        $@.gen
	# WHERE PARM1 < 10 AND PARM2 < 1000
pfprimex:
	cp pfprime.gen pfprime.tmp
	perl -pe 's{^(A032373|A050413|A050544|A050847|A050885|A056245|A056248|A056258|A059454'\
	'|A101001|A101003|A101722|A101732|A101734|A259137|A259138|A281063|A295399|A293592|A322935)}{\# $$1};' \
	pfprime.tmp > pfprime.gen
#-------------------
prilist:
	grep -E "(Numbers|Integers)" $(COMMON)/joeis_names.txt \
	| grep -E 'ers [a-z] (such that|for which) ' \
	| grep -P 'are +(all +)?prime' \
	| grep -P "\tnyi" \
	>        $@.tmp
	perl prilist.pl $@.tmp \
	2>       $@.rest.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
prilistm:
	cp -v prilist.man $@.gen
	head -n4 $@.gen
	wc -l    $@.*
#----
EE=
prisub:
	grep -E "(Numbers|Integers)" $(COMMON)/joeis_names.txt \
	| grep -E 'ers [a-z] (such that|for which) ' \
	| grep -E 'is (a )?prime' \
	| grep -v PowerFactorPrime \
	>        $@.tmp
	perl prisub.pl $(EE) $@.tmp \
	2>       $@.rest.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
prisuba:
	grep $@ prisub.gen \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
#--
primof:
	grep -E "Primes of (the )?form " $(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	perl prisub.pl $(EE) $@.tmp \
	2>       $@.rest.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
anumof:
	make cat_names GREP="[0-9][0-9] a\([i-n]\) *\= *" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	perl prisub.pl $(EE) anumof.tmp \
	2>       $@.rest.tmp \
	| grep -v anumofa \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--
proprep:
	cut -f4-5  $@.gen | sort | uniq -c | sort -r > $@.sort.tmp
	head -n4   $@.sort.tmp
	cut -f5    $@.gen | sort | uniq -c | sort -r | grep -v " 1 " | tee $@.code.tmp
#----
somos0:
	grep -E "^\%[NF]" $(COMMON)/jcat25.txt | grep -P "\ba\(\w[^\)]*\) *([\*\/] *a\(|\^[\d\*\/\^\+\-\(\) ]+a\()" \
	| grep -viP "(sum|prime|that|smallest|least|digit|lim|Expansion|Conjecture|triangle|concatenate|sqrt|a\(n\) *\>\=)" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
somos1:
	grep -E "^\%[NFCO]" $(COMMON)/jcat25.txt | grep -P "a\(n[\+\-\d]+\)|\A\%O" \
	| grep -vEi "sum|prod|divi|digit" \
	| perl oshrink.pl \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
cordrec_prep:
	perl cordrec_prep.pl -A  somos1.tmp 2> $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	cut -f6  $@.rest.tmp | sort | uniq -c
	wc -l    $@.tmp $@.rest.tmp
cordrec:
	perl cordrec.pl -A cordrec_prep.tmp 2> $@.rest.tmp \
	| sort | uniq -w7 \
	>        $@.gen
	#
	wc -l    $@.gen $@.rest.tmp
	# make overwrite SRC=$@.man TAR=$@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest.tmp
somos2:
	perl somos_grep.pl -A somos1.tmp    2> $@.rest.tmp \
	| sort | uniq -w7 > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*tmp
somos3:
	grep -E "^A[0-9]" somos2.tmp > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
somos4:
	grep -E "^A[0-9]" somos.man | grep -P "somos4" > $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "UPDATE seq4 s SET parm2 = (SELECT SUBSTR(data, 1, 64) FROM asdata d WHERE d.aseqno = s.aseqno);"
	$(DBAT) -x -444444 seq4 > $@.tmp
	perl somos_inits.pl       $@.tmp > $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
cordrectab0:
	perl cordrec_prep.pl -A $(HOLREC)/cordrectab.tmp 2> cordrectab.rest.tmp \
	>        cordrectab.tmp
	head -n4 cordrectab.tmp
	wc -l    cordrectab.tmp cordrectab.rest.tmp
	cut -f6  cordrectab.rest.tmp | sort | uniq -c
	#
	perl cordrec.pl -A cordrectab.tmp 2> cordrectab.rest2.tmp \
	| sort | uniq -w7 \
	>        cordrectab.gen
	head -n4 cordrectab.gen
	wc -l    cordrectab.gen cordrectab.rest*.tmp
cordrectab:
	cat cordrectab.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen $@.rest*.tmp
#----------------
suchprim:
	grep Numbers $(COMMON)/joeis_names.txt | grep -E 'ers [a-z] such *that' | grep -E 'is (a )?prime' \
	| grep -v "PowerFactorPrimeSequence" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	perl suchprim.pl $@.tmp \
	2>       $@.rest.tmp \
	| grep -E  "suchpr" \
	| grep -vE "xxsuchprk|xxsuchprik" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  suchp*.*
	cut -f2  $@.gen | sort | uniq -c
suchrep99:
	grep -E "[Rr]epunit|R_n|R_k" suchprim.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
suckrep99:
	perl -ne 'print if m{such that (the string )?[kn]\d+ is prime};' suchprim.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
dummy36:
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
#----
primodsol:
	grep -P "Primes p such that x\^\d *= *\d has (a|no) solution mod p" $(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------
tupfact:
	cp -v tupfact.man tupfact.gen
#--------------------------
# A117807 Start with 1015 and repeatedly reverse the digits and add 4 to get the next term.
radd:
	perl -ne 'if (m{\A(A\d+) Start with (\d+) and repeatedly reverse the digits and add (\d+) to get the next}) {'\
	' print join("\t", $$1, "radd", 0, 10, $$2, $$3) . "\n"; }' $(COMMON)/names \
	>        $@.gen
	cat radd.man >> $@.gen # binary ...
	head -n4 $@.gen
	wc -l    $@.gen
#--
radd0: # get the RADD sequences from the Wiki page
	wget "https://oeis.org/wiki/Sequences_of_RADD_type?action=raw" -O $@.raw
#   1   3   1      3   A118517
#   1   4   1     54   A117828 See A117830, A117827 for cycle
	make radd
radd_wiki: # too few seqs.
	perl -ne 'if (m{\A\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(A\d{6})}) {'\
	' print join("\t", $$5, "radd", 0, $$1, $$2, $$3, $$4, 10) . "\n"; }' radd0.raw \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
subsele: # A047161 null Number of nonempty subsets of {1,2,...,n} in which exactly 1/3 of the elements are <= n/2.	nonn,changed,	1..1000	nyi
	grep -E "in which exactly [0-9][0-9]*\/" $(COMMON)/joeis_names.txt \
	>        $@.tmp
	perl subsele.pl $@.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
sumdig: # sum of digits in various bases
	grep -vE "^#" sumdig.man > sumdig.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
sum0:
	grep -P "^\%o" $(COMMON)/jcat25.txt | grep -E "[s]um\(" | grep -E "\(PARI\)" | cut -b4- \
	| sed -e "s/ *(PARI) */\tsum\t0\t/" -e "s/\/\*.*//" \
	| grep -P "\= *sum" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sumdiv0:
	grep -E "^\%o" $(COMMON)/jcat25.txt | grep -E "[ns]umdiv\(" | grep -E "\(PARI\)" | cut -b4- \
	| sed -e "s/ (PARI) /\tsumdiv\t0\t/" -e "s/\/\*.*//" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	#-e "s/\\\\.*//" \
	#
sumdiv1:
	perl $@.pl sumdiv0.tmp \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
sumdiv2:
	grep -v "#" sumdiv2.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
sumdiv3:
	grep -v "#" sumdiv3.man \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
numdiv:
	perl numdiv.pl $(COMMON)/joeis_names.txt \
	| sort -n -k4 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
numdiv_test:
	$(JAVA) irvine.oeis.a030.A030515 $(K)
sumform:
	grep "Number of divisors" $(COMMON)/joeis_names.txt \
	| perl -ne 'if (m{Number of divisors of (\d+)\*n([\+\-]\d) of form (\d+)\*[a-z]([\+\-]\d+)\.}) {'\
	' print join("\t", substr($$_, 0, 7), "parm5", 1, "A359212", $$1, $$2, $$3, $$4) ."\n"; }'\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------
# Sums of like powers
sumlipo: sumlipo_extract sumlipo_load sumlipo_unload sumlipo_wiki
sumlipo_extract:
	grep -E "[Ss]ums? " $(COMMON)/joeis_names.txt \
	| grep -viE "A004018|arra(y|ngement)|base|composite|decimal|digit|differ|divi(ding|sible|sor)|egyptian|factor|fibon" \
	| grep -viE "(hex|hept|pent)agonal|matri|necklace|nonsquare"\
	| grep -viE "permut|prime|pyramidal|ratio|reciproc|squarefree|triangular|Young" \
	| perl sumlipo.pl \
	2>       $@.rest.tmp \
	| grep -vE "A000534" \
	| sort -k2 \
	>        $@.tmp
	head -n4 $@.tmp
	sort $@.rest.tmp > $@.rest
	wc -l    $@.rest
	wc   -l  $@.tmp
	cut -f2  $@.tmp | sort | uniq -c
sumlipo_load: # load extracted parameters into seq4
	grep -hE "^A[0-9]" sumlipo_extract.tmp sumlipo.man | sort  | uniq > $@.1.tmp
	make seq4 LIST=$@.1.tmp
	$(DBAT) -f sql/sumlipo.sql
	$(DBAT) -f sql/sumliv.create.sql
sumlipo_unload:
	$(DBAT) -44444 sumliv \
	>        sumlipo.gen
	wc -l    sumlipo.gen
#--
sumlipo.diff:
	cut -b1-7 sumlipo.gen > d1.tmp
	cut -b1-7 sumpow.gen  > d2.tmp
	diff -wy --width=32 --suppress-common-lines d1.tmp d2.tmp
	rm -v d1.tmp d2.tmp
sumlipo_wiki:
	perl wiki_tabs.pl -e $(EL) -d $(D) sumlipo.witab \
	>        sumlipo.wiki
#----
sumway: # Numbers that are the sum of 2 nonzero squares in exactly 1 way.
	cat $(COMMON)/joeis_names.txt \
	| grep -E "sum of " | grep way \
	| perl sumlipo.pl \
	| sort -k4n -k5n -k6n -k7n -k8 -k9n \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
sumway.dupl.check:
	cut -f4-9 sumway.gen | sort | uniq -c \
	| grep -vE "^  *1  *" || :
sumwan.check:
	cut   -b1-7 sumway.gen | sed -e "s/\r//" > $@.1.tmp
	grep -E "Number of ways of writing n as (the |a )sum of " $(COMMON)/names \
	| grep -vf $@.1.tmp \
	| cut -b1-120 \
	| tee    $@.tmp
sumwi:
	$(DBAT) "\
	| tee    $@.tmp
#-----
alter1: # load A-numbers from Sean's spreadsheet
	perl extract_aseqnos.pl alter1.tsv \
	| sort > $@.1.tmp
	wc -l    $@.1.tmp
	cut -f1  $@.1.tmp \
	| sort | uniq \
	>        $@.tmp
	make seq LIST=$@.tmp
alter1_check: # compare against seq4
	$(DBAT) "SELECT s.aseqno, n.name FROM seq s, asname n \
	  WHERE s.aseqno = n.aseqno \
	    AND s.aseqno NOT IN (SELECT aseqno FROM seq4) \
	  ORDER BY 1;"
alter2_check: # joeis against seq4
	$(DBAT) "SELECT j.aseqno, n.name FROM joeis j, asname n \
	  WHERE j.aseqno = n.aseqno \
	    AND j.superclass IN ('LimitedSumOfLikePowersSequence','SumOfLikePowersSequence') \
	    AND j.aseqno NOT IN (SELECT aseqno FROM seq4) \
	  ORDER BY 1;"
wiki_check: # load A-numbers from generated sumlipo.wiki -> seq2
	perl extract_aseqnos.pl sumlipo.wiki \
	| sort > $@.1.tmp
	wc -l    $@.1.tmp
	uniq -c  $@.1.tmp | grep -v " 1 " || :
	cut -f1  $@.1.tmp \
	| sort | uniq \
	>        $@.tmp
	make seq2 LIST=$@.tmp
wiki_rest:
	$(DBAT) "SELECT s.aseqno, s.callcode \
	    , s.pow || ' ' || s.mult || ' ' || s.mquant || ' ' || s.least || ' ' || s.dist || ' ' || s.ways || ' ' || s.wquant \
	    , s4.parm8, n.name FROM sumliv s, seq4 s4, asname n \
	  WHERE s.aseqno = n.aseqno \
	    AND s.aseqno = s4.aseqno \
	    AND s.aseqno NOT IN (SELECT aseqno FROM seq2) \
	  ORDER BY 1;" \
	| tee    $@.tmp
	wc -l    $@.tmp
wiki_stat:
	$(DBAT) -x "SELECT 'total extracted: ', COUNT(*) FROM sumliv s                                                "
	$(DBAT) -x "SELECT 'present in Wiki: ', COUNT(*) FROM sumliv s WHERE s.aseqno     IN (SELECT aseqno FROM seq2)"
	$(DBAT) -x "SELECT 'missing in Wiki: ', COUNT(*) FROM sumliv s WHERE s.aseqno NOT IN (SELECT aseqno FROM seq2)"
#----
# A003325	Sequence	Numbers that are the sum of 2 positive cubes.	nonn,easy,nice,changed,	1..20000
# A003327	A003338	Numbers that are the sum of 4 positive cubes in 1 or more way.	nonn,	1..1000
# A003328	A003339	Numbers that are the sum of 5 positive cubes.	nonn,	1..1000
sumpow0_not_used: #
	cat $(COMMON)/joeis_names.txt \
	| perl -ne \
	'm{\A(A\d+)}; my $$aseqno = $$1; if ($$aseqno ge "A003325" and $$aseqno le "A003399") { '\
	'  print join("\t", $$aseqno, "sumpow", 0) . "\n";}' \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
sumpow:
	# =====> don't forget copys
	cat sumpow.man \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#	| grep -vE "^(A0004(04|08|14)|A003072|A0033|A0048[0-1][0-9]|A00482[0-3]|A047700)" \
#
sumpow.min0:
	cp -v $@.man $@.gen
#--------
# A037121	null	Trajectory of 3 under map n -> 47n+1 if n odd, n->n/2 if n even.	nonn,synth	0..20	nyi
# A037122	null	Trajectory of 3 under map n->49n+1 if n odd, n->n/2 if n even	nonn,synth	0..24	nyi
trajen:
	cp -v parm3.jpat $@.jpat
	grep -E "Trajectory of " $(COMMON)/joeis_names.txt | grep -P " if n odd\, n *\-\> *n\/2 if n even" \
	| perl -ne 'use strict; my @p = split(/\t/); $$p[2] =~ m{(\d+) under (the )?map \w *\-\> *(\d+)}; '\
	' my ($$start, $$factor) = ($$1, $$3); print join("\t", $$p[0], "$@", 0, "A033962", $$start, $$factor, $$p[2]) . "\n";'\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
valuation:
	grep -E "^\%[NFC]" $(COMMON)/jcat25.txt | grep -E "[^e]valuation" | cut -b4- | sed -e "s/ /\t/" \
	| perl valuation.pl \
	2>       $@.rest.tmp \
	| cat - valuation.man \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
valupari:
	grep -E "^\%[o]" $(COMMON)/jcat25.txt | grep -E "valuation" | cut -b4- | sed -e "s/ /\t/" \
	| perl valuation.pl \
	2>       $@.rest.tmp \
	| sort | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
#================================
old_one_time_patchs:
	cat sumpow.man \
	| grep -E  "^A0033(40|41|42|43|44|45|46)" \
	| cut -b1-7 \
	| xargs -l -innn make pat1 ASEQNO=nnn
pat1:
	perl -ne 's/\s+\Z//; my $$line = $$_; '\
	'if ($$line =~ m{\A(\s+)for \(int k([3-9a-c]) \= 1\;}) {'\
	'  my ($$indent, $$ind) = ($$1, $$2); $$ind =~ s{([a-c])}{"1" . (ord($$1) - ord("a"))}e; '\
	'  my $$im1 = $$ind - 1; my $$im2 = $$im1 - 1;'\
	'  $$line =~ s{ 1\;}{ k$$im1;};'\
	'  print $$indent . "final Z z$$im1 = z$$im2.add(pow(k$$im1));\n";'\
	'} '\
	'print "$$line\n";' \
	$(A).java > temp/$(A).java
#----
sublatin:
	cp -v sublatin.man sublatin.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
sumwiki0: # fetch Index Section Su from OEIS Wiki
	wget "https://oeis.org/w/index.php?title=Index_to_OEIS:_Section_Su&section=7&action=raw" -O - >  $@.raw.tmp
	wget "https://oeis.org/w/index.php?title=Index_to_OEIS:_Section_Su&section=8&action=raw" -O - >> $@.raw.tmp
sumwiki: # extract all uniq A-numbers and sort them
	cat sumwiki0.raw.tmp | perl -ne 'use strict; foreach my $$aseqno (m{(A\d{6})}g) '\
	'{ print join("\t", $$aseqno, "$@", 0) . "\n"; } '\
	| sort | uniq \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
sumwiki1: # attach names and load them in db-table suw4
	make CC=sumwiki select EX=XX
	perl -ne 's{\t\t+}{\t}; print;' sumwiki.gen > $@.tmp
	sed -e "s/seq4/suw4/g" sql/seq4.create.sql > sql/suw4.create.sql
	$(DBAT) -f sql/suw4.create.sql
	cat sumwiki.gen | grep -E "^A" | sort | uniq > suw4.tmp
	$(DBAT) -m csv -r suw4 < suw4.tmp
	$(DBAT) -4 suw4
	$(DBAT) -n suw4
sumwiki2: # determine which are not yet covered by sumlipo (first "make CC=sumlipo select")
	$(DBAT) -x "SELECT w.aseqno, w.name \
	  FROM suw4 w \
	  WHERE w.aseqno NOT IN (SELECT aseqno FROM seq4) \
	  ORDER BY 1" \
	>        $@.tmp
	wc -l    $@.tmp
#--------------------------
traits:
	ls -al traits.*
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
	$(DBAT) -x "SELECT a.aseqno, 'not-in-joeis', d.data, '# ' || a.termno || ' ' || n.name \
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
#----
fininof_check: # Sequences with keywords "fini", but no "full"
	$(DBAT) "SELECT i.aseqno, j.superclass, i.termno, n.name \
	    FROM  asinfo i, asname n \
	    LEFT JOIN joeis j ON n.aseqno = j.aseqno \
	    WHERE i.aseqno = n.aseqno \
	      AND i.keyword     LIKE '%fini%' \
	      AND i.keyword NOT LIKE '%full%' \
	    ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
	cp -v    $@.txt $(COMMON)
	cd $(COMMON) ; make html_checks
	rm -vf $(COMMON)/$@.txt
#----
finibf_check: # Sequences with keywords "fini,full", but full terms are in b-file only
	$(DBAT) -x "SELECT i.aseqno, j.superclass, i.termno, b.bfimax - b.bfimin + 1 \
	    FROM  asinfo i \
	    LEFT JOIN bfinfo b ON i.aseqno = b.aseqno \
	    LEFT JOIN joeis  j ON b.aseqno = j.aseqno \
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
#--------------------------------
unsigned: unsigned1 unsigned2
	sort unsigned2.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
unsigned1:
	grep -E "^.[NCFY]" $(COMMON)/jcat25.txt | grep -Ei "unsigned" \
	| perl unsigned.pl \
	2>       $@.rest.tmp \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.*tmp
unsigned2:
	make seq4 LIST=unsigned1.tmp
	$(DBAT) -x "SELECT s.aseqno, 'unsigned', 0, s.parm1 \
	    , CASE WHEN i.keyword LIKE 'sign' THEN 'sign' ELSE 'nonn' END \
	    , s.parm2 \
	    FROM seq4 s, asinfo i \
	    WHERE s.aseqno = i.aseqno \
	      AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
	      AND s.parm1      IN (SELECT aseqno FROM joeis) \
	    ORDER BY 1" \
	>        $@.tmp
	# the other way around
	$(DBAT) -x "SELECT s.parm1, 'unsigned', 0, s.aseqno \
	    , CASE WHEN i.keyword LIKE 'sign' THEN 'sign' ELSE 'nonn' END \
	    , s.parm2 \
	    FROM seq4 s, asinfo i \
	    WHERE s.parm1 = i.aseqno \
	      AND s.parm1  NOT IN (SELECT aseqno FROM joeis) \
	      AND s.aseqno     IN (SELECT aseqno FROM joeis) \
	    ORDER BY 1" \
	>>       $@.tmp
#--------------------------------
uvpoly: # in ./ck, A208510 ff.
	sort $(CK)/$@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
uvpolx: # in ./ck, A208510 ff.
	sort $(CK)/$@.tmp | uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
weight_check:
	grep "Weight distr" $(COMMON)/names \
	| sed -e "s/ /\tweight\t0\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "SELECT s.aseqno, s.parm1, i.termno, i.keyword, i.author \
		FROM  seq4 s, asinfo i \
		WHERE s.aseqno NOT IN (SELECT aseqno FROM JOEIS) \
		  AND s.aseqno = i.aseqno \
		ORDER BY 1" \
	>        $@.txt
	head -n4 $@.txt
	wc   -l  $@.txt
	cp -v    $@.txt $(COMMON)/$@.txt
	cd $(COMMON) ; make html_checks
	rm -v    $(COMMON)/$@.txt
weight2:
	$(DBAT) "SELECT j.aseqno, j.superclass \
		FROM  seq2 s, joeis j \
		WHERE s.aseqno = j.aseqno \
		ORDER BY 1" \
	>       $@.j.txt
	wc   -l $@.j.txt
#--------------------------------
wroot:
	grep -E "^A[0-9]" $(WEIDIS)/wroot.tmp \
	| grep -vE "A109160" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
	# | grep -vE "A109479|A109481|A109483" \
	#
#--------------------------------
word:
	$(DBAT) "SELECT i.aseqno, 'word', 0, COALESCE(j.superclass, '********'), n.name, b.bfimax-b.bfimin + 1 \
		FROM  asinfo i, asname n, bfinfo b LEFT JOIN joeis j ON b.aseqno = j.aseqno \
		WHERE i.aseqno = n.aseqno \
		  AND n.aseqno = b.aseqno \
		  AND i.keyword     LIKE '%word%' \
		  AND i.keyword NOT LIKE '%dead%' \
		ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
#================================
seqix:
	$(DBAT) -f sql/seqix.create.sql
	seq 1 64 | $(DBAT) -r seqix
	$(DBAT) -4 seqix
seq: # parameter: $(LIST)
	$(DBAT) -f $(COMMON)/seq.create.sql
	cut -b1-7 $(LIST) | grep -E "^A" | $(DBAT) -m csv -r seq
	$(DBAT) -n seq
seq2: # parameter: $(LIST)
	$(DBAT) -f $(COMMON)/seq2.create.sql
	cat $(LIST) | grep -E "^[A-Za-z]" | sort | uniq > seq2.tmp
	$(DBAT) -m csv -r seq2 < seq2.tmp
	$(DBAT) -4 seq2
	$(DBAT) -n seq2
seq3: # parameter: $(LIST)
	$(DBAT) -f $(COMMON)/seq3.create.sql
	cat $(LIST) | grep -E "^A" | cut -f1-3 | sort | uniq > seq3.tmp
	$(DBAT) -m csv -r seq3 < seq3.tmp
	$(DBAT) -4 seq3
	$(DBAT) -n seq3
seq4: # parameter: $(LIST) with aseqno, offset1, parm1, parm2, parm3, parm4, name
	$(DBAT) -f sql/seq4.create.sql
	cat $(LIST) | grep -E "^A" | sort | uniq -w7 > seq4.tmp
	$(DBAT) -m csv -r seq4 < seq4.tmp
	# $(DBAT) -4 seq4
	# $(DBAT) -n seq4
delseq: seq # parameters: $(TAB) $(LIST)
	$(DBAT) -v "DELETE FROM $(TAB) WHERE aseqno IN (SELECT aseqno FROM seq)"
#----
cat_names: # GREP=
	grep -P "$(GREP)" $(COMMON)/cat25.txt \
	| perl -ne 'if (m{\A\%(\w) (\w+) (.*)}) { print join("\t", $$2, $$1, $$3) . "\n"; }'
#--------
njoeis: # LIST
	make seq
	$(DBAT) -x "SELECT COUNT(aseqno) FROM seq \
	WHERE aseqno NOT IN (SELECT aseqno FROM joeis)"
	$(DBAT) -x "SELECT j.aseqno, j.superclass FROM seq s, joeis j \
	WHERE s.aseqno = j.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
joeis2: # LIST
	make seq2
	$(DBAT) -x "SELECT s.aseqno, s.info FROM seq2 s \
	WHERE s.aseqno NOT IN (SELECT j.aseqno FROM joeis j) ORDER BY 1" \
	>        n$@.tmp
	head -n4 n$@.tmp
	wc -l    n$@.tmp
	$(DBAT) -x "SELECT j.aseqno, j.superclass, s.info FROM seq2 s, joeis j \
	WHERE s.aseqno = j.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#--------------------------
manual_check:
	find manual -iname "A??????.java" -printf "%f\t%T+\n" | perl -pe 's{\.java}{}; s{\+.*}{}; '\
	>        $@.tmp
	head -n4 $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) "SELECT s.aseqno, s.info, COALESCE(j.superclass, 'nyi') AS superclass, n.name \
	  FROM seq2 s, asname n LEFT JOIN joeis j ON n.aseqno = j.aseqno \
	  WHERE s.aseqno = n.aseqno \
	  ORDER BY 2" \
	| tee    $@.tmp
	wc -l    $@.tmp
manual_joeis: sumall manual_check # CC= prematurely update table joeis with new classes
	$(DBAT) "INSERT INTO joeis (SELECT aseqno, $(CC), 'new', SUBSTR($(CC),1,6), 'gfis' FROM seq2)"
#----
DIR=mangf
mangf_check: # DIR=
	find $(DIR) -iname "A??????.java" -printf "%f\t%T+\n" | perl -pe 's{\.java}{}; s{\+.*}{}; '\
	>        $@.tmp
	head -n4 $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.info, COALESCE(j.superclass, 'nyi') AS nyi, n.name \
	  FROM seq2 s, asname n LEFT JOIN joeis j ON n.aseqno = j.aseqno \
	  WHERE s.aseqno = n.aseqno \
	  ORDER BY 2" \
	| sort \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
	grep -P "\tnyi\t" $@.txt || :
	grep -P "\tnyi\t" $@.txt | wc
mangf_retest:
	cut -f1 mangf_check.txt | grep -E "^A[0-9][0-9]" \
	| xargs -l -innn cp -v mangf/nnn.java manual
	make CC=man purge man distel
#----
packlist_check:
	rm -f $@.tmp
	ls -tcl ../../pack*.lst | cut -b44- \
	| xargs -innn make -s packlist_check1 FILE=nnn \
	| tee -a $@.tmp
packlist_check1:
	cat $(FILE) | perl -ne 'm{\/(A\d+)}; print "$$1\n"; ' | sort | uniq > $@.tmp
	make seq LIST=$@.tmp
	echo ====$(FILE)====
	ls -al $(FILE)
	$(DBAT) -x "SELECT aseqno FROM seq WHERE aseqno NOT IN (SELECT aseqno FROM joeis) ORDER BY 1;"
#--------------------------
analog: analog1 anasort anaprep anaload anastret anastren
analog1:
	perl normalize_name.pl $(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
anasort:
	sed -e "s/\t/\#/g" analog1.tmp \
	| sort --field-separator="#" -k4,4 -k3,3 -k1,1 -k5,5 \
	| sed -e "s/\#/\t/g" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
anaprep:
	perl stretchable.pl anasort.tmp \
	>        $@.tmp
	grep -v "cellular automaton" $@.tmp \
	>        $@.txt || :
	head -n4 $@.txt
	wc   -l  $@.txt
	grep    "cellular automaton" $@.tmp \
	>        $@.ca.txt || :
	wc   -l  $@.ca.txt
anaload:
	make seq4 LIST=anaprep.txt
	$(DBAT) "UPDATE seq4 s \
	  SET s.parm4 = SUBSTR(COALESCE((SELECT h.matrix FROm holref h WHERE s.callcode = h.aseqno), ''), 1, 1024) \
	  ,   s.parm5 = SUBSTR(COALESCE((SELECT h.init   FROm holref h WHERE s.callcode = h.aseqno), ''), 1, 128 ) \
	;"
anastret:
	$(DBAT) -x "SELECT * FROM seq4 ORDER BY 6,4,5" \
	>        $@.txt
	head -n4 $@.txt
	wc   -l  $@.txt
anastren: # only the ones from anastret that contain no "Annnnnn"
	grep -v "Annnnnn" anastret.txt \
	>        $@.txt || :
	head -n4 $@.txt
	wc   -l  $@.txt
#--
analog4:
	make seq4 LIST=analog1.tmp
	$(DBAT) -n seq4
	$(DBAT) -4 seq4
analogx:
	$(DBAT) -x "SELECT b.aseqno, a.aseqno, a.callcode, b.name\
		FROM seq4 a, seq4 b \
		WHERE a.name = b.name  \
		  AND substr(b.callcode, 1, 2) =  'ZZ' \
		  AND substr(a.callcode, 1, 2) <> 'ZZ' \
		  AND a.aseqno < b.aseqno \
		  ORDER BY b.name, b.aseqno "
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
anadel1:
	# does not work
	$(DBAT) -x "DELETE   FROM seq4   WHERE SUBSTR(  callcode, 1, 2) =  'ZZ' AND NOT EXISTS \
	    (SELECT b.aseqno FROM seq4 b WHERE SUBSTR(b.callcode, 1, 2) <> 'ZZ' AND name = b.name)"
analog2:
	$(DBAT) -x "SELECT aseqno FROM joeis WHERE superclass <> 'LinearRecurrence'" \
	| sed -e "s/\r//" > joeis_impl.txt
	grep -f joeis_impl.txt $(COMMON)/names \
	| perl normalize_name.pl \
	| sed -e "s/ / +j+ /" > $@.tmp
analog3:
	sort -k3 -k2 -k1 -t "	" analog1.tmp analog2.tmp \
	      >  @.txt
	head -n4 $@.txt
	wc -l    $@.txt
analog5:
	perl get_stretchables.pl analog3.txt \
	>        $@.txt
	head -n4 $@.txt
	wc   -l  $@.txt
#================
# Clark Kimberling's sequences
cklist:
	cd ck; make $@
intin:
	cd ck; make $@
philo1:
	cd $(CONTRIB)/ck ; make philo1
	cat $(CONTRIB)/ck/philo1.tmp \
	| tee    $@.gen
	wc -l    $@.gen
#================
# Chapoton
chapoton:
	$(DBAT) "SELECT i.aseqno, SUBSTR(COALESCE(j.superclass, 'null'), 1, 8), n.name, i.author \
		FROM asinfo i, asname n LEFT JOIN joeis j on n.aseqno = j.aseqno \
		WHERE i.aseqno = n.aseqno \
		  AND i.author LIKE '%Chapoton%' \
		  ORDER BY 1;" \
	| tee $@.tmp
#-------
s1:
	cp ../../src/irvine/oeis/recur/GeneralRecurrence.jav 	$(JOEIS)/src/irvine/oeis/recur
s2:
	cp ../../src/irvine/oeis/triangle/BaseTriangle.jav 		$(JOEIS)/src/irvine/oeis/triangle
s3:
	scp ../../src/irvine/test/HolonomicRecurrenceTest.java 	gf:~/work/gits/joeis/src/irvine/test
s4:
	scp ../../internal/irvine/oeis/RecurrenceReflector.java	gf:~/work/gits/joeis/internal/irvine/oeis/
