#!make

# Makefile in gits/joeis-lite/internal/fischer/supply: update the database tables 
# @(#) $Id$
# 2026-09-24, Georg Fischer: copied from ../makefile
#----------------
GITS=../../../..
LITE=$(GITS)/joeis-lite
HERE=$(GITS)/joeis-lite/internal/fischer/supply
JOEIS=$(GITS)/joeis
DATA=$(GITS)/OEIS-mat/data
COMMON=$(GITS)/OEIS-mat/common
OEISDATA=$(GITS)/oeisdata
TODAY=`date +%Y-%m-%d`
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
RAMATH=java -cp $(GITS)/ramath/dist/ramath.jar
JPREP=$(RAMATH)  org.teherba.ramath.sequence.JoeisPreparer
NT=64
MANY=999999
CLASS=dummy.java
D=0
TO=4
GU=65536
NC=
BFPATH=$(COMMON)/bfile
PROG=$(GITS)/OEIS-prog/prog
PRIO=java,gp
JOPT=-Ddebug=$(D) -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=$(PROG) -Doeis.verbose=$(VERBOSE) -Doeis.priority="$(PRIO)" -Doeis.timeout=$(TO)
ifeq ($(OS),Windows_NT)
    CPS=;
else
    CPS=:
endif
JAVA=java $(JOPT) -cp "$(LITE)/dist/joeis-lite.jar$(CPS)$(JOEIS)/build.tmp/joeis.jar"
JJAVA=java $(JOPT) -cp "$(JOEIS)/build.tmp/joeis.jar"
COMPA=-dir 16
BATLIT=$(JAVA) irvine.test.BatchTest -vv $(WITHB) -d $(D) -t $(TO) -u $(GU) $(COMPA)
INSPECTOR=$(JAVA) irvine.oeis.AbstractInspector
INIT="1"
REMOTE=gfis@atair:~/work/gits/joeis-lite/internal/fischer
OFFSET=0
#----------------
all: # all possible targets:
	grep -P "^\w[^\:]*\:" makefile | sort
#----
killmake:
	cmd /c tasklist | grep make | cut -b28-34 | xargs -l -innn cmd /c taskkill /F /PID nnn
#----------------------------------
# Get the failures from an "ant all-tests" job on the server
REM=REM_must_be_defined
joeis_fail: joeis_fail0 joeis_fail1 
joeis_fail0:
	scp $(REM):~/work/gits/joeis/all-tests.log all-tests.log
joeis_fail1:
	grep "framework.ComparisonFailure" all-tests.log \
	| perl -ne 'if (m{irvine\.oeis\.a\d+\.(A\d+)}) { print "$$1\n"; }' \
	| tee    $@.tmp
	wc -l    $@.tmp
	cp -v $@.tmp $(GITS)/OEIS-mat/contrib/refresh.list.man
joeis_fail2:
	ro # refresh b-files of all with comparison failures
joeis_fail3: # test the failed ones
	cd .. ; cp -v supply/joeis_fail1.tmp cc.gen ; make CC=cc purge dist test log 	
joeis_fail4: # check whether they are not recycled
	cd .. ; make seq LIST=supply/joeis_fail1.tmp
	dbat -x "select s.aseqno, j.superclass, COALESCE(substr(n.name, 1, 64), '-> recyled') \
	    from      seq    s \
	    left join joeis  j on s.aseqno = j.aseqno \
	    left join asname n on j.aseqno = n.aseqno" \
	| tee    $@.tmp
#----
# get the sha256 and size from placeholders for b-files
oeisdata_sha: oeisdata_sha1 
oeisdata_sha1: 
	find $(OEISDATA)/files -iname "b??????.txt" \
	| perl extract_oeisdata_sha.pl \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
	