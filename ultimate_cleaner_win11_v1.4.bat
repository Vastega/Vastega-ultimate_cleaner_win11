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
echo.
echo Проверка обновлений...
set "verUrl=https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/version.txt"
set "tmpVer=%TEMP%\uc_remote_version.txt"

call :download "%verUrl%" "%tmpVer%"
if errorlevel 1 (
    echo.
    echo %C_RED%╔══════════════════════════════════════════╗%C_RESET%
    echo %C_RED%║  ❌ ОШИБКА: не удалось скачать version.txt  ║%C_RESET%
    echo %C_RED%╚══════════════════════════════════════════╝%C_RESET%
    pause
    goto mainMenu
)

set "latestVer="
for /f "usebackq delims=" %%A in ("%tmpVer%") do (
    set "latestVer=%%A"
    goto gotLatest
)
:gotLatest

if not defined latestVer (
    echo.
    echo %C_RED%╔══════════════════════════════════════════╗%C_RESET%
    echo %C_RED%║  ❌ ОШИБКА: version.txt пуст или неверен   ║%C_RESET%
    echo %C_RED%╚══════════════════════════════════════════╝%C_RESET%
    pause
    goto mainMenu
)

echo.
echo Текущая версия: %currentVer%
echo Доступная версия: !latestVer!

if "%currentVer%"=="!latestVer!" (
    echo.
    echo %C_CYAN%╔══════════════════════════════════════╗%C_RESET%
    echo %C_CYAN%║   У вас установлена актуальная версия   ║%C_RESET%
    echo %C_CYAN%╚══════════════════════════════════════╝%C_RESET%
    del /q "%tmpVer%" >nul 2>&1
    pause
    goto mainMenu
)

echo.
echo %C_YELLOW%╔══════════════════════════════════════╗%C_RESET%
echo %C_YELLOW%║   Найдена новая версия: !latestVer!    ║%C_RESET%
echo %C_YELLOW%╚══════════════════════════════════════╝%C_RESET%
echo.
set /p "doUpd=Обновить сейчас до v!latestVer!? (Д/Н): "
if /I NOT "%doUpd%"=="Д" (
    del /q "%tmpVer%" >nul 2>&1
    goto mainMenu
)

set "newFileName=ultimate_cleaner_win11_v!latestVer!.bat"
set "newUrl=https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/%newFileName%"
set "dest=%~dp0%newFileName%"

echo Загрузка %newFileName% ...
call :download "%newUrl%" "%dest%"
if errorlevel 1 (
    echo.
    echo %C_RED%╔══════════════════════════════════════════╗%C_RESET%
    echo %C_RED%║  ❌ Ошибка: не удалось скачать новую версию ║%C_RESET%
    echo %C_RED%╚══════════════════════════════════════════╝%C_RESET%
    del /q "%tmpVer%" >nul 2>&1
    pause
    goto mainMenu
)

for %%I in ("%dest%") do set "fsz=%%~zI"
if "%fsz%"=="0" (
    echo.
    echo %C_RED%╔══════════════════════════════════════════╗%C_RESET%
    echo %C_RED%║  ❌ Ошибка: файл нулевого размера           ║%C_RESET%
    echo %C_RED%╚══════════════════════════════════════════╝%C_RESET%
    del /q "%dest%" >nul 2>&1
    del /q "%tmpVer%" >nul 2>&1
    pause
    goto mainMenu
)

echo.
echo %C_GREEN%╔══════════════════════════════════════════════╗%C_RESET%
echo %C_GREEN%║   ✅ ОБНОВЛЕНИЕ УСПЕШНО УСТАНОВЛЕНО (v!latestVer!)   ║%C_RESET%
echo %C_GREEN%╚══════════════════════════════════════════════╝%C_RESET%
echo Создание резервной копии текущей версии...
ren "%~f0" "ultimate_cleaner_win11_v%currentVer%.bak" >nul 2>&1

echo Запуск новой версии...
start "" "%dest%"

del /q "%tmpVer%" >nul 2>&1
exit /b 0

:: === Полное удаление Edge ===
:remEdge
echo Полное удаление Microsoft Edge...
taskkill /F /IM msedge.exe >nul 2>&1
...
goto mainMenu

:endFlag
:: ==== Флаг России (в конце) ====
echo [97m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [94m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [91m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
pause
exit /b


:: ---------- Функция скачивания ----------
:download
setlocal
set "url=%~1"
set "out=%~2"

where curl >nul 2>&1
if %errorlevel%==0 (
    curl -s -L "%url%" -o "%out%"
    if %errorlevel%==0 (
        endlocal & exit /b 0
    )
)

powershell -NoProfile -Command ^
"try { (New-Object System.Net.WebClient).DownloadFile('%url%','%out%'); exit 0 } catch { exit 1 }"
if %errorlevel%==0 (
    endlocal & exit /b 0
)

endlocal & exit /b 1
