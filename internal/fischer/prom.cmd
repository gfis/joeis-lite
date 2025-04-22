@echo off
set parm=%1
set subdir=a%parm:~1,3%
cp -v %GITS%/joeis/src/irvine/oeis/%parm%.java %GITS%/joeis-lite/src/irvine/oeis/%parm%.java
echo #~ src/irvine/oeis/%parm%.java | sed -e "s/[ \r]//g" >> packlist.man
uedit64 %GITS%/joeis-lite/src/irvine/oeis/%parm%.java
ls -al %GITS%/joeis-lite/src/irvine/oeis/%parm%.java
