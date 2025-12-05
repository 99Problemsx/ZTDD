#===============================================================================
# Marshal Compatibility - Removed Classes
#===============================================================================
# This file contains dummy classes for plugins that were removed but had data
# saved in save files. Without these classes, Marshal can't deserialize old saves.
#===============================================================================

#-------------------------------------------------------------------------------
# Social Links Plugin (REMOVED)
# Define empty stub so old saves can load
#-------------------------------------------------------------------------------
class Player < Trainer
  # Dummy module for removed Social Links plugin
  module SocialLinks
    # Empty - just needs to exist for Marshal compatibility
  end
  
  # Initialize the module if old save tries to access it
  def social_links
    @social_links ||= {}
    return @social_links
  end
end

#===============================================================================
# Add more removed classes here if needed in the future
#===============================================================================
# Example:
# class SomeRemovedClass
#   # Empty stub
# end
