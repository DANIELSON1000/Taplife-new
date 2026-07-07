@echo off
echo TapLife - Allow port 5000 through Windows Firewall
echo Run this file as Administrator (right-click - Run as administrator)
echo.
netsh advfirewall firewall add rule name="TapLife API 5000 In" dir=in action=allow protocol=TCP localport=5000 profile=any
netsh advfirewall firewall add rule name="TapLife API 5000 Out" dir=out action=allow protocol=TCP localport=5000 profile=any
netsh advfirewall firewall add rule name="TapLife Node.js" dir=in action=allow program="C:\Program Files\nodejs\node.exe" enable=yes profile=any
echo.
echo Done. If you see "Ok." above, firewall is configured.
echo Now run: cd backend ^& npm run dev
pause
