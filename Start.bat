@echo off
::ngxin ���ڵ��̷�
set NGINX_PATH=%~d0

::Nginx ����Ŀ¼
set NGINX_DIR=%~dp0
::color 0a

:MENU
::tasklist|findstr /i "Nginx.exe"
tasklist /fi "imagename eq Nginx.exe"
TITLE Nginx ����ű�

echo.
echo. *************************** 
echo. *************************** 
echo. *** Nginx ����ű� v1.1 *** 
echo. ***       Hmjz100       ***
echo. ***************************
echo. *************************** 
echo.
echo.  [1] �� ��
echo.  [2] �� ��
echo.  [3] �� ��
echo.  [4] ˢ ��
echo.  [5] ��������
echo.  [6] �������
echo.  [7] �� ��
echo.  [0] �� ��
echo.

set /p ID=������ѡ������ $
cls
IF "%id%"=="1" GOTO start
IF "%id%"=="2" GOTO stop
IF "%id%"=="3" GOTO restart
IF "%id%"=="4" GOTO MENU
IF "%id%"=="5" GOTO reloadConf
IF "%id%"=="6" GOTO checkConf
IF "%id%"=="7" GOTO showVersion
IF "%id%"=="0" EXIT
GOTO MENU

::*************************************************************************************************************
::����
:start
call :startNginx
GOTO MENU

::ֹͣ
:stop
call :shutdownNginx
GOTO MENU

::����
:restart
call :shutdownNginx
call :startNginx
GOTO MENU

::�����������ļ�
:checkConf
call :checkConfNginx
GOTO MENU

::���¼���Nginx�����ļ�
:reloadConf
call :checkConfNginx
call :reloadConfNginx
GOTO MENU

::��ʾNginx�汾
:showVersion
call :showVersionNginx
GOTO MENU


::*************************************************************************************
::�ײ�
::*************************************************************************************
:shutdownNginx

echo.Ѱ��Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"������, ����ǿ�ƹرա�
    taskkill /F /IM Nginx.exe
    echo.�ر���ɡ�
    goto :eof
)
echo �ر�Nginx......
Nginx -s stop
taskkill /F /IM Nginx.exe
echo.�ر���ɡ�
goto :eof
 
:startNginx
echo.Ѱ��Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"������
    goto :eof
)
 
%NGINX_PATH% 
cd "%NGINX_DIR%" 
 
IF EXIST "%NGINX_DIR%Nginx.exe" (
    echo.����Nginx...... 
    start "" Nginx.exe
)
IF NOT EXIST "%NGINX_DIR%\conf\game.txt" (
    start "" "https://localhost/"
)
echo 01 > .\conf\game.txt
echo.������ɡ�
goto :eof

 
:checkConfNginx
echo.Ѱ��Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"������
    goto :eof
)

%NGINX_PATH%
cd "%NGINX_DIR%"
echo.��� Nginx �����ļ�......
Nginx -t -c conf/nginx.conf

goto :eof

::���¼��� Nginx �����ļ�
:reloadConfNginx
echo.Ѱ��Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"������
    goto :eof
)

%NGINX_PATH%
cd "%NGINX_DIR%"
echo.���� Nginx �����ļ�......
Nginx -s reload

goto :eof

::��ʾNginx�汾
:showVersionNginx
echo.Ѱ��Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"������
    goto :eof
)

%NGINX_PATH% 
cd "%NGINX_DIR%" 
Nginx -V

goto :eof