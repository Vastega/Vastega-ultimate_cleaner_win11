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

echo %C_WHITE%25. Проверить обновление программы%C_RESET%
echo.
set /p CHOICE="Выберите пункт меню: "

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
    call :boxBlue "У вас уже актуальная версия %currentVer%"
) else (
    call :boxOrange "Найдена новая версия: !latestVer! ⬇"

    echo Загрузка новой версии...
    call :progress

    set "newFile=ultimate_cleaner_win11_v!latestVer!.bat"
    curl -s -L -o "%~dp0!newFile!" ^
      https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/!newFile!

    if exist "%~dp0!newFile!" (
        call :boxGreen "ОБНОВЛЕНИЕ УСПЕШНО УСТАНОВЛЕНО ✅"
        echo Создание резервной копии старой версии...
        ren "%~f0" "ultimate_cleaner_win11_v%currentVer%.bak"

        echo Запуск новой версии...
        start "" "%~dp0!newFile!"
        exit /b
    ) else (
        call :boxRed "Ошибка: файл обновления не найден ❌"
    )
)
pause
goto mainMenu

:: === Цветные рамки ===
:boxGreen
echo [92m╔════════════════════════════════════════╗[0m
echo [92m║ %~1 ║[0m
echo [92m╚════════════════════════════════════════╝[0m
goto :eof

:boxRed
echo [91m╔════════════════════════════════════════╗[0m
echo [91m║ %~1 ║[0m
echo [91m╚════════════════════════════════════════╝[0m
goto :eof

:boxOrange
echo [38;5;208m╔════════════════════════════════════════╗[0m
echo [38;5;208m║ %~1 ║[0m
echo [38;5;208m╚════════════════════════════════════════╝[0m
goto :eof

:boxBlue
echo [96m╔════════════════════════════════════════╗[0m
echo [96m║ %~1 ║[0m
echo [96m╚════════════════════════════════════════╝[0m
goto :eof

:: === Градиентный прогресс-бар ===
:progress
setlocal EnableDelayedExpansion

:: Градиент: красный → жёлтый → зелёный
set "GRAD[0]=[91m"
set "GRAD[1]=[93m"
set "GRAD[2]=[92m"

set "barLen=30"
set /a step=100/barLen

for /L %%p in (0,1,100) do (
    set /a index=%%p/33
    set "color=!GRAD[!index!]!"

    set "bar="
    for /L %%i in (1,1,!barLen!) do (
        if %%i LEQ %%p/!step! (
            set "bar=!bar!█"
        ) else (
            set "bar=!bar! "
        )
    )

    <nul set /p "=!color![!bar!] %%p%%[0m`r"
    ping -n 1 localhost >nul
)
echo(
endlocal
goto :eof

:endFlag
:: ==== Флаг России (в конце) ====
echo [97m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [94m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
echo [91m████████████████████████████████████████████████████████████████████████████████████████████████████████████████████[0
pause
exit /b
