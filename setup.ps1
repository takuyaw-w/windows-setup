<#
 # 事前に行っておくこと。
 # 1. ExecutionPolicyの変更
 #    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
 #>

 Write-Host "Did you set the ExecutionPolicy to RemoteSigned?"
$input = Read-Host "Enter (Y)es or (N)o?"
switch ($input) {
    "Y" {
        Write-Host "Start Setup." -ForegroundColor Green
    }
    "N" {
        Write-Host "Stop Setup." -ForegroundColor Red
        Write-Host "Execute the following command with administrative privileges." -ForegroundColor Red
        Write-Host "'Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force'" -BackgroundColor Yellow -ForegroundColor Black
        exit
    }
    Default {
        Write-Host "invalid value." -ForegroundColor Red
        exit
    }
}

# scoop install
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# scoop utility install
$UTILS = @(
  "aria2"
  "lessmsi"
  "dark"
  "7zip"
  "git"
)

scoop install $UTILS

# bucket add
scoop bucket add extras
scoop bucket add php
scoop update *

# package install
$PKGS = @(
    "vcredist2019"
    "android-studio"
    "vscode"
    "nvm"
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
    "php7.4"
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
