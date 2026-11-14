# Erstellt das Release von LocalAI Studio:
#   release\LocalAIStudio.exe         – eigenständige Single-File-Anwendung (Windows x64, .NET integriert)
#   release\LocalAIStudio-Setup.exe   – Windows-Installer (Inno Setup 6)
#
# Voraussetzungen: .NET 10 SDK, Inno Setup 6 (ISCC.exe)
# Verwendung:  powershell -ExecutionPolicy Bypass -File build.ps1 [-SkipTests]
param([switch]$SkipTests)
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'
$env:DOTNET_NOLOGO = '1'
if (Test-Path "$env:USERPROFILE\.dotnet\dotnet.exe") { $env:PATH = "$env:USERPROFILE\.dotnet;$env:PATH" }

$release = Join-Path $root 'release'
New-Item -ItemType Directory -Force $release | Out-Null

if (-not $SkipTests) {
    Write-Host "== Tests ==" -ForegroundColor Cyan
    dotnet test "$root\tests\LocalAIStudio.Tests\LocalAIStudio.Tests.csproj" -c Release
    if ($LASTEXITCODE -ne 0) { throw "Tests fehlgeschlagen." }
}

Write-Host "== Veröffentlichen (self-contained, single-file, win-x64) ==" -ForegroundColor Cyan
$publish = Join-Path $root 'artifacts\publish'
Remove-Item $publish -Recurse -Force -ErrorAction SilentlyContinue
dotnet publish "$root\src\LocalAIStudio\LocalAIStudio.csproj" -c Release -r win-x64 --self-contained true `
    -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:EnableCompressionInSingleFile=true `
    -p:DebugType=none -p:DebugSymbols=false -o $publish
if ($LASTEXITCODE -ne 0) { throw "Veröffentlichen fehlgeschlagen." }
Copy-Item "$publish\LocalAIStudio.exe" "$release\LocalAIStudio.exe" -Force

Write-Host "== Installer ==" -ForegroundColor Cyan
$iscc = @("$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe", "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe", "$env:ProgramFiles\Inno Setup 6\ISCC.exe") |
    Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $iscc) { throw "Inno Setup 6 (ISCC.exe) wurde nicht gefunden." }
& $iscc /Q "$root\installer\LocalAIStudio.iss"
if ($LASTEXITCODE -ne 0) { throw "Installer-Erstellung fehlgeschlagen." }

Get-ChildItem $release -Filter *.exe | ForEach-Object { "{0,-28} {1,8:N1} MB" -f $_.Name, ($_.Length / 1MB) }
