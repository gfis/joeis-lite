#!make

# makefile for jOEIS binary crossreference table joxref
# @(#) $Id$
# 2023-06-21, Georg Fischer
#
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
LITE=$(GITS)/joeis-lite
JOEIS=$(GITS)/joeis
CLAS=$(JOEIS)/build.tmp/classes/irvine/oeis
DBAT=java -jar $(GITS)/dbat/dist/dbat-lite.jar -e UTF-8 -c worddb
# JOPT=-Ddebug=$(D) -Xmx2g -Xss1g -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
JOPT=-Ddebug=$(D) -Xmx2800m -Xss800m -Duser.language=en -Dprog.root=./prog -Doeis.verbose=$(VERBOSE) -Doeis.priority="java,gp" -Doeis.timeout=$(TO)
ifeq ($(OS),Windows_NT)
    CPS=;
else
    CPS=:
endif
JAVA=java $(JOPT) -cp "$(LITE)/dist/joeis-lite.jar$(CPS)$(JOEIS)/build.tmp/joeis.jar"
D=0
#--------
all:
	grep -P "^\w" makefile
#----:
test1:
	ratpow:
	cd $(COMMON) ; grep -iP "(Expansion of( the)?|G\.f\.\:?) *prod(uct)?\_\{\w\>" jcat25.txt | grep -E "^%[NFCY]" \
	| grep -P "\^\(\d\/" | perl nyi.pl -p 2>&1 \
	| grep -svE "Decimal expansion" \
	| grep -sP "^.[A-Z] " \
	>        $@.tmp
	cp -v $(COMMON)/$@.tmp .
	wc -l    $@.tmp
