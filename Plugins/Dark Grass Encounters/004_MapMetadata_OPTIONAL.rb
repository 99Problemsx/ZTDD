#===============================================================================
# OPTIONAL: Map Metadata Extension for Dark Grass BGM
# This file adds support for per-map dark grass battle music
# 
# If you want to use this feature:
# 1. Uncomment the code below
# 2. Add DarkGrassBattleBGM to your map metadata in PBS/map_metadata.txt
#
# Example:
# [001]
# Name = Route 1
# DarkGrassBattleBGM = Battle_DarkGrass
#===============================================================================

=begin

module GameData
  class MapMetadata
    # Add dark grass battle BGM attribute
    attr_reader :dark_grass_battle_BGM
    
    # Store the original initialize method
    alias darkgrass_metadata_initialize initialize
    
    # Override initialize to include dark grass BGM
    def initialize(hash)
      darkgrass_metadata_initialize(hash)
      @dark_grass_battle_BGM = hash[:dark_grass_battle_BGM]
    end
  end
end

# Add schema entry for PBS compilation
module Compiler
  module_function
  
  alias darkgrass_compile_map_metadata compile_map_metadata
  
  def compile_map_metadata(path = "PBS/map_metadata.txt")
    # Add the schema entry before compiling
    schema = GameData::MapMetadata.schema
    schema["DarkGrassBattleBGM"] = [:dark_grass_battle_BGM, "s"] unless schema.has_key?("DarkGrassBattleBGM")
    # Call original compile method
    darkgrass_compile_map_metadata(path)
  end
end

=end
