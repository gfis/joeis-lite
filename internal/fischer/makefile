#!make

# Makefile in gits/joeis-lite/internal/fischer: sequence generation and testing
# @(#) $Id$
# 2019-07-15: joeis parallel to joeis-lite
# 2019-05-20, Georg Fischer: copied from makefile
#
GITS=../../..
LITE=$(GITS)/joeis-lite
JOEIS=$(GITS)/joeis
COMMON=$(GITS)/OEIS-mat/common
CONTRIB=$(GITS)/OEIS-mat/contrib
LINREC=$(GITS)/OEIS-mat/linrec
HOLREC=$(GITS)/OEIS-mat/holrec
TRIREC=$(GITS)/OEIS-mat/trirec
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
RAMATH=java -cp $(GITS)/ramath/dist/ramath.jar org.teherba.ramath
MAXT=32
HOLT=java   -cp $(GITS)/ramath/dist/ramath.jar irvine.test.HolonomicRecurrenceTest
MANY=999999
D=0
TO=4
GU=0
N=1000
NUM=999
NT=32
SC=222221210100
NC=
OFS=1
WITHB=-b $(COMMON)/bfile -t $(TO)
JOPT=-Doeis.big-factor-limit=1000000000 -Xmx4g
ifeq ($(OS),Windows_NT)
    CPS=;
else
    CPS=:
endif
JAVA=java $(JOPT) -cp "$(LITE)/dist/joeis-lite.jar$(CPS)$(JOEIS)/build.tmp/joeis.jar"
BATLIT=$(JAVA) irvine.test.BatchTest -v $(WITHB) -d $(D) -u $(GU)
INIT=0
START=`grep -E "^A" batch.log | tail -n1 | cut -b1-7`
REMOTE=gfis@atair:~/work/gits/joeis-lite/internal/fischer
#----------------

all:
	# Possible targets:
	grep -E "^[a-z]" makefile
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
raupdate:
	cp -v ../../../ramath/src/main/java/irvine/oeis/HolonomicRecurrence.java     ../../src/irvine/oeis
	cp -v ../../../ramath/src/main/java/irvine/test/HolonomicRecurrenceTest.java ../../src/irvine/test
update: purge
	cd ../.. ; find src | xargs -l -i{} cp -pv ../../gitups/joeis/{} {}
count:
	find ../../src -iname "A??????.java" | wc -l
list:
	find ../../src -iname "A??????.java" -ls
pack:
	cd ../.. ; find src -iname "A??????.java" > pack.$(CC).lst \
	; wc -l                                     pack.$(CC).lst \
	; find internal/fischer/$(CC).*.log      >> pack.$(CC).lst \
	; echo src/irvine/oeis/$(CLASS).java     >> pack.$(CC).lst \
	; echo internal/fischer/$(CC).gen        >> pack.$(CC).lst \
	; echo internal/fischer/$(CC).jpat       >> pack.$(CC).lst
	cd ../.. ; tar --files-from=pack.$(CC).lst -cvzf $(CC).`date +%Y-%m-%d.%H`.tgz \
	| perl -pe "s{\/A\S*}{}" | uniq -c
rename:
	echo cfs*.jpat | xargs -l \
	  perl -i.bak -pe "s{ContinuedFractionOfSqrt([^S])}{ContinuedFractionOfSqrtSequence$1}g;"
#==========================
remove: # parameter: CC
	rm -f remlist.tmp
	perl -ne 'm{^A(\d\d\d)(\d+)}; print "a$$1/A$$1$$2.java\n";' $(CC).gen > remlist.tmp
	cat remlist.tmp | xargs -l -i{} rm  -f ../../target/WEB-INF/classes/irvine/oeis/{}
	cat remlist.tmp | xargs -l -i{} rm -vf                    ../../src/irvine/oeis/{}
OFS=offset
#--------
ccall: select clean purge gener dist test pack
# parameter: CC
#----
NOT=NOT
select: select1 select2 # parameter: CC, OFS
select1:
	make $(CC)
	head -4 $(CC).gen
	wc -l   $(CC).gen
