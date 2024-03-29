function Get-Inventory
{
    BEGIN
    {
        Remove-Item -ea SilentlyContinue c:\retries.txt
    }
    PROCESS
    {
        try
        {
            $computername = $_
            $os = gwmi win32_operatingsystem -comp $_ -ea Stop
            $bios = gwmi win32_bios -comp $_
            $obj = New-Object -TypeName PSObject
            $obj | Add-Member -MemberType NoteProperty -Name ComputerName -Value ($_)
            $obj | Add-Member -MemberType NoteProperty -Name OSBuild -Value ($os.buildnumber)
            $obj | Add-Member -MemberType NoteProperty -Name SPVersion -Value ($os.servicepackmajorversion)
            $obj | Add-Member -MemberType NoteProperty -Name BIOSSerial -Value ($bios.serialnumber)
            Write-Output $obj
        }
        catch
        {
            $computername | Out-File c:\retries.txt
        }
    }
}
'localhost','WIN2K8R2-PSTEST','localho' | Out-File c:\names.txt
Get-Content c:\names.txt | Get-Inventory | Export-Csv c:\inventory.csv