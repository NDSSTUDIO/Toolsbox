@echo off
title NDS���ܹ�����
echo =================================================================================
echo  __  __  ____    ____        ____    ______  __  __  ____    ______   _____      
echo /\ \/\ \/\  _`\ /\  _`\     /\  _`\ /\__  _\/\ \/\ \/\  _`\ /\__  _\ /\  __`\    
echo \ \ `\\ \ \ \/\ \ \,\L\_\   \ \,\L\_\/_/\ \/\ \ \ \ \ \ \/\ \/_/\ \/ \ \ \/\ \  
echo  \ \ , ` \ \ \ \ \/_\__ \    \/_\__ \  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  \ \ \ \ \  
echo   \ \ \`\ \ \ \_\ \/\ \L\ \    /\ \L\ \ \ \ \ \ \ \_\ \ \ \_\ \ \_\ \__\ \ \_\ \ 
echo    \ \_\ \_\ \____/\ `\____\   \ `\____\ \ \_\ \ \_____\ \____/ /\_____\\ \_____\
echo     \/_/\/_/\/___/  \/_____/    \/_____/  \/_/  \/_____/\/___/  \/_____/ \/_____/
echo NDS���ܹ����� �Զ������³���[UPD]
echo NDSNETWORK By-N98MC_DG2
echo =================================================================================

echo ���ڼ�⻷��...
ver | findstr /i "10\." > nul
if %errorlevel% equ 0 (
    goto startOL
) else (
    echo ��ϵͳ��֧����������,��������ģʽ...
    goto startNOOL
    
)

:startOL
echo ϵͳ�汾֧��,��ʼ��������Ƿ�ͨ��...
REM ���������Ƿ�����
ping github.com -n 1 > nul
if errorlevel 1 (
echo �޷����ӵ�������!
echo ����������������,����ѯ�ʷ���������Ա
echo ����������ģʽ����...
timeout /t 3
goto startNOOL
) else (
goto cupd
)

:cupd
echo ��������������,��ʼ������...
powershell -command "curl -o 'ver.bat' 'https://github.com/NDSSTUDIO/Toolsbox/ver.bat'"
call ver.bat
del ver.bat

if not exist "%~dp0main" (
    set choice=y
    echo ��⵽δ����������,��ʼ����...
    goto download
) else (
    goto upd
    
)


:upd
REM ��ǰ�汾��
cls
set /p imver=< %~dp0\ver.txt
REM ��ȡ���°汾��
echo ��ȡ���������°汾:
echo %ver%
echo ���ذ汾��
echo %imver%
REM ���汾���Ƿ����+-
if %qupd%==true (
    echo �˰汾ǿ�Ƹ���!
    set choice=y
    goto download   
) else (
    goto startUPD
)
:startUPD
if %ver%==%imver% (
    goto start
) else (
    set /p choice="��鵽���µĸ��£��Ƿ������ [y/n] (y=���ظ��� n=�����ظ���:)"
    goto download
)


:download
if /I "%choice%"=="y" (
    powershell -command "curl -o 'main.bat' 'https://github.com/NDSSTUDIO/Toolsbox/main.bat'"
    attrib "main.bat" +h +s
    echo %ver% > %~dp0\ver.txt
    attrib "ver.txt" +h
    ) else (
    echo ȡ������,ֱ������...
)

:start
echo ���,������������...
timeout /t 3
start main.bat
