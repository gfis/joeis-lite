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
HOLREC=$(GITS)/OEIS-mat/holrec
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
# Caution: the ordering below matters!
all: \
	clean \
	a007273         \
	aliquot         \
	basefract       \
	cellauto1D      \
	cellauto2D      \
	cofrsqrt        \
	  cofrsnum        \
	coordination    \
	coxeter         \
	dead            \
	diffseq         \
	finite
	  briefseq        \
	  noncomputable   \
	  divisors        \
	padding         \
	partsums        \
	periodic        \
	  recperiod       \
	  sigperiod       \
	primecongruence \
	runsbase        \
	squaredigits    \
	walk23          \
	#
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
briefseq: briefseq1 briefseq2 # BriefSequence
	cp -v briefseq2.tmp briefseq.txt
	wc -l    $@*
briefseq1: # get all calls
	grep -P "\tBriefSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc briefseq $@.grep.tmp \
	| perl -pe 'if (!m{\t\-?\d+\, *BRIEF}) { s{briefseq\t0\t}{briefseq\t0\t0, BRIEF, }; } '\
	' s{\t0}{}; s{\,}{\t};'\
	>        $@.tmp
	head -n4 $@.tmp
briefseq2: # 
	grep -vP "^A276972" briefseq1.tmp \
	| perl -pe 's{BRIEF\,}{BRIEF\t}; s{ }{}g; s[\}\}][]g;' \
	| perl repl_zlist.pl -p 2 \
	| perl -pe 's{\"}{}g; s{\[\[}{\[}g; s{\]\]}{\]}g; ' \
	>        $@.tmp
	head -n4 $@.tmp
#----
cellauto1D: cellauto1D1 cellauto1D2 # one-dimensional celluar automata
	cp -v cellauto1D2.tmp cellauto1D.txt
	wc -l    $@*
cellauto1D1: # get all calls
	grep -P "\tCellular1DAutomaton" $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -cc ca1 \
	>        $@.tmp
	head -n4 $@.tmp
cellauto1D2: # separate into standard/non-standard
	grep -v "/" cellauto1D1.tmp > $@.rest.tmp
	grep    "/" cellauto1D1.tmp \
	| perl -pe 'm{\/(\w+)}; my $$cc = $$1; s/\t\w+/\t$$cc/;' \
	>        $@.tmp
	head -n4 $@.tmp
#----
cellauto2D: cellauto2D1 cellauto2D2 # two-dimensional celluar automata
	cp -v cellauto2D2.tmp cellauto2D.txt
	wc -l    $@*
cellauto2D1: # get all calls
	grep -P "\tFiveNeighbor2DAutomaton" $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -of -cc ca2on \
	| perl -pe 's/\, */\t/g; ' \
	>        $@.tmp
	head -n4 $@.tmp
cellauto2D2: # separate into standard/non-standard
	grep -v "/" cellauto2D1.tmp > $@.rest.tmp
	grep    "/" cellauto2D1.tmp \
	| perl -pe 'm{\/(\w+)}; my $$cc = $$1; s/\t\w+/\t$$cc/;' \
	>        $@.tmp
	head -n4 $@.tmp
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
complement: complement1 complement2 complement3 # ComplementSequence
complement1: # get all calls
	grep -P "\tComplementSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc complement $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
complement2: # separate nominator/denominator
	perl complement.pl complement1.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
complement3: 
	grep -vP "A057716|A061310|A183868|A243956" complement2.tmp \
	| perl -pe 's/\tcomplement/\tsetOperator/;'\
	' s{(\d+)\tnew ([^\t]+)}{"B \/ C\tnew " . ($$1 == 0 ? "A001477" : "A000027") . "\(\)\, new $$2"}e;' \
	>        complement.txt
	wc -l    complement*
#----
intersect: intersect1 intersect2 intersect3 # IntersectionSequence
intersect1: # get all calls
	grep -P "\tIntersectionSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc intersect $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
intersect2: # separate nominator/denominator
	perl complement.pl intersect1.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
intersect3: 
	grep -vP "^A00054[89]" intersect2.tmp \
	| perl -pe 's/\tcomplement/\tsetOperator/; s/\d+\tnew/B x C\tnew/' \
	>        intersect.txt
	wc -l    intersect*
#----
setdifference: setdifference1 setdifference2 setdifference3 # SetDifferenceSequence
setdifference1: # get all calls
	grep -P "\tSetDifferenceSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc setdifference $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
setdifference2: 
	perl complement.pl setdifference1.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
