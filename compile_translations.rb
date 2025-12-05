#!/usr/bin/env ruby
# encoding: utf-8
#===============================================================================
# Automatischer Übersetzungs-Compiler
# Kompiliert Text_deutsch_game/ und Text_deutsch_core/ zu .dat Dateien
#===============================================================================

puts "═" * 80
puts "  Übersetzungs-Compiler für Pokémon Essentials v21.1"
puts "  Zorua - The Divine Deception"
puts "═" * 80
puts ""

# Überprüfe, ob wir im richtigen Verzeichnis sind
unless Dir.exist?("Data") && File.exist?("Game.ini")
  puts "❌ FEHLER: Bitte führe dieses Skript im Root-Verzeichnis des Spiels aus!"
  puts "   (Das Verzeichnis mit Game.exe, Data/ und PBS/)"
  exit 1
end

# Finde alle Translation-Ordner
translation_folders = Dir.glob("Text_*_*")

if translation_folders.empty?
  puts "❌ FEHLER: Keine Übersetzungs-Ordner gefunden!"
  puts "   Erwartet: Text_deutsch_game/ und Text_deutsch_core/"
  puts ""
  puts "💡 Tipp: Erstelle Übersetzungen über das Debug-Menü:"
  puts "   Debug → Other options → Files → Extract text from game files"
  exit 1
end

puts "📁 Gefundene Übersetzungs-Ordner:"
translation_folders.each_with_index do |folder, i|
  puts "   #{i + 1}. #{folder}"
end
puts ""

# Lade Essentials Umgebung
puts "⚙️  Lade Essentials Umgebung..."
begin
  require './Data/Scripts/001_Technical/003_Intl_Messages.rb'
  puts "✅ Erfolgreich geladen"
rescue LoadError => e
  puts "❌ FEHLER: Konnte Essentials nicht laden"
  puts "   #{e.message}"
  puts ""
  puts "💡 Tipp: Dieses Skript muss über Essentials ausgeführt werden."
  puts "   Verwende stattdessen das Debug-Menü im Spiel:"
  puts "   Debug → Other options → Files → Compile translated text"
  exit 1
end
puts ""

# Kompiliere jeden Ordner
translation_folders.each do |folder|
  dat_filename = folder.gsub(/^Text_/, "")
  
  puts "─" * 80
  puts "📦 Kompiliere: #{folder} → Data/messages_#{dat_filename}.dat"
  puts "─" * 80
  
  begin
    # Rufe Translator.compile_text auf
    Translator.compile_text(folder, dat_filename)
    puts "✅ Erfolgreich kompiliert: Data/messages_#{dat_filename}.dat"
  rescue StandardError => e
    puts "❌ FEHLER beim Kompilieren von #{folder}:"
    puts "   #{e.message}"
    puts "   #{e.backtrace.first(3).join("\n   ")}"
  end
  puts ""
end

puts "═" * 80
puts "✅ Kompilierung abgeschlossen!"
puts "═" * 80
puts ""
puts "📝 Nächste Schritte:"
puts "   1. Überprüfe, ob .dat Dateien erstellt wurden:"
translation_folders.each do |folder|
  dat_filename = folder.gsub(/^Text_/, "")
  dat_path = "Data/messages_#{dat_filename}.dat"
  if File.exist?(dat_path)
    puts "      ✅ #{dat_path}"
  else
    puts "      ❌ #{dat_path} (NICHT GEFUNDEN)"
  end
end
puts ""
puts "   2. Setze Sprache in mkxp.json oder Options-Menü"
puts "   3. Starte das Spiel und teste die Übersetzungen"
puts ""
puts "💡 Tipp: Bei Problemen siehe ÜBERSETZUNG_KOMPILIEREN.md"
puts ""
