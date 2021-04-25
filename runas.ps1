$Document = [System.Environment]::GetFolderPath("MyDocument");

## Windows Powershell
New-Item -Force -ItemType SymbolicLink -Path $Document\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Value $PSScriptRoot\PowerShell_profile.ps1
## Powershell Core
New-Item -Force -ItemType SymbolicLink -Path $Document\PowerShell\Microsoft.PowerShell_profile.ps1 -Value $PSScriptRoot\PowerShell_profile.ps1
