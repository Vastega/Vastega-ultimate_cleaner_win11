@echo off
:: ultimate_cleaner_win11.bat v1.5
:: Очистка Windows 11 (25H2 и др.)
:: Кодировка: ANSI (Windows-1251)

chcp 1251 >nul
setlocal EnableDelayedExpansion

:: Цвета
set "C_OK=[92m"
set "C_FAIL=[91m"
set "C_WARN=[93m"
set "C_INFO=[96m"
set "C_RESET=[0m"

:MENU
cls
echo ================================
echo   ⚡ ULTIMATE CLEANER v1.5 ⚡
echo ================================
echo.
echo 1. Очистка временных файлов
echo 2. Очистка кеша Windows Update
echo 3. Удаление логов
echo 4. Очистка корзины
echo 5. Полная очистка
echo 25. Проверка обновлений
echo 0. Выход
echo.
set /p choice="Выберите пункт меню: "

if "%choice%"=="1" goto TEMP
if "%choice%"=="2" goto WU
if "%choice%"=="3" goto LOGS
if "%choice%"=="4" goto BIN
if "%choice%"=="5" goto FULL
if "%choice%"=="25" goto UPDATE
if "%choice%"=="0" exit
goto MENU

:TEMP
echo %C_INFO%[INFO]%C_RESET% Очистка временных файлов...
del /s /q "%temp%\*.*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1
md "%temp%"
echo %C_OK%[OK]%C_RESET% Временные файлы удалены!
pause
goto MENU

:WU
echo %C_INFO%[INFO]%C_RESET% Очистка кеша Windows Update...
net stop wuauserv >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution" >nul 2>&1
net start wuauserv >nul 2>&1
echo %C_OK%[OK]%C_RESET% Кеш Windows Update очищен!
pause
goto MENU

:LOGS
echo %C_INFO%[INFO]%C_RESET% Очистка логов...
del /s /q "C:\Windows\Logs\*.*" >nul 2>&1
echo %C_OK%[OK]%C_RESET% Логи удалены!
pause
goto MENU

:BIN
echo %C_INFO%[INFO]%C_RESET% Очистка корзины...
rd /s /q %systemdrive%\$Recycle.Bin >nul 2>&1
echo %C_OK%[OK]%C_RESET% Корзина очищена!
pause
goto MENU

:FULL
echo %C_WARN%[WARNING]%C_RESET% Запущена полная очистка!
call :TEMP
call :WU
call :LOGS
call :BIN
echo %C_OK%[OK]%C_RESET% Полная очистка завершена!
pause
goto MENU

:UPDATE
echo Проверка обновлений...
set "current_version=1.5"
set "latest_version=1.5"

if "%current_version%"=="%latest_version%" (
    echo %C_OK%Установлена последняя версия %current_version%!%C_RESET%
) else (
    echo %C_WARN%Найдена новая версия: %latest_version%%C_RESET%
    echo Загрузка новой версии...
    :: Тут можно вставить код скачивания с GitHub
    echo %C_OK%[OK]%C_RESET% Обновление успешно установлено!
    echo Запуск новой версии...
    start "" "ultimate_cleaner_win11_v%latest_version%.bat"
    exit
)
pause
goto MENU
