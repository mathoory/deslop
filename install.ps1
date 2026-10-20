# One-time setup on Windows PowerShell: fetch styles, point Vale here, add `delint` to the profile.
$dir = $PSScriptRoot
if (-not (Get-Command vale -ErrorAction SilentlyContinue)) { Write-Error "Install Vale first: https://vale.sh/docs/install"; exit 1 }
vale --config "$dir/.vale.ini" sync
[Environment]::SetEnvironmentVariable("VALE_CONFIG_PATH", "$dir\.vale.ini", "User")
$line = "function delint { & '$dir\delint.ps1' @args }"
if (-not (Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force | Out-Null }
if (-not (Select-String -Path $PROFILE -SimpleMatch $line -Quiet)) { Add-Content -Path $PROFILE -Value $line }
Write-Host "Done. Open a new terminal, then: delint README.md"
