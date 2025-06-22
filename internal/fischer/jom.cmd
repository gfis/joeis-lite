set parm=%1
set subdir=a%parm:~1,3%
cp -v  %GITS%/joeis/src/irvine/oeis/%subdir%/%parm%.java %GITS%/joeis-lite/internal/fischer/manual
cmd /c start https://oeis.org/%parm%
e manual/%parm%.java
ls -al %GITS%/joeis/src/irvine/oeis/%subdir%/%parm%.java
