function Get-Stuff
{
    BEGIN
    {
        del c:\errors.txt -ea SilentlyContinue
    }
    PROCESS
    {
        trap
        {
            $_ | Out-File c:\errors.txt -append
            continue
        }
        gwmi win32_bios -comp $_ -ea Stop
    }
}
'WIN2K8R2-PSTEST','Notonline','localhost' | Get-Stuff