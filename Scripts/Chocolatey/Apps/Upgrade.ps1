 $MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq “OpenVPN Connect”}
$GetVersion = Get-WmiObject Win32_Product -Filter "name='OpenVPN Connect'" | Select-Object version
$MyAppIdentifier = $MyApp.IdentifyingNumber

foreach($version in $GetVersion)
{
    if(!($version.version -match "3.3.6"))
    {
        Start-Process -Wait "C:\Windows\System32\msiexec.exe" -ArgumentList "/x $MyAppIdentifier /qn"
        Start-Process -Wait "C:\ProgramData\Chocolatey\choco.exe" -ArgumentList "install openvpn-connect -y"
    }
} 
