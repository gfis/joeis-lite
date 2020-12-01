@echo off
set parm=%1
set subdir=a%parm:~1,3%
cp -v C:/Users/User/work/gits/joeis/src/irvine/oeis/%subdir%/%parm%.java manual
uedit64 manual\%parm%.java
