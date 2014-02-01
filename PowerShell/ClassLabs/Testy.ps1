#$DebugPreference = "Continue"
$name = Read-Host "Enter computer name"
#Write-Debug "`$name contains $name"
if (Test-Connection $name -quiet)
{
    #Write-Debug "Test-connection was True"
    gwmi win32_bios -ComputerName $name
}
else
{
    #Write-Debug "Test-connection was False"
}