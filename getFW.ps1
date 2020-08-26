$getRulesStatus = Get-NetFirewallProfile | Select-Object Name , Enabled

#checks if a Windows Event log source with the give name already exists.
$logFileExists = [System.Diagnostics.EventLog]::SourceExists("WindowsFirewall");
#if the log source exists, it uses it. if it doesn't, it creates it.
if (! $logFileExists)
{New-EventLog -LogName Application -Source "WindowsFirewall"}



foreach ($rule in $getRulesStatus)

{

if ($rule.Enabled -eq $true)
{

Write-Host $rule

<#$infoMessage = $rule.name

 Write-Output "`n`n$infoMessage"

    Write-EventLog -LogName Application -Source "WindowsFirewall" -EntryType Information -EventID 2368 -Message ($infoMessage)
    #>
}
elseif ($rule.Enabled -eq $false)

{ 
$errorMessage = "$rule.Name is disabled" 
Write-Host "`n`n$errorMessage"
    Write-EventLog -LogName Application -Source "WindowsFirewall" -EntryType Error -EventID 2365 -Message ($errorMessage)
}
}
