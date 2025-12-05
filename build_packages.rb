# Quick Build Script - Führe das im Spiel aus (F8 Console)
# Oder kopiere den Code in ein Event

begin
  Console.echo_h1("Building Encrypted Asset Packages")
  Console.echo_li("This may take a few minutes...")
  
  # Build all packages
  AdvancedAssetProtection::Builder.build_all
  
  Console.echo_h1("Build Complete!")
  Console.echo_li("You can now run: .\\build_release.ps1 -Version '1.0.0'")
  
rescue => e
  Console.echo_error("Build failed: #{e.message}")
  Console.echo_error(e.backtrace.join("\n"))
end