EX=
select2:
	make seq4 LIST=$(CC).gen
	$(DBAT) "UPDATE seq4 s \
		SET name    = (SELECT a.name    FROM asname a WHERE s.aseqno = a.aseqno) \
	    ,   offset  = (SELECT a.offset1 FROM asinfo a WHERE s.aseqno = a.aseqno)"
	$(DBAT) -x "SELECT aseqno, callcode, $(OFS), parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 \
	    WHERE aseqno NOT IN (SELECT CONCAT('$(EX)', aseqno) FROM joeis) \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
	# $(DBAT) -x "SELECT COUNT(aseqno) FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM joeis)"
clean: purge # parameter: CC; $(CC).fail.log from previous test is stripped off $(CC).gen
	wc -l $(CC).gen
	cut -b1-7 $(CC).fail.log > clean.tmp
	grep -vf clean.tmp $(CC).gen > $(CC).tmp
	cp -v $(CC).tmp $(CC).gen
	wc -l $(CC).gen
dirty:
	wc -l $(CC).gen
	cp    $(CC).gen $(CC).old.tmp
	cut -b1-7 $(CC).pass.log > dirty.tmp
	grep -vf dirty.tmp $(CC).gen > $(CC).tmp
	cp -v $(CC).tmp $(CC).gen
	wc -l $(CC).gen
purge: # remove all oeis/annn directories
	rm -rf  ../../target/WEB-INF/classes/irvine/oeis/a???
	rm -rf                     ../../src/irvine/oeis/a???
	rm -vf *.bak
gener: # parameter: CC, MANY, NC; test sequences in $(CC).gen
	head -n$(MANY) $(CC).gen      > ghead.tmp
	perl gen_seq4.pl -d $(D) $(NC)  ghead.tmp
dist:
	cd ../.. ; ant -silent dist
test: # parameter: CC
	rm -f batch.log
	head -n$(MANY) $(CC).gen      > ghead.tmp
	make stripgr LIST=ghead.tmp
	make runbt
	make evaluate
testex: # parameter: CC; test all existing (generated) sequences
	rm -f batch.log
	find ../../src -iname "A??????.java" -printf "%f\n" | cut -b1-7 \
	| head -n$(MANY) > ghead.tmp
	make stripgr  LIST=ghead.tmp
	make runbt
	make evaluate
log: # generate an HTML page for the failed tests
	cd $(COMMON); make -f checks.make joeis_check LOG=$(CC)
retest: # run the failed ones again (with a higher timeout)
	cut -b1-7 $(CC).fail.log > failed.tmp
	grep -f failed.tmp $(CC).gen > $(CC).gen.fail.tmp
	make stripgr LIST=$(CC).gen.fail.tmp
	$(BATLIT)  strip.tmp 2>&1 | tee batch.log
	grep  pass batch.log >>    $(CC).pass.log
	grep  FA   batch.log | tee $(CC).fail.log
stripgr: # attach terms from 'stripped' to A-numbers for BatchTest
	cut -b1-7  $(LIST) > aseqnos.tmp
	grep -f    aseqnos.tmp $(COMMON)/stripped \
	| head -n$(MANY) > strip.tmp
	wc -l      strip.tmp
runbt: # Run BatchTest for this group
	$(BATLIT)  strip.tmp 2>&1 | tee -a batch.log
evaluate:
	grep  pass batch.log >     $(CC).pass.log
	grep  FAIL batch.log | tee $(CC).fail.log
	wc -l $(CC).*.log
bfile:
	echo make bfile SEQ=123456 N=1000 OFS=1
	grep -E "^A$(SEQ)" $(COMMON)/names \
	| sed -e "s/A$(SEQ)/\#/" \
	>  $(CONTRIB)/b$(SEQ).txt
	java -jar ../../dist/joeis-lite.jar A$(SEQ) $(N) $(OFS) \
	| grep -vi java \
	| sed -e "s/Generated by jOEIS/Generated by Georg Fischer with jOEIS/" \
	>> $(CONTRIB)/b$(SEQ).txt
	head -n 8 $(CONTRIB)/b$(SEQ).txt
	tail -n 4 $(CONTRIB)/b$(SEQ).txt
joeins:
	$(DBAT) -v "INSERT INTO joeis (SELECT aseqno, 'HolonomicRec', 'new' FROM seq4);"
seqtest:
	$(JAVA) irvine.test.SequenceTest $(ASEQNO) $(N) $(OFFSET)
#=========================================================
bas:
	make bas_all TARGET=gener
	cat $@?*.gen > $@.gen
	make dist
	make test CC=$@
	make pack CC=$@
