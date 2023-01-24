#!make
# old targets
# 2023-01-24, Georg Fischer; *DvH=81
all:
	grep -P "^\w" anabuild_old.make 
#----
anabuild.2022-12-30:
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A064437 A096173 A293761 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select gener EX=xx
	make CC=decexro    select gener
	make CC=concatf    select gener
	cp -pv hold/*.java manual || :
	make CC=man        man
	make CC=$@ dist testall pack 
anabuild.2022-10-14:
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A034906 A048724 A050528 A238938 A274022 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select gener EX=xx
	cp -pv hold/*.java manual || :
	make CC=man        man
	make CC=$@ dist testall pack 
anabuild.2022-10-13:
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A032810 A116611 A214703 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select gener
	cp -pv hold/*.java manual
	make CC=man        man
	make CC=$@ dist testall pack 
anabuild.2022-10-12: # *IP=48
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A152578 A204574 A246708 A255636 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select       gener
	make CC=A046005    select EX=xx gener
	cp -pv hold/*.java manual
	make CC=man        man
	make CC=$@ dist testall pack 
anabuild.2022-09-26: 
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A261719 A261781 A261836 A306800 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	cp -pv hold/*.java manual
	make CC=man        man
	cmd /c jodel.cmd A239368
	make CC=$@ dist testall pack 
anabuild.2022-09-06: 
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo concsimple \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	cp -pv hold/*.java manual
	make CC=man        man
	make CC=$@ dist testall pack 
anabuild.2022-09-05: 
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo concsimple A132901 A173426 A249350 A262571 A287300 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	cp -pv hold/*.java manual
	make CC=man        man
	make CC=$@ dist testall pack 
anabuild.2022-09-04: 
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A074993 A095709 A100846 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	cp -pv hold/*.java manual
	make CC=man        man
	make CC=$@ dist testall pack GU=4
anabuild.2022-09-03: 
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A261835 A261836 A261781 A261718 A261719 A053600 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	cp -pv hold/*.java manual
	make CC=man        man
	make CC=$@ dist testall pack GU=4
anabuild.2022-08-31: 
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo  A058304 A285684  \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	make CC=man        man
	make CC=$@ dist testall pack
anabuild.2022-08-20: # ??? delivered?
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo  A288108 A288318 A288972  \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	make CC=man        man
	make CC=$@ dist testall pack
anabuild.2022-08-19:
	make purge
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo  A288108 A288318 A288972  \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	make CC=man        man
	make CC=$@ dist testall pack
anabuild.2022-08-02:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	# A006988 A116611  A051222 A274022
	echo  A116611 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build      select EX=xx gener
	make CC=man        man
	make CC=$@ dist 
	make CC=A006988 test TO=8 GU=8 log
	make CC=A274022 test TO=8 GU=8 log
	make CC=A050449 testall log 
# hygeom + A050449: 2022-08-06
anabuild.2022-07-19:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A112813 A130433 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=mult1      select EX=xx gener
	make CC=build      select EX=xx gener
	make CC=man        man
	make CC=$@ dist testall log TO=8 pack
anabuild.2022-07-15:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A067443 A067903 A067934 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=cordrectab select gener
	make CC=build      select EX=xx gener
	make CC=man        man
	make CC=$@ dist testall log TO=8 pack
anabuild.2022-07-13:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A064326 A237202 A342638 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select EX=xx gener
	make CC=man       man
	make CC=$@ dist testall log TO=8 pack
anabuild.2022-07-06:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A214258 A214269 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=partcapp  select EX=xx gener
	make CC=A161026   select EX=xx gener
	make CC=man       man
	make CC=$@ dist testall log TO=8 pack
#----
anabuild.2022-07-04:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	LATER=
	echo A292795 A319539 A319541 A319394 A319797 A337165 A339101 A340949 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-07-03:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	LATER=
	echo A341064 A341074  \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=deris     select       gener
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-06-14:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	LATER=
	echo A054055 A120602 A346577 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-06-09:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	LATER=
	echo  \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A999999" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-06-08: # FP=8
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	LATER=
	echo A057522 A062634 A065122 A079000 A103566 A175442 A175434 A283765 A298338 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-06-06: # RH=76
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A075834 A112557 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-06-05:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo phlist A212957 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-30:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A253095 A250261 A246935 adiveo \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-29:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A144416 A246049 A241981 A246522 A246609 A261780 A271423 A271424 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp \
	| sort | uniq -w7 > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-27:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A069537 A069588 A151843 A166311 A262344 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-25:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo prilist A127109 A134210 A136690 A178361 A190016 A200053 A226288 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=build     select       gener
	make CC=A124262   select EX=xx gener
	make CC=A144779   select EX=xx gener
	make CC=A258774   select EX=xx gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-24:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A061870 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=A139056   select EX=xx gener
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-22:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A124262 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=A144779   select EX=xx gener
	make CC=prilist   select       gener
	make CC=prilistm  select       gener
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-21:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A111528 A121022 A128367 A145609 A172455 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=A147571   select EX=xx gener
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=4
anabuild.2022-05-20:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	make CC=trecpas   select       gener
	echo A225466 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=4
anabuild.2022-05-18:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A105599 A144502 A158138 A189233 A204459 A215861 A220062 A221857 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=A144150   select EX=xx gener
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=4
anabuild.2022-05-15:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A060642 A075196 A080510 A143453 A145111 A180887 A184887 A193515 \
	     A245405 A306800 A323224 A334218 A346426 A346520 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=holom     select       gener
	make CC=build     select       gener
	make CC=man       man
	make dist testall log TO=4
anabuild.2022-05-12:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	# echo A244372 A299038 rewritten/retested
	echo A237018 A239550 A240608 A242447 A242451 A242464 A243081 A244454 A244530 A255982 A324162 A346500 A346517 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A001761" build.tmp > build.man
	make CC=build     select EX=xx gener
	make CC=man       man
	make dist testall log TO=4
anabuild.2022-05-10:
	make purge
	cp -v hold/*.java manual || :
	git add -v A*.man *.sql *.pl *.jpat
	rm -f build.man build.tmp
	echo A147682 A180281 A183568 A184271 A194621 A210062 A229653 A244372 A295028 \
	     A305161 A308680 A316074 A318754 A319501 \
	| xargs -n1 echo | xargs -innn cat nnn.man >> build.tmp
	grep -vE "A032305|A063524|A244407|A244410|A299039" build.tmp > build.man
	make CC=build     select EX=xx gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-07:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	# make CC=A060035   select       gener
	make CC=tricol    select       gener
	make CC=man       man
	make dist testall log TO=2
anabuild.2022-05-06:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A060035   select       gener
	make CC=A237276   select       gener
	make CC=A238208   select       gener
	make CC=perman    select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-05:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A203264   select       gener
	make CC=A203761   select       gener
	make CC=A205558   select       gener
	make CC=perman    select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-03:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A204892   select       gener
	make CC=A205556   select       gener
	make CC=A205558   select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-05-02:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A063983   select       gener
	make CC=A204892   select       gener
	make CC=A205546   select       gener
	make CC=man       man
	make dist testall log TO=8
anabuild.2022-04-30:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A062117   select       gener
	make CC=A213500   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-29:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=linrec    select       gener
	make CC=A119682   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-27:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=esf       select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-25:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A102669   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-19:
	make purge
	cp -v hold/*.java manual || :
	git add -v *.man *.sql *.pl *.jpat
	make CC=A062737   select       gener
	make CC=A069842   select       gener
	make CC=A091113   select       gener
	make CC=A157147   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-18:
	make purge
	cp -v hold/*.java manual
	git add -v *.man *.sql *.pl *.jpat
	make CC=eulerxm   select       gener
	make CC=A059007   select       gener
	make CC=A070667   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-14:
	make purge
	cp -v hold/*.java manual
	git add -v *.man *.sql *.pl *.jpat
	make CC=A069272   select       gener
	make CC=A066699   select       gener
	make CC=prodsim   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-12:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A126616   select       gener
	make CC=A242787   select       gener
	make CC=A245399   select       gener
	make CC=A256293   select       gener
	make CC=parshift  select EX=xx gener
	make CC=partprom  select       gener
	make CC=partsumm  select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-09:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A090000   select       gener
	make CC=A104808   select       gener
	make CC=A309182   select       gener
	make CC=man       man
	make dist testall log TO=24
anabuild.2022-04-08:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=n2        select       gener
	make CC=posins    select       gener
	make CC=transpose select       gener
	make CC=trimirror select       gener
	make CC=inbase2   select       gener
	make CC=A090000   select       gener
	make CC=A104808   select       gener
	make CC=A309182   select       gener
	make CC=man       man
	make dist testall log TO=24
anabuild.2022-04-05:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make primen0 primen1
	make CC=primen    select       gener
	make CC=man       man
	make dist testall log TO=24
anabuild.2022-04-02:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A109345   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-04-01:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=triselect select       gener
	make CC=A109345   select       gener
	make CC=man       man
	make dist testall log
anabuild-2022-03-25:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A060164   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-24:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=partsumm  select       gener
	make CC=A137952   select       gener
	make CC=A120134   select       gener
	make CC=A160931   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-22:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A061403   select       gener
	make CC=A092221   select       gener
	make CC=A099542   select       gener
	make CC=A288580   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-20:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A061931   select       gener
	make CC=A062034   select       gener
	make CC=A062137   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-19:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A061323   select       gener
	make CC=A061384   select       gener
	make CC=A061511   select       gener
	make CC=A061751   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-17:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A099544   select       gener
	make CC=A181447   select EX=xx gener
	make CC=etgeneric select       gener
	make CC=valuation select       gener
	make CC=denrat    select       gener
	cp -v  hold/*.java manual
	cp -v  park/*.java manual
	cp -v park2/*.java manual
	make CC=man       man
	make dist testall log
anabuild.2022-03-15:
	# make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A067480   select       gener
	make CC=denrat    select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-12:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A103123   select       gener
	make CC=A145180   select EX=xx gener
	make CC=A165471   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-03-01:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A055143   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-02-28:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A067067   select       gener
	make CC=A105501   select       gener
	make CC=man       man
	make dist testall log
anabuild.2022-02-27:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A008905   select       gener
	make CC=A056176   select       gener
	make CC=cofrseq   select       gener
	make CC=posins    select       gener
	make CC=man       man
	cmd /c jodel A191359
	cmd /c jodel A317413
	cmd /c jodel A342652
	make dist testall log
anabuild.2022-02-25: # *JA=65
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=cofrman   select       gener
	make CC=insect    select       gener
	make CC=cofrman   man dist testall log
anabuild.2022-02-22: # *JA=65
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A033981   select       gener
	make CC=A055812   select       gener
	make CC=A055685   select       gener
	make CC=A061561   select       gener
	make CC=A204574   select       gener
	make CC=insect    gener man dist testall log
anabuild.2022-02-14: # *GH=74
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A082246   select EX=xx gener
	make CC=A054800   select EX=xx gener
	make CC=A078847   select EX=xx gener
	make CC=man man dist testall log
anabuild.2022-02-13:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A034741   select EX=xx gener
	make CC=A054703   select EX=xx gener
	make CC=A054718   select EX=xx gener
	make CC=A001692   select EX=xx gener
	make CC=A054703 man dist testall log
anabuild.2022-02-02:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A210000   select gener
	make CC=A211266   select gener
	make CC=A211422   select gener
	make CC=A210000 man dist testall log
anabuild.2022-01-31:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A277548   select EX=xx gener
	make CC=A321543   select EX=xx gener
	make CC=A321543 man dist testall log
anabuild.2022-01-27:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A057036   select EX=xx gener
	make CC=A057036   man dist testall log
anabuild.2022-01-25:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A034695   select EX=xx gener
	make CC=A055115   select EX=xx gener
	make CC=triselect select EX=xx gener
	make CC=triselect man dist testall log
anabuild.2022-01-23:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A055960   select EX=xx gener
	make CC=triselect select EX=xx gener
	make CC=triselect man dist testall log pack1
anabuild.2022-01-21:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A212846 select EX=xx gener
	make CC=A212846 man dist testall log pack1
anabuild.2022-01-19:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A000449 select EX=xx gener
	make CC=A029709 select EX=xx gener
	make CC=A059695 select EX=xx gener
	make CC=A050999 select EX=xx gener
	make CC=A051801 select EX=xx gener
	make CC=A082246 select EX=xx gener
	make CC=A133355 select EX=xx gener
	make CC=A171430 select EX=xx gener
	make CC=A029709 man dist testall log pack
anabuild.2022-01-17:
	make purge
	git add -v *.man *.sql *.pl *.jpat
	make CC=A275043 select EX=xx gener
	make CC=A033981 select EX=xx gener
	make CC=A104088 select EX=xx gener
	make CC=A074476 select       gener
	make CC=A055473 select       gener
	make CC=A167626 select       gener
	make CC=A007693 select EX=xx gener
	make CC=A023200 select EX=xx gener
	make CC=A074476 man dist testall log pack
anabuild.2022-01-16:
	make purge
	make CC=A027894 select EX=xx gener
	make CC=A116081 select EX=xx gener
	make CC=A116081 man distel
anabuild.2022-01-14:
	make purge
	make CC=cumulcnt select gener
	make CC=A018195  select gener
	make CC=cumulcnt man distel TO=16
anabuild.2022-01-09:
	make purge
	make CC=A087630 select EX=xx gener
	make CC=A093211 man dist testall pack
anabuild.2022-01-08:
	make purge
	make CC=A087630 select EX=xx gener
	make CC=A050990 select EX=xx gener # Knoedel numbers
	make CC=A343523 select EX=xx gener
	make CC=A066432 select       gener # 10^n mod n^10
	make CC=A093211 select       gener # all subsequences distinct and divisible by 11
	make CC=A006938 select EX=xx gener # dec -> bin
	make CC=A038500 select EX=xx gener # highest power of k dividing n
	make CC=A054861 select EX=xx gener # highest power of k dividing n!
	make CC=A110389 select EX=xx gener # Integers with mutual residues -1.
	m