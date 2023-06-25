#!make

# makefile for regression tests
# @(#) $Id$
# 2023-06-22, Georg Fischer
#
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
LITE=$(GITS)/joeis-lite
JOEIS=$(GITS)/joeis
COHERE=../../joeis-lite/internal/fischer/reflect
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
EDITOR=uedit64
SRC=src/irvine/oeis
# JOPT=-Ddebug=$(D) -Xmx2g -Xss1g -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
JOPT=-Ddebug=$(D) -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
ifeq ($(OS),Windows_NT)
    CPS=;
else
    CPS=:
endif
JAVA=java $(JOPT) -cp "$(LITE)/dist/joeis-lite.jar$(CPS)$(JOEIS)/build.tmp/joeis.jar"
D=0
REMOTE=set_REMOTE_env_variable
#--------
all:
	grep -P "^\w" makefile
#----
# 1) irvine.oeis.a130.A130162(irvine.oeis.AbstractSequenceTest)java.lang.ArithmeticException: / by zero
# 2) irvine.oeis.a047.A047895(irvine.oeis.AbstractSequenceTest)junit.framework.ComparisonFailure: a(1) expected:<0> but was:<-1>
down:
	scp $(REMOTE):~/work/gits/joeis/regression.log .
grep: # LIST= ; extract failing pack.aseqno and messages from an email
	grep "AbstractSequenceTest)" $(LIST) \
	| perl -ne 'm{oeis\.a\d{3}\.(A\d+)}; print "$$1\t"; m{\:(.*)}; print "$$1\n"; '\
	| tee $@.tmp
list: # copy the result of a previous "make grep" from joeis/src into ../manual
	grep -E "^A[0-9]" grep.tmp | cut -f1 | sort | uniq -w7 \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
	> $@.tmp
	cat $@.tmp | xargs -innn ls -al $(JOEIS)/src/irvine/oeis/nnn.java
	wc -l $@.tmp
pull: # copy the result of a previous "make grep" from joeis/src into ../manual
	grep -E "^A[0-9]" grep.tmp | cut -f1 | sort | uniq -w7 \
	| perl -ne 'my $$aseqno = substr($$_, 0, 7); print lc(substr($$aseqno, 0, 4)) . "/$$_";' \
	> $@.tmp
	cat $@.tmp | xargs -innn cp -vp $(JOEIS)/src/irvine/oeis/nnn.java ../manual
	wc -l $@.tmp
edit: # call the editor for the result of a previous "make grep"
#----
GU=2
test: # SUP= GU= ; select all sequences that use the base sequence(s) in SUP
	grep -iP "$(SUP)" ../joxref/joxref.txt | cut -f1 | sort | uniq -w7 \
	| tee   ../regtest.gen
	wc -l   ../regtest.gen
	cd .. ; make CC=regtest test log TO=8 GU=$(GU)

