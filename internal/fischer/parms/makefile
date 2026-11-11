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
MANY=29061947
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
	a007273   \
	basefract \
	cofrsqrt  \
	cofrsnum  \
	coxeter   \
	padding   \
	periodic  \
	recperiod \
	sigperiod \
	# Caution: the ordering above matters!
	wc -l    *.txt
#========
clean:
	rm *.tmp || :
#----
# get the parameters for A007273 - inverse cyclotomic polynomials (~ 680)
a007273:
	grep -P "Inverse of \d+\w+ cyclotomic polynomial" $(COMMON)/names \
	| perl -pe 'my $$line = $$_; $$line =~ m{of (\d+)}; my $$k = $$1; '\
	' $$_ = join("\t", substr($$line, 0, 7), "parmof2", 0, "A007273", $$k) . "\n"; ' \
	| grep -vPi "^$@" \
	>        $@.txt
	tail -n4 $@.txt
	wc -l    $@.txt
#----
# get the parameters for cons.BaseFractionSequence
basefract: basefract1 # apply the corrections
	grep -vP "^A256460" basefract1.tmp \
	| tr -d "\r" > $@.tmp
	grep -P "^A" $@.corr.txt | cut -f1 | sed -e "s/^/\^/" > $@.grep.tmp
	grep -vf $@.grep.tmp $@.tmp > $@.txt
	cat $@.corr.txt            >> $@.txt
basefract1: # extract "expansion of 17/29." from jcat25
	grep -P " expansion of +(\-?\d+) *\/ *(\d+)\." $(COMMON)/jcat25.txt \
	| perl basefract.pl \
	2>       $@.rest.tmp \
	>        $@.tmp
	tail -n4 $@.tmp
	cat      $@.rest.tmp
	wc -l    $@*.tmp
#----
# get the parameters for the period of sqrt(x), from ContinuedFractionOfSqrtSequence
cofrsqrt: cofrsqrt1 cofrsqrt2 cofrsqrt3
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat cofrsqrt3.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
cofrsqrt1: # determine subclasses of ContinuedFractionOfSqrtSequence
	$(DBAT) -x "SELECT j.aseqno, 'cofrsqrt', i.offset1, substr(n.name, 1, 64) FROM joeis j, asinfo i, asname n \
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
# get the parameters for the convergents of sqrt(x), from A006702 resp. ContinuedFractionOfSqrtSequence
cofrsnum: cofrsnum1 cofrsnum2 cofrsnum3 cofrsnum4 cofrsnum5 cofrsnum6 cofrsnum7
	echo "# $@.txt: (aseqno, offset1, callcode, matrix, inits, perlen, sort); `date +%Y-%m-%d.%H`" > $@.txt
	sort cofrsnum7.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
cofrsnum1: # extract the period lengths per square
	grep -P "^A\d+" cofrsqrt.txt \
	| gawk -e '{ print $$9 "\t" $$7 }' \
	| head -n$(MANY) \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
cofrsnum2: # load (square, perlen) into seq2
	$(DBAT) -f $(COMMON)/seq2.create.sql
	$(DBAT) -r seq2 cofrsnum1.tmp
	$(DBAT) -n seq2
	$(DBAT) -4 seq2
cofrsnum3: # extract the (numer|denomin)ator sequences and their squares
	# J042849	ContinuedFractionOfSqrtSequence	Denominators of continued fraction convergents to sqrt(955).	nonn,frac,easy	0..200	cfsqden	_N. J. A. Sloane_
	# J042925	Denominators of continued fraction convergents to sqrt(994)
	grep -h -P "(Numer|Denomin)ators of continued fraction convergents to sqrt\(\d+\)\." $(COMMON)/joeis_names.txt \
	| cut -f1,3 \
	| perl -ne 'm{\A[A-Z](\d+)\t(Numer|Denomin)ators of continued fraction convergents to sqrt\((\d+)\)};'\
	' my ($$aseqno, $$numden, $$square) = ("A$$1", lc(substr($$2, 0, 3)), $$3);'\
	' print join("\t", $$aseqno, $$numden, $$square) . "\n"; '\
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
cofrsnum4: # load (aseqno, num|den, square) into seq3
	cd $(COMMON); make seq3 LIST=$(HERE)/cofrsnum3.tmp
cofrsnum5: # join with the period lengths ins seq2
	$(DBAT) -x "SELECT s3.aseqno, s3.pattern, '0', 'matrix', CAST(s2.info AS INT) * 2, s2.info, s3.info  \
	    , substr(CAST(100000000 + s3.info AS INT), 2, 8) || '.' || s3.pattern \
	    FROM seq3 s3, seq2 s2 \
	    WHERE s2.aseqno = s3.info \
	    ORDER BY 8 DESC" \
	| head -n$(MANY) \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
#	| sort -k8 \
#
cofrsnum6: # fill the inits
	cat cofrsnum5.tmp \
	| head -n$(MANY) \
	| getinits -p 2 -sq \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
cofrsnum7: # fill the inits
	cat cofrsnum6.tmp \
	| perl cofrsnum.pl \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
