@echo off
set parm=%1
set subdir=a%parm:~1,3%
cp -v C:/Users/User/work/gits/joeis/src/irvine/oeis/%parm%.java C:/Users/User/work/gits/joeis-lite/src/irvine/oeis/%parm%.java
echo ~ src/irvine/oeis/%parm%.java >> packlist.man
uedit64 C:/Users/User/work/gits/joeis-lite/src/irvine/oeis/%parm%.java
