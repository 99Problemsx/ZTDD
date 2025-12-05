# Create Test Packages (Mock für Demo)
# Da wir nicht direkt im Spiel sind, erstellen wir Test-Packages

Write-Host "Creating test encrypted packages..." -ForegroundColor Yellow

# Erstelle einen Test-Package (simuliert)
$testPackagePath = "Graphics_0.zrpk"

# Magic Header + minimale Struktur
$header = [byte[]]@(0x5A, 0x52, 0x55, 0x41)  # "ZRUA"
$version = [byte]1
$flags = [byte]0x0F  # Alle Features
$reserved = [byte[]]@(0, 0)
$indexSize = [byte[]]@(50, 0, 0, 0)  # 50 bytes
$indexData = [byte[]](1..50)

$packageData = $header + $version + $flags + $reserved + $indexSize + $indexData

[System.IO.File]::WriteAllBytes($testPackagePath, $packageData)

Write-Host "✓ Created test package: $testPackagePath" -ForegroundColor Green
Write-Host ""
Write-Host "Note: This is a demo package. For real encryption, run in-game:" -ForegroundColor Yellow
Write-Host "  AdvancedAssetProtection::Builder.build_all" -ForegroundColor Gray
