@ECHO OFF

:example1
ECHO.First example:
ECHO.Press either Y or N to continue...
CALL BUILD\GETYN.COM

IF ERRORLEVEL 2 goto :example1no
IF ERRORLEVEL 1 goto :example1yes
IF ERRORLEVEL 0 goto :invalidoutput

:example1yes
ECHO.You pressed Y.
goto :example2

:example1no
ECHO.You pressed N.
goto :example2

:example2
ECHO.
ECHO.Second example:
CALL BUILD\GETYN.COM Press either Y or N to continue (Y/N): 
IF ERRORLEVEL 2 goto :example2no
IF ERRORLEVEL 1 goto :example2yes
IF ERRORLEVEL 0 goto :invalidoutput

:example2yes
ECHO.You selected Yes.
goto :end

:example2no
ECHO.You selected No.
goto :end

:invalidoutput
ECHO.Invalid output given by GETYN.COM
goto end

:end