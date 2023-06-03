@echo off
title NDS万能工具箱
echo =================================================================================
echo  __  __  ____    ____        ____    ______  __  __  ____    ______   _____      
echo /\ \/\ \/\  _`\ /\  _`\     /\  _`\ /\__  _\/\ \/\ \/\  _`\ /\__  _\ /\  __`\    
echo \ \ `\\ \ \ \/\ \ \,\L\_\   \ \,\L\_\/_/\ \/\ \ \ \ \ \ \/\ \/_/\ \/ \ \ \/\ \  
echo  \ \ , ` \ \ \ \ \/_\__ \    \/_\__ \  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  \ \ \ \ \  
echo   \ \ \`\ \ \ \_\ \/\ \L\ \    /\ \L\ \ \ \ \ \ \ \_\ \ \ \_\ \ \_\ \__\ \ \_\ \ 
echo    \ \_\ \_\ \____/\ `\____\   \ `\____\ \ \_\ \ \_____\ \____/ /\_____\\ \_____\
echo     \/_/\/_/\/___/  \/_____/    \/_____/  \/_/  \/_____/\/___/  \/_____/ \/_____/
echo NDS万能工具箱 自动化更新程序[UPD]
echo NDSNETWORK By-N98MC_DG2
echo =================================================================================

echo 正在检测环境...
ver | findstr /i "10\." > nul
if %errorlevel% equ 0 (
    goto startOL
) else (
    echo 该系统不支持联网功能,编译离线模式...
    goto startNOOL
    
)

:startOL
echo 系统版本支持,开始检查连接是否通畅...
REM 检查服务器是否正常
ping github.com -n 1 > nul
if errorlevel 1 (
echo 无法连接到服务器!
echo 请检查您的网络设置,或者询问服务器管理员
echo 程序将以离线模式启动...
timeout /t 3
goto startNOOL
) else (
goto cupd
)

:cupd
echo 服务器连接正常,开始检查更新...
powershell -command "curl -o 'ver.bat' 'https://github.com/NDSSTUDIO/Toolsbox/ver.bat'"
call ver.bat
del ver.bat

if not exist "%~dp0main" (
    set choice=y
    echo 检测到未下载主程序,开始下载...
    goto download
) else (
    goto upd
    
)


:upd
REM 当前版本号
cls
set /p imver=< %~dp0\ver.txt
REM 获取最新版本号
echo 获取到官网最新版本:
echo %ver%
echo 本地版本：
echo %imver%
REM 检查版本号是否相符+-
if %qupd%==true (
    echo 此版本强制更新!
    set choice=y
    goto download   
) else (
    goto startUPD
)
:startUPD
if %ver%==%imver% (
    goto start
) else (
    set /p choice="检查到有新的更新，是否继续？ [y/n] (y=下载更新 n=不下载更新:)"
    goto download
)


:download
if /I "%choice%"=="y" (
    powershell -command "curl -o 'main.bat' 'https://github.com/NDSSTUDIO/Toolsbox/main.bat'"
    attrib "main.bat" +h +s
    echo %ver% > %~dp0\ver.txt
    attrib "ver.txt" +h
    ) else (
    echo 取消下载,直接启动...
)

:start
echo 完成,正在启动程序...
timeout /t 3
start main.bat
