#!make

# makefile for reflections about jOEIS programs
# @(#) $Id$
# 2023-06-17, Georg Fischer
#
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
LITE=$(GITS)/joeis-lite
JOEIS=$(GITS)/joeis
COHERE=../../joeis-lite/internal/fischer/reflect
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
ROBOT=$(GITS)/OEIS-mat/robot
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
all: absref_stat direct dirarr
	# grep -P "^\w" makefile
help:
	grep -E "^[a-z]" makefile | sort
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
absref_stat2:
	make absref1 MODE=trian LIST=offinspect1.tmp
absref_stat9:
	make offin
	tail -n16 offin.tmp \
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
dirarr_db: dirarr_reflect dirarr_load dirarr_dump # build a table of all DirectSequences
dirarr_reflect: # extract all sequences with keywords "tabl|tabf" that implement DirectArray
	perl dirarr.pl $(COMMON)/joeis_names.txt \
	| $(ABSINSPECT) dirarr - \
	>        dirarr.tmp
	head -n4 dirarr.tmp
	wc -l    dirarr.tmp
dirarr_load:
	$(DBAT) -f $(COMMON)/dirarr.create.sql
	grep -E "^A[0-9]+" dirarr.tmp \
	| perl -ne 'my ($$aseqno, $$offset1, $$superclass) = split(/\t/); print join("\t", $$aseqno, "dirarr", $$offset1, "", "") . "\n";'\
	| $(DBAT) -r dirarr
	# $(DBAT) "INSERT INTO dirarr values('A006942', 0, 'dirarr', '', '');"
	$(DBAT) -n   dirarr
dirarr_dump:
	$(DBAT) -x "SELECT aseqno, offset1 FROM dirarr ORDER BY 1" > $(ROBOT)/dirarr.txt
#----
direct_db: direct_reflect direct_load direct_dump # build a table of all DirectSequences
direct_reflect: # extract all sequences that implement DirectSequence
	sed -e "s/\t/\t0\t/" $(COMMON)/joeis_list.txt \
	| $(ABSINSPECT) direct - \
	>        direct.tmp
	head -n4 direct.tmp
	wc -l    direct.tmp
direct_load:
	$(DBAT) -f $(COMMON)/direct.create.sql
	grep -E "^A[0-9]+" direct.tmp \
	| perl -ne 'my ($$aseqno, $$offset1, $$superclass) = split(/\t/); print join("\t", $$aseqno, "direct", $$offset1, "", "") . "\n";'\
	| $(DBAT) -r direct
	# $(DBAT) "INSERT INTO direct values('A006942', 0, 'direct', '', '');"
	$(DBAT) -n   direct
direct_dump:
	$(DBAT) -x "SELECT aseqno, offset1 FROM direct ORDER BY 1" > $(ROBOT)/direct.txt
#========
hasram: # extract all that extend Triangle with hasRAM()=true
	$(DBAT) -x "SELECT i.aseqno, i.offset1, j.superclass FROM asinfo i, joeis j\
	    WHERE i.aseqno = j.aseqno \
	      AND i.keyword LIKE '%tabl%' \
	      AND j.superclass NOT IN ('LambdaTriangle','LambdaArray','PartitionTransformTriangle') \
	    ORDER BY 1" \
	| $(ABSINSPECT) hasram - \
	| grep -vP "\bget\(\t" | sed -e "s/\t/\tH\t/" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#========
K=
vector: dirseq dirman dirdate dirimp hasram known funct # prepare for and create file vector.txt for the classification of all A-numbers
	perl build_vector.pl $(K)
	cut -b1-1024 vector.txt
	ls -al       vector.txt
dirman: # DirectSequences in ../manual
	grep -iHP "oeis\.(DirectSequence|LambdaSequence)" ../manual/*.java \
	| perl -ne 'm{(A\d+)}; print "$$1\tD\n";' \
	>    $@.tmp
	sort $@.tmp dirseq.man | uniq \
	| tee dirseq.man
	wc -l dirseq.man
dirdate: # grep LambdaSequences from aman/date.man
	grep -P "^A\d{6}\s+lambdan" ../aman/`date +%Y-%m-%d`.man | cut -b1-9 | sed -e "s/l/E/" \
	| tee -a dirseq.man
	wc -l    dirseq.man
dirseq: # DirectSequences 'D', explicit "implementing D.S.", not inherited
	grep DirectSequence $(COMMON)/joeis_list.txt | grep -P "^A\d+\s" \
	| sed -e "s/\t/\tD\t/" -e "s/DirectSequence//" \
	>        $@.txt
	head -n2 $@.txt
	wc -l    $@.txt
dirarr: # DirectArray 'T', explicit "implementing DirectArray", not inherited
	grep DirectArray $(COMMON)/joeis_list.txt | grep -P "^A\d+\s" \
	| sed -e "s/\t/\tT\t/" -e "s/DirectArray//" \
	>        $@.txt
	head -n2 $@.txt
	wc -l    $@.txt
dirimp: # DirectSequences 'E', inherited from LambdaSequence etc., and 'M', 'X', otherwise 'A'
	$(DBAT) -x "SELECT aseqno, CASE \
	    WHEN superclass IN \
	        ( 'BeattySequence' \
	        , 'CachedSequence' \
	        , 'HypergeometricSequence' \
	        , 'LambdaSequence' \
	        , 'MultiplicativeSequence' \
	        , 'PaddingSequence' \
	        , 'PeriodicSequence' \
	        )                        THEN 'E' \
	    WHEN superclass IN \
	        ( 'FiniteSequence' \
	        , 'BriefSequence' \
	        , 'NoncomputableSequence' \
	        )                        THEN 'B' \
	    WHEN superclass IN \
	        ( 'MemorySequence' \
	        )                        THEN 'M' \
	    WHEN superclass IN \
	        ( 'DecimalExpansionSequence' \
	        , 'PolynomialRootExpansionSequence' \
	        )                        THEN 'X' \
	    WHEN superclass IN \
	        ( 'LambdaTriangle' \
	        )                        THEN 'T' \
	    WHEN superclass IN \
	        ( 'LambdaArray' \
	        )                        THEN 'U' \
	    WHEN superclass IN \
	        ( 'LambdaTable' \
	        )                        THEN 'S' \
	    ELSE                              'J' \
	    END FROM joeis j  ORDER BY 1" \
	| sed -e "s/\r//" \
	>        $@.txt
	head -n2 $@.txt
	wc -l    $@.txt
funct: # extract from jOEIS source
	cp $(JOEIS)/src/irvine/math/function/Functions.java $@.tmp
	cat $(LITE)/src/irvine/math/function/Functions.java >> $@.tmp || :
	perl read_functions.pl $@.tmp \
	| grep -vP "A007919" \
	| sort | uniq -w7 \
	| tee    funct.txt
	wc -l    funct.txt
known: # extract known functions
	grep -P "^[A-Z]\d+\tK" $@.man \
	| tee $@.txt
	wc -l $@.txt
#========
finite1:     # select the eligable programs
	$(DBAT) -x "SELECT i.aseqno, i.termno,  j.superclass FROM asinfo i, joeis j WHERE i.aseqno = j.aseqno \
	  AND superclass IN ('FiniteSequence', 'NoncomputableSequence', 'BriefSequence') ORDER BY 1" \
	>        $@.tmp
	head -n2 $@.tmp
	wc -l    $@.tmp
#----
genall: genall1 genall2 # assemble all *.gen *.man aman/*.man
	grep -f genall2.tmp genall1.tmp > $@.gen
	head -n2 $@.gen
	wc -l    $@.gen
genall1:
	cat ../*.gen ../*.man ../aman/*.man \
	| perl -ne 's{\A[^A][^A]?[^A]?[^A]?}{}; print if m{\AA};'\
	| sort | uniq -w32 > $@.tmp
	wc -l $@.tmp
genall2:
	cut -f1 offin.tmp > $@.tmp
genall3: # count the callcodes
	cut -f2 genall.gen | sort | uniq -c | sort | tee $@.tmp
#================
queue: # LIST=
	perl queue.pl -p $(LIST) > $(LIST).pack
#----
BASE=PolynomialFieldSequence
pack_base: # BASE= pack all jOEIS programs that extend same base class $(BASE)
	grep -P "\t$(BASE)" $(COMMON)/joeis_names.txt \
	| perl -pe 's/^([B-Z])/A/;' \
	>                 list.$(BASE).tmp
	wc -l             list.$(BASE).tmp
	perl queue.pl -p  list.$(BASE).tmp >  pack.$(BASE).tmp
	grep -P "super\(" pack.$(BASE).tmp > super.$(BASE).tmp
	wc -l *.$(BASE).tmp
#----
GREP=NestedSequence
pack_nest: pack_nest1 pack_nest2 pack_nest3 pack_nest4 # GREP= pack all extending $(GREP)
pack_nest1: # pack the relevant *.java
	wc -l $(COMMON)/joeis_names.txt
	grep -P "\t$(GREP)" $(COMMON)/joeis_names.txt \
	| perl -pe 's/^([B-Z])/A/;' \
	| tee    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
	cp -v $@.pack pack.$(GREP).tmp
pack_nest2: # grep super calls and encode them
	grep -P " class |super\(" pack_nest1.pack \
	| perl -pe 's/\{ *\r?\n/\t/; s/ extends \w+ *//; s/public class //;' \
	| endirect \
	| tee    $@.super.tmp
