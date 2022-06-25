@echo off
set parm=%1
set subdir=a%parm:~1,3%
cat C:/Users/User/work/gits/joeis-lite/internal/fischer/prog/gp/%subdir%/%parm%.gp
