@echo off
set parm=%1
set subdir=a%parm:~1,3%
less %GITS%/joeis/src/irvine/oeis/%parm%.java
