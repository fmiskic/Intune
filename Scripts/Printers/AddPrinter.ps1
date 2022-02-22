##Static Variables

$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$DriverInf = "$DriverPath\$DriverInfName"
$DriverPath = "$PSScriptRoot\Driver"

##Variables to Change

#Name of the driver
$DriverName = "Driver name goes here"

#Filename of .inf for printer driver
$DriverInfName = ".inf or similar goes here"

#Hostname or ip of printer
$portName = "hostname or direct ip of printer goes here"

#What you want your printer to be named on the system
$PrinterName = "What you want the printer to be named goes here"


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
