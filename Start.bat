@echo off
::ngxin 所在的盘符
set NGINX_PATH=%~d0

::Nginx 所在目录
set NGINX_DIR=%~dp0
::color 0a

:MENU
::tasklist|findstr /i "Nginx.exe"
tasklist /fi "imagename eq Nginx.exe"
TITLE Nginx 管理脚本

echo.
echo. *************************** 
echo. *************************** 
echo. *** Nginx 管理脚本 v1.1 *** 
echo. ***       Hmjz100       ***
echo. ***************************
echo. *************************** 
echo.
echo.  [1] 启 动
echo.  [2] 关 闭
echo.  [3] 重 启
echo.  [4] 刷 新
echo.  [5] 重载配置
echo.  [6] 检查配置
echo.  [7] 版 本
echo.  [0] 退 出
echo.

set /p ID=请输入选择的序号 $
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
::启动
:start
call :startNginx
GOTO MENU

::停止
:stop
call :shutdownNginx
GOTO MENU

::重启
:restart
call :shutdownNginx
call :startNginx
GOTO MENU

::检查测试配置文件
:checkConf
call :checkConfNginx
GOTO MENU

::重新加载Nginx配置文件
:reloadConf
call :checkConfNginx
call :reloadConfNginx
GOTO MENU

::显示Nginx版本
:showVersion
call :showVersionNginx
GOTO MENU


::*************************************************************************************
::底层
::*************************************************************************************
:shutdownNginx

echo.寻找Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"不存在, 尝试强制关闭。
    taskkill /F /IM Nginx.exe
    echo.关闭完成。
    goto :eof
)
echo 关闭Nginx......
Nginx -s stop
taskkill /F /IM Nginx.exe
echo.关闭完成。
goto :eof
 
:startNginx
echo.寻找Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"不存在
    goto :eof
)
 
%NGINX_PATH% 
cd "%NGINX_DIR%" 
 
IF EXIST "%NGINX_DIR%Nginx.exe" (
    echo.启动Nginx...... 
    start "" Nginx.exe
)
IF NOT EXIST "%NGINX_DIR%\conf\game.txt" (
    start "" "https://localhost/"
)
echo 01 > .\conf\game.txt
echo.启动完成。
goto :eof

 
:checkConfNginx
echo.寻找Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"不存在
    goto :eof
)

%NGINX_PATH%
cd "%NGINX_DIR%"
echo.检查 Nginx 配置文件......
Nginx -t -c conf/nginx.conf

goto :eof

::重新加载 Nginx 配置文件
:reloadConfNginx
echo.寻找Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"不存在
    goto :eof
)

%NGINX_PATH%
cd "%NGINX_DIR%"
echo.重载 Nginx 配置文件......
Nginx -s reload

goto :eof

::显示Nginx版本
:showVersionNginx
echo.寻找Nginx...... 
IF NOT EXIST "%NGINX_DIR%Nginx.exe" (
    echo "%NGINX_DIR%Nginx.exe"不存在
    goto :eof
)

%NGINX_PATH% 
cd "%NGINX_DIR%" 
Nginx -V

goto :eof