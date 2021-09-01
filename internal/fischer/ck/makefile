#!make

# OEIS-mat/constant: DecimalExpansion, Beatty, ContinuedFraction etc. of real constants
# @(#) $Id$
# 2021-07-13: moved from ./real
# 2021-07-01, Georg Fischer: copied from ../weidis
#---------------------------------
GITS=../../../..
COMMON=$(GITS)/OEIS-mat/common
DBAT=java -jar $(GITS)/dbat/dist/dbat.jar -e UTF-8 -c worddb
RAMATH=java -cp $(GITS)/ramath/dist/ramath.jar
JPREP=$(RAMATH) org.teherba.ramath.sequence.JoeisPreparer
LITE=../../..
FISCHER=..
NT=32
D=0 # debug mode

all:
	echo select specific target 
#-------
overwrite: # SRC= TAR= inserts or replaces all records in TAR by the ones in SRC, key is aseqno
	grep -E "^A[0-9]" $(SRC) | cut -b1-7 > $@.sa.tmp
	grep -vf $@.sa.tmp $(TAR) > $@.tn.tmp || :
	sort $@.tn.tmp $(SRC) > $(TAR)
	wc -l $(TAR)
#===============================================
cklist:
	$(DBAT) "SELECT i.aseqno, COALESCE(j.superclass, 'null'), n.name, i.keyword, b.bfimax - b.bfimin + 1 \
	  FROM asinfo i, asname n, bfinfo b LEFT JOIN joeis j ON j.aseqno = b.aseqno \
	  WHERE i.aseqno = n.aseqno \
	    AND n.aseqno = b.aseqno \
	    AND i.author LIKE '%Kimberling%' \
	    AND i.aseqno NOT IN (SELECT aseqno FROM poeis) \
	  ORDER BY 1;" \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
#--------
bnr:
	# A190775	null	[(bn+c)r]-b[nr]-[cr], where (r,b,c)=(sqrt(1/2),3,2) and [ ]=floor.	nonn,synth	132
	grep -P "\[\(b" $(COMMON)/joeis_names.txt \
	| grep -vE "Number of sequences" \
	| perl -ne 's{a\(n\) *\= *}{}; '\
	' s{ and .*}{}; s{[\* ]}{}g; s{\,where\(r\,b\,c\)\=\(}{\t}; s{\)\Z}{}; s{goldenratio}{phi}g;'\
	' s{\tnull\t}{\t}; s{\A}{\=K\=\t}; print; ' \
	>        $@.tmp
	head -n8 $@.tmp
	wc -l    $@.tmp
#----
# A190841 null    (1+A190803)/2
intin:
	grep -P "\tIntegers in " cklist.txt \
	| perl -ne 's{Integers in *}{}; s{\s+\Z}{};'\
	' s{ }{}g; s{[\.\;.].*}{};'\
	' if (m{\A(A\d+)\tnull\t\(?((\-?\d+)([\+]))?(A\d+)\)?\/(\d+)}) {'\
	' my $$d="1----1           23------34----42 5----5     6---6"; '\
	' my ($$line, $$aseqno, $$rseqno, $$add, $$div) = ($$_, $$1, $$5, $$3, $$6); '\
	' if (defined($$add)) { $$add = (substr($$add, 0, 1) eq "-") ? ".subtract(" . substr($$add, 1) . ")" : ".add($$add)" ; } else { $$add = ""; } '\
	' print join("\t", $$aseqno, "$@", 0, $$rseqno, $$add, $$div, $$_) ."\n"; }'\
	>        ../$@.gen
	head -n4 ../$@.gen
	wc -l    ../$@.gen
#================
# ck_guides

