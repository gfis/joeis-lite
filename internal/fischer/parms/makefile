#!make

# makefile for parameter lists which can generate OEIS programs in Java, Python etc.
# @(#) $Id$
# 2026-11-03, Georg Fischer
#
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
LITE=$(GITS)/joeis-lite
FISCHER=$(LITE)/internal/fischer
REFLECT=$(FISCHER)/reflect
JOEIS=$(GITS)/joeis
HERE=../../joeis-lite/internal/fischer/parms
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
PAREFL=irvine.oeis.ParameterReflector
D=0
#========
# rebuild all lists
all: \
	clean     \
	cofrsqrt  \
	padding   \
	periodic  \
	recperiod \
	sigperiod \
	#
	wc -l    *.txt
#========
clean:
	rm *.tmp || : 
#----
# get the parameters for the period of sqrt(x), from ContinuedFractionOfSqrtSequence
cofrsqrt: cofrsqrt1 cofrsqrt2 cofrsqrt3
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat cofrsqrt3.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
cofrsqrt1: # determine subclasses of ContinuedFractionOfSqrtSequence
	$(DBAT) "SELECT j.aseqno, 'cofrsqrt', i.offset1, substr(n.name, 1, 64) FROM joeis j, asinfo i, asname n \
	  WHERE j.aseqno = i.aseqno AND i.aseqno = n.aseqno \
	  AND j.superclass LIKE   'ContinuedFractionOfSqrtSequence%' ORDER BY 1" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
cofrsqrt2: # extract padding parameters by reflection of ContinuedFractionOfSqrtSequence
	$(JAVA) $(PAREFL) -d $(D) cofrsqrt1.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@*tmp
cofrsqrt3: # rotate the padding by one to the right
	perl rotate.pl -r 1 -p 2 cofrsqrt2.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
#----
# get the parameters of PaddingSequence
padding: padding1 padding2 
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat padding2.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
padding1:
	$(DBAT) "SELECT j.aseqno, 'padding', i.offset1 FROM joeis j, asinfo i WHERE j.aseqno = i.aseqno \
	  AND j.superclass LIKE   'PaddingSequence%' ORDER BY 1" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
padding2:
	$(JAVA) $(PAREFL) -d $(D) padding1.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
#----
# get the parameters of PeriodicSequence
periodic: periodic1 periodic2 
	echo "# $@.txt: (aseqno, offset1, period, period_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat periodic2.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
periodic1:
	$(DBAT) "SELECT j.aseqno, 'periodic', i.offset1 FROM joeis j, asinfo i WHERE j.aseqno = i.aseqno \
	  AND j.superclass LIKE   'PeriodicSequence%' ORDER BY 1" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
periodic2:
	$(JAVA) $(PAREFL) -d $(D) periodic1.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
#----
# extract the periodic linear recurrences and convert them to padding
recperiod: recperiod1 recperiod2 
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat recperiod2.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
recperiod1:
	# 	A247387	holos	2	[0,1,0,0,0,0,0,0,-1]
	# cat $(FISCHER)/holref.txt 
	cat sigperiod3.tmp > $@.tmp
	grep -P "holos\t\d+\t\[0\,1\,(0\,)+\-1\]"  $(FISCHER)/holref.txt \
	| grep -vP "\t(perio|pad|conti)" \
	>>       $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
recperiod2:
	perl recperiod.pl  -d $(D) -f sigperiod1.tmp recperiod1.tmp \
	>        $@.tmp
#----
# grep special signatures (not from (1-x^k)) generating periodic sequences from the OEIS index, 
sigperiod: sigextract1 sigperiod2 sigperiod3 sigperiod4 
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat sigperiod4.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
sigextract1:
	perl sigextract.pl -a 16 -d $(D) $(COMMON)/../lrindex/lrindx.raw \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigperiod2: # prepare the hashmap for recperiod.pl
	cut -f4,5 sigextract1.tmp | uniq \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigperiod3: # expand the inits
	getinits -s sigextract1.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigperiod4: # convert to padding or periodic
	perl sigperiod.pl sigperiod3.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#======== various targets ====
frequent:
	$(DBAT) "SELECT COUNT(superclass), superclass FROM joeis \
	  WHERE superclass NOT LIKE 'A______' \
	    AND superclass NOT IN ('Sequence0', 'Sequence1', 'Sequence2', 'Sequence3', 'AbstractSequence', 'PrependSequence') \
	  GROUP BY superclass \
	  ORDER BY 1 DESC FETCH FIRST 128 ROWS ONLY" \
	| tee $@.tmp
#----
help:
	grep -E "^[a-z]" makefile | sort
#----