setdifference3: 
	grep -vP "^A057716|^A057609" setdifference2.tmp \
	| perl -pe 's/\tcomplement/\tsetOperator/; s/\d+\tnew/B - C\tnew/' \
	>        setdifference.txt
	wc -l    setdifference*
#----
union: union1 union2 union3 # UnionSequence
union1: # get all calls
	grep -P "\tUnionSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc union $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
union2: 
	perl complement.pl union1.tmp \
	2>       $@.rest.tmp \
	>        $@.tmp
	head -n4 $@.tmp
union3: 
	grep -vP "^A057716|^A398556|MySequence|Z14\:" union2.tmp \
	| perl -pe 's/\: +\:/\:\:/; s/\tcomplement/\tsetOperator/; s/\d+\tnew/B u C\tnew/' \
	>        union.txt
	wc -l    union*
#----
coordination: coordination1 coordination2 # CoordinationSequence
	cp -v coordination2.tmp coordination.txt
	wc -l    $@*
coordination1: # get all calls
	grep -P "\tCoordinationSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc coordination $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
coordination2: # separate nominator/denominator
	cat coordination1.tmp \
	| perl -pe 's{\,\s*new}{\tnew}; s{ }{}g; s{new}{new }g; s[\}\}][]g;' \
	>        $@.tmp
	head -n4 $@.tmp
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
dead: # dead sequences
	$(DBAT) -x "SELECT j.aseqno, '$@', i.offset1, substr(n.name, 1, 128) \
		FROM joeis j, asinfo i, asname n \
		WHERE j.aseqno = i.aseqno \
		  AND i.aseqno = n.aseqno \
		  AND j.superclass = 'DeadSequence' \
		ORDER BY 1 " \
	>        $@.txt
	tail -n4 $@.txt
	wc -l    $@.txt
#----
diffseq: # first differences of a squence
	grep -P "\tDifferenceSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -of -cc $@ \
	| perl repl_adjust.pl \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#----
divisors: divisors1 divisors2 # extract the finite sequences of ordered divisors
	# Caution, depends on target finite
	uniq -c  $@.txt | grep -v " 1 " || :
	tail -n4 $@.txt
	wc -l    $@.txt
divisors1:
	# A018283	finite	1	FINITE	[Jaguar.factor(100).divisorsSorted()]
	grep -P "divisorsSorted" finite2.tmp \
	| perl -ne 'if (m{Jaguar.factor\((\d+)}) { my $$num = $$1; '\
	' s{\t.*}{\tdivisors\t1\t$$num}; print; }; ' \
	>        $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.tmp
divisors2:
	cut -f1 divisors3.man > $@.grep.tmp
	grep -vf $@.grep.tmp divisors1.tmp > $@.tmp 
	sort $@.tmp divisors3.man > divisors.txt
	wc -l    divisors.txt
#----
euler: euler1 euler2 # EulerTransform
	cp -v euler2.tmp euler.txt
	wc -l    $@*
euler1: # get all calls
	grep -P "\tEulerTransform" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -of -cc euler $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
euler2: # 
	cat euler1.tmp \
	| perl -pe 's{\,\s*new}{\tnew}; s{ }{}g; s{new}{new }g; s[\}\}][]g;' \
	>        $@.tmp
	head -n4 $@.tmp
#----
finite: finite1 finite2 # FiniteSequence
	grep -vP "\[[^\-0-9]" finite2.tmp \
	>        $@.txt
	tail -n2 $@.txt
	wc -l    $@*
finite1: # get all calls
	grep -P "\tFiniteSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc finite $@.grep.tmp \
	| perl -pe 'if (!m{\t\-?\d+\, *FINITE}) { s{finite\t0\t}{finite\t0\t0, FINITE, }; } '\
	' s{\t0}{}; s{\,}{\t}; s{\"\[|\]\"}{}g; ' \
	>        $@.tmp
	head -n4 $@.tmp
finite2: # 
	cat finite1.tmp \
	| perl -pe 's{FINITE\,}{FINITE\t}; s{ }{}g; s[\}\}][]g;' \
	| perl repl_zlist.pl -p 2 \
	| cut -f1-3,5- \
	>        $@.tmp
	head -n4 $@.tmp
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
#----
noncomputable: noncomputable1 noncomputable2 # NoncomputableSequence
	cp -v noncomputable2.tmp noncomputable.txt
	wc -l    $@*
noncomputable1: # get all calls
	grep -P "\tNoncomputableSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc noncomputable $@.grep.tmp \
	| perl -pe 'if (!m{\t\-?\d+\, *NONCOMPUTABLE}) { s{noncomputable\t0\t}{noncomputable\t0\t0, NONCOMPUTABLE, }; } '\
	' s{\t0}{}; s{\,}{\t}; s{\"\[|\]\"}{}g; ' \
	>        $@.tmp
	head -n4 $@.tmp
