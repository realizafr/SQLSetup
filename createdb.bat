@echo off
echo Running MySQL setup dynamically from any folder...

REM Get the current directory of this batch file
SET SCRIPT_PATH=%~dp0

REM Define MySQL executable path inside XAMPP
SET MYSQL_PATH="C:\xampp\mysql\bin\mysql.exe"

REM Execute SQL file using MariaDB from the same folder as this batch script
%MYSQL_PATH% -u root < "%SCRIPT_PATH%setup.sql"

echo Database and table setup completed successfully!
pause