bas_sel:
	make bas_all TARGET=select
	cat bas*.gen > basall.gen
bas_gen:
	make bas_all TARGET=gener
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
	>   $@.tmp
	perl -ne \
	'if (m{^(A\d+)\s+(Integers|Numbers) ([nk] )?(that|which) contain (exactly one|a single) (\d+) in base (\d+)})'\
	'{ print join("\t", $$1, "$@", 0, 1, $$7, $$6, 1) . "\n" }' \
	$(COMMON)/names \
	>>   $@.tmp
	perl -ne \
	'if (m{^(A\d+)\s+(Integers|Numbers) ([nk] )?(that|which) contain (exactly one|a single) (\d+)\.})'\
	'{ print join("\t", $$1, "$@", 0, 1, 10, $$6, 1) . "\n" }' \
	$(COMMON)/names \
	>>    $@.tmp
	sort  $@.tmp \
	| sed -e "s/A043489\t$@\t0\t1/A043489\t$@\t0\t0/" \
	> $@.gen
	# A043489 exceoptionally starts with 0
	head -4 $@.gen
	wc -l   $@.gen
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
	>>  $@.gen
	cat $@.gen
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
	>>  $@.gen
	cat $@.gen
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
	wc -l $@.gen
#---
# A043555 Number of runs in base-3 representation of n.	nonn,base,easy,	0..1000
basrun:
	perl -ne \
	'if (m{^(A\d+)\s+Number of runs in base.(\d+) representation of [nk]})'\
	'{ print join("\t", $$1, "$@", 0, $$2) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	cat $@.gen
#----
# A043569 Numbers n such that base 2 representation has exactly 2 runs.	nonn,base,	1..10000
basruneq:
	perl -ne \
	'if (m{^(A\d+)\s+Numbers [nk] (such that|whose) (the )?base.(\d+) representation has exactly (\d+) runs})'\
	'{ print join("\t", $$1, "$@", 0, $$4, $$5) . "\n" }' \
	$(COMMON)/names \
	| grep -vE "A043569|A043570|A043638|A043675" \
	> $@.gen
	wc -l $@.gen
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
	> $@.gen
	cat $@.gen
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
	> $@.gen
	cat $@.gen
#--------------------------
carule0:
	perl -ne 'if ((m{cellular automat}) and (m{Rule (\d+)})) { print; }' \
	$(COMMON)/jnames.txt \
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
#-----------
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

conc0:
	perl -ne \
	'if (m{concaten}) { print; }' \
	$(COMMON)/names \
	>     $@.tmp
	wc -l $@.tmp
concprod:
	perl -n concprod.pl \
	$(COMMON)/names \
	>     $@.gen
	wc -l $@.gen
concprod2:
	perl -ne \
	's{Numbers \w such that }{}; '\
	'if (m{^(A\d+)\s+(the concatenation of \w with [\w\+\-\*\d]{3}|\w concatenated with [\w\+\-\*\d]{3}|the square of \w|\w times [\w\+\-\*\d]{3}) (gives|is) '\
	'(the concatenation of two numbers \w and [\w\+\-\*\d]{3}|the product of two numbers which differ by \d+|a square)})'\
	'{ my ($$aseqno, @both) = ($$1, $$2, $$4); '\
	'  my ($$left, $$right) = map { s{times}{\*}; s{concatenated with}{\/\/}; '\
	'  s{the concatenation of (\w) with ([\w\+\-\*\d]{3})}{$$1 \/\/ ($$2)};'\
	'  s{(\w) concatenated with ([\w\+\-\*\d]{3})}{$$1 \/\/ ($$2)};'\
	'  s{the concatenation of two numbers (\w) and ([\w\+\-\*\d]{3})}{$$1 \/\/ ($$2)};'\
	'  s{the product of two numbers which differ by (\d+)}{m \* (m\+$$1)};'\
	'  s{the square of (\w)}{$$1 * $$1}; s{a square}{n * n};'\
	'  $$_} @both;'\
	'  $$left =~ s{[a-z]}{k}g; $$right =~ s{[a-z]}{m}g;'\
	'  print join("\t", $$aseqno, "$@", 0, $$left, " ; $$right") . "\n"; }' \
	$(COMMON)/names \
	>     $@.gen
	wc -l $@.gen
#----------
mma_uniqc:
	cut -b1-10 $(COMMON)/cat25.txt | grep -E "^%t" | uniq -c | grep " 1 " | cut -b 12-18 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#	      2 %t A000001
mma_single:
	grep -E "^%t" $(COMMON)/cat25.txt \
	| perl mma_single.pl \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
mma_joeis:
	make seq2 LIST=mma_single.tmp
	$(DBAT) "SELECT m.aseqno, SUBSTR(j.superclass, 1, 3), m.info FROM seq2 m LEFT JOIN joeis j ON m.aseqno = j.aseqno \
		ORDER BY 3" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#--------
# %F A238745 a(n) = A181819(A124859(n)).
chain2:
	grep -E "a\(n\) *= *A[0-9][0-9]*\(A[0-9][0-9]*\(n\)\)" $(COMMON)/cat25.txt \
	| perl -ne 'my $$line = $$_; '\
	'if ($$line =~ m{^\%\w (A\d+)\s*a\(n\) *= *(A\d+)\((A\d+)\(n\)\)\s*\.}) {'\
	'print join("\t", $$1, "$@", 0, $$2, $$3) . "\n"; }'\
	| uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset, s.parm1, s.parm2, j.superclass\
		FROM seq4 s LEFT JOIN joeis j ON s.aseqno = j.aseqno \
		WHERE parm1 IN (SELECT aseqno FROM joeis) \
		  AND parm2 IN (SELECT aseqno FROM joeis) \
		ORDER BY 1"\
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------
# %F A238745 a(n) = A181819(A124859(n)).
seqop:
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
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset, s.parm1, s.parm2, s.parm3 \
		, (SELECT i.offset1 FROM asinfo i WHERE s.parm2 = i.aseqno) \
		, j.superclass\
		FROM seq4 s LEFT JOIN joeis j ON s.aseqno = j.aseqno \
		WHERE parm2        IN (SELECT aseqno FROM joeis) \
		  AND s.aseqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 1"\
	>         $@.gen
	head -n4  $@.gen
	wc -l     $@.gen
addseq:
	grep -E "a\(n\) *= *([a-z]|[\+\-\* ])([a-z]|[\+\-\*])* *A[0-9][0-9]*(\([a-z]\))?" $(COMMON)/cat25.txt \
	| perl -ne 'my $$line = $$_; $$line =~ s{\s+\Z}{}; '\
	'if ($$line =~ m{^\%\w (A\d+)\s*a\(n\) *= *([a-z\+\-\* ])+(A\d+)(\(\w\))?\.}) {'\
	'print join("\t", $$1, "$@", 0, $$3, $$2, substr($$line, 3, 128)) . "\n"; }'\
	| uniq -w7 \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=addseq.tmp
#--------
# A272999 %t Select[Range[0, 100000], PrimeQ[ (85*10^# + 473)/9 ] &]
# A272999 Numbers k such that (11*10^k + 49)/3 is prime.
pfprime:
	perl -ne \
	's/ /\t/; '\
	'if (m{^(A\d{6})\t(Numbers|Integers) \w such that \(?(\d+)\s*\*\s*(\d+)\^\w\s*([\+\-0-9 ]+)\)?\s*(\/\s*(\d+))? is prime\.}) {'\
	' my ($$aseqno, $$num, $$base, $$add, $$div) = ($$1, $$3, $$4, $$5, $$7); '\
	' $$add =~ s{ }{}g; if (length($$div) == 0) { $$div = 0; } '\
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
	> $@.gen
	make seq4 LIST=$(CC).gen
	$(DBAT) "UPDATE seq4 s SET PARM1 = (SELECT SUBSTR(data, 1, INSTR(data, ',') - 1) \
	    FROM asdata d WHERE d.aseqno = s.aseqno)"
	$(DBAT) -x "SELECT * FROM seq4 WHERE PARM1 < 10 AND PARM2 < 1000 ORDER BY aseqno" > $@.gen
pfprimex:
	cp pfprime.gen pfprime.tmp
	perl -pe 's{^(A032373|A050413|A050544|A050847|A050885|A056245|A056248|A056258|A059454'\
	'|A101001|A101003|A101722|A101732|A101734|A259137|A259138|A281063|A295399|A293592|A322935)}{\# $$1};' \
	pfprime.tmp > pfprime.gen
