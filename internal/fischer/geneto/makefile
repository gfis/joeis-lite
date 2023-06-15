#!make

# makefile for transition of GeneralizedEulerTransfor -> LambdaEulerTransform
# @(#) $Id$
# 2023-06-10, Georg Fischer
#
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
JOEIS=$(GITS)/joeis
SRC=src/irvine/oeis
D=0
#--------
all:
	grep -P "^\w" makefile
#----:
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
	
	