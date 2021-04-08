$MajorVersion = (Get-Host).version.Major

# function
function cdGhq {
    Set-Location $(ghq list --full-path | peco)
    Clear-Host
}

# Alias
Set-Alias g cdGhq
Set-Alias grep rg
Set-Alias find fd
if ($MajorVersion -eq 5) {
    Remove-Item alias:cat
} else {
    Remove-Alias cat
}
Set-Alias cat bat