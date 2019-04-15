#!make

# @(#) $Id$
# 2019-04-13: test all sequences, with timeout
# 2019-04-09, Georg Fischer
#----------------
JOEIS=../../gitups/joeis
GITS=../../gits
LITE=$(GITS)/joeis-lite
COMMON=$(GITS)/OEIS-mat/common
LINREC=$(GITS)/OEIS-mat/linrec
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
# BATCH=java -Xms1024m -Xmx2048m -cp build.tmp/joeis.jar irvine.test.BatchTest -v
BATCH=java -cp build.tmp/joeis.jar irvine.test.BatchTest -v
LIST=strip.tmp
WITHB=-b ../../gits/OEIS-mat/common/bfile 
TO=2
MANY=999999
START=A
#----

all: joeis_list strip testb
#----
testloop:
	for number in 1 2 3 4 ; do \
		make testb ; \
	done

testb:# Test against b-files, fallback stripped
	cut -b1-7 exclude.man | sed -e "s/\r//" | sort | uniq > exclude.tmp
	export START=`grep restart batch.log | tail -n1 | cut -b1-7` ; \
	grep -vf  exclude.tmp strip.txt | head -n$(MANY) \
	| sed -n "/^$(START)/,/^A999999/p" > strip.tmp
	$(BATCH) $(WITHB) -t $(TO) \
			strip.tmp   2>&1 > batch.log
	grep -E "FA| at "  batch.log | tee fail.log
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
			export START=`grep restart batch.log | tail -n1 | cut -b1-7` ; \
    	echo `date +%H:%M:%S` $$START ; \
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
joeis_list: joeis_list1 joeis_list2 # get the A-numbers and used superclasses of all implemented sequences
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
strip: # attach terms from 'stripped' to A-numbers for BatchTest
	cut -b1-7 joeis_list.txt > aseqnos.tmp
	grep -f   aseqnos.tmp $(COMMON)/stripped \
	>         $@.txt
	head -n4  $@.txt
	wc -l     $@.txt
#----