pack_nest3: # extract the underlying DirectSequences [DEFK]
	grep -P "\d\,\s*new [B-FKM]\d{6}" pack_nest2.super.tmp \
	| sort -k4,4 \
	| tee    $@.direct.tmp
	grep -P "\d\,\s*new A"            pack_nest2.super.tmp \
	| sort -k4,4 \
	| tee    $@.nondir.tmp
	wc -l    pack_nest*.tmp
pack_nest4: # grep the broken ones
	grep -P "v \-\> *\t" pack_nest3.direct.tmp
#----
hasoc_prep: # DIR= grep all that have a constructor with an isolated offset parameter
	find src/irvine/oeis -iname "*.java" | xargs -l grep -P "(public|protected) \w+\(final *int *offset" \
	| tee    $@.tmp
hasoc: # create table 'hasoc'
	perl $@.pl hasoc_prep.tmp \
	| sort | uniq -w7 \
	>        $@.tmp
	tail -n8 $@.tmp
	wc -l    $@.tmp
	$(DBAT) -f hasoc.create.sql
	$(DBAT) -r hasoc < $@.tmp
	$(DBAT) -n hasoc#----
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
memoff1: # MemorySequencd with offset != 0
	grep -P "\tMemorySequence\t" $(COMMON)/joeis_names.txt \
	| cut -f1,5 | cut -b1-9 | grep -vP "\s0" \
	| tee    $@.tmp
	wc -l    $@.tmp
#----
morphlist: # print a seq4 parameter list of all subclasses of MorphismFixedPointSequence
	cat morphism.use.tmp \
	| perl -ne 'm{(A\d{6})}; print "$$1\t0\t\t\n";' \
	>        $@.1.tmp
	tail -n2 $@.1.tmp
	wc -l    $@.1.tmp
	make absref1 MODE=morph LIST=$@.1.tmp \
	| tee    $@.tmp
	tail -n2 $@.tmp
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
offindep: # superclasses that do not occur in offin 1175
	$(DBAT) -x "SELECT DISTINCT(o2.superclass) FROM offin o2 WHERE o2.aseqno NOT IN (SELECT o1.superclass FROM offin o1) ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
offindep2: # superclasses that do occur in offin
	$(DBAT) -x "SELECT o2.superclass, COUNT(o2.aseqno) FROM offin o2 WHERE o2.aseqno IN (SELECT o1.superclass FROM offin o1) GROUP BY o2.superclass ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
offindep3: # superclasses that do not occur in offin 627
	$(DBAT) -x "SELECT DISTINCT(o2.superclass) FROM offin o2, joeis j \
	  WHERE o2.aseqno NOT IN (SELECT o1.superclass FROM offin o1) \
	    AND o2.superclass = j.aseqno \
	    AND j.superclass LIKE 'AbstractSequence' \
	  ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
offsort: # sort offin.tmp with superclasses ASC
	sort -k5.1 -k1.1 offin.tmp | sed -e "s/\r//" > offin.srt
offin: # create table 'offin'
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
offpack: # pack all jOEIS sources that have wrong offsets - edit them
	perl queue.pl -p offin.tmp > $@.pack
	e $@.pack
offunpack: # unpack the edited sources into joeis-lite/src
	perl queue.pl -uf offpack.pack
#----
pack_grep: # GREP=A018940 pack all sources that extend $(GREP)
	grep -P "$(GREP)" offin.tmp \
	| perl queue.pl -p > set.pack
unpackall:
	# cd .. ; make purge
#	# make unpack1 P=A018940
#	# make unpack1 P=basec
#	# make unpack1 P=wrapcon
#	# make unpack1 P=wraprec
# 2023-07-12:
#	# cd .. ; make CC=A001482 gener
#	# cd .. ; make CC=A004035 gener
#	# cd .. ; make CC=A105599 gener
#	# make unpack1 P=overgo
#	# make unpack1 P=based
#	# make unpack1 P=triangle0
#	# make unpack1 P=A000217
#	# make unpack1 P=triangle1
#	# make unpack1 P=memfun
#	# cp -pv ../hold_many/A*.java ../manual
#	# cp -pv ../hold_tresimple/A*.java ../manual
# 2023-07-12:
#	make unpack1 P=trionk2
#	make unpack1 P=offin.07-13
#	make unpack1 P=memor14
#	make unpack1 P=protect14
#	cp -pv ../hold_man/A*.java ../manual
#	cp -pv ../hold_robots/A*.java ../manual
#	cd .. ; rm -f manual/A171238.java
#	cd .. ; make CC=A105599 gener
#	cd .. ; make CC=A115422 gener
#	cd .. ; make CC=refl_trionk man dist testall log TO=8 GU=4 pack1
#	cd .. ; make CC=A052179 gener
#	cd .. ; make CC=A055235 gener
#	cd .. ; make CC=A057036 gener
#	cd .. ; make CC=A067067 gener
#	cd .. ; make CC=A067480 gener
#	cd .. ; make CC=A069588 gener
#	cd .. ; make CC=A098941 gener
#	cd .. ; make CC=A105471 gener
#	cd .. ; make CC=A169964 gener
#	make unpack1 P=offin16
#	make unpack1 P=hasoc16a
#	perl queue.pl -uf hasoc16d.pack
#	cd .. ; make CC=refl_hasoc16d man dist testall log TO=8 GU=4 pack1
# 2023-07-17
#	perl queue.pl -uf hasoc17b.pack
#	cd .. ; make CC=refl_hasoc17b man dist testall log TO=10 GU=2 pack1
# 2023-07-18:
#	make unpack1 P=hasoc18a
#	cd .. ; cp -pv hold/*.java manual
#	make hasoc18b
#	make unpack1 P=hasoc18b
#	cd .. ; make CC=refl_hasoc18b man dist testall log TO=8 GU=32 pack1
# 2023-07-21:
#	make unpack1 P=hasoc21a
#	make unpack1 P=hasoc21b
#	make unpack1 P=hasoc21c
#	cd .. ; cp -pv hold/*.java manual
#	cd .. ; make CC=refl_hasoc21c man dist testall log TO=4
# 2023-07-22:
#	make unpack1 P=hasoc22a
#	cd .. ; cp -pv hold/*.java manual
#	cd .. ; make CC=refl_hasoc22a man dist testall log TO=4
# 2023-07-22:
	make unpack1 P=offin23a
	make unpack1 P=offin23b
	cd .. ; cp -pv hold/*.java manual
	cd .. ; make CC=refl_offin23a man dist testall log TO=4 GU=2
	make absref_stat
#--
unpack1: # P= ; unpack 1 *.pack, and write ../refl_$(P).gen
	perl queue.pl -u $(P).pack
	grep -P "\A\#\!queue" $(P).pack | cut -f2 | grep -v A999 > ../refl_$(P).gen
#--------
# 2023-10-17, introduce interface DirectSequence
direct17:
	perl queue.pl -p direct17.man \
	| perl patch_queue.pl -m $@ \
	>        $@.pack
	uedit64  $@.pack
#--------
offin23b:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass, h.parmno, h.parms \
	  FROM offin o1 LEFT JOIN hasoc h ON o1.superclass = h.superclass \
	  ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| grep -vE "A173930" \
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl patch_queue.pl -m $@ \
	>        $@.pack
	uedit64  $@.pack
offin23a:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass, h.parmno, h.parms \
	  FROM offin o1 LEFT JOIN hasoc h ON o1.superclass = h.superclass \
	  ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| grep -vE "A173930" \
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl patch_queue.pl -m $@ \
	>        $@.pack
	uedit64  $@.pack
#--------
hasoc22a:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass, h.parmno, h.parms \
	  FROM offin o1 LEFT JOIN hasoc h ON o1.superclass = h.superclass \
	  ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| grep -vf ../refl_hasoc22a.javer.tmp \
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl patch_queue.pl -m $@ \
	>        $@.pack
	uedit64  $@.pack
hasoc21c:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass, h.parmno, h.parms \
	  FROM offin o1, hasoc h\
	  WHERE o1.superclass = h.superclass \
	  ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	>        $@.pack
	uedit64  $@.pack
hasoc21b:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass, h.parmno, h.parms \
	  FROM offin o1, hasoc h\
	  WHERE o1.superclass = h.superclass \
	  ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	>        $@.pack
	uedit64  $@.pack
hasoc21a:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass, h.parmno, h.parms \
	  FROM offin o1, hasoc h\
	  WHERE o1.superclass = h.superclass \
	  ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	>        $@.pack
	uedit64  $@.pack
hasoc18b:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass FROM offin o1 \
	  WHERE o1.superclass IN ('A003285','A007695','A011804','A027157','A047749','A133687','A285012','A318795') \
	    ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl patch_queue.pl -m hasoc18b \
	>        $@.pack
	uedit64  $@.pack
hasoc18a:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass FROM offin o1 \
	  WHERE o1.superclass IN (SELECT superclass FROM hasoc) \
	    ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	>        $@.pack
	uedit64  $@.pack
hasoc16z:
	cd .. ; make CC=A052179 select EX=xx
	cd .. ; make CC=A055235 select EX=xx
	cd .. ; make CC=A057036 select EX=xx
	cd .. ; make CC=A067067 select EX=xx
	cd .. ; make CC=A067480 select EX=xx
	cd .. ; make CC=A069588 select EX=xx
	cd .. ; make CC=A098941 select EX=xx
	cd .. ; make CC=A105471 select EX=xx
	cd .. ; make CC=A169964 select EX=xx
#--
hasoc16a:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass FROM offin o1 \
	  WHERE o1.superclass IN (SELECT superclass FROM hasoc) \
	    AND o1.aseqno NOT IN (SELECT superclass FROM offin) ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl -ne 's{(\Apublic +class +A\d+ +extends +[^\{]+ *\{)}'\
	'  {$$1\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$$\(ASEQNO\)\(\) \{\n    super\(\$$\(OFFSET\)\);\n  \}}; print; '\
	>        $@.pack
	uedit64  $@.pack
hasoc16b:
	$(DBAT) -x "SELECT DISTINCT o1.superclass, i.offset1, '->', i.offset1, j.superclass FROM offin o1, joeis j, asinfo i \
	  WHERE o1.superclass = j.aseqno \
	    AND  j.aseqno     = i.aseqno \
	    AND  j.superclass IN (SELECT superclass FROM hasoc) \
	  ORDER BY 1" \
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl -ne 's{(\Apublic +class +A\d+ +extends +[^\{]+ *\{)}'\
	'  {$$1\n\n  \/\*\* Constructor with offset\.\n   \* \@param offset first index\n   \*\/\n  public \$$\(ASEQNO\)\(final int offset\) \{\n    super\(offset\);\n  \}}; print; '\
	>        $@.pack
	uedit64  $@.pack
hasoc16c:
	grep -P "  (protected|public) *A\d+\(final ([^i]|[^\,]+\,)" hasoc16b.pack | tee $@.tmp
	uedit64 $@.tmp
hasoc16d:
	perl patch_queue.pl -m hasoc16 hasoc16b.pack > $@.pack
hasoc17a:
	$(DBAT) -x "SELECT o1.aseqno, o1.shift, o1.superclass FROM offin o1 \
	  WHERE o1.superclass IN (SELECT superclass FROM hasoc) \
	    ORDER BY 1" \
	| perl -ne 's{\-\>}{\t\-\>\t}; print; '\
	| tee    $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	>        $@.pack
	uedit64  $@.pack
hasoc17b:
	perl patch_queue.pl -m hasoc17 hasoc17a.pack > $@.pack
	uedit64  $@.pack
#--
A000217: # pack all sources that extend $(A)
	grep -P "$@" offin.tmp | perl queue.pl -p \
	| perl -ne 's{(\Apublic +class +A\d+ +extends *$@ *\{)}'\
	'  {$$1\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$$\(ASEQNO\)\(\) \{\n    super\(\$$\(OFFSET\)\);\n  \}}; print; '\
	>        $@.pack
	uedit64  $@.pack
A018940: # pack all sources that extend $(A)
	grep -P "$@" offin.tmp | perl queue.pl -p > $@.pack
#--
basec:
	grep -P "[a-z]" offin.tmp \
	| grep -vP "WrappedRecurrence|Memory|Triangle" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
based:
	grep -P "[a-z]" offin.tmp \
	| grep -vP "Memory|\bTriangle" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
#--
memfun:
	grep -P "MemoryFunction" offin.tmp \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl -ne 's{(\Apublic +class +A\d+ +extends +[^\{]+ *\{)}'\
	'  {$$1\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$$\(ASEQNO\)\(\) \{\n    super\(\$$\(OFFSET\)\);\n  \}}; print; '\
	>        $@.pack
	uedit64  $@.pack
#--
overgo: # which do override getOffset()?
	cat override-of-getOffset.txt \
	| perl -ne 'm{(A\d{6})}; print "$$1\n";' \
	>        $@.tmp
	tail -n2 $@.tmp
	cd .. ; make seq LIST=reflect/$@.tmp
	$(DBAT) -x "SELECT s.aseqno, 0, '->', i.offset1, j.superclass FROM seq s, asinfo i, joeis j \
	  WHERE s.aseqno = i.aseqno AND i.aseqno = j.aseqno ORDER BY 1" \
	>        $@.2.tmp
	wc -l    $@.2.tmp
	# $(ABSINSPECT) offin $@.2.tmp \
	# >        $@.3.tmp
	perl queue.pl -p $@.2.tmp > $@.pack
	uedit64  $@.pack
overgo2: # repeat the nes that failed
	cd .. ; make seq LIST=reflect/$@.fail
	$(DBAT) -x "SELECT s.aseqno, 0, '->', i.offset1, j.superclass FROM seq s, asinfo i, joeis j \
	  WHERE s.aseqno = i.aseqno AND i.aseqno = j.aseqno ORDER BY 1" \
	>        $@.2.tmp
	wc -l    $@.2.tmp
	# $(ABSINSPECT) offin $@.2.tmp \
	# >        $@.3.tmp
	perl queue.pl -p $@.2.tmp > $@.pack
	uedit64  $@.pack
#--
trionk: # insert an IIB into those stemming from callcode=trionk
	grep -B20 -P "super.compute\(" offin.pack  | grep -P "#!queue" | cut -f2- \
	| perl queue.pl -p \
	| perl -ne 's{(\Apublic +class +A\d+ +extends +[^\{]+ *\{)}'\
	'  {$$1\n\n  \/\*\* Construct the sequence\. \*\/\n  public \$$\(ASEQNO\)\(\) \{\n    setOffset\(\$$\(OFFSET\)\);\n  \}}; print; '\
	| perl -ne 's{(private int mN = *)(\d+) *\- *(\d+)}{"$$1" . ($$2 - $$3)}e; print; '\
	>        $@.pack
	uedit64  $@.pack
#--
triangle1: # extends Triangle
	grep -P "\bTriangle" offin.tmp \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp \
	| perl -ne 's{(^\s*hasRAM\()}{    setOffset\(\$$\(OFFSET\)\);\n$$1}m; print; '\
	| perl -e 'undef $$/; while (<>) { s{(extends *\w+ *\{\n)(\s*\@Override)}{$$1\n  \/\*\* Construct the sequence\. \*\/\n  public \$$\(ASEQNO\)\(\) \{\n    super\(\$$\(OFFSET\)\);\n    hasRAM\(false\);\n  \}$$2}mg; print; } '\
	>        $@.pack
	uedit64  $@.pack
#--
wrapcon: # extends WrappedConstantTriangle
	$(DBAT) -x "SELECT i.aseqno, 0, '->', i.offset1, j.superclass FROM asinfo i, joeis j \
	  WHERE i.aseqno = j.aseqno \
	    AND j.superclass = 'WrappedConstantTriangle' ORDER BY 1" > $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
	uedit64 $@.pack
wraprec: # extends WrappedRecurrence
	$(DBAT) -x "SELECT i.aseqno, 0, '->', i.offset1, j.superclass FROM asinfo i, joeis j \
	  WHERE i.aseqno = j.aseqno \
	    AND j.superclass = 'WrappedRecurrence' ORDER BY 1" > $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
	perl queue.pl -p $@.tmp > $@.pack
	uedit64 $@.pack
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
#----
gen_lambdin: # extract all CCs "lambdin" from../*.gen
	grep -h lambdin ../*.gen | endirect | sort | uniq | tee gen_lambdin.tmp
conv_lambdin: # convert CC=lambdin -> CC=lambdan
	grep -P "^[^A]" gen_lambdin.tmp \
	| grep -vP "^.(352892|135964|135965|336642)\t" \
	| lambdian | tee ../aman/$@.tmp
	wc -l            ../aman/$@.tmp
	grep -P "\#2"    ../aman/$@.tmp
move_lambdin: # make it "manual" for addpass target
	cp -v ../aman/conv_lambdin.tmp ../aman/conv_lambdin.man
#f	A067792 1       FAIL    ,2,3,5,7,7      computed:       ,3,5,5,11,7
#f	A073170 3       FAIL    ,1,2,3  computed:       ,-1,0,1
#f	A083242 3       FAIL    ,3,2    computed:       ,5,7
#f	A093051 3       FATAL   Exception Division by zero.     , irvine.math.z.Div.divideAndRemainder(Unknown Source), irvine.m
#f	A156296 2       FAIL    ,10,140,5740    computed:       ,140,5740,700280
#----
gen_pfs: # generate code from/for PolynomialFieldSequence; 2025-02-28 BP
	perl gen_pfs.pl -d 1 ../../../src/irvine/oeis/PolynomialFieldSequence.java \
	| tee   gen_pfs.txt

