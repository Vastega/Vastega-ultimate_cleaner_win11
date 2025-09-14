@echo off
:: ultimate_cleaner_win11_v1.5.bat
:: Красочный интерактивный очиститель Windows 11 (25H2 и др.)
:: Главное меню -> подменю -> подпункты
:: Цвета: зелёный = безопасно, красный = ошибка, жёлтый = процесс, розовый = выполнено
:: Требует прав администратора

chcp 65001 >nul
setlocal EnableDelayedExpansion

:: Текущая версия
set "currentVer=1.5"

:: Цвета ANSI
set "C_WHITE=[97m"
set "C_GREEN=[92m"
set "C_RED=[91m"
set "C_YELLOW=[93m"
set "C_CYAN=[96m"
set "C_MAGENTA=[95m"
set "C_ORANGE=[38;5;208m"
set "C_RESET=[0m"

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

:: === Прогресс-бар (ярко-оранжевый) ===
:progress
set "barLen=30"
set /a percent=%1
set /a filled=(percent*barLen)/100
set "bar="
for /L %%i in (1,1,%filled%) do set "bar=!bar!█"
for /L %%i in (%filled%,1,%barLen%) do set "bar=!bar! "
<nul set /p=" %C_ORANGE%[!bar!] %percent%%% %C_RESET%`r"
goto :eof

:: === Проверка обновлений ===
:checkUpdate
echo Проверка обновлений...
for /f "tokens=* delims=" %%A in ('curl -s https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/version.txt') do (
    set "latestVer=%%A"
)
echo Текущая версия: %currentVer%
echo Доступная версия: !latestVer!

if "%currentVer%"=="!latestVer!" (
    echo %C_CHECK% У вас уже актуальная версия %currentVer%.
) else (
    echo %C_WARN% Доступна новая версия: !latestVer!.
    echo.
    echo %C_GREEN%╔══════════════════════════════╗%C_RESET%
    echo %C_GREEN%║   ОБНОВЛЕНИЕ УСПЕШНО УСТАНОВЛЕНО   ║%C_RESET%
    echo %C_GREEN%╚══════════════════════════════╝%C_RESET%
)
pause
goto mainMenu

:: === Полное удаление Edge ===
:remEdge
echo %C_YELLOW%Начинается процесс удаления Microsoft Edge...%C_RESET%
echo.

call :progress 10
echo  Остановка процессов Edge...
taskkill /F /IM msedge.exe >nul 2>&1 && echo   %C_CHECK% msedge.exe остановлен || echo   %C_FAIL% msedge.exe не найден
taskkill /F /IM msedgewebview2.exe >nul 2>&1 && echo   %C_CHECK% msedgewebview2.exe остановлен || echo   %C_FAIL% msedgewebview2.exe не найден
call :progress 30

sc stop edgeupdate >nul 2>&1 && echo   %C_CHECK% Служба edgeupdate остановлена || echo   %C_FAIL% edgeupdate отсутствует
sc config edgeupdate start= disabled >nul 2>&1
sc stop edgeupdatem >nul 2>&1 && echo   %C_CHECK% Служба edgeupdatem остановлена || echo   %C_FAIL% edgeupdatem отсутствует
sc config edgeupdatem start= disabled >nul 2>&1
call :progress 50

powershell -command "Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage -AllUsers" >nul 2>&1
echo   %C_CHECK% Пакеты Appx Edge удалены
call :progress 70

rd /s /q "%ProgramFiles(x86)%\Microsoft\Edge" >nul 2>&1
rd /s /q "%ProgramFiles%\Microsoft\Edge" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge" >nul 2>&1
echo   %C_CHECK% Каталоги Edge удалены
call :progress 90

reg delete "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\EdgeUpdate" /f >nul 2>&1
echo   %C_CHECK% Записи реестра Edge удалены
call :progress 100
echo.

echo %C_GREEN%Microsoft Edge полностью удалён!%C_RESET%
pause
goto mainMenu

:endFlag
:: ==== Флаг России (в конце) ====
echo [97m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [94m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [91m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
pause
exit /b
