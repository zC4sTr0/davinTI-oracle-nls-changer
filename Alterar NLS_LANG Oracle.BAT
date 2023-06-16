@echo off
setlocal enabledelayedexpansion

set "searchValue=NLS_LANG"
set "regKey=HKLM\SOFTWARE\Oracle"
set "foundKey="

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
    echo Nenhum local correspondente encontrado. Criado variável de ambiente: em "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
) else (
REG ADD "%foundKeyOracle%" /V NLS_LANG /T REG_SZ /F /D AMERICAN_AMERICA.WE8ISO8859P1
)

pause

endlocal
