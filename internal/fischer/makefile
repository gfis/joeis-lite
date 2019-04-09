#!make

# Makefile for joeis sequence geneariton and testing 
# 2019-04-06: for joeis-lite
# 2019-03-28, Georg Fischer
#
B=
BATCH=java -jar ../../dist/joeis-lite.jar -v $(B)
GITS=../../..
JOEIS=$(GITS)/../gitups/joeis
COMMON=$(GITS)/OEIS-mat/common
LINREC=$(GITS)/OEIS-mat/linrec
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
MANY=44444
D=0

all: 
	# Possible targets:
	grep -E "^[a-z]" makefile
#--------------------------
joeis_load: # populate a table with A-numbers and superclass names of implemented sequences
	$(DBAT) -f joeis.create.sql
	sed -e "s/ /\t/" joeis_list.txt | grep -E "^A" \
	| $(DBAT) -m csv -r joeis
	$(DBAT) -4 joeis
	$(DBAT) -n joeis
joeis_list: joeis_list1 joeis_List2
joeis_list1:
	find $(JOEIS)/src/irvine/oeis -iname "A??????.java" \
	| xargs -l grep -E " extends" > $joeis_list.1.tmp
joeis_list2:
	grep -E "^public class" joeis_list.1.tmp \
	| sed -e "s/public class *//" -e "s/ extends / /" -e "s/ {.*//" \
	>        joeis_list.txt
	head -n4 joeis_list.txt
	wc -l    joeis_list.txt
joeis_stat:
	$(DBAT) -x "SELECT count(superclass), superclass \
		FROM joeis \
		WHERE superclass NOT LIKE 'A______'  \
		GROUP BY superclass \
		ORDER BY 1 DESC" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
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
#--------------------------
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
batch_fini: # fini_check
	cat fini_check.txt > subset.tmp
	make test
test:
	$(BATCH) subset.tmp
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
	make seq2 INFO=$(LINREC)/lrlink_mma2.tmp
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
zip: # ZIP file with all newly generated Java sequences
	zip -r error42.`date +%Y-%m-%d`.zip ../../src/irvine/oeis/a*
#---------------------------
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
fini_check: 
	$(DBAT) -x "SELECT i.aseqno, d.data \
	    FROM  asinfo i, asdata d \
	    WHERE i.aseqno = d.aseqno \
	      AND i.aseqno NOT IN (SELECT aseqno FROM joeis) \
	      AND keyword LIKE '%fini%'  \
	      AND keyword LIKE '%full%'  \
	      AND keyword LIKE '%synth%' \
	" \
	| tee $@.txt
	wc -l $@.txt 
#----
fini_gen:
	head -n$(MANY) fini_check.txt \
	| perl gen_pattern.pl -n $(COMMON)/names -p finiPattern.jav \
	| tee $@.log 
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
	make seq INFO=$@.tmp
	$(DBAT) "SELECT aseqno \
	    FROM  seq \
	    WHERE aseqno NOT IN (SELECT aseqno FROM joeis) \
	" \
	| tee $@.tmp
	wc -l $@.tmp
#----------------
seq: # parameter: $(INFO)
	$(DBAT) -f $(COMMON)/seq.create.sql
	cut -b1-7 $(INFO) | grep -E "^A" | $(DBAT) -m csv -r seq
	$(DBAT) -n seq
seq2: # parameter: $(INFO)
	$(DBAT) -f $(COMMON)/seq2.create.sql
	cat $(INFO) | grep -E "^A" | sort | uniq > seq2.tmp
	$(DBAT) -m csv -r seq2 < seq2.tmp
	$(DBAT) -4 seq2
	$(DBAT) -n seq2
delseq: seq # parameters: $(TAB) $(INFO)
	$(DBAT) -v "DELETE FROM $(TAB) WHERE aseqno IN (SELECT aseqno FROM seq)"
