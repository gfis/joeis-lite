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
ABSINSPECT=$(JAVA) irvine.oeis.AbstractInspector
D=0
#--------
all: absref_stat direct_db dirarr_db
	# grep -P "^\w" makefile
help:
	grep -E "^[a-z]" makefile | sort
#----:
frequent:
	$(DBAT) "SELECT COUNT(superclass), superclass FROM joeis \
	  WHERE superclass NOT LIKE 'A______' \
	    AND superclass NOT IN ('Sequence0', 'Sequence1', 'Sequence2', 'Sequence3', 'AbstractSequence', 'PrependSequence') \
	  GROUP BY superclass \
	  ORDER BY 1 DESC FETCH FIRST 128 ROWS ONLY" \
	| tee $@.tmp
#----
padding: padding1 padding2 # get the parameters of PaddingSequence
padding1:
	$(DBAT) "SELECT j.aseqno, 'padding', i.offset1 FROM joeis j, asinfo i WHERE j.aseqno = i.aseqno \
	  AND j.superclass LIKE   'PaddingSequence%' ORDER BY 1" \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
padding2:
	$(JAVA) irvine.oeis.ParameterReflector -d $(D) padding1.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp
#----
periodic: periodic1 periodic2 # get the parameters of PeriodicSequence
periodic1:
	$(DBAT) "SELECT j.aseqno, 'periodic', i.offset1 FROM joeis j, asinfo i WHERE j.aseqno = i.aseqno \
	  AND j.superclass LIKE   'PeriodicSequence%' ORDER BY 1" \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
periodic2:
	$(JAVA) irvine.oeis.ParameterReflector -d $(D) periodic1.tmp \
	2>       $@.rest.tmp \
	| tr -d "\r" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp $@.rest.tmp
periodic9: # pack all sources
	perl $(REFLECT)/queue.pl -p periodic1.tmp > $@.pack
#----
holperiod: 	# 	A247387	holos	2	[0,1,0,0,0,0,0,0,-1]
	grep -P "holos\t\d+\t\[0\,1\,(0\,)+\-1\]"  $(FISCHER)/holref.txt \
	| tee    $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp 
	grep -vP "\t(peri|pad)" $@.tmp | wc
