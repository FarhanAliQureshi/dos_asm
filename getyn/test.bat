@ECHO OFF

IF NOT EXIST BUILD\GETYN.COM GOTO :NotFound

:Example1
ECHO.First example:
ECHO.Press either Y or N to continue...
CALL BUILD\GETYN.COM

IF ERRORLEVEL 2 GOTO :Example1No
IF ERRORLEVEL 1 GOTO :Example1Yes
IF ERRORLEVEL 0 GOTO :InvalidOutput

:Example1Yes
ECHO.You pressed Y.
GOTO :Example2

:Example1No
ECHO.You pressed N.
GOTO :Example2

:Example2
ECHO.
ECHO.Second example:
CALL BUILD\GETYN.COM Press either Y or N to continue (Y/N): 
IF ERRORLEVEL 2 GOTO :Example2No
IF ERRORLEVEL 1 GOTO :Example2Yes
IF ERRORLEVEL 0 GOTO :InvalidOutput

:Example2Yes
ECHO.You selected Yes.
GOTO :end

:Example2No
ECHO.You selected No.
GOTO :end

:InvalidOutput
ECHO.Invalid output given by GETYN.COM
GOTO end

:NotFound
ECHO.BUILD\GETYN.COM is not found. Please run MAKE to build it.
GOTO end

:end