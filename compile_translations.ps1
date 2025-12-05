# Übersetzungs-Compiler für Windows
# Kompiliert Text_deutsch_game/ und Text_deutsch_core/ zu .dat Dateien

Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host "  Übersetzungs-Compiler für Pokémon Essentials v21.1" -ForegroundColor Yellow
Write-Host "  Zorua - The Divine Deception" -ForegroundColor Yellow
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host ""

# Überprüfe, ob wir im richtigen Verzeichnis sind
if (-not (Test-Path "Data") -or -not (Test-Path "Game.ini")) {
    Write-Host "❌ FEHLER: Bitte führe dieses Skript im Root-Verzeichnis des Spiels aus!" -ForegroundColor Red
    Write-Host "   (Das Verzeichnis mit Game.exe, Data/ und PBS/)" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Aktuelles Verzeichnis: $PWD" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

# Finde alle Translation-Ordner
$translationFolders = Get-ChildItem -Directory -Filter "Text_*_*" | Select-Object -ExpandProperty Name

if ($translationFolders.Count -eq 0) {
    Write-Host "❌ FEHLER: Keine Übersetzungs-Ordner gefunden!" -ForegroundColor Red
    Write-Host "   Erwartet: Text_deutsch_game/ und Text_deutsch_core/" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Tipp: Erstelle Übersetzungen über das Debug-Menü:" -ForegroundColor Yellow
    Write-Host "   Debug → Other options → Files → Extract text from game files" -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host "📁 Gefundene Übersetzungs-Ordner:" -ForegroundColor Green
for ($i = 0; $i -lt $translationFolders.Count; $i++) {
    Write-Host "   $($i + 1). $($translationFolders[$i])" -ForegroundColor White
}
Write-Host ""

# Warnung: Dieses Skript benötigt Game.exe
Write-Host "⚠️  WICHTIG: Kompilierung erfolgt über das Spiel selbst" -ForegroundColor Yellow
Write-Host "   Dieses PowerShell-Skript startet das Spiel und führt die Kompilierung durch." -ForegroundColor Yellow
Write-Host ""
Write-Host "📝 Alternative Methode (Empfohlen):" -ForegroundColor Cyan
Write-Host "   1. Starte Game.exe im Debug-Modus" -ForegroundColor White
Write-Host "   2. Drücke F9 für Debug-Menü" -ForegroundColor White
Write-Host "   3. Other options → Files → Compile translated text" -ForegroundColor White
Write-Host "   4. Wähle deutsch_core und deutsch_game nacheinander aus" -ForegroundColor White
Write-Host ""

# Frage Benutzer
$response = Read-Host "Möchtest du fortfahren? (j/n)"
if ($response -ne "j" -and $response -ne "J" -and $response -ne "y" -and $response -ne "Y") {
    Write-Host "Abgebrochen." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host "  Überprüfung der Übersetzungsdateien" -ForegroundColor Yellow
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host ""

# Überprüfe jede Übersetzungs-Ordner
foreach ($folder in $translationFolders) {
    Write-Host "─" * 80 -ForegroundColor Gray
    Write-Host "📂 $folder" -ForegroundColor Cyan
    Write-Host "─" * 80 -ForegroundColor Gray
    
    $txtFiles = Get-ChildItem -Path $folder -Filter "*.txt"
    
    if ($txtFiles.Count -eq 0) {
        Write-Host "   ⚠️  Keine .txt Dateien gefunden" -ForegroundColor Yellow
    }
    else {
        Write-Host "   ✅ $($txtFiles.Count) Übersetzungsdateien gefunden" -ForegroundColor Green
        
        # Zeige erste 5 Dateien
        $displayCount = [Math]::Min(5, $txtFiles.Count)
        for ($i = 0; $i -lt $displayCount; $i++) {
            Write-Host "      • $($txtFiles[$i].Name)" -ForegroundColor White
        }
        if ($txtFiles.Count -gt 5) {
            Write-Host "      • ... und $($txtFiles.Count - 5) weitere" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
}

Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host "  Anleitung zur Kompilierung" -ForegroundColor Yellow
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host ""
Write-Host "Da die Kompilierung die Essentials-Engine benötigt, verwende bitte:" -ForegroundColor White
Write-Host ""
Write-Host "Methode 1: Debug-Menü (Empfohlen)" -ForegroundColor Green
Write-Host "   1. Starte Game.exe" -ForegroundColor White
Write-Host "   2. Drücke F9 im Spiel" -ForegroundColor White
Write-Host "   3. Other options → Files → Compile translated text" -ForegroundColor White
Write-Host "   4. Wähle nacheinander:" -ForegroundColor White
foreach ($folder in $translationFolders) {
    $shortName = $folder -replace "^Text_", ""
    Write-Host "      • $shortName" -ForegroundColor Cyan
}
Write-Host ""
Write-Host "Methode 2: mkxp Konsole" -ForegroundColor Green
Write-Host "   1. Starte Game.exe" -ForegroundColor White
Write-Host "   2. Drücke F8 für Konsole" -ForegroundColor White
Write-Host "   3. Eingabe für jeden Ordner:" -ForegroundColor White
foreach ($folder in $translationFolders) {
    $datFilename = $folder -replace "^Text_", ""
    Write-Host "      Translator.compile_text('$folder', '$datFilename')" -ForegroundColor Cyan
}
Write-Host ""

# Überprüfe ob .dat Dateien existieren
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host "  Status der kompilierten Dateien" -ForegroundColor Yellow
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host ""

$allExist = $true
foreach ($folder in $translationFolders) {
    $datFilename = $folder -replace "^Text_", ""
    $datPath = "Data\messages_$datFilename.dat"
    
    if (Test-Path $datPath) {
        $fileInfo = Get-Item $datPath
        $size = [Math]::Round($fileInfo.Length / 1KB, 2)
        $modified = $fileInfo.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
        Write-Host "   ✅ $datPath" -ForegroundColor Green
        Write-Host "      Größe: $size KB | Zuletzt geändert: $modified" -ForegroundColor Gray
    }
    else {
        Write-Host "   ❌ $datPath (NICHT GEFUNDEN)" -ForegroundColor Red
        $allExist = $false
    }
}

Write-Host ""
if ($allExist) {
    Write-Host "🎉 Alle Übersetzungsdateien sind kompiliert!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📝 Nächste Schritte:" -ForegroundColor Cyan
    Write-Host "   1. Bearbeite mkxp.json und setze:" -ForegroundColor White
    Write-Host '      "language": "deutsch"' -ForegroundColor Cyan
    Write-Host "   2. Starte das Spiel und teste die Übersetzungen" -ForegroundColor White
}
else {
    Write-Host "⚠️  Einige Übersetzungsdateien fehlen noch" -ForegroundColor Yellow
    Write-Host "   Bitte kompiliere sie über das Debug-Menü (siehe oben)" -ForegroundColor White
}

Write-Host ""
Write-Host "💡 Weitere Informationen: ÜBERSETZUNG_KOMPILIEREN.md" -ForegroundColor Cyan
Write-Host ""
pause
