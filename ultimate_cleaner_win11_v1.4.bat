@echo off
:: ultimate_cleaner_win11_v1.4.bat
:: Красочный интерактивный очиститель Windows 11 (25H2 и др.)
:: Главное меню -> подменю -> подпункты
:: Цвета: зелёный = безопасно, красный = ошибка, жёлтый = процесс, розовый = выполнено
:: Требует прав администратора

chcp 65001 >nul
setlocal EnableDelayedExpansion

:: Текущая версия
set "currentVer=1.4"

:: Цвета ANSI
set "C_WHITE=[97m"
set "C_GREEN=[92m"
set "C_RED=[91m"
set "C_YELLOW=[93m"
set "C_CYAN=[96m"
set "C_MAGENTA=[95m"
set "C_RESET=[0m"
set "C_ORANGE=[38;5;208m"

:: Галочка и крест
set "C_CHECK=[92m✔[0m"
set "C_FAIL=[91m✘[0m"
set "C_WARN=[93m⚠[0m"

:: ==== Флаг России (в начале) ====
echo [97m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [94m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [91m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo.

:askEnter
echo.
set /p ANSWER="Хотите попасть в меню очистки? (Д/Н):"
if /I "%ANSWER%"=="Д" goto mainMenu
if /I "%ANSWER%"=="Н" goto endFlag
echo Пожалуйста, введите Д или Н.
goto askEnter

:mainMenu
cls
echo %C_CYAN%==========================================%C_RESET%
echo %C_CYAN%   ULTIMATE CLEANER – Windows 11 v%currentVer%   %C_RESET%
echo %C_CYAN%==========================================%C_RESET%
echo.

:: --- Очистка мусора ---
echo %C_GREEN%=== ОЧИСТКА МУСОРА ===%C_RESET%
echo %C_WHITE%  1. TEMP и временные файлы%C_RESET%
echo %C_WHITE%  2. Prefetch%C_RESET%
echo %C_WHITE%  3. Корзина%C_RESET%
echo %C_WHITE%  4. Миниатюры%C_RESET%
echo.

:: --- Система ---
echo %C_RED%=== СИСТЕМНЫЕ ФАЙЛЫ ===%C_RESET%
echo %C_WHITE%  5. Windows Update (кэш)%C_RESET%
echo %C_WHITE%  6. Windows.old%C_RESET%
echo %C_WHITE%  7. Гибернация (hiberfil)%C_RESET%
echo %C_WHITE%  8. Логи событий (Event Logs)%C_RESET%
echo.

:: --- Встроенные приложения ---
echo %C_MAGENTA%=== ВСТРОЕННЫЕ ПРИЛОЖЕНИЯ ===%C_RESET%
echo %C_WHITE%  9. Microsoft Store%C_RESET%
echo %C_WHITE% 10. Почта и Календарь%C_RESET%
echo %C_WHITE% 11. OneDrive%C_RESET%
echo %C_WHITE% 12. Edge (полное удаление)%C_RESET%
echo %C_WHITE% 13. Xbox%C_RESET%
echo %C_WHITE% 14. Defender%C_RESET%
echo %C_WHITE% 15. Телеметрия%C_RESET%
echo %C_WHITE% 16. UAC%C_RESET%
echo %C_WHITE% 17. Outlook%C_RESET%
echo %C_WHITE% 18. Microsoft 365%C_RESET%
echo %C_WHITE% 19. Поиск (Search)%C_RESET%
echo %C_WHITE% 20. Phone Link%C_RESET%
echo %C_WHITE% 21. WidgetService%C_RESET%
echo.

:: --- Дополнительно ---
echo %C_YELLOW%=== ДЕЙСТВИЯ СИСТЕМЫ ===%C_RESET%
echo %C_WHITE%22. Обновить меню%C_RESET%
echo %C_WHITE%23. Выход%C_RESET%
echo %C_WHITE%24. Перезагрузка ПК%C_RESET%
echo %C_WHITE%25. Проверить обновление программы%C_RESET%
echo.

set /p CHOICE="Выберите пункт меню: "

if "%CHOICE%"=="12" goto remEdge
if "%CHOICE%"=="25" goto checkUpdate

goto mainMenu

:: === Проверка обновлений ===
:checkUpdate
echo Проверка обновлений...
for /f "tokens=* delims=" %%A in ('curl -s https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/version.txt') do (
    set "latestVer=%%A"
)

echo Текущая версия: %currentVer%
echo Доступная версия: !latestVer!

if "%currentVer%"=="!latestVer!" (
    echo.
    echo %C_CYAN%╔════════════════════════════════════╗%C_RESET%
    echo %C_CYAN%║     У ВАС АКТУАЛЬНАЯ ВЕРСИЯ ✅     ║%C_RESET%
    echo %C_CYAN%╚════════════════════════════════════╝%C_RESET%
) else (
    echo.
    echo %C_ORANGE%╔══════════════════════════════════════════════╗%C_RESET%
    echo %C_ORANGE%║   НАЙДЕНА НОВАЯ ВЕРСИЯ: !latestVer! ⚠        ║%C_RESET%
    echo %C_ORANGE%╚══════════════════════════════════════════════╝%C_RESET%
    echo.
    echo Загрузка новой версии...

    :: Прогресс-бар загрузки
    call :progressBar

    set "tempFile=%~dp0update_temp.bat"
    curl -s -L -o "!tempFile!" ^
      https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/ultimate_cleaner_win11_v!latestVer!.bat

    if exist "!tempFile!" (
        echo.
        echo %C_GREEN%╔════════════════════════════════════════════╗%C_RESET%
        echo %C_GREEN%║    ОБНОВЛЕНИЕ УСПЕШНО УСТАНОВЛЕНО ✅     ║%C_RESET%
        echo %C_GREEN%╚════════════════════════════════════════════╝%C_RESET%

        echo Создание резервной копии...
        ren "%~f0" "ultimate_cleaner_win11_v%currentVer%.bak"

        echo Обновление основного файла...
        move /Y "!tempFile!" "%~dp0ultimate_cleaner_win11_v!latestVer!.bat" >nul

        echo Запуск новой версии...
        start "" "%~dp0ultimate_cleaner_win11_v!latestVer!.bat"
        exit /b
    ) else (
        echo.
        echo %C_RED%╔════════════════════════════════════╗%C_RESET%
        echo %C_RED%║   ОШИБКА: НЕ УДАЛОСЬ ОБНОВИТЬ ✘   ║%C_RESET%
        echo %C_RED%╚════════════════════════════════════╝%C_RESET%
    )
)

pause
goto mainMenu

:: === Прогресс-бар ===
:progressBar
setlocal EnableDelayedExpansion
set "bar="
for /L %%i in (1,1,20) do (
    set "bar=!bar!#"
    <nul set /p "=Загрузка: [!bar!....................] %%i0%%"
    ping -n 2 localhost >nul
    cls
)
echo Загрузка: [####################] 100%%
endlocal
exit /b

:: === Полное удаление Edge ===
:remEdge
echo Полное удаление Microsoft Edge...
taskkill /F /IM msedge.exe >nul 2>&1
taskkill /F /IM msedgewebview2.exe >nul 2>&1
taskkill /F /IM msedgeupdate.exe >nul 2>&1
taskkill /F /IM MicrosoftEdgeUpdate.exe >nul 2>&1
sc stop edgeupdate >nul 2>&1
sc config edgeupdate start= disabled >nul 2>&1
sc stop edgeupdatem >nul 2>&1
sc config edgeupdatem start= disabled >nul 2>&1
powershell -command "Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -command "Get-AppxProvisionedPackage -Online | where {$_.DisplayName -like '*Microsoft.MicrosoftEdge*'} | Remove-AppxProvisionedPackage -Online" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\Edge" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeUpdate" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeCore" >nul 2>&1
rd /s /q "%ProgramFiles%\Microsoft\Edge" >nul 2>&1
rd /s /q "%ProgramFiles%\Microsoft\EdgeUpdate" >nul 2>&1
rd /s /q "%ProgramFiles%\Microsoft\EdgeCore" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\EdgeUpdate" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\EdgeCore" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft\EdgeWebView" >nul 2>&1
rd /s /q "%ProgramFiles%\Microsoft\EdgeWebView" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\EdgeWebView" >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\EdgeUpdate" /f >nul 2>&1

:: Проверка остаточных файлов/процессов
set "edgeLeft=0"
tasklist | find /i "msedge.exe" >nul && set "edgeLeft=1"
if exist "%ProgramFiles(x86)%\Microsoft\Edge" set "edgeLeft=1"
if exist "%ProgramFiles%\Microsoft\Edge" set "edgeLeft=1"
if exist "%LOCALAPPDATA%\Microsoft\Edge" set "edgeLeft=1"

if "!edgeLeft!"=="0" (
    echo %C_CHECK% Microsoft Edge полностью удалён.
) else (
    echo %C_WARN% Microsoft Edge удалён частично, остались следы.
)
pause
goto mainMenu

:endFlag
:: ==== Флаг России (в конце) ====
echo [97m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [94m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [91m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
pause
exit /b
