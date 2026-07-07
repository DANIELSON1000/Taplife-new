@echo off
echo ========================================
echo TapLife Database Setup Script
echo ========================================
echo.

echo Step 1: Creating database...
echo Please enter PostgreSQL password when prompted (hirwa)
echo.

"C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -c "CREATE DATABASE taplife_db;"

echo.
echo Step 2: Loading database schema...
echo.

"C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -d taplife_db -f "C:\Users\HP\Documents\maurice manzi UK\taplife-system\backend\database.sql"

echo.
echo ========================================
echo Database setup complete!
echo ========================================
pause
