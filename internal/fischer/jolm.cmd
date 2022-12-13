@echo off
set parm=%1
set subdir=a%parm:~1,3%
sed -e "s/%1/%2/" C:/Users/User/work/gits/joeis-lite/src/irvine/oeis/%subdir%/%parm%.java > manual/%2.java
uedit64 manual/%2.java
