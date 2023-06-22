@echo off
setlocal enabledelayedexpansion

set "searchValue=NLS_LANG"
set "regKey=HKLM\SOFTWARE\Oracle"
set "foundKey="
set "OraclePath=%ORACLE_HOME%"

for /f "tokens=1,2*" %%A in ('reg query "%regKey%" /s /v "%searchValue%" ^| findstr /i "%searchValue%"') do (
    set "foundKey=%%A"
    set "valueName=%%B"
    set "valueData=%%C"
)

for /f "tokens=1,2*" %%A in ('reg query "%regKey%" /s /v "%searchValue%" ^| findstr /i "Oracle"') do (
    set "foundKeyOracle=%%A"
    
    echo Local encontrado em: %foundKeyOracle%
    echo ----------------------------------------------
    echo Caminho completo: !foundKeyOracle! no registro !foundKey!
    echo Valor atual: !valueData!
    echo Valor trocado para: AMERICAN_AMERICA.WE8ISO8859P1
    echo ----------------------------------------------

)


if not defined foundKey (
    echo Nao foi encontrado um registro do OracleClient. Será criado variável de ambiente para o PLSQL em "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V NLS_LANG /T REG_SZ /F /D AMERICAN_AMERICA.WE8ISO8859P1
    echo %OraclePath%
    echo NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1 > "%OraclePath%/network/admin/sqlnet.ora"
    echo NLS_LANG configurado!

) else (
    REG ADD "%foundKeyOracle%" /V NLS_LANG /T REG_SZ /F /D AMERICAN_AMERICA.WE8ISO8859P1
)

pause

endlocal
