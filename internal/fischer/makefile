#!make

# Makefile in gits/joeis-lite/internal/fischer: sequence generation and testing
# @(#) $Id$
# 2020-06-21: test with BatchMonitor
# 2019-07-15: joeis parallel to joeis-lite
# 2019-05-20, Georg Fischer: copied from makefile
#
GITS=../../..
LITE=$(GITS)/joeis-lite
HERE=$(LITE)/internal/fischer
JOEIS=$(GITS)/joeis
COMMON=$(GITS)/OEIS-mat/common
CONTRIB=$(GITS)/OEIS-mat/contrib
COORS=$(GITS)/OEIS-mat/coors
LINREC=$(GITS)/OEIS-mat/linrec
HOLREC=$(GITS)/OEIS-mat/holrec
TRIREC=$(GITS)/OEIS-mat/trirec
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
RAMATH=java -cp $(GITS)/ramath/dist/ramath.jar org.teherba.ramath
MAXT=16
HOLT=java   -cp $(GITS)/ramath/dist/ramath.jar irvine.test.HolonomicRecurrenceTest
MANY=999999
CLASS=dummy.java
D=0
TO=4
TOADD=4000
WAITM=100
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
BATLIT=$(JAVA) irvine.test.BatchTest -vv $(WITHB) -d $(D) -u $(GU)
INIT=0
START=`grep -E "^A" batch.log | tail -n1 | cut -b1-7`
REMOTE=gfis@atair:~/work/gits/joeis-lite/internal/fischer
#----------------
all:
	# Possible targets:
	grep -E "^[a-z]" makefile | sort
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
from_ramath:
	cp -v ../../../ramath/src/main/java/irvine/oeis/HolonomicRecurrence.java     ../../src/irvine/oeis
	# cp -v ../../../ramath/src/main/java/irvine/test/HolonomicRecurrenceTest.java ../../src/irvine/test
to_ramath:
	cp -v ../../src/irvine/oeis/HolonomicRecurrence.java     ../../../ramath/src/main/java/irvine/oeis
	# cp -v ../../src/irvine/test/HolonomicRecurrenceTest.java ../../../ramath/src/main/java/irvine/test
diff_ramath:
	diff -wC0 ../../../ramath/src/main/java/irvine/oeis/HolonomicRecurrence.java     ../../src/irvine/oeis || :
	# diff -wC0 ../../../ramath/src/main/java/irvine/test/HolonomicRecurrenceTest.java ../../src/irvine/test || :
diff_joeis:
	ls -1 ../../src/irvine/oeis/*.java | xargs -l -innn \
	  diff -wsC0                        nnn ../../../joeis/src/irvine/oeis/ || :
#	  diff -wsy --suppress-common-lines nnn ../../../joeis/src/irvine/oeis/ || :
#	diff -wC0 ../../../joeis/src/irvine/oeis/HolonomicRecurrence.java   ../../src/irvine/oeis || :
update:
	cp -v     ../../../joeis/src/irvine/oeis/EulerTransform.java      ../../src/irvine/oeis || :
#	cd ../.. ; find src | xargs -l -i{} cp -pv ../../gits/joeis/{} {}
count:
	find ../../src -iname "A??????.java" | wc -l
list:
	find ../../src -iname "A??????.java" -ls
pack: pack1 pack2
pack1:
	cd ../.. ; find src -iname "A??????.java" > pack.$(CC).lst \
	; wc -l                                     pack.$(CC).lst \
	; find internal/fischer/$(CC).*.log      >> pack.$(CC).lst \
	; echo "$(CLASS)" | xargs -d" " -i{} echo src/irvine/oeis/{}.java  >> pack.$(CC).lst \
	; echo internal/fischer/$(CC)*.gen       >> pack.$(CC).lst \
	; echo internal/fischer/$(CC)*.jpat      >> pack.$(CC).lst
	cd ../.. ; tar --files-from=pack.$(CC).lst -cvzf $(CC).`date +%Y-%m-%d.%H`.tgz \
	| perl -pe "s{\/A\S*}{}" | uniq -c
pack2:
	git commit -a
	git push origin master
rename:
	echo cfs*.jpat | xargs -l \
	  perl -i.bak -pe "s{ContinuedFractionOfSqrt([^S])}{ContinuedFractionOfSqrtSequence$1}g;"
pocre:
	$(DBAT) -f $(COMMON)/poeis.create.sql
poins:
	cut -b1-7 $(CC).gen \
	| sed -e "s/$$/\t$(CLASS)\t/" \
	| $(DBAT) -m csv -r poeis
	$(DBAT) -4 poeis
	$(DBAT) -n poeis
bfresh: # CC=
	cd $(COMMON) ; make bfresh 
#==========================
remove: # parameter: CC
	rm -f remlist.tmp
	perl -ne 'm{^A(\d\d\d)(\d+)}; print "a$$1/A$$1$$2.java\n";' $(CC).gen > remlist.tmp
	cat remlist.tmp | xargs -l -i{} rm  -f ../../target/WEB-INF/classes/irvine/oeis/{}
	cat remlist.tmp | xargs -l -i{} rm -vf                    ../../src/irvine/oeis/{}
OFS=offset
#--------
ccall: select clean purge gener dist test pack # parameter: CC
#----
NOT=NOT
select: select1 select2 # parameter: CC, OFS
select1:
	make $(CC)
	head -n4 $(CC).gen
	wc   -l  $(CC).gen
EX=
select2:
	make seq4 LIST=$(CC).gen
	$(DBAT) "UPDATE seq4 s \
	    SET name    = (SELECT a.name    FROM asname a WHERE s.aseqno = a.aseqno) \
	    ,   offset  = (SELECT a.offset1 FROM asinfo a WHERE s.aseqno = a.aseqno)"
	$(DBAT) -v -f $(CC).sql > $(CC).sql.tmp || :
	$(DBAT) -x "SELECT s.aseqno, callcode, $(OFS), parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 s, asinfo i \
	    WHERE s.aseqno = i.aseqno \
	      AND (s.aseqno NOT IN (SELECT CONCAT('$(EX)', aseqno) FROM joeis)) \
	      AND i.keyword NOT LIKE '%dead%' \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
		  >  $(CC).gen
	head -n4 $(CC).gen
	wc -l    $(CC).gen
	#     AND (callcode NOT IN ('lingf','holos') OR aseqno NOT IN (SELECT aseqno FROM cojec)) \
	# $(DBAT) -x "SELECT COUNT(aseqno) FROM seq4 WHERE aseqno NOT IN (SELECT aseqno FROM joeis)"
clean: purge # parameter: CC; $(CC).pass.log from previous test is grepped from $(CC).gen
	wc -l $(CC).gen
	cut -b1-7 $(CC).pass.log > clean.tmp
	grep -f clean.tmp $(CC).gen > $(CC).tmp
	cp -v $(CC).tmp $(CC).gen
	wc -l $(CC).gen
dirty: # parameter: CC; $(CC).pass.log from previous test is stripped off $(CC).gen
	wc -l $(CC).gen
	cp    $(CC).gen $(CC).old.tmp
	cut -b1-7 $(CC).pass.log > dirty.tmp
	grep -vf dirty.tmp $(CC).gen > $(CC).tmp
	cp -v $(CC).tmp $(CC).gen
	wc -l $(CC).gen
logsel:# set the test results of CC= in column PARM=n
	cut -f1,3 $(CC).fail.log $(CC).pass.log > logset.tmp
	make seq2 LIST=logset.tmp
	$(DBAT) "UPDATE seq4 s4 SET parm$(PARM)=COALESCE((SELECT info FROM seq2 s2 WHERE s2.aseqno = s4.aseqno), 'unknown');"
	$(DBAT) -x -99999 seq4 > $(CC).sel
	head -n4 $(CC).gen
	wc -l    $(CC).gen
#----
control: # extract shorter descriptions for passed seqs.
	cut -b1-7 $(CC).pass.log \
	| perl -ne ' s/\s+\Z//; print "\%. $$_ \n"; ' > $@.tmp
	grep -Ef $@.tmp $(COMMON)/cat25.txt \
	| perl -ne ' print substr($$_, 1) if m{\A\%[NCFtSTU]}; ' \
	| sed -e "s/^S /\#________________\nS /" \
	>        $(CC).$@.txt
	wc -l    $(CC).$@.txt
#----
# ... oeis\a062\A062724.java:23: error: no suitable method found for add(CR)
prune: purge # parameter: CC; $(CC).fail.log from previous test is stripped off $(CC).gen
	cat dist.log \
	| perl -ne 'if (m{(A\d+)\.java\:\d*\:\s*error\:}) { print "$$1\n"; } '\
	| cut -b1-7 > prune.tmp
	wc -l    prune.tmp
	grep -vf prune.tmp $(CC).gen > $(CC).tmp
	grep  -f prune.tmp $(CC).gen > $(CC).reco.tmp
	sed -e "s/\r//" $(CC).tmp > $(CC).gen
	wc -l $(CC).*
purge: # remove all oeis/annn directories
	rm -rf  ../../target/WEB-INF/classes/irvine/oeis/a???
	rm -rf                     ../../src/irvine/oeis/a???
	rm -vf *.bak
gener: # parameter: CC, MANY, NC; test sequences in $(CC).gen
	head -n$(MANY) $(CC).gen      > ghead.tmp
	perl gen_seq4.pl -d $(D) $(NC)  ghead.tmp
	make -i $(CC).patch || :
dist:
	rm -f dist.log
	make dist1 2>&1 | tee dist.log
	#################################################################
dist1:
	cd ../.. ; ant -silent dist 2>&1
testout: # parameter: CC
	rm -f batch.log
	head -n$(MANY) $(CC).gen      > ghead.tmp
	make stripgr LIST=ghead.tmp
	make runbt evaluate
test:
	rm -f batch.log
	head -n$(MANY) $(CC).gen      > ghead.tmp
	make stripgr LIST=ghead.tmp
	echo 0x0 > seekpos.mon
	cp seekpos.mon seekpos.tmp
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
runbt: # Run BatchTest for this group
	$(BATLIT) strip.tmp 2>&1 | tee -a batch.log
testex: # parameter: CC=; test all existing (generated) sequences
	rm -f batch.log
	find ../../src -iname "A??????.java" -printf "%f\n" | cut -b1-7 \
	| head -n$(MANY) > ghead.tmp
	make stripgr  LIST=ghead.tmp
	make runbt
	make evaluate
log: # CC=; generate an HTML page for the failed tests
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
evaluate:
	uniq -w7 batch.log | grep -E  "pass" >     $(CC).pass.log || :
	uniq -w7 batch.log | grep -vE "pass" | tee $(CC).fail.log || :
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
#----
seqt: # ASEQNO=$(ASEQNO) - print data up to 260 characters
	$(JAVA) irvine.test.SequenceTest -a $(ASEQNO) 
seqtest: # ASEQNO=$(ASEQNO) MAXT=$(MAXT) OFFSET=$(OFFSET) - print b-file
	$(JAVA) irvine.test.SequenceTest -a $(ASEQNO) -bf -n $(MAXT) -o $(OFFSET)
spectest:
	$(JAVA) irvine.test.SpecialTest            $(MAXT) $(OFFSET)
tiletest:
	$(JAVA) org.teherba.tile.TilingSequence -n $(MAXT)
runjava: # CLASS= MAXT=
	$(JAVA) $(CLASS) -n $(MAXT)
pseudotest: # ASEQNO=
	$(JAVA) irvine.oeis.PseudoSequence $(ASEQNO)
ej:
	echo $(JAVA)
#================================================================
#================================
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
#--------------------------------
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
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset, s.parm1, s.parm2, b.bfimax - b.bfimin + 1, d.data \
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
concprod:
	perl -n concprod.pl \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
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
	>        $@.gen
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
decofr: # Continued fraction of real expression
	perl decofr.pl -i 0 $(COMMON)/joeis_names.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	# perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#--------------------------------
deriv_rest: deriv2 deriv3 deriv4 deriv5 deriv6 deriv7 
deriv1c: # grep cat25: (a(n) = )?aseqno
	grep -E "^\%[NF] A" $(COMMON)/cat25.txt \
	| cut -b4- \
	| grep -P  "^A\d{6}[^A]*A\d{6}" \
	| sed -e "s/ /\t/" \
	| grep -vEi "sum|product|\!|\.\.\." \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
deriv1n: # grep names: (a(n) = )?aseqno
	grep -E "^A" $(COMMON)/names \
	| grep -P  "^A\d{6}[^A]*A\d{6}" \
	| sed -e "s/ /\t/" \
	| sed -e "s/\tTwice  *A/\t2\*A/" \
	| grep -vEi "sum|product|\!|\.\.\." \
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
deriv3: # add offset1 from asinfo; aseqno, md5sum, offset, ~~form, form, cond
	make seq4 LIST=deriv2.tmp
	$(DBAT) -v -f deriv3.update.sql
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
	$(RAMATH).sequence.JoeisPreparer -f deriv4.tmp \
	| perl deriv_select.pl \
	>        $@.tmp
	make seq4 LIST=deriv5.tmp
	$(DBAT) -x "SELECT s.aseqno, s.callcode, s.offset, s.parm1, s.parm2, s.parm3, s.parm4 \
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
	>        $@.tmp 
	head -n4 $@.tmp
	wc   -l  $@.*
deriv:
	grep -vE "floor|ceil|round" deriv7.tmp \
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
	$(RAMATH).sequence.JoeisPreparer -f dex2.tmp \
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
	$(DBAT) -x "SELECT s.aseqno, callcode, offset, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, s.name \
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
eulerian:
	grep -E "\%[CFN]" $(COMMON)/cat25.txt | grep -E "Eulerian[\[]" \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
# A006526 Egyptian fraction for 1/e.
# A248319 Egyptian fraction representation of sqrt(96) (A010547) using a greedy function.	nonn,changed,synth	0..8	null
egyptfract:
	grep -E "Egyptian fraction" $(COMMON)/joeis_names.txt \
	| perl -ne 'use strict; if (m{Egyptian fraction representation of sqrt\((\d+)\)}) { my $$root = $$1; my $$aseqno = substr($$_, 0, 7); '\
	' print join("\t", $$aseqno, "$@", 0, "CR.valueOf($$root).sqrt()") . "\n"; } '\
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#--------------------------------
floor0: floor1 floor2 floor3 floor4 floor5
floor1:
	grep -E "\[|floor|ceil|round|fract" $(COMMON)/joeis_names.txt \
	| grep "null" \
	>        floor0.tmp
	perl -ne 'if (s{Nearest +integer +to +}{\~\~} > 0) { s{(\d)\.(\d)}{$$1\#$$2}g; '\
	' s{\~\~([^\.\;\:\,]+)(.*)}{round\($$1\)$$2}; s{\#}{\.}g; print; }' $(COMMON)/joeis_names.txt \
	| grep "null" \
	>>       floor0.tmp
	cat      floor0.tmp \
	| grep -viE "prime|sum|product|binomial|triangle|base|cofr|continued fraction|a?round(ed|ing|)|frac(\,|tal|tion |tions)|\!|\.\.\." \
	>        $@.tmp
	wc   -l  $@*.*
floor2:
	perl floor_split.pl   -d $(D) floor1.tmp \
	2>       $@.rest \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@*.*
	head -n4 $@.rest
	wc   -l  $@.rest
floor3:
	$(RAMATH).sequence.JoeisPreparer -f floor2.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	grep "#" $@.tmp \
	>        $@.rest || :
	head -n4 $@.rest
	wc   -l  $@.rest
floor4:
	perl cr_infix.pl      -d    1 floor3.tmp 2>&1 \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp	
	grep "#" $@.tmp \
	>        $@.rest || :
	head -n4 $@.rest
	wc   -l  $@.rest
floor5:
	perl floor_combine.pl -d $(D) floor4.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
floor: floor5
	grep A floor5.tmp \
	| grep -vE "A038126|A134903|A134909" \
	>        $@.gen
	# cp floor5.tmp $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
#--------------------------------
finifull: # finite and full
	$(DBAT) "SELECT i.aseqno, '$@', i.offset1, d.data \
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
# HolonomicSequence
#----
DIST=0
OFFSET=0
GFTYPE=0
fholo:
	grep -E "^$(S)" $(COMMON)/asdata.txt
	grep $(S) holos.gen | tee x.tmp 
	$(HOLT) -f x.tmp
runholo:
	$(HOLT) -n $(MAXT) -p "$(MATRIX)" -i "$(INIT)" -o $(OFFSET) -d $(D) -dist $(DIST) -t $(GFTYPE)
holt: # parameter GEN=
	$(HOLT) -d $(D) -n $(MAXT) -f $(GEN)
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
holos:
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
	cat $(LIST) \
	>        $@.1.tmp
	head -n8 $@.1.tmp
	wc -l    $@.1.tmp
	$(HOLT) -d $(D) -n $(MAXT) -f $@.1.tmp \
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
	>         $@.tmp
	head -n 4 $@.tmp
	wc -l     $@.tmp
linr1:
	$(DBAT) "SELECT 'A' || i.seqno, i.sigorder, i.signature, n.name \
		FROM lrindx i, asname n, asinfo a \
		WHERE 'A' || i.seqno = n.aseqno \
		  AND 'A' || i.seqno = a.aseqno \
		  AND 'A' || i.seqno NOT IN (SELECT aseqno FROM joeis) \
		  AND i.compsig <> '88888888' \
		  AND a.keyword NOT LIKE '%dead%' \
		ORDER BY 1" \
	>         $@.tmp
	head -n 4 $@.tmp
	wc -l     $@.tmp
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
#--------------------------------
# A272999 %t Select[Range[0, 100000], PrimeQ[ (85*10^# + 473)/9 ] &]
# A272999 Numbers k such that (11*10^k + 49)/3 is prime.
pfprime:
	perl -ne \
	's/ /\t/; '\
	'if (m{^(A\d{6})\t(Numbers|Integers) \w such that[^\(\d]*\(?(\d+)\s*\*\s*(\d+)\^\w\s*([\+\-0-9 ]+)\)?\s*(\/\s*(\d+))? is (a )?prime\.}) {'\
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
	>        $@.gen
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
#--------------------------------
# A216777 null    Primes p such that x^64 = -2 has no solution mod p.     nonn,easy,      1..1000
# A216862 null    Primes p such that x^5 = 20 has a solution mod p.       nonn,easy,      1..1000
# A040034 (PARI): forprime(p=2, 10^3, if(#polrootsmod(x^3-2, p)==0, print1(p, ", ")))
primsol:
	grep "Primes p such that " $(COMMON)/joeis_names.txt | grep -E "has (a|no) solution" \
	| perl -ne 'use strict; my $$line = $$_; $$line =~ s{\s+\Z}{}; '\
	'if ($$line =~ m{^(A\d+)\t\w+\tPrimes[^x]+x\^(\d+) *\= *(\-?\d+) +has +(a|no) solution}) { '\
	'  my ($$aseqno, $$pow, $$y, $$bool) = ($$1, $$2, $$3, $$4); $$bool =~ s{a}{1}; $$bool =~ s{no}{0}; '\
	'  print join("\t", $$aseqno, "$@", 0, $$pow, $$y, $$bool) . "\n"; '\
	' } '\
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
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
#------------------------------------------------------
negpos: # all done
	cat ../../../fasces/oeis/A131393/negpos.gen \
	| grep -E "ak|dk" \
	| sed -e "s/\t/\tnegpos\t0\t/" \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
	perl callcode_wiki.pl -p 1 $@.gen > $@.wiki
#--------------------------------
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
	cat noncomp1.tmp noncomp2.tmp | sort | uniq -w7 \
	| grep -vE "A005646|A094871" \
	>  $@.tmp
	make seq4 LIST=$@.tmp
	#                                                   PARM1   PARM2    PARM3     PARM4     PARM5     PARM6
	$(DBAT) -x "SELECT s.aseqno, s.callcode, i.offset1, d.data, s.parm1, b.bfimin, b.bfimax, d.termno, i.keyword, '', '', n.name \
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
	    ORDER BY 4, 1" \
	| perl finifull.pl \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
	make seq4 LIST=$@.tmp
	cp -v $@.tmp noncomp.gen
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
noncomp:
	# run (noncomp0 and) noncomp_prep before
#--------------------------------
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
	grep -E "Positions of " $(COMMON)/cat25.txt \
	| grep -v "of records" \
	| cut -b4- | sed -e "s/ /\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
posins2:
	perl posins.pl -d 0 posins1.tmp \
	2>       posins.rest \
	| sort | uniq -w7 \
	>        posins.gen
	head -n4 posins.gen
	head -n2 posins.rest
	wc -l    posins.gen posins.rest
	# perl callcode_wiki.pl -p 1 posins.gen > posins.wiki
#================================
# Derived sequences processed with deris.pl
#
DEROPT=
deris0: deris1 charfun2
	rm -rf   deris2.gen
	echo "charfun compseq diffseq partprod partsum recordpos recordval dummy" \
	| xargs -d" " -innn make -i deris2 TARGET=nnn
	head -n4 deris2.gen
	wc -l    deris2.gen
deris1: 
	echo -n "characteristic|indicator"         > charfun.grep.tmp
	echo -n "complement"                       > compseq.grep.tmp
	echo -n "difference"                       > diffseq.grep.tmp
	echo -n "partial product"                  > partprod.grep.tmp
	echo -n "partial sum"                      > partsum.grep.tmp
	echo -n "record"                           > recordpos.grep.tmp
	echo -n "record"                           > recordval.grep.tmp
# -n: no trailing newline!
deris2:
	#================================
	grep -E "^\%[NCF] A[0-9]*" $(COMMON)/cat25.txt \
	| grep -iE "`cat $(TARGET).grep.tmp`" \
	| sed -e "s/ /\t/" -e "s/ /\t/" \
	| perl deris.pl $(DEROPT)  -cc $(TARGET) -f $(COMMON)/joeis_ofter.txt \
	>        $(TARGET).gen
	head -n4 $(TARGET).gen
	wc -l    $(TARGET).gen
	cat      $(TARGET).gen \
	>>       $@.gen
deris:
	sort     deris2.gen charfun2.gen | uniq -w7 \
	>        deris.gen
	head -n4 $@.gen
	wc -l    $@.gen
#----
charfun2: # Characteristic function of rseqno
	perl charfun_index.pl \
	| sed -e "s/ /\t/" -e "s/ /\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.*
	cat      $@.tmp \
	| perl deris.pl $(DEROPT) -cc charfun -f $(COMMON)/joeis_ofter.txt \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.*
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
	grep -E 'rectoproc' $(COMMON)/cat25.txt \
	| cut -b 4- | sed -e "s/ /\t/" \
	| grep -vE "A110908" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	cd $(COMMON); make seq2 LIST=../../joeis-lite/internal/fischer/$@.tmp
	$(DBAT) -x "SELECT * FROM seq2 WHERE aseqno NOT IN (SELECT aseqno FROM joeis) ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
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
squaredig_test:
	java -cp ../../dist/joeis-lite.jar irvine.oeis.SquareDigitsSequence $(NT) $(SC)
squaredig_width:
	$(DBAT) "SELECT b.aseqno, b.maxlen, n.name FROM bfinfo b, seq4 s, asname n \
	WHERE b.aseqno = s.aseqno \
	  AND s.aseqno = n.aseqno \
	  ORDER BY 1" | tee @$.tmp
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
	$(DBAT) -x "SELECT aseqno, callcode, offset, parm1, parm2, parm3, parm4, parm5 \
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
	$(DBAT) -x "SELECT aseqno, callcode, offset, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
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
	$(JAVA) irvine.test.EulerTransformTest -v -p $(PER) -m $(MAXT)
#----
INIT=""
TYPE=2
euler: # manual EulerTest PER="1,0,1" INIT=1 MAXT=32 TYPE=2
	$(JAVA) irvine.test.EulerTransformTest -p $(PER) -s $(TYPE) -m $(MAXT) -i $(INIT)
#----
eulerper:
	perl eulerper.pl $(COMMON)/cat25.txt \
	  2>     $@.rest.tmp \
	>        $@.tmp
	sort     $@.tmp eulerper.man \
	| uniq -w7 \
	>        $@.gen
	head -n4 $@.gen
	wc -l    $@.rest*
	wc -l    $@.gen
#--------------------------------
eulerx0: # grep cat25 - takes some time
	perl eulerxfm.pl $(COMMON)/cat25.txt \
	2>       $@.rest.tmp \
	>        $@.tmp
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
	$(DBAT) -x "SELECT s.aseqno, callcode, offset, parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
	    FROM seq4 s, asinfo i \
	    WHERE s.aseqno = i.aseqno \
	      AND (s.aseqno NOT IN (SELECT aseqno FROM joeis)) \
	      AND i.keyword NOT LIKE '%dead%' \
	    ORDER BY 1" \
	| perl -pe "s{\'\'}{\'}g" \
	  >      $@.gen
	head -n4 $@.gen
	wc -l    $@.gen
eugpolym:
	cp -v    $@.man $@.gen
#--
euguess_short8: # remove all with numbers that are too big
	perl -ne 'print if ! m{\,\-?\d{8}};' euguess2.tmp \
	| sed -e "s/\tnonn\t/\t3\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
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
mckay0:
	$(DBAT) "SELECT n.aseqno, b.bfimax - b.bfimin + 1, COALESCE(j.superclass, 'not_in_joeis'), n.name \
	  FROM asname n \
	  LEFT JOIN bfinfo b on n.aseqno = b.aseqno \
	  LEFT JOIN joeis  j on b.aseqno = j.aseqno \
	  WHERE n.name LIKE '%McKay%' \
	  ORDER BY 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
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
	$(DBAT) -x "SELECT aseqno, callcode, $(OFS), parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, name \
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
kblocks: all done
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
flexfact: all done
	perl -ne \
	'if (m{^(A\d+)\s+\[\s*exp\((\d+)\/(\d+)\)\s*\*\s*n\s*\!\s*\]}) { print join("\t", $$1, "$@", 0, $$2, $$3) . "\n" }' \
	$(COMMON)/names \
	> $@.gen
	perl -ne \
	'if (m{^(A\d+)\s+(a\(n\)\s*\=\s*)?[fF]loor\s*\(\s*exp\(\s*(\d+)\/(\d+)\)\s*\*\s*n\!\s*\)}) { print join("\t", $$1, "$@", 0, $$3, $$4) . "\n" }' \
	$(COMMON)/names \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#-------------------
# A095140 null    Triangle formed by reading Pascal's triangle (A007318) mod 5.
# A126058 null    Exponents p of the Mersenne primes 2^p - 1 (see A000043) read mod 18.   nonn,more,synth 1..47
# A126812 null    Ramanujan numbers (A000594) read mod 4. nonn,   1..65537
moderiv: # names: Annnnnn a(n) = (\d+)*n^(\d+) mod (\d+)
	cat $(COMMON)/joeis_names.txt \
	| grep -vE "Mersenne primes|Bell numbers" \
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
	cat $(COMMON)/names \
	| perl -ne \
	'if (m{[^\(a-z]n\^(\d+) mod (\d+)(.)}) { '\
	'if ($$3 ne "^") { '\
	'print join("\t", substr($$_, 0, 7), "$@", 0, $$1, $$2, $$3) . "\n"; }}' \
	| uniq -w 7 \
	>        $@.gen
	head -n4 $@.gen
	wc   -l  $@.gen
#-------------------
# A036160	null	3^n mod 223.	nonn,easy,synth	1
# A036161	null	a(n) = 2^n mod 227.	nonn,easy,changed,	1
modpow2: # names: Annnnnn [a(n) = ](\d+)^n mod (\d+)
	# all done
	perl -ne \
	' if (m{\A(A\d+)\s+(a\(n\)\s*\=\s*)?(\d+)\^n\s+mod\s+(\d+)([^\.]*)\.}) {'\
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

#--------------------------
polyn:
	cat $(COMMON)/names \
	| perl -ne \
	'if (! m{\.\.\.} and m{\A(A\d{6}\s+\w\(([a-z])\)\s*\=\s*[ \d\+\-\*\/\!ank\[\]\{\}\(\)\^]+)\.})'\
	'{ print "$$1\n"; }' \
	| sed -e "s/ /\t/" -e "s/ //g" -e "y/[]{}/()()/" \
	| grep -v '\.\.' \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
	make seq2 LIST=$@.tmp
	$(DBAT) "SELECT aseqno, info \
		FROM  seq2 \
		WHERE aseqno NOT IN (SELECT aseqno FROM JOEIS) \
		ORDER BY 1" \
	>        $@.gen
	head -n4 $@.gen
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
#-------------------
such_prime:
	grep Numbers $(COMMON)/names | grep -E 'such *that' | grep -E 'is *prime' \
	| grep -v '[BRZFGPofgd]' \
	| sed -e "s/ /\t/" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
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
sumlipo:
	grep -E "[Ss]ums? " $(COMMON)/joeis_names.txt \
	| grep -viE "A004018|arra(y|ngement)|base|composite|decimal|digit|differ|divi(ding|sible|sor)|egyptian|factor|fibon" \
	| grep -viE "(hex|hept|pent)agonal|matri|necklace|nonsquare"\
	| grep -viE "permut|prime|pyramidal|ratio|reciproc|squarefree|triangular|Young" \
	| perl sumlipo.pl \
	  2>     $@.rest.tmp \
	| grep -vE "A000534" \
	| sort -k2 \
	>        $@.gen
	head -n4 $@.gen
	sort $@.rest.tmp > $@.rest
	wc -l    $@.rest
	wc   -l  $@.gen
	cut -f2  $@.gen | sort | uniq -c
sumlipo.diff:
	cut -b1-7 sumlipo.gen > d1.tmp
	cut -b1-7 sumpow.gen  > d2.tmp
	diff -wy --width=32 --suppress-common-lines d1.tmp d2.tmp
	rm -v d1.tmp d2.tmp
sumlipow:
	perl wiki_tabs.pl -e $(EX) -d $(D) sumlipo.witab \
	> sumlipo.wiki
	# | tee    sumlipo.wiki
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
	$(ASEQNO).java > temp/$(ASEQNO).java
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
	sed -e "s/seq4/suw4/g" seq4.create.sql > suw4.create.sql
	$(DBAT) -f suw4.create.sql
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
word:
	$(DBAT) "SELECT i.aseqno, 'word', 0, n.name, b.bfimax -b.bfimin + 1 \
		FROM  asinfo i, asname n, bfinfo b \
		WHERE i.aseqno = n.aseqno \
		  AND n.aseqno = b.aseqno \
		  AND i.keyword LIKE '%word%' \
		  AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
		ORDER BY 4, 1" \
	>        $@.tmp
	head -n4 $@.tmp
	wc   -l  $@.tmp
#================================
seqix:
	$(DBAT) -f seqix.create.sql
	seq 1 64 | $(DBAT) -r seqix
	$(DBAT) -4 seqix
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
analog: analog1 anasort anastret
analog1:
	perl normalize_name.pl $(COMMON)/jnames.txt \
	>        $@.tmp
	wc -l    $@.tmp
anasort: 
	sort -k3 -k2 -k1 -t "	" analog1.tmp \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
anastret:
	perl stretchable.pl anasort.tmp \
	>        $@.txt
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
#--------
