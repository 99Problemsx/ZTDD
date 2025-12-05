#===============================================================================
# Dark Grass Terrain Tag
# Based on BW/B2W2 Dark Grass mechanic
#===============================================================================

module GameData
  class TerrainTag
    # Add new attribute reader for dark grass wild encounters
    attr_reader :dgrass_wild_encounters
    
    # Store the original initialize method
    alias darkgrass_initialize initialize
    
    # Override initialize to include dark grass attribute
    def initialize(hash)
      darkgrass_initialize(hash)
      @dgrass_wild_encounters = hash[:dgrass_wild_encounters] || false
    end
  end
end

#===============================================================================
# Register Dark Grass terrain tag
# Uses ID number 18 (first available after vanilla tags)
#===============================================================================

GameData::TerrainTag.register({
  :id                       => :DarkGrass,
  :id_number                => 18,
  :deep_bush                => true,
  :dgrass_wild_encounters   => true,
  :double_wild_encounters   => true,
  :battle_environment       => :TallGrass,
  :shows_grass_rustle       => true
})
