#!/usr/bin/env ruby
# Battle Facilities Converter - Convert remaining PBS files

require_relative 'Plugins/PBS Data System/[002] Converter.rb'

puts "Converting Battle Facilities only..."
PBSConverter.convert_battle_facilities
puts "Done!"
