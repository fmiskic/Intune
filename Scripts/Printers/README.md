1. Add correct drivers to the "Driver" folder
2. Change variables in AddPrinter.ps1 to match the printer you are trying to add.
3. Package the whole folder directory using IntuneWinAppUtil.exe
4. Run IntuneWinAppUtil.exe via cmdline. Specify your source folder as X:\Sample\Add Printer. The setup file will be RunAddPrinter.cmd. Output folder can also be X:\Sample\Add Printer. Say no to specify catalog folder. Then the .intunewin file should be created
5. Add the app to Intune via Windows app (Win32) select the .intunewin file you just created
6. For the App info enter the usual stuff. Under Program Install/Uninstall command put RunAddPrinter.cmd
7. For the Detection rule set Manual>Registry. Key Path: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\$PrinterName from AddPrinter.ps1. For example if $PrinterName = Cookie it would be HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\Cookie. Detection Method: Key exists
