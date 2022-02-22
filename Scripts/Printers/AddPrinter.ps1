<#
.SYNOPSIS
    Name: AddPrinter.ps1
    The purpose of this script is to add a local printer to a device.

.DESCRIPTION
    This is a add printer script ideally used with Intune to create a .intunewinfile. This file can then be used to 
    deploy to computer via Intune.

.NOTES
    Version 1.0

#>

##Static Variables (Do not change!)

#Grab root path of script
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
#State driver path
$DriverPath = "$PSScriptRoot\Driver"

##End of static Variables

##Variables to Change (These need to be changed in order for the script to work)

#Filename of the .inf Driver
$DriverInfName = "example.inf" 

#Name of the driver
$DriverName = "Xerox Global Print Driver PCL6" #Example

#Hostname or ip of printer
$portName = "hostname or ip goes here"

#What you want your printer to be named on the system
$PrinterName = "Cookie Printer"

##End Changing Variables

#States the full driver path including driver .inf name
$DriverInf = "$DriverPath\$DriverInfName"

#Add Printer Script
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue

if (-not $checkPortExists) {

Add-PrinterPort -name $portName -PrinterHostAddress "$portName"
}
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prndrvr.vbs" -a -m "$DriverName" -h $DriverPath -i $DriverInf
$printDriverExists = Get-PrinterDriver -name $DriverName -ErrorAction SilentlyContinue

if ($printDriverExists)
{
Add-Printer -Name "$PrinterName" -PortName $portName -DriverName $DriverName
}
else
{
Write-Warning "Printer Driver not installed"
} 
