#!make

# makefile for transition of Sequence -> AbstractSequence
# @(#) $Id$
# 2023-06-17, Georg Fischer
#
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
LITE=$(GITS)/joeis-lite
JOEIS=$(GITS)/joeis
COHERE=../../joeis-lite/internal/fischer/reflect
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
SRC=src/irvine/oeis
# JOPT=-Ddebug=$(D) -Xmx2g -Xss1g -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
JOPT=-Ddebug=$(D) -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
ifeq ($(OS),Windows_NT)
    CPS=;
else
    CPS=:
endif
JAVA=java $(JOPT) -cp "$(LITE)/dist/joeis-lite.jar$(CPS)$(JOEIS)/build.tmp/joeis.jar"
ABSINSPECT=$(JAVA) irvine.oeis.AbstractInspector
D=0
#--------
all:
	grep -P "^\w" makefile
#----:
absref_stat: absref_statf absref_stato absref_stat9 # 3 AbstractSequence reflections with statistics
absref_statf:
	make finite1
	make absref1 MODE=finit LIST=finite1.tmp
absref_stato:
	make offinspect1
	make absref1 MODE=noabs LIST=offinspect1.tmp
	make absref1 MODE=offin LIST=offinspect1.tmp
	# make absref1 MODE=seqwo
absref_stat9:
	tail -n4 offin.tmp noabs.tmp seqwo.tmp \
	| grep -P  "^\d\d\d\d\-" | tee -a reflect_progress.txt
absref1: # MODE= LIST= ; run one reflection for MODE and sequences in LIST
	$(ABSINSPECT) $(MODE) $(LIST) \
	>        $(MODE).tmp
	wc -l    $(MODE).tmp
	grep -E  "^#" $(MODE).tmp
	grep -vE "^#" $(MODE).tmp \
	| cut -f3 $(MODE).tmp | sort | uniq -c | sort -n \
	>        $(MODE).txt
	tail -n16 $(MODE).txt
#----
dead_joeis: # detect DeadSequence consistency
	# not dead in OEIS and     dead in jOEIS
	$(DBAT) -x "SELECT i.aseqno, 'dead', i.offset1, i.keyword, j.superclass \
	  FROM joeis j LEFT JOIN asinfo i ON i.aseqno = j.aseqno \
		WHERE i.keyword    NOT LIKE '%dead%'   \
		  AND j.superclass     LIKE 'DeadSeq%' \
		ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
	#     dead in OEIS and not dead in jOEIS
	$(DBAT) -x "SELECT i.aseqno, 'dead', i.offset1, i.keyword, j.superclass, '', '', '', '', '', '', n.name \
	  FROM asname n, asinfo i LEFT JOIN joeis j ON i.aseqno = j.aseqno \
		WHERE n.aseqno = i.aseqno \
		  AND i.keyword        LIKE '%dead%'   \
		  AND COALESCE(j.superclass, 'UnknownSequence') NOT LIKE 'DeadSeq%' \
		ORDER BY 1" \
	| tee    ../dead.gen
	wc -l    ../dead.gen
dead_robot: dead_joeis # generate DeadSequence's
	cd .. ; make CC=dead gener
#----
interfaces:
	cut -f1-2 $(COMMON)/joeis_names.txt | grep -v nyi | grep -P " " | grep -v Conjectural \
	| grep -P "SequenceWithOffset"
	| tee    $@.tmp
	wc -l    $@.tmp
#----
liseq: # list those with "implements Sequence"
	grep -P "\tSequence\t" $(COMMON)/joeis_names.txt \
	| perl -ne 's/\t.*/\t0/; print;' \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	$(DBAT) -f $(COMMON)/seq2.create.sql
	$(DBAT) -r seq2 < $@.tmp
	$(DBAT) "UPDATE seq2 s SET info = (SELECT offset1 FROM asinfo i WHERE s.aseqno = i.aseqno);"
	$(DBAT) -x "SELECT * FROM seq2 ORDER BY 1;" > $@.txt
	head -n2 $@.txt
	wc -l    $@.txt
#----
finite1:     # select the eligable programs
	$(DBAT) -x "SELECT i.aseqno, i.termno,  j.superclass FROM asinfo i, joeis j WHERE i.aseqno = j.aseqno \
	  AND superclass IN ('FiniteSequence', 'NoncomputableSequence', 'BriefSequence') ORDER BY 1" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
#----
offcount: # SUP=superclass ; count the different offsets for some jOEIS superclass
	grep $(SUP) $(COMMON)/joeis_names.txt | cut -f2,5 | sed -e "s/\.\..*//" | sort | uniq -c
	grep $(SUP) noabs.tmp | grep -vP "\t1\t" | sort 
#--
offinspect1: # select the eligible programs
	$(DBAT) -x "SELECT i.aseqno, i.offset1, j.superclass FROM asinfo i, joeis j WHERE i.aseqno = j.aseqno ORDER BY 1" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
offman: # check the offsets in ../manual
	ls -1 ../manual/*.java | sed -e "s/.java//" | cut -b11- > $@.tmp
	cd .. ; make seq LIST=reflect/$@.tmp
	$(DBAT) -x "SELECT s.aseqno, i.offset1, 'dummy' FROM seq s, asinfo i WHERE s.aseqno = i.aseqno" > $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	make absref1 MODE=offin LIST=$@.tmp

offlev1: # first level in class hierarchy
	grep -P "^A\d+\t[^\t]*\tA\d{6}" offin.tmp | sed -e "s/ //g" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	$(DBAT) -f $(COMMON)/seq3.create.sql
	$(DBAT) -r seq3 < $@.tmp
	$(DBAT) -x "SELECT * FROM seq3 WHERE info NOT IN (SELECT aseqno FROM seq3) ORDER BY 1" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
#----
patch_abstract: # patch all in the list above
	perl patch_abstract.pl liseq.txt
#--------
# targets for PrependSequence - skip conversion
patch_prep: patch_prepnew patch_prepext
	cd .. ; make man dist testall TO=8 GU=4
patch_prepnew: # remove any leading skip parameter in PrependSequence and append ".skip(...)" if not 0
	cat prepend0.man \
	| perl -ne 'm{\/(A\d{6})}; print "$$1\n";' \
	| perl patch_prepend.pl -m new
	cat $(GITS)/joeis-lite/$(SRC)/a161/A161306.java
patch_prepext: # remove any leading skip parameter in the constructor of sequences with "extends PrependSequence" and append ".skip(...)" if not 0
	grep PrependSequence $(COMMON)/joeis_names.txt \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	perl patch_prepend.pl -d 1 -m ext $@.tmp \
	| tee $@.debug.tmp
	cat $(GITS)/joeis-lite/$(SRC)/a088/A088802.java
patch_prep2: # those without Annnnnn in the super statement
	perl patch_prepend.pl -d 1 -m ext nosuit.man \
	| tee $@.debug.tmp
	cat $(GITS)/joeis-lite/$(SRC)/a325/A325765.java
#----
# ../../../src/irvine/oeis/a065/A065144.java:     super(new A029948().skip(1));
prepskip: # detect SkipSequence applications
	grep "))" patch_prepext.debug.tmp | cut -b10- \
	| perl -ne 'use strict; if (m{\/(A\d+).java[^\(]*\(new +(A\d+)\(\)\.skip\((\d+)\)\)}) { '\
	' my ($$aseqno, $$rseqno, $$skip) = ($$1, $$2, $$3); '\
	' print join("\t", $$aseqno, $$rseqno, $$skip) . "\n"; }'\
	| sort \
	| tee    $@.tmp
	wc -l    $@.tmp
prepskip1:
	cat prepskip.
#========
# patches for various superclasses
patches:
	cd .. ; make purge
	make patch1 DEFOFF=1 SUP=MorphismFixedPointSequence
	cd .. ; make count dist testall log TO=8 GU=8
patch1:
	grep -P $(SUP) noabs.tmp | grep -vP "\t$(DEFOFF)\t" \
	| perl -ne 's/\t(\-?\d+)\t/\t$(DEFOFF) \-\> $$1\t/; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl patch_offset.pl -d 1 $@.tmp 2>&1 \
	| tee    $@.log.tmp
	wc -l    $@.log.tmp
old_patches:
	make patch1 DEFOFF=1 SUP=MorphismFixedPointSequence
#----
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
pdiff:
	grep -E "DifferenceSequence" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
prows:
	grep -E "RowSumSequence|PartialProductSequence" offinspect2.txt \
	| perl patch_offset.pl -d 1 -m prefix \
	| tee $@.tmp
	make dist testall log TO=8 GU=8
#========
# retrofit of RaddSequence

raddlist2: # generate a list with pack/A-number
	grep RaddSequence ../joxref/joxref.txt | cut -f1 | grep -E "^A" \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
	| sort | tee $@.txt
	wc -l   $@.txt
raddsrc:
	mkdir -p radd
	cat raddlist2.txt | xargs -innn cp -v $(JOEIS)/$(SRC)/nnn.java radd
	ls -1 radd | wc -l
raddgrep:
	grep super radd/*.java \
	| tee   $@.tmp
# radd/A120218.java:    super(10, 100103, 2);
# radd/A213012.java:    super(2, 26);
# radd/A281301.java:    super(10, new Z("1000004999700144385"));
radd3gen:
	cat raddgrep.tmp \
	| perl -ne 'use strict; s/\r?\n//; my $$line = $$_; if ($$line =~ m{\/(A\d+)}) { my $$aseqno = $$1;'\
	' $$line =~ m{\((.*)}; my $$list = $$1; $$list =~ s{\)\;}{}; my @parts = split(/\, */, $$list);'\
	' print join("\t", $$aseqno, "radd" . scalar(@parts), 0, @parts) . "\n"; } '\
	|   tee radd3.gen
	wc -l   radd3.gen
#========
enpack:
	cat genet_old.txt \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
	| sort | tee $@.txt
	wc -l $@.txt
#----
diffsrc:
	rm -f $@.rest.tmp
	cat enpack.txt | xargs -innn  diff -w -C0 $(JOEIS)/$(SRC)/nnn.java $(SRC)/nnn.java 2>> $@.rest.tmp \
	| tee $@.tmp
eval_diff:
	grep -vE "GeneralizedEuler" diffsrc.tmp \
	| grep -vP "^\!\s+\*\s+[A-Z]|^\*\*\*|^\-\-\-\s+\d+" \
	| tee $@.tmp
cpold:
	cat enpack.txt | xargs -innn cp -v $(JOEIS)/$(SRC)/nnn.java oldsrc
with_f_den:
	grep -iHP "return *new *Z\[\]" oldsrc/*.java | grep -v NEG_ONE | grep "," | grep -v binom \
	| tee $@.tmp
difflist:
	cut -b1-7 genet.*.gen | sort | uniq > gen.tmp
	diff --width=40 -wy genet_old.txt gen.tmp \
	| tee $@.tmp
special_super: # grep the constructors different from "super(0, 1)"
	grep -iH super oldsrc/*.java | grep -vP "super\(0\, 1\)" \
	| tee $@.tmp
comments: # get the leading comments 
	grep -iH -P "manually|generated" oldsrc/*.java \
	| tee    $@.tmp
	wc -l    $@.tmp
	grep -f missing.tmp comments.tmp
#----
list2: # store the A-numbers in table seq2
	$(DBAT) -f $(COMMON)/seq2.create.sql
	$(DBAT) -r seq2 < genet_old.txt
	$(DBAT) -n seq2
genold:
	cat genet.??.gen \
	| grep -P "^A\d+\tgen" \
	| sort | uniq -w7 \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	$(DBAT) -f ../sql/seq4.create.sql
	$(DBAT) -r seq4 < $@.tmp
	$(DBAT) "DELETE FROM seq4 WHERE callcode NOT LIKE 'gen%';"
	$(DBAT) -444444 -x seq4 \
	>        $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
#----
check: genold list2 additional missing
additional: 
	$(DBAT) -x "SELECT * FROM seq4 s4 WHERE s4.aseqno NOT IN (SELECT aseqno FROM seq2) ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
missing:
	$(DBAT) -x "SELECT * FROM seq2 s2 WHERE s2.aseqno NOT IN (SELECT aseqno FROM seq4) ORDER BY 1" \
	| cut -f1 | sed -e "s/\r//" \
	| tee    $@.tmp
	wc -l    $@.tmp
#----
history:
	grep -iH A genet.??.gen | sed -e "s/:/\t/" | sort -k2,2 -k1,1 \
	>        $@.tmp
	head -n2 $@.tmp
	cut -f2 history.tmp | sort | uniq | wc -l
#----
existest:
	cp -v genet_old.txt ../ghead.tmp
	cd .. ; make CC=$@ test2 log TO=2 GU=64
retrogen:
	cat oldsrc/*.java \
	| perl $@.pl -d $(D) \
	| grep -vE "A032178|A344063" \
	>        $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
jpats:
	ls -1 ../genet*.jpat | cut -b 4- | xargs -innn cp -v ../nnn nnn.tmp
	ls -1 *.jpat.tmp | sed -e "s/.jpat.tmp//" -e "s/genet/t/" | xargs -innn mv -v genennn.jpat.tmp ipronnn.jpat
	rm -vf *.bak
	ls -1 iprot*.jpat | xargs -innn \
	  perl -i.bak -e 'undef $$/; my $$buffer = <>; $$buffer =~ s/GeneralizedEulerTransform/InfiniteProductTransform/g; print $$buffer;' nnn
	cp -v iprot*.jpat ..
rest:
#	
	
	sed -e "s/GeneralizedEulerTransform/InfiniteProductTransform/g" nnn > nnn.jpat
	
#----
ratpow:
	cd $(COMMON) ; grep -iP "(Expansion of( the)?|G\.f\.\:?) *prod(uct)?\_\{\w\>" jcat25.txt | grep -E "^%[NFCY]" \
	| grep -P "\^\(\d\/" | perl nyi.pl -p 2>&1 \
	| grep -svE "Decimal expansion" \
	| grep -sP "^.[A-Z] " \
	>        $@.tmp
	cp -v $(COMMON)/$@.tmp .
	wc -l    $@.tmp
