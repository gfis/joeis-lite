@echo off
set parm=%1
set subdir=a%parm:~1,3%
sed -e "s/%1/%1/" -e "s/Generated by gen_seq4\.pl/manually/" %GITS%/joeis-lite/src/irvine/oeis/%subdir%/%parm%.java > manual/%1.java
uedit64 manual\%1.java
