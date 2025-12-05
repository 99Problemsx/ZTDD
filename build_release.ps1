# Build Release Script für Zorua: The Divine Deception
# Erstellt verschlüsselte Asset-Packages und Release-Ordner

param(
    [string]$Version = "1.0.0",
    [switch]$SkipBuild = $false,
    [switch]$NoZip = $false,
    [switch]$Force = $false
)

Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Zorua Release Builder v1.0            ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$ReleaseName = "Zorua_v$Version"
$ReleaseDir = ".\Release\$ReleaseName"

# Schritt 1: Build Asset Packages (wenn nicht übersprungen)
if (-not $SkipBuild) {
    Write-Host "[1/5] Checking for encrypted asset packages..." -ForegroundColor Yellow
    
    # Prüfe ob Packages existieren
    $packages = Get-ChildItem -Path . -Filter "*.zrpk" -Recurse
    if ($packages.Count -eq 0) {
        Write-Host "  ! No .zrpk packages found." -ForegroundColor Yellow
        Write-Host "  → Build packages in-game with: AdvancedAssetProtection::Builder.build_all" -ForegroundColor Gray
        Write-Host ""
        if (-not $Force) {
            $continue = Read-Host "Continue without packages? (Y/N)"
            if ($continue -ne "Y" -and $continue -ne "y") {
                Write-Host "  ✗ Build cancelled." -ForegroundColor Red
                exit 0
            }
        }
        Write-Host "  → Continuing without encrypted packages (Dev Mode)" -ForegroundColor Yellow
    }
    else {
        Write-Host "  ✓ Found $($packages.Count) package(s)" -ForegroundColor Green
    }
}
else {
    Write-Host "[1/5] Skipping package check..." -ForegroundColor Yellow
}

# Schritt 2: Release-Ordner erstellen
Write-Host "[2/5] Creating release directory..." -ForegroundColor Yellow

if (Test-Path $ReleaseDir) {
    Write-Host "  → Cleaning old release..." -ForegroundColor Gray
    Remove-Item $ReleaseDir -Recurse -Force
}

New-Item -Path $ReleaseDir -ItemType Directory -Force | Out-Null
Write-Host "  ✓ Created: $ReleaseDir" -ForegroundColor Green

# Schritt 3: Dateien kopieren
Write-Host "[3/5] Copying files..." -ForegroundColor Yellow

# DLL Dateien (wichtig: im Hauptverzeichnis, nicht DLL-Ordner!)
Write-Host "  → Copying DLL files..." -ForegroundColor Gray
$dllFiles = Get-ChildItem -Path . -Filter "*.dll"
foreach ($dll in $dllFiles) {
    Copy-Item $dll.FullName -Destination $ReleaseDir
}
Write-Host "  ✓ Copied $($dllFiles.Count) DLL files" -ForegroundColor Green

# Essentials
$essentialFiles = @(
    "Game.exe",
    "Game.ini",
    "Game.rxproj",
    "mkxp.json",
    "README.md"
)

foreach ($file in $essentialFiles) {
    if (Test-Path $file) {
        Copy-Item $file -Destination $ReleaseDir
        Write-Host "  ✓ $file" -ForegroundColor Green
    }
    else {
        Write-Host "  ! $file not found" -ForegroundColor Yellow
    }
}

# Ordner
$essentialDirs = @(
    "DLL",
    "Fonts"
)

# Plugins werden nur im Dev-Mode kopiert (sonst in Packages)
$packages = Get-ChildItem -Path . -Filter "*.zrpk" -Recurse
if ($packages.Count -eq 0) {
    $essentialDirs += "Plugins"
}

foreach ($dir in $essentialDirs) {
    if (Test-Path $dir) {
        Copy-Item $dir -Destination $ReleaseDir -Recurse
        Write-Host "  ✓ $dir\" -ForegroundColor Green
    }
    else {
        Write-Host "  ! $dir\ not found" -ForegroundColor Yellow
    }
}

# Packages
$packages = Get-ChildItem -Path . -Filter "*.zrpk" -Recurse
if ($packages.Count -gt 0) {
    foreach ($package in $packages) {
        Copy-Item $package.FullName -Destination $ReleaseDir
        Write-Host "  ✓ $($package.Name)" -ForegroundColor Green
    }
    
    # Data Ordner wird IMMER benötigt (enthält Scripts.rxdata, System.rxdata, etc.)
    if (Test-Path "Data") {
        Write-Host "  → Copying Data\ (required)..." -ForegroundColor Gray
        Copy-Item "Data" -Destination $ReleaseDir -Recurse
        Write-Host "  ✓ Data\" -ForegroundColor Green
    }
}
else {
    Write-Host "  ! No .zrpk packages found (Dev Mode build)" -ForegroundColor Yellow
    
    # Copy original directories for Dev Mode
    $devDirs = @("Graphics", "Audio", "Data", "PBS")
    foreach ($dir in $devDirs) {
        if (Test-Path $dir) {
            Write-Host "  → Copying $dir\ (unencrypted)..." -ForegroundColor Gray
            Copy-Item $dir -Destination $ReleaseDir -Recurse
            Write-Host "  ✓ $dir\" -ForegroundColor Green
        }
    }
}

# Save Files Ordner (leer)
New-Item -Path "$ReleaseDir\Save Files" -ItemType Directory -Force | Out-Null
Write-Host "  ✓ Save Files\ (empty)" -ForegroundColor Green

# Schritt 4: Größe berechnen
Write-Host "[4/5] Calculating size..." -ForegroundColor Yellow

$totalSize = (Get-ChildItem $ReleaseDir -Recurse | Measure-Object -Property Length -Sum).Sum
$sizeMB = [math]::Round($totalSize / 1MB, 2)

Write-Host "  ✓ Total size: $sizeMB MB" -ForegroundColor Green

# Schritt 5: ZIP erstellen (optional)
if (-not $NoZip) {
    Write-Host "[5/5] Creating release archive..." -ForegroundColor Yellow
    
    $zipPath = ".\Release\$ReleaseName.zip"
    
    if (Test-Path $zipPath) {
        Remove-Item $zipPath -Force
    }
    
    # Komprimiere mit Maximum Compression
    Compress-Archive -Path "$ReleaseDir\*" -DestinationPath $zipPath -CompressionLevel Optimal
    
    $zipSize = [math]::Round((Get-Item $zipPath).Length / 1MB, 2)
    $ratio = [math]::Round(($zipSize / $sizeMB) * 100, 1)
    
    Write-Host "  ✓ Created: $ReleaseName.zip" -ForegroundColor Green
    Write-Host "  ✓ Size: $zipSize MB (${ratio}% of uncompressed)" -ForegroundColor Green
}
else {
    Write-Host "[5/5] Skipping archive creation..." -ForegroundColor Yellow
}

# Fertig!
Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✓ Release Build Complete!             ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Release Directory: $ReleaseDir" -ForegroundColor Cyan
Write-Host "Total Size: $sizeMB MB" -ForegroundColor Cyan

if (-not $NoZip) {
    Write-Host "Archive: $zipPath ($zipSize MB)" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Test the release build: cd '$ReleaseDir' && .\Game.exe" -ForegroundColor Gray
Write-Host "2. If everything works, distribute the ZIP file" -ForegroundColor Gray
Write-Host "3. Keep the uncompressed folder for updates" -ForegroundColor Gray
Write-Host ""

# Optional: Release-Ordner öffnen
$openFolder = Read-Host "Open release folder? (Y/N)"
if ($openFolder -eq "Y" -or $openFolder -eq "y") {
    Start-Process explorer.exe -ArgumentList $ReleaseDir
}
