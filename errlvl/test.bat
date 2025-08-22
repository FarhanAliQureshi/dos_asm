@ECHO OFF

IF NOT EXIST BUILD\ERRLVL.COM GOTO :NotFound
CALL BUILD\ERRLVL.COM

IF ERRORLEVEL 5 GOTO :Err5
IF ERRORLEVEL 0 GOTO :NoError

:Err5
ECHO.ERRLVL.COM exited with ERRORLEVEL of 5
goto end

:NoError
ECHO.ERRLVL.COM exited without any return code
goto end

:NotFound
ECHO.BUILD\ERRLVL.COM is not found. Please run MAKE to build it.
goto end

:end