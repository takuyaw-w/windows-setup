<#
 # Advance Preparation
 # 1. Change ExecutionPolicy
 #    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
 # 2. Install scoop
 #    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
 #    
 #>

$isScoopInstalled = Get-Command scoop;
if ($isScoopInstalled) {
    Write-Host "Start Setup."
} else {
    Write-Host "scoop is not installed." -ForegroundColor Red
    Write-Host "Execute the following command with administrative privileges to install scoop." -ForegroundColor Red
    Write-Host "Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')" -BackgroundColor Yellow -ForegroundColor Black
    exit
}

# scoop utility install
$UTILS = @(
  "aria2"
  "lessmsi"
  "dark"
  "innounp"
  "7zip"
  "git"
)

scoop install $UTILS

# bucket add
scoop bucket add extras
scoop bucket add jp https://github.com/rkbk60/scoop-for-jp
scoop update *

# package install
$PKGS = @(
    "vscode"
    "winmerge"
    "vim-kaoriya"
    # "nvm" -> volta
    "ghq"
    "peco"
    "jq"
    "pwsh"
    "gitui"
    "ripgrep"
    "firefox"
    "googlechrome"
    "thunderbird"
    "windows-terminal"
    "ripgrep"
    "fd"
    "bat"
)
scoop install $PKGS

# git settings
$USERNAME = Read-Host "Your Name?"
$USEREMAIL = Read-Host "Your email?"
git config --global user.name $USERNAME
git config --global user.email $USEREMAIL 
git config --global core.autoCRLF false
git config --global ghq.root '~/dev'

# profile
$PSUSERHOME = $profile -replace "^(.*)\\.*$", "`$1" -replace "^(.*)\\.*$", "`$1"
## Windows Powershell
New-Item $PSUSERHOME\WindowsPowerShell -Force -ItemType Directory
## Powershell Core
New-Item $PSUSERHOME\PowerShell -Force -ItemType Directory

# runas
Start-Process powershell.exe ("-NoProfile -Command cd " + $PSScriptRoot + "; .\runas.ps1") -Verb runas
