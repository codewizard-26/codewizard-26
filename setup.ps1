<#
.SYNOPSIS
    Regenerates all local assets for the codewizard-26 profile README.
#>
[CmdletBinding()]
param(
    [string]$Username = 'codewizard-26',
    [string]$Image = 'assets\Frame 1.png',
    [int]$Cols = 100,
    [switch]$Color = $true,
    [switch]$Reveal = $true
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot

Write-Host "`n[1/3] drawing the skill radar" -ForegroundColor Cyan
python (Join-Path $root 'scripts\radar.py') --data (Join-Path $root 'assets\skills.json') -o (Join-Path $root 'assets\radar')

Write-Host "`n[2/3] drawing the language radar & stat cards from GitHub" -ForegroundColor Cyan
try {
    python (Join-Path $root 'scripts\radar.py') --github $Username -o (Join-Path $root 'assets\radar-langs') --values --curve 0.4
} catch {
    Write-Warning "language radar skipped: $_"
}

try {
    python (Join-Path $root 'scripts\cards.py') --user $Username --projects (Join-Path $root 'assets\projects.json') --out (Join-Path $root 'assets')
} catch {
    Write-Warning "cards skipped: $_"
}

if (Test-Path (Join-Path $root $Image)) {
    Write-Host "`n[3/3] dot-matrixing $Image" -ForegroundColor Cyan
    $dotArgs = @(
        (Join-Path $root 'scripts\dotify.py'), (Join-Path $root $Image),
        '-o', (Join-Path $root 'assets\portrait'),
        '--cols', $Cols, '--equalize', '--detail', '0.5'
    )
    if ($Color)  { $dotArgs += '--color' }
    if ($Reveal) { $dotArgs += '--reveal' }
    python @dotArgs
}

Write-Host "`ndone! Open preview.html to inspect assets locally.`n" -ForegroundColor Green
