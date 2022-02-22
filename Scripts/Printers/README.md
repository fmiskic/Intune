# Readme
This script is intended for deploying network printers through the Company Portal app in Intune or as a required app.

### How to use:
1. Create a folder on your computer in `C:\Temp\AddPrinter` #This folder can be anything you'd like but you need to make sure to realize this is the root of the folder.

2. You can download and copy the `AddPrinter.ps1` to this new directory

3. Download the drivers for the printer you are trying to add. Ideally this would be the extracted driver files (.inf)
Copy the corresponding driver files to `C:\Temp\AddPrinter\Driver` *This is important as the script reads the driver from the root of the AddPrinter.ps1 script*

### Modifying the script:
In the section `### Variables to Change ###`

	1. $DriverInfName = "example.inf"
*Enter the name of the .inf file you copied from the printer drivers you downloaded.*

*For example: If I am using a Xerox Global Printer Driver it would be `$DriverInfName = "x3UNIVX.inf" `*

	2. $DriverName = "Actual Driver Name Goes Here" 

*For example: If I am using a Xerox Global Printer Driver it would be `DriverName = "Xerox Global Print Driver PCL6"`*

	3. $portName = "hostname or ip goes here"

*For example: `$portName = "192.168.22.9"` or `$portName = "cookie.hostname.com"`*

	4. $PrinterName = "Cookie Printer"

*The name the printer will have on the workstation*

Once complete. Save the file. 

*Note: You can also rename the .ps1 to something else but make sure when creating the .intunewin file you remember it is called this. Also in the Intune install command it needs to be this as well.*

### End Changing Variables ###


### Creating the .intunewin file to be uploaded to Intune:
1. Package the whole folder using IntuneWinAppUtil.exe 
	* 	https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool 

	*Please read how to use the IntuneWinAppUtil.exe.*
2. Run IntuneWinAppUtil.exe via cmdline. 
	* Specify your source folder as `C:\Temp\AddPrinter`
	* The setup file will be `AddPrinter.ps1`
	* Output folder can also be `C:\Temp\AddPrinter`
	* Say `No` to specify catalog folder. 

3. The .intunewin file should be created and found in C:\Temp\AddPrinter if you are following the paths recommended in the readme.

### How to add the .intunewin file to Intune:
1. Add the app to Intune via Apps>Windows then click +Add 
2. Select Windows app (Win32)
3. Select the .intunewin file you just created for the app package file.
4. For the App information enter a Name, Description, Publisher, and an Icon. 
5. Under Program Install/Uninstall command put `powershell.exe -ExecutionPolicy Bypass -File .\AddPrinter.ps1` *Note: Currently there is no uninstall script that I have created but it could be as simple as creating a script to remove it from the registry entry. Therefore the Install and Uninstall command are the same*
6. For the Detection rule set Manual>Registry. Key Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\$PrinterName` from `AddPrinter.ps1`. 
*For example if `$PrinterName = Cookie` it would be `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\Cookie`.* 
7. Set the detection Method: Key exists
8. Assign the script to the groups you would like. 

*Ideally this readme is in favor of making the printer Available to devices so they can install as Self Service from Company Portal. Otherwise you can make it required and it should autoinstall*