noncomputable2: # 
	cat noncomputable1.tmp \
	| perl -pe 's{NONCOMPUTABLE\,}{NONCOMPUTABLE\t}; s{ }{}g; s[\}\}][]g;' \
	| perl repl_zlist.pl -p 2 \
	>        $@.tmp
	head -n4 $@.tmp
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
partsums:
	grep PartialSumSequence $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -of -cc $@ \
	| perl repl_adjust.pl \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
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
primecongruence: primecongruence1 primecongruence2 # 
	cp -v primecongruence2.tmp primecongruence.txt
	wc -l    $@*
primecongruence1: # get all calls
	grep -P "\tCongruenceForm" $(COMMON)/joeis_list.txt | cut -f1 \
	>        $@.grep.tmp
	perl extract_super.pl -d $(D) -cc pricongr $@.grep.tmp \
	>        $@.tmp
	head -n4 $@.tmp
primecongruence2: # 
	cat primecongruence1.tmp \
	| perl -pe 's{\,\s*new}{\tnew}; s{ }{}g; s{new}{new }g; s[\}\}][]g;' \
	>        $@.tmp
	head -n4 $@.tmp
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
runsbase: runsbase1 runsbase2 # RunsBaseSequence
	cp -v runsbase2.tmp runsbase.txt
	wc -l    $@*
runsbase1: # get all calls
	grep -P "\tRunsBaseSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -of -cc runsbase \
	>        $@.tmp
	head -n4 $@.tmp
#	| perl -pe 's/\, */\t/g; ' \
#
runsbase2: # separate into standard/non-standard
	grep -vP "\t(bas|jux)" runsbase1.tmp > $@.rest.tmp
	grep -P  "\t(bas|jux)" runsbase1.tmp \
	| perl -pe 'm{\t((bas|jux)\w+)}; my $$cc = $$1; s/\t\w+/\t$$cc/; s/\)[^\t]*//;' \
	>        $@.tmp
	head -n4 $@.tmp
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
#----
squaredigits: squaredigits1 squaredigits2 # one-dimensional celluar automata
	cp -v squaredigits2.tmp squaredigits.txt
	wc -l    $@*
squaredigits1: # get all calls
	grep -P "\tSquareDigitsSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -of -cc squaredig4 \
	>        $@.tmp
	head -n4 $@.tmp
squaredigits2: # separate into standard/non-standard
	cat squaredigits1.tmp \
	| perl -pe 's{ }{}g; s{\,\"}{\t\"}; s{\,}{\t}; s[\}\}][];' \
	>        $@.tmp
	head -n4 $@.tmp
#----
walk23: # Walk through squares and cubes
	grep -P "\tWalkCubeSequence" $(COMMON)/joeis_list.txt | cut -f1 \
	| perl extract_super.pl -of -cc walk23 \
	| perl -pe 's/\, */\t/g; ' \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#======== various targets ====
counts:
	wc -l    *.txt
cyclo_use: # where are inverse cyclotomic used; needs a007273.txt being loaded in seq4
	$(DBAT) -x "SELECT x.aseqno, x.rseqno, substr(n.name, 1, 64) FROM asxref x, asname n \
	  WHERE x.rseqno = n.aseqno \
	    AND x.rseqno IN (SELECT aseqno FROM seq4) \
	    ORDER BY 1" \
	| endirect \
	>        $@.tmp
	tail -n8 $@.tmp
	wc -l    $@.tmp
MANY=128
frequencies:
	$(DBAT) -m html "\
	  SELECT superclass, frequence FROM ( \
	      SELECT superclass, COUNT(superclass) as frequence FROM joeis \
	        WHERE superclass NOT IN ('Sequence0', 'Sequence1', 'Sequence2', 'Sequence3', 'AbstractSequence', 'PrependSequence') \
	        GROUP BY superclass \
	    ) as A \
	    WHERE frequence >= $(MANY) ORDER BY 2 DESC \
	  " \
	| tee $@.html
	#  FETCH FIRST $(MANY) ROWS ONLY" \
	#
	chmod 755 $@.html
	cmd /c start $@.html
#----
help:
	grep -E "^[a-z]" makefile | sort
#----
hol_to_linrec:
	grep holon $(FISCHER)/holref.txt \
	| perl $(HOLREC)/$@.pl -d $(D) -1  \
	2>       $@.rest.tmp \
	| tee    $@.tmp
	tail -n4 $@.tmp
	wc -l    $@.*tmp

