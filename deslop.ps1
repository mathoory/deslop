# Lint prose for AI-writing tells: Vale (ai-tells + proselint + Claudisms), then the proselint CLI.
# Usage: deslop <file or folder>...      Exit code 1 if anything was flagged.
$dir = $PSScriptRoot
if ($args.Count -eq 0) { Write-Error "usage: deslop <file or folder>..."; exit 2 }
if (-not (Test-Path "$dir/styles/ai-tells")) { vale --config "$dir/.vale.ini" sync | Out-Null }
$status = 0
vale --config "$dir/.vale.ini" --output line @args
if ($LASTEXITCODE -ne 0) { $status = 1 }
if (Get-Command proselint -ErrorAction SilentlyContinue) {
    $env:PYTHONUTF8 = "1"
    proselint check --config "$dir/proselintrc.json" -o compact @args
    if ($LASTEXITCODE -ne 0) { $status = 1 }
} else { Write-Host "(proselint not installed: pip install proselint)" }
exit $status
