@echo off

set argC=0
for %%x in (%*) do Set /A argC+=1

if %argC%==4 (
    bash Test.sh "%1" "%2" "%3" "%4"
) else if %argC%==5 (
    bash Test.sh "%1" "%2" "%3" "%4" "%5"
)
