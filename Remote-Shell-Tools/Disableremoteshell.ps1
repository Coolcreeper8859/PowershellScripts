Remove-ItemProperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
-Name LocalAccountTokenFilterPolicy
Disable-PsRemoting -Force
Set-Item WSMan:\localhost\Client\TrustedHosts -Value " " -Force