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
all: absref_stat
	# grep -P "^\w" makefile
#----:
absref_stat: absref_statf absref_stato absref_stat9 # 3 AbstractSequence reflections with statistics
absref_statf:
	# make finite1
	# make absref1 MODE=finit LIST=finite1.tmp
absref_stato:
	make offinspect1
	# make absref1 MODE=noabs LIST=offinspect1.tmp
	make absref1 MODE=offin LIST=offinspect1.tmp
	# make absref1 MODE=seqwo
absref_stat9:
	tail -n16 offin.tmp noabs.tmp \
	| grep -P  "^\d\d\d\d\-" >> reflect_progress.txt
	tail -n8 reflect_progress.txt
absref1: # MODE= LIST= ; run one reflection for MODE and sequences in LIST
	$(ABSINSPECT) $(MODE) $(LIST) \
	>        $(MODE).tmp
	wc -l    $(MODE).tmp
	grep -E  "^#" $(MODE).tmp
	grep -vE "^#" $(MODE).tmp \
	| cut -f3 $(MODE).tmp | sort | uniq -c | sort -n \
	>        $(MODE).txt
	tail -n64 $(MODE).txt
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
	grep $(SUP) offinspect1.tmp | cut -f2-3 | sort | uniq -c
	# grep $(SUP) noabs.tmp | grep -vP "\t1\t" | sort 
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
offsort: # sort offin.tmp with superclasses ASC
	sort -k5.1 -k1.1 offin.tmp | sed -e "s/\r//" > offin.srt
offin_table: # create table 'offin' 
	$(DBAT) -f offin.create.sql
	grep -E "^A[0-9]" offin.tmp | sed -e "s/ //g" \
	| $(DBAT) -r offin
	$(DBAT) -4 offin
	$(DBAT) -n offin
offin_eval2: # select those with all subclasses needing the same offset patch, on 2 levels
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass \
	                            , o2.shift, o2.superclass \
	  FROM  offin o1, offin o2 \
	  WHERE o2.aseqno = o1.superclass AND o2.shift = o1.shift \
	  ORDER BY 5,3,1;" \
	| tee    $@.tmp
	wc -l    $@.tmp
offin_eval3: # select those with all subclasses needing the same offset patch, on 3 levels
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass \
	                            , o2.shift, o2.superclass \
	                            , o3.shift, o3.superclass \
	  FROM  offin o1, offin o2, offin o3 \
	  WHERE o2.aseqno = o1.superclass AND o2.shift = o1.shift \
	    AND o3.aseqno = o2.superclass AND o3.shift = o2.shift \
	  ORDER BY 7,5,3,1;" \
	| tee    $@.tmp
	wc -l    $@.tmp
offin_eval4: # select those with all subclasses needing the same offset patch, on 4 levels
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass \
	                            , o2.shift, o2.superclass \
	                            , o3.shift, o3.superclass \
	                            , o4.shift, o4.superclass \
	  FROM  offin o1, offin o2, offin o3, offin o4 \
	  WHERE o2.aseqno = o1.superclass AND o2.shift = o1.shift \
	    AND o3.aseqno = o2.superclass AND o3.shift = o2.shift \
	    AND o4.aseqno = o3.superclass AND o4.shift = o3.shift \
	  ORDER BY 9,7,5,3,1;" \
	| tee    $@.tmp
	wc -l    $@.tmp
#----
pack: # GREP=A018940 pack all sources that extend $(A)
	grep -P "$(GREP)" offin.tmp \
	| perl queue.pl -p > set.pack
unpackall: \
	A018940u \
	basecu \
	wrapconu \
	wraprecu \
	#
#--
A018940: # pack all sources that extend $(A)
	grep -P "$@" offin.tmp \
	| perl queue.pl -p > $@.pack
A018940u:
	perl queue.pl -u A018940.pack
#--
basec:
	grep -P "[a-z]" offin.tmp \
	| grep -vP "WrappedRecurrence|Memory|Triangle" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
basecu:
	perl queue.pl -u basec.pack
wrapcon:
	$(DBAT) -x "SELECT i.aseqno, 0, '->', i.offset1, j.superclass FROM asinfo i, joeis j \
	  WHERE i.aseqno = j.aseqno \
	    AND j.superclass = 'WrappedConstantTriangle' ORDER BY 1" > $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
	uedit64 $@.pack
wrapconu:
	perl queue.pl -u wrapcon.pack
wraprec:
	$(DBAT) -x "SELECT i.aseqno, 0, '->', i.offset1, j.superclass FROM asinfo i, joeis j \
	  WHERE i.aseqno = j.aseqno \
	    AND j.superclass = 'WrappedRecurrence' ORDER BY 1" > $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
	uedit64 $@.pack
wraprecu:
	perl queue.pl -u wraprec.pack
#----
patch_abstract: # patch all in the list above
	perl patch_abstract.pl liseq.txt
#----
patch_toff:
	cd .. ; make purge
	grep -iP "\bSequence[01]\b" offin.tmp\
	| perl patch_offset.pl -m toff
	cd .. ; make count dist testall GU=4
patch_noabs: # SUP= prefix offset in super(...) when "Annnnnn extends $(SUP)" 
	cd .. ; make purge
	grep -iP "$(SUP)" noabs.tmp \
	| perl patch_offset.pl -m pref
	cd .. ; make count dist testall GU=4 sumall
patch_offin: # SUP= prefix offset in super(...) when "Annnnnn extends $(SUP)" 
	cd .. ; make purge
	grep -iP "$(SUP)" offin.tmp \
	| perl patch_offset.pl -m pref
	cd .. ; make count dist testall GU=4 sumall
