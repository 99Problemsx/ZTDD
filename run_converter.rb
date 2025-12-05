# Standalone converter runner
# Run this with: ruby run_converter.rb

# Load the converter
require_relative 'Plugins/PBS Data System/[002] Converter'

# Run conversion
puts "Starting PBS conversion..."
PBSConverter.convert_all
puts "Done!"