#------
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
#--------------------------
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
#-------------------------------
dupl:
	perl -ne \
	'if (m{^(A\d+) (Duplicate of |Essentially the same as |Same as )(A\d+)})'\
	'{ print join("\t", $$1, "$@", 0, $$3, substr(lc($$3), 0, 4), $$2) . "\n" }' \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
dupl_cut:
	$(DBAT) -x "SELECT aseqno, callcode, $(OFS), parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 s \
	    WHERE parm1 IN (SELECT aseqno FROM joeis) \
	      AND parm3 like 'Duplicate%' \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
	| grep -vE "A082627|A174781" \
	>        dupl.gen
	head -n4 dupl.gen
	wc -l    dupl.gen
#----
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
	| tee    $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
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
dhdop:
	sed -e "s/dhd/trigf/" $(TRIREC)/dhd_gf.tmp \
	>        trigf.gen
	tail -n4 trigf.gen
	wc -l    trigf.gen
rio:
	grep -E  "fract21"  $(TRIREC)/rio3.tmp \
	| sed -e "s/fract21/trigf/" \
	>        trigf.gen
	tail -n4 trigf.gen
	wc -l    trigf.gen
fract21:
	grep -E  "fract21"  $(TRIREC)/fract2.tmp \
	| sed -e "s/fract21/trigf/" \
	>        trigf.gen
	tail -n4 trigf.gen
	wc -l    trigf.gen
fract22:
	grep -E  "fract22"  $(TRIREC)/fract2.tmp \
	| sed -e "s/fract22/trigf/" \
	>        trigf.gen
	tail -n4 trigf.gen
	wc -l    trigf.gen
#-------------------------------
hosqrt: hosqrt1 
hosqrt1:
	perl extract_hosqrt.pl $(COMMON)/cat25.txt \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
hosqrt2:
	#
#-------------------------------
# HolonomicSequence
#----
DIST=0
OFFSET=0
fholo:
	grep -E "^$(S)" $(COMMON)/asdata.txt
	grep $(S) holos.gen | tee x.tmp 
	$(HOLT) -f x.tmp
runholo:
	$(HOLT) -n $(MAXT) -p "$(MATRIX)" -i "$(INIT)" -o $(OFFSET) -d $(D) -dist $(DIST)
holt: # parameter GEN=
	$(HOLT) -d $(D) -n $(MAXT) -f $(GEN)
#-------------------
holco:
	grep -E "CoefficientList\[Series" $(COMMON)/cat25.txt \
	| grep -viE "Sum|Product|Bessel|Elliptic|Hyper|theta|catalan|Drop|Pochhammer|Lambert|Continued" \
	| cut -b4- \
	| uniq -w7 \
	| sed "s/ /\t$@\t0\t/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#-------------------
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
holos:
	grep -E "holos" $(HOLREC)/rectab4.tmp \
	| sort | uniq -w 7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
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
#--
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
	$(HOLT) -d $(D) -n $(MAXT) -f $(LINREC)/raeval_holog.tmp
holog0: 
	# sed -e "s/\t/\tholog\t0\t/" -e "s/$$/\t0/" 
	cat $(LINREC)/raeval_holog.tmp \
	>        $@.1.tmp
	head -n8 $@.1.tmp
	wc -l    $@.1.tmp
	$(HOLT) -d $(D) -n $(MAXT) -f $@.1.tmp \
	>        $@.2.tmp
	head -n8 $@.2.tmp
	wc -l    $@.2.tmp
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
	$(HOLT) -d $(D) -n $(MAXT) -f $@.1.tmp \
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
#------------------------------
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
#-------------------------------
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
#----------------------------------------------
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
	>         $@.tmp
	head -n 4 $@.tmp
	wc -l     $@.tmp
linr1:
	$(DBAT) "SELECT 'A' || i.seqno, i.sigorder, i.signature, n.name \
		FROM lrindx i, asname n \
		WHERE 'A' || i.seqno = n.aseqno \
		  AND 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		  AND i.compsig NOT LIKE '%888888%' \
		ORDER BY 1" \
	>         $@.tmp
	head -n 4 $@.tmp
	wc -l     $@.tmp
