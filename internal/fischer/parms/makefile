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
#--------
all: \
	clean     \
	holperiod \
	padding   \
	periodic  \
	#
	wc -l    *.txt
help:
	grep -E "^[a-z]" makefile | sort
#----
clean:
	rm *.tmp || :
cofrsqrt: cofrsqrt1 cofrsqrt2 # get the parameters for the period of sqrt(x), from ContinuedFractionOfSqrtSequence
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat cofrsqrt2.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
cofrsqrt1:
	$(DBAT) "SELECT j.aseqno, 'cofrsqrt', i.offset1, substr(n.name, 1, 64) FROM joeis j, asinfo i, asname n \
	  WHERE j.aseqno = i.aseqno AND i.aseqno = n.aseqno \
	  AND j.superclass LIKE   'ContinuedFractionOfSqrtSequence%' ORDER BY 1" \
	>        $@.tmp
	tail -n2 $@.tmp
	wc -l    $@.tmp
cofrsqrt2:
	$(JAVA) $(PAREFL) -d $(D) cofrsqrt1.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
#----
padding: padding1 padding2 # get the parameters of PaddingSequence
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
periodic: periodic1 periodic2 # get the parameters of PeriodicSequence
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
periodic9: # pack all sources
	perl $(REFLECT)/queue.pl -p periodic1.tmp > $@.pack
#----:
frequent:
	$(DBAT) "SELECT COUNT(superclass), superclass FROM joeis \
	  WHERE superclass NOT LIKE 'A______' \
	    AND superclass NOT IN ('Sequence0', 'Sequence1', 'Sequence2', 'Sequence3', 'AbstractSequence', 'PrependSequence') \
	  GROUP BY superclass \
	  ORDER BY 1 DESC FETCH FIRST 128 ROWS ONLY" \
	| tee $@.tmp
#----
holperiod: holperiod1 holperiod2 # extract the periodic linear recurrences and convert them to padding
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat holperiod2.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
holperiod1:
	# 	A247387	holos	2	[0,1,0,0,0,0,0,0,-1]
	grep -P "holos\t\d+\t\[0\,1\,(0\,)+\-1\]"  $(FISCHER)/holref.txt \
	| grep -vP "\t(perio|pad|conti)" \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
holperiod2:
	perl holperiod.pl holperiod1.tmp \
	>        $@.tmp
#----
