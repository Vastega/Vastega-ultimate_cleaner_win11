@echo off
:: ultimate_cleaner_win11_v1.5.bat
:: Автоматическое обновление + меню очистки Windows 11
:: Цвета: зелёный = успех, красный = ошибка, оранжевый = новая версия, синий = актуально

chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ==============================
:: Версия программы
:: ==============================
set "currentVer=1.5"
set "updateURL=https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/ultimate_cleaner_win11_v1.5.bat"
set "updateFile=%~dp0ultimate_cleaner_win11_v1.5.bat"

:: ==============================
:: Цвета ANSI
:: ==============================
set "C_RESET=[0m"
set "C_GREEN=[92m"
set "C_RED=[91m"
set "C_ORANGE=[93m"
set "C_BLUE=[96m"

:: ==============================
:: Функция рамки
:: ==============================
:box
set "text=%~1"
set "color=%~2"
setlocal enabledelayedexpansion
set "len=0"
for /l %%i in (0,1,1024) do (
    if "!text:~%%i,1!"=="" (
        set len=%%i
        goto :breakLen
    )
)
:breakLen
set /a boxLen=len+4
<nul set /p "top=%color% "
for /l %%i in (1,1,!boxLen!) do <nul set /p "=%color%═"
echo %color%╗%C_RESET%
echo %color%║ %text% ║%C_RESET%
<nul set /p "bot=%color% "
for /l %%i in (1,1,!boxLen!) do <nul set /p "=%color%═"
echo %color%╝%C_RESET%
endlocal
goto :eof

:: ==============================
:: Проверка обновлений
:: ==============================
:updateCheck
echo Проверка обновлений...
:: загружаем файл версии
powershell -command "(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner_win11/main/version.txt').Content" > "%temp%\version.txt"
set /p latestVer=<"%temp%\version.txt"
del "%temp%\version.txt"

if "%latestVer%"=="" (
    call :box "Ошибка: не удалось проверить обновления" %C_RED%
    goto mainMenu
)

echo Текущая версия: %currentVer%
echo Доступная версия: %latestVer%

if "%latestVer%"=="%currentVer%" (
    call :box "У вас актуальная версия" %C_BLUE%
    goto mainMenu
) else (
    call :box "Найдена новая версия: %latestVer%" %C_ORANGE%
    echo Загрузка новой версии...
    powershell -command "Invoke-WebRequest -Uri '%updateURL%' -OutFile '%updateFile%'"
    if exist "%updateFile%" (
        call :box "ОБНОВЛЕНИЕ УСПЕШНО УСТАНОВЛЕНО ✓" %C_GREEN%
        echo Запуск новой версии...
        start "" "%updateFile%"
        exit
    ) else (
        call :box "Ошибка: файл обновления не найден" %C_RED%
        goto mainMenu
    )
)

:: ==============================
:: Главное меню
:: ==============================
:mainMenu
cls
echo =============================
echo     ULTIMATE CLEANER v%currentVer%
echo =============================
echo 1. Очистка временных файлов
echo 2. Очистка кэша
echo 3. Проверка обновлений
echo 0. Выход
echo =============================
set /p choice="Выберите пункт меню: "

if "%choice%"=="1" goto cleanTemp
if "%choice%"=="2" goto cleanCache
if "%choice%"=="3" goto updateCheck
if "%choice%"=="0" exit
goto mainMenu

:: ==============================
:: Очистка временных файлов
:: ==============================
:cleanTemp
echo Очистка временных файлов...
del /q /s "%temp%\*.*" >nul 2>&1
call :box "Очистка завершена" %C_GREEN%
pause
goto mainMenu

:: ==============================
:: Очистка кэша
:: ==============================
:cleanCache
echo Очистка кэша...
del /q /s "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
call :box "Кэш очищен" %C_GREEN%
pause
goto mainMenu