#----------------------------------------------
# A288596 Fixed point of the mapping 00->0101, 1->1000, starting with 00. nonn,easy,      1..10000
# A104521 Fixed point of the morphism 0->{1}, 1->{1,0,1}. nonn,synth      0..104
# A159689 Fixed point of the morphism 0 -> 0,1,0; 1 -> 1,1; starting from a(0)=0.
# A286937 {111->null}-transform of the Sturmian word A080764.     nonn,easy,      1..10000
# A286987 {111->1}-transform of the Sturmian word A080764.        nonn,easy,      1..10000morfix:
# A286804 {000->null}-transform of the Pell word, A171588.        nonn,easy,      1..10000
# A285952 {0->1, 1->10}-transform of the Thue-Morse word A010060. nonn,easy,synth 1..86	perl -ne \
# A285589 {00->0, 11->1}-transform of A285565.    nonn,easy,      1..10000
# A284387 {010->2}-transform of the infinite Fibonacci word A003849.      nonn,easy,changed,      1..10000
# A105203 Trajectory of 1 under the morphism f: 1->{1,2,1}, 2->{2,3,2}, 3->{3,1,3}.
# A212810 Iterate the morphism 1->122, 2->1112 starting with 1.
# A284388 0-limiting word of the morphism 0 -> 1, 1 -> 001.
morfix:
	CLASS=MorphismSequence
	perl -ne \
	'my $$line = $$_;'\
	'if ($$line =~ m{^(A\d+)\s+.*([Ff]ixed (point )?(under |of )|Iterate |Substitution |generated by |[Rr]esult of |closed under )'\
	'(the )?(mapping |map |morphism |morphing |\:|)([ 0-9\-\>\,\;\{\}\(\)\[\]]+)} )'\
	'{ my ($$aseqno, $$map) = ($$1, $$7); $$map =~ s{\s}{}g; $$map =~ tr{\[\]\(\)}{\{\}\{\}};'\
	'  $$map =~ s{\}\,}{\}\;}g; $$map =~ s{[\,\;]\Z}{}; if ($$map =~ m{[\}\;]}) { $$map =~ s{[\{\}\,]}{}g; };'\
	'  $$map =~ s{\;}{\,}g; $$map =~ m{\A(\d+)}; my $$start = ""; '\
	'if ($$line =~ m{(start |starting |apply |applied )(with |from |to )([a-z]\(\d\)\D*)?(\d+)}i) { $$start = $$4; }'\
	'if ($$line =~ m{\-\>}) { print join("\t", $$aseqno, "$@", 0, $$start, "", $$map) . "\n"; }}' \
	$(COMMON)/names \
	| grep -vE "A106437|A119647|A176416|A30549[56]|A317198|A32092[67]" \
	| tee $@.gen
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
	| tee -a $@.gen
	# mor*
	wc -l $@.gen
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
	$(COMMON)/jnames.txt | tee x.tmp
	wc -l x.tmp
#
#------------------------------------------------------
negpos:
	cat ../../../fasces/oeis/A131393/negpos.gen \
	| grep -E "ak|dk" \
	| sed -e "s/\t/\tnegpos\t0\t/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#----------------
# %C A070365 Period 6: repeat [1, 5, 4, 6, 2, 3].
# %F A118822 Period 8 sequence: [2,-1,0,-1,-2,1,0,1].
# %C A175408 Period of length 10: {7,2,6,3,5,4,4,5,3,1}.
# %N A257931 Period length 24 sequence [0, 1, 1, 0, -2, -1, 0, 1, 0, 0, -1, -1, 0, 1, 1, 0, 0, -1, 0, 1, 2, 0, -1, -1].
period: # PeriodicSequence
	perl -ne \
	'if (m{^(\%\w) (A\d+)\s+Period [^\{\(\[]*[\{\(\[]([\- \d\,]+)})'\
	'{ my ($$aseqno, $$list) = ($$2, $$3); '\
	'$$list =~ s{ }{}g; print join("\t", $$aseqno, "$@", 0, $$list) . "\n"; }' \
	$(COMMON)/cat25.txt \
	| grep -v A210188 \
	>        $@.gen
	head -n2 $@.gen
	tail -n2 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
	# ([ \d\,]+)[\}\)\]]})'\
#----------------
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
squaredig_test:
	java -cp ../../dist/joeis-lite.jar irvine.oeis.SquareDigitsSequence $(NT) $(SC)
