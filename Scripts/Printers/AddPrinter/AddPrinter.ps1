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


##Static Variables

$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$DriverPath = "$PSScriptRoot\Driver"
#Filename of .inf for printer driver. This is the only thing that needs to be changed.
$DriverInfName = "OEMSETUP.inf"
$DriverInf = "$DriverPath\$DriverInfName"


##Variables to Change

#Name of the driver. You will need to stage or install the printer to see the name of the actual driver
$DriverName = "Printer Driver"

#Hostname or ip of printer
$portName = "myprinter.com or 192.168.1.5 for example"

#What you want your printer to be named on the system. It can be anything.
$PrinterName = "The printer name on the system"

#Printer 
$PrndrvrVBS = Resolve-Path "C:\Windows\System32\Printing_Admin_Scripts\*\Prndrvr.vbs" |Select -First 1

#Add Printer Script
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue

if (-not $checkPortExists) {

Add-PrinterPort -name $portName -PrinterHostAddress "$portName"
}
cscript "$PrndrvrVBS" -a -m "$DriverName" -h $DriverPath -i $DriverInf
$printDriverExists = Get-PrinterDriver -name $DriverName -ErrorAction SilentlyContinue

if ($printDriverExists)
{
Add-Printer -Name "$PrinterName" -PortName $portName -DriverName $DriverName
}
else
{
Write-Warning "Printer Driver not installed"
} 
