echo off 
echo "This simple batch from https://github.com/hidekiyamamoto/W10AppxCleaner - will remove provisioned and installed apps except the ones specified." 
echo "You will see red logs but no matter what, let it finish, it will just take a small time." 
echo "When you are ready press any button." 
pause 
echo "This batch will remove any provisioned app except CALCULATOR and STICKY NOTES - you can add the apps you want to keep (see line 20 af this batch)" 
cd c:\ 
echo "Starting part I: Removing provisioned apps..." 
echo "Getting provisioned packages, this could take a minute or two..." 
powershell -command "& {Get-ProvisionedAppxPackage -online}" > xpackages.txt 
echo "Filtering packages names..." 
find "ackageName" xpackages.txt > xpackagesremove.txt 
echo "Removing application we want to keep from the list..." 
find /V "ticky" xpackagesremove.txt > xpackagesremove01.txt 
find /V "alculator" xpackagesremove01.txt > xpackagesremove02.txt 
echo "Renaming last packages file to powershell script..." 
ren xpackagesremove02.txt xpackagesremove.bat 
echo "Removing temporary files..." 
del xpackages.txt"
del xpackagesremove.txt 
del xpackagesremove01.txt
echo Replacing content in the batch file... 
powershell -command "& {(Get-Content c:\xpackagesremove.bat).replace('---------- XPACKAGESREMOVE01.TXT', '') | Set-Content c:\xpackagesremove.bat}" 
powershell -command "& {(Get-Content c:\xpackagesremove.bat).replace('---------- XPACKAGESREMOVE02.TXT', '') | Set-Content c:\xpackagesremove.bat}" 
powershell -command "& {(Get-Content c:\xpackagesremove.bat).replace('---------- XPACKAGESREMOVE.TXT', '') | Set-Content c:\xpackagesremove.bat}" 
powershell -command "& {(Get-Content c:\xpackagesremove.bat).replace('---------- XPACKAGES.TXT', '') | Set-Content c:\xpackagesremove.bat}" 
powershell -command "& {(Get-Content c:\xpackagesremove.bat).replace('PackageName  :', 'Remove-ProvisionedAppxPackage -online -PackageName') | Set-Content c:\xpackagesremove.bat}" 
powershell -command "& {(Get-Content c:\xpackagesremove.bat).replace('Remove-P', 'powershell -command ""Remove-P') | Set-Content c:\xpackagesremove.bat}" 


echo "Getting installed packages, this could take a minute or two..." 
powershell -command "& {Get-AppxPackage -allusers *}" > xapps.txt 
echo "Filtering packages names..." 
find "FullName" xapps.txt > xpackagesremove.txt 

echo "Removing application and dependencies we want to keep from the list... (see line 50 of this script)" 
find /V "ticky" xpackagesremove.txt > xpackagesremove01.txt 
find /V "alculator" xpackagesremove01.txt > xpackagesremove02.txt 
find /V "Native.Runtime" xpackagesremove02.txt > xpackagesremove01.txt 
find /V "Native.Framework" xpackagesremove01.txt > xpackagesremove02.txt 
find /V "VCLibs" xpackagesremove02.txt > xpackagesremove01.txt 

 
echo "Renaming last packages file to powershell script..." 
ren xpackagesremove01.txt xappsremove.bat 
echo "Removing temporary files..." 
del xapps.txt 
del xpackagesremove.txt 
del xpackagesremove02.txt 
echo "Replacing content in the batch file..." 
powershell -command "& {(Get-Content c:\xappsremove.bat).replace('---------- XPACKAGESREMOVE01.TXT', '') | Set-Content c:\xappsremove.bat}" 
powershell -command "& {(Get-Content c:\xappsremove.bat).replace('---------- XPACKAGESREMOVE02.TXT', '') | Set-Content c:\xappsremove.bat}" 
powershell -command "& {(Get-Content c:\xappsremove.bat).replace('---------- XPACKAGESREMOVE.TXT', '') | Set-Content c:\xappsremove.bat}" 
powershell -command "& {(Get-Content c:\xappsremove.bat).replace('---------- XAPPS.TXT', '') | Set-Content c:\xappsremove.bat}" 
powershell -command "& {(Get-Content c:\xappsremove.bat).replace('PackageFullName        :', 'Remove-AppxPackage ') | Set-Content c:\xappsremove.bat}" 
powershell -command "& {(Get-Content c:\xappsremove.bat).replace('Remove-A', 'powershell -command ""Remove-A') | Set-Content c:\xappsremove.bat}" 
echo "End of part I: Removal scripts generated, press any button to run them." 
pause 
 
xpackagesremove.bat & xappsremove.bat & del xpackagesremove.bat & del xappsremove.bat 
echo "End of part II: Scripts executed, press any button to exit." 
pause 