cofrsnum8:
	echo "# $@.txt: (aseqno, offset1, callcode, matrix, inits, perlen, sort); `date +%Y-%m-%d.%H`" > cofrsnum.txt
	sort cofrsnum7.tmp \
	| sed -e "s/linearec/holos/" -e "s/\[/\[0,/" >> cofrsnum.txt
	head -n4 cofrsnum.txt
	wc -l    cofrsnum.txt
#----
# get the parameters for recur.AliquotSequence (all finite)
aliquot: aliquot1
	cp -v aliquot1.tmp $@.txt
aliquot1: # get Aliquot sequence names
	# A362440	nyi t	Aliquot sequence starting at 841.	nonn,fini,full	1..17	nyi	_N. J. A. Sloane_
	grep -P "Aliquot sequence starting at \d+\." $(COMMON)/names \
	| perl -ne 'm{^(A\d+)\D+(\d+)}; print "$$1\taliquot\t0\t$$2\n"' \
	| sort > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#----
# get the parameters for recur.CoxeterGroupSequence
coxeter: coxeter1
	cp -v coxeter1.tmp $@.txt
coxeter1: # get Coxeter sequence names
	grep "Number of reduced words of length n in Coxeter group " $(COMMON)/names \
	| perl -ne 'm{^(A\d+)\D+(\d+)\D+(\d+)\D+(\d+)}; print "$$1\tcoxeter\t0\t$$4\t$$2\n"' \
	| sort > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
coxeter2: # get coxG calls from 'names' subset
	cat coxeter1.tmp \
	$(PFRACT) -n 24 -f $@.tmp > $@.txt
#----
fullfini: fullfini1 # finite and full
fullfini1:
	$(DBAT) -x "SELECT i.aseqno, '$@', i.offset1, d.termno, d.data, substr(n.name, 1, 128) \
		FROM asinfo i, bfinfo b, bfdata d, asname n \
		WHERE i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND d.aseqno = n.aseqno \
		  AND b.bfimax - b.bfimin  + 1 <= d.termno \
		  AND i.keyword like '%full%' \
		ORDER BY 1 " \
	| endirect | grep -P "^A" | sort \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
fullfini2:
	cut -f1,$(DBAT) -x "SELECT i.aseqno, '$@', i.offset1, d.termno, d.data, substr(n.name, 1, 128) \
		FROM asinfo i, bfinfo b, bfdata d, asname n \
		WHERE i.aseqno = b.aseqno \
		  AND b.aseqno = d.aseqno \
		  AND d.aseqno = n.aseqno \
		  AND b.bfimax - b.bfimin  + 1 <= d.termno \
		  AND i.keyword like '%full%' \
		ORDER BY 1 " \
	| endirect | grep -P "^A" | sort \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp

#----
# get the parameters of PaddingSequence
padding: padding1 padding2
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat padding2.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
padding1:
	$(DBAT) -x "SELECT j.aseqno, 'padding', i.offset1 FROM joeis j, asinfo i WHERE j.aseqno = i.aseqno \
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
recperiod: sigperiod recperiod1 recperiod2
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
sigperiod: sigperiod1 sigperiod2 sigperiod3 sigperiod4
	echo "# $@.txt: (aseqno, offset1, inits, padright, inits_len, padright_len); `date +%Y-%m-%d.%H`" > $@.txt
	cat sigperiod4.tmp >> $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
sigperiod1:
	perl sigextract.pl -a 64 -d $(D) $(COMMON)/../lrindex/lrindx.raw \
	| grep -vP "A021299|A021309|A021980|A117154|A224238" \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigperiod2: # prepare the hashmap for recperiod.pl
	cut -f4,5 sigperiod1.tmp | uniq \
	>        $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigperiod3: # expand the inits
	getinits -sq sigperiod1.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
sigperiod4: # convert to padding or periodic
	perl sigperiod.pl sigperiod3.tmp > $@.tmp
	head -n4 $@.tmp
	wc -l    $@.tmp
#======== various targets ====
cyclo_use: # where are inverse cyclotomic used; needs a007273.txt being loaded in seq4
	$(DBAT) -x "SELECT x.aseqno, x.rseqno, substr(n.name, 1, 64) FROM asxref x, asname n \
	  WHERE x.rseqno = n.aseqno \
	    AND x.rseqno IN (SELECT aseqno FROM seq4) \
	    ORDER BY 1" \
	| endirect \
	>        $@.tmp
	tail -n8 $@.tmp
	wc -l    $@.tmp
frequent:
	$(DBAT) "SELECT COUNT(superclass), superclass FROM joeis \
	  WHERE superclass NOT IN ('Sequence0', 'Sequence1', 'Sequence2', 'Sequence3', 'AbstractSequence', 'PrependSequence') \
	  GROUP BY superclass \
	  ORDER BY 1 DESC FETCH FIRST 256 ROWS ONLY" \
	| tee $@.tmp
#----
help:
	grep -E "^[a-z]" makefile | sort
#----

