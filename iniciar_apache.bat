@echo off
chcp 65001 > nul
echo ==============================================================================
echo   NODO - Lanzador de Servidor Web Apache (Entorno Local)
echo ==============================================================================
echo.

set FOUND=0

:: 1. Comprobar XAMPP
if exist "C:\xampp\apache\bin\httpd.exe" (
    echo [✓] Apache encontrado en XAMPP (C:\xampp\apache\bin\httpd.exe)
    set FOUND=1
    echo Iniciando servicio Apache...
    start "" "C:\xampp\apache\bin\httpd.exe"
    start http://localhost/index.html
    goto fin
)

:: 2. Comprobar Program Files Apache
if exist "C:\Program Files\Apache Software Foundation\Apache2.4\bin\httpd.exe" (
    echo [✓] Apache encontrado en Program Files
    set FOUND=1
    echo Iniciando servicio Apache...
    start "" "C:\Program Files\Apache Software Foundation\Apache2.4\bin\httpd.exe"
    start http://localhost/index.html
    goto fin
)

:: 3. Comprobar WampServer
if exist "C:\wamp64\bin\apache\apache2.4.58\bin\httpd.exe" (
    echo [✓] Apache encontrado en WampServer
    set FOUND=1
    start "" "C:\wamp64\bin\apache\apache2.4.58\bin\httpd.exe"
    start http://localhost/index.html
    goto fin
)

if %FOUND%==0 (
    echo [i] No se encontro una instalacion automatica de Apache en C:\xampp o Program Files.
    echo.
    echo Pasos rapidos para usar con Apache:
    echo 1. Si usas XAMPP: copia esta carpeta a 'C:\xampp\htdocs\nodes\' y abre http://localhost/nodes/index.html
    echo 2. O configura el archivo 'apache-vhost.conf' provisto en la carpeta conf de tu Apache.
    echo 3. Alternativamente, puedes hacer doble clic directamente en 'index.html' para abrirlo en tu navegador.
    echo.
    echo Abriendo 'index.html' en tu navegador predeterminado...
    start "" "%~dp0index.html"
)

:fin
echo.
pause
