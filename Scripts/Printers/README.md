# Readme
This script is intended for deploying network printers through the Company Portal app in Intune.

Create a folder on your computer in C:\Temp\Printer (For example).
You can either download and copy the AddPrinter.ps1 to this new directory

Download the drivers for the printer you are trying to add. Ideally this would be the extracted driver files (.inf)
Copy the corresponding driver files to C:\Temp\Printer\Driver 

Package the whole folder using IntuneWinAppUtil.exe https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool please read how to use.
Run IntuneWinAppUtil.exe via cmdline. Specify your source folder as C:\Temp\Printer. The setup file will be AddPrinter.ps1. Output folder can also be C:\Temp\Printer. Say no to specify catalog folder. Then the .intunewin file should be created


Add the app to Intune via Windows app (Win32) select the .intunewin file you just created
For the App info enter the usual stuff. Under Program Install/Uninstall command put RunAddPrinter.cmd
For the Detection rule set Manual>Registry. Key Path: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\$PrinterName from AddPrinter.ps1. For example if $PrinterName = Cookie it would be HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\Cookie. Detection Method: Key exists
