$env:scotizeps_ver = 11
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv
Invoke-WebRequest -Uri https://s3.amazonaws.com/thejohnweb/scotizeps/versions.ps1 -Outfile "$HOME\Documents\WindowsPowerShell\versions.ps1"
if (Test-Path "$HOME\Documents\WindowsPowerShell\versions.ps1") {
    Start-Process -FilePath powershell.exe -ArgumentList "$HOME\Documents\WindowsPowerShell\versions.ps1" -NoNewWindow -Wait
    refreshenv
    Write-Host -ForegroundColor DarkMagenta "Local Scotize Version is $env:scotizeps_ver"
    Write-Host -ForegroundColor DarkMagenta "Online Scotize Version is $env:newscotizeps_ver"
    if ($env:newscotizeps_ver -gt $env:scotizeps_ver) {
        Write-Host -ForegroundColor DarkGreen "Scotize Version Upgrade Needed"
        Invoke-WebRequest -Uri https://s3.amazonaws.com/thejohnweb/scotizeps/scotizeps.ps1 -Outfile "$HOME\Documents\WindowsPowerShell\scotize.ps1"
        Invoke-WebRequest -Uri https://s3.amazonaws.com/thejohnweb/scotizeps/Microsoft.PowerShell_profile.ps1 -Outfile "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
        $env:scotizeps_ver = 11$env:newscotizeps_ver
        refreshenv
        Remove-Item -Path "$HOME\Documents\WindowsPowerShell\versions.ps1"
        Write-Host -ForegroundColor DarkGreen "Scotize Version Upgrade Complete"
    }
    else {
        Write-Host -ForegroundColor DarkMagenta "Scotize Version Upgrade Not Needed"
    }
}