squaredig_width:
	$(DBAT) "SELECT b.aseqno, b.maxlen, n.name FROM bfinfo b, seq4 s, asname n \
	WHERE b.aseqno = s.aseqno \
	  AND s.aseqno = n.aseqno \
	  ORDER BY 1" | tee @$.tmp
#----------------
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
	$(DBAT) -x "SELECT aseqno, callcode, offset, parm1, parm2, parm3, parm4, parm5 \
	    FROM seq4 \
	    ORDER BY 1" \
		  > $@.tmp
	head -4 $@.tmp
	wc -l   $@.tmp
choulet3:
	perl choulet.pl choulet2.tmp | tee holos.gen
choulet_bf:
	$(JAVA) irvine.test.SequenceTest A176604 $(N) 0
#----
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
#---------------------------
euler:
	echo "$(PER)" | tr , '\n' | $(JAVA) irvine.oeis.EulerTransformSequence $(OFFSET) | less
eulerper:
	perl eulerper.pl $(COMMON)/cat25.txt \
	| uniq   -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
euleras: # difficult initial terms
	perl -ne \
	'my $$line = $$_; if (($$line =~ m{Euler transform of (A\d+)}) and ($$line !~ m{Inverse Euler})) { '\
	'my ($$adepend) = ($$1); '\
	'if (1) {'\
	'$$line =~ m{^\%\w (A\d+)}; my $$aseqno = $$1;'\
	'print join("\t", $$aseqno, "$@", 0, lc(substr($$adepend, 0,4)), $$adepend) . "\n" }}' \
	$(COMMON)/cat25.txt \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
eulerasinv: # about 24, with difficult initial terms
	perl -ne \
	'my $$line = $$_; if (($$line =~ m{Inverse Euler transform of (A\d+)})) { '\
	'my ($$adepend) = ($$1); '\
	'if (1) {'\
	'$$line =~ m{^\%\w (A\d+)}; my $$aseqno = $$1;'\
	'print join("\t", $$aseqno, "$@", 0, lc(substr($$adepend, 0,4)), $$adepend) . "\n" }}' \
	$(COMMON)/cat25.txt \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
euleras_dep:
	$(DBAT) "DELETE FROM seq4 WHERE parm2 NOT IN (SELECT aseqno FROM joeis);"
	$(DBAT) -x "SELECT aseqno, callcode, $(OFS), parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 \
	    WHERE aseqno NOT IN (SELECT aseqno FROM joeis) \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
#---------
evconst:
	perl evconst.pl \
		  > $(CC).gen
	head -4 $(CC).gen
	wc -l   $(CC).gen
#--------------------
kblocks:
	perl kblocks.pl \
	| tee   $(CC).gen
	wc -l   $(CC).gen
#---------------------------
finifull:
	$(DBAT) "SELECT i.aseqno, '$@', 0, d.data \
		FROM asinfo i, bfinfo b, bfdata d \
		WHERE i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND i.keyword like '%full%' \
		  AND b.bfimax - b.bfimin  + 1 <= d.termno \
		ORDER BY 1 " \
	| perl finifull.pl \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
logmod:
	head -n4 $@.gen
	wc -l    $@.gen
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
#--------------------------
dex0: dex1 dex2 dex3 dex4
dex1: # names: Annnnnn Decimal expansion of ... and in jOEIS
	$(DBAT) "UPDATE asname SET name = 'Decimal expansion of 2*(5-3*exp(1/2))/(2*exp(1/2)-3).' WHERE aseqno = 'A108813'"
	$(DBAT) -x "SELECT a.aseqno, 'dex', a.offset1, n.name, a.keyword \
		FROM asinfo a, bfinfo b, asname n \
		WHERE a.aseqno = n.aseqno \
		  AND b.aseqno = n.aseqno \
		  AND a.keyword    LIKE '%cons%' \
		  AND b.maxlen <= 2 \
		ORDER BY 1" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
dex2:
	perl extract_dex.pl dex1.tmp \
	| sed -e "s/pi log/pi\*log/" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
dex3:
	$(RAMATH).sequence.JoeisPreparer -f dex2.tmp \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
dex4:
	perl infix_dex.pl dex3.tmp \
	| grep -vE "^(A114054|A117853|A202955|A248622)" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp	
	grep -vE "^#" $@.tmp | wc -l	
dex:
	cp dex4.tmp dex.gen
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
#-------------------
# A109718 Periodic sequence with period {0,1,0,3}, or n^3 mod 4.
# A109720 Periodic sequence {0,1,1,1,1,1,1} or n^6 mod 7.       
# A109753 n^3 mod 8; the periodic sequence {0,1,0,3,0,5,0,7}.   
# A159852 n^2 mod 60.                                           
# A167129 n^7 mod 21.                                           
# A167166 a(n) = n^7 mod 16.                                    
modpow: # names: Annnnnn a(n) = (\d+)*n^(\d+) mod (\d+)
	cat $(COMMON)/names \
	| perl -ne \
	'if (m{[^\(a-z]n\^(\d+) mod (\d+)(.)}) { '\
	'if ($$3 ne "^") { '\
	'print join("\t", substr($$_, 0, 7), "$@", 0, $$1, $$2, $$3) . "\n"; }}' \
	| uniq -w 7 \
	| tee   $@.gen
	head -4 $@.gen
	wc   -l $@.gen
#-------------------
# A036160	null	3^n mod 223.	nonn,easy,synth	1
# A036161	null	a(n) = 2^n mod 227.	nonn,easy,changed,	1
modpow2: # names: Annnnnn [a(n) = ](\d+)^n mod (\d+)
	perl -ne \
	' if (m{\A(A\d+)\s+(a\(n\)\s*\=\s*)?(\d+)\^n\s+mod\s+(\d+)([^\.]*)\.}) {'\
	' my ($$aseqno, $$base, $$mod, $$rest) = ($$1, $$3, $$4, $$5); $$rest =~ s{\s}{}g;'\
	' if ($$rest eq "" or $$rest eq "^n") {'\
	' print join("\t", $$aseqno, ($$rest eq "" ? "modpow2" : "modpow3"), 0, $$base, $$mod) . "\n"; }}' \
	$(COMMON)/names \
	>       $@.gen
	head -4 $@.gen
	wc   -l $@.gen
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
	| perl -ne \
	'if (! m{\.\.\.} and m{\A(A\d{6}\s+\w\(([a-z])\)\s*\=\s*[ \d\+\-\*\/\!ank\[\]\{\}\(\)\^]+)\.})'\
	'{ print "$$1\n"; }' \
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
	$(COMMON)/names \
	| tee   $@.gen
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
	$(DBAT) -x "SELECT a.aseqno, 'not-in-joeis', d.data \
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
cfsqrt_old: cfsqrt_prep cfsqrt_gen
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
	make  joeis2 LIST=$@.tmp
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
#--------------------------
weight_check:
	grep "Weight distr" $(COMMON)/names \
	| sed -e "s/ /\tweight\t0\t/" \
	>       $@.tmp
	head -4 $@.tmp
	wc   -l $@.tmp
	make seq4 LIST=$@.tmp
	$(DBAT) "SELECT s.aseqno, s.parm1, i.termno, i.keyword, i.author \
		FROM  seq4 s, asinfo i \
		WHERE s.aseqno NOT IN (SELECT aseqno FROM JOEIS) \
		  AND s.aseqno = i.aseqno \
		ORDER BY 1" \
	>       $@.txt
	head -4 $@.txt
	wc   -l $@.txt
	cp -v   $@.txt $(COMMON)/$@.txt
	cd $(COMMON) ; make html_checks
	rm -v   $(COMMON)/$@.txt
weight2:
	$(DBAT) "SELECT j.aseqno, j.superclass \
		FROM  seq2 s, joeis j \
		WHERE s.aseqno = j.aseqno \
		ORDER BY 1" \
	>       $@.j.txt
	wc   -l $@.j.txt
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
analog: analog1 anasort anastret
analog1:
	perl normalize_name.pl $(COMMON)/jnames.txt \
	>         $@.tmp
	wc -l     $@.tmp
anasort: 
	sort -k3 -k2 -k1 -t "	" analog1.tmp \
	>         $@.tmp
	head -n 4 $@.tmp
	wc -l     $@.tmp
anastret:
	perl stretchable.pl anasort.tmp \
	>         $@.txt
	head -n 4 $@.txt
	wc   -l   $@.txt
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
	      > $@.txt
	head -4 $@.txt
	wc -l   $@.txt
analog5:
	perl get_stretchables.pl analog3.txt \
	>       $@.txt
	head -4 $@.txt
	wc   -l $@.txt
#--------
