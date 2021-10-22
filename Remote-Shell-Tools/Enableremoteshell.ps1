New-ItemProperty -Name LocalAccountTokenFilterPolicy `
-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
-PropertyType DWord -Value 1
Enable-PsRemoting -Force
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force