patch_sup:
	# make patch_noabs SUP=SkipSequence
	# make patch_offin SUP=A049150
	# make patch_offin SUP=EgyptianFractionSequence
	# make patch_noabs SUP=RecordPositionSequence
	# make patch_noabs SUP=RunLengthSequence
	# make patch_noabs SUP=PierceExpansionSequence
	# make patch_offin SUP=ContinuedFractionSequence
	# make patch_offin SUP=PaddingSequence
	# make patch_offin SUP=ConvolutionSequence
	# make patch_offin SUP=InverseSequence
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
patch_prepend: # prefix if not DEFOFF
	cd .. ; make purge
	grep -iP "PrependSequence" offin.tmp\
	| perl patch_offset.pl -m cond
	cd .. ; make count dist testall GU=8
#----
patch_fini: # prefix the Finite... constructor calls with "offset, attr,"; assume DEFOFF=0
	cd .. ; make purge
	grep -P "(Finite|Noncomputable|Brief)Sequence" offin.tmp\
	| perl patch_offset.pl -m fini
	cd .. ; make count dist testall GU=8
#----
patch_gener:
	ls -1 ../aman/A*[0-9].man \
	| perl -ne 'm{(A\d+)}; print "$$1\t0\tdummy\n";' \
	> $@.tmp
	sed -e "s/$$/\t0\tdummy/" $@.tmp \
	| perl -w patch_offset.pl -m gener
	# cd .. ; make sumall
gener2: # select those that have offset problems
	cd .. ; make seq LIST=reflect/patch_gener.tmp
	perl -ne 'if (m{\A\s*(\d+)\s+(A\d+)}) { print "$$2\t$$1\n"; }' offin.txt \
	>        $@.lst
	wc -l    $@.lst
	cd .. ; make seq2 LIST=reflect/offin.tmp
gener3:
	$(DBAT) -x "SELECT s.aseqno FROM seq s, seq2 s2 WHERE s.aseqno = s2.aseqno ORDER BY 1;" \
	| perl -ne 's/\r?\n//; my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_\n";' \
	| tee    $@.tmp
	wc -l    $@.tmp
gener4:
	cat gener3.tmp | xargs -innn grep -A1 -HP "extends|final int offset" $(JOEIS)/src/irvine/oeis/nnn.java \
	| tee    $@.tmp
#----
patch_triselect0:
	# ../aman/A337165.man:A338464        trionk  0       A337165 0       2*mN    mN      T(2n,n)
	find ../aman -name "A??????.man" | xargs -innn grep  trionk nnn \
	| grep -v "#" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
patch_triselect:
	cat patch_triselect0.tmp \
	| perl -ne 'my $$line = $$_; $$line =~ s/\s*\Z//; if ($$line =~ s/\ttrionk\t/\ttriselect\t/) { my @parts = split(/\t/, $$line); '\
	' if (substr($$parts[0], 1) > 50000) { '\
	' $$parts[5] .= ",$$parts[6]"; $$parts[5] =~ s{mN}{n}g; print join("\t", @parts) . "\n"; }} '\
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	cd .. ; make purge CC=$@ select EX=xx geditel GU=4 TO=8
patch_tripnk:
	cat patch_triselect0.tmp \
	| perl -ne 'my $$line = $$_; $$line =~ s/\s*\Z//; if ($$line =~ s/\ttrionk\t/\ttripnk\t/) '\
	' { print "$$line\n"; } '\
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	cd .. ; make purge CC=$@ select EX=xx geditel GU=4 TO=8
#----
patch_linrec: # prefix the LinearRecurrence constructor calls with "offset, "; assume DEFOFF=0
	grep   -P "LinearRecurrence" offin.tmp  \
	| perl patch_offset.pl -m pref
	cd .. ; make count dist testall GU=16
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
	cat prepskip.tmp
#----
pull: # LIST= copy the ones in LIST into ../manual
	grep -E "^A[0-9]" $(LIST) | cut -f1 | sort | uniq -w7 \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
	> $@.tmp
	cat $@.tmp | xargs -innn cp -vp $(JOEIS)/src/irvine/oeis/nnn.java ../manual
	wc -l $@.tmp
getoffset: # all that define getOffset(int), from Sean's list
	rm -f oldsrc/*.java
	cut -b19- override-of-getOffset.txt \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	cat $@.tmp | xargs -innn cp $(JOEIS)/src/irvine/oeis/nnn oldsrc
	ls -1 oldsrc | wc -l
getoffset2: # which came from treonk/arronk
	grep -iP "(matrix|triangle)Elem" oldsrc/*.java | wc
geto_comt: # comments of the ones in oldsrc
	grep -iP "// (manually|Generated)" oldsrc/*.java | tee $@.tmp
#----
triangle:
	rm -f oldsrc/*.java
	grep -P "\tTriangle\t" $(COMMON)/joeis_names.txt | cut -f1 \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
	cat $@.tmp | xargs -innn cp $(JOEIS)/src/irvine/oeis/nnn.java oldsrc
	ls -1 oldsrc | wc -l
triangle_super:
	grep -iHP "super *\(" oldsrc/*.java | tee $@.tmp
#================================
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
# tolite: # copy a list of A-numbers to joeis-lite/src - but mkdir?
# 	cat $LIST) \
# 	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
# 	| sort | xargs -innn cp -pv $(JOEIS)/src/irvine/oeis/nnn.java $(LITE)/src/irvine/oeis/nnn.java
# 	wc -l $@.txt
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
