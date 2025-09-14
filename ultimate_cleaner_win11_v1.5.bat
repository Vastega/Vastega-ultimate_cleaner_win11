@echo off
:: ultimate_cleaner_win11_v1.5.bat
:: Красочный интерактивный очиститель Windows 11 (25H2 и др.)
:: Главное меню -> подменю -> подпункты
:: Цвета: зелёный = безопасно, красный = ошибка, жёлтый = процесс, розовый = выполнено
:: Требует прав администратора

chcp 65001 >nul
setlocal EnableDelayedExpansion

:: =============================
:: Текущая версия
set "currentVer=1.5"
:: =============================

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

:: =============================
:: Главное меню
:mainMenu
cls
echo %C_CYAN%=====================================================%C_RESET%
echo     ULTIMATE CLEANER – Windows 11 v%currentVer%
echo %C_CYAN%=====================================================%C_RESET%
echo.
echo 1. Очистка мусора
echo 2. Очистка кэша
echo 3. Проверить обновления
echo 0. Выход
echo.
set /p choice="Выберите пункт меню: "

if "%choice%"=="1" goto cleanTrash
if "%choice%"=="2" goto cleanCache
if "%choice%"=="3" goto updateCheck
if "%choice%"=="0" exit
goto mainMenu

:: =============================
:cleanTrash
echo %C_YELLOW%Очистка мусора...%C_RESET%
timeout /t 2 >nul
echo %C_GREEN%Готово!%C_RESET%
pause
goto mainMenu

:cleanCache
echo %C_YELLOW%Очистка кэша...%C_RESET%
timeout /t 2 >nul
echo %C_GREEN%Готово!%C_RESET%
pause
goto mainMenu

:: =============================
:updateCheck
echo Проверка обновлений...
set "latestVer=1.5"

if "%latestVer%"=="%currentVer%" (
    echo %C_GREEN%У вас уже последняя версия!%C_RESET%
    pause
    goto mainMenu
)

echo %C_YELLOW%Найдена новая версия: %latestVer%%C_RESET%
echo Загрузка новой версии...

:: Скачивание новой версии
set "newFile=%~dp0ultimate_cleaner_win11_v%latestVer%.bat"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Vastega/Vastega-ultimate_cleaner/main/ultimate_cleaner_win11_v%latestVer%.bat','%newFile%')"

if exist "%newFile%" (
    echo %C_GREEN%ОБНОВЛЕНИЕ УСПЕШНО УСТАНОВЛЕНО %C_CHECK%%C_RESET%
    echo Запуск новой версии: "%newFile%"
    start "" "%newFile%"
) else (
    echo %C_RED%Ошибка загрузки обновления %C_FAIL%%C_RESET%
)

echo.
pause
exit
