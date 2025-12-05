#===============================================================================
# [000] Hotfixes - Compatibility Patches
#===============================================================================
# Behebt Kompatibilitätsprobleme mit DBK Plugins und Essentials Core
# Diese Datei wird VOR allen anderen Advanced AI Modulen geladen ([000])
#===============================================================================

#===============================================================================
# DBK Wonder Launcher Compatibility
#===============================================================================
# DBK Wonder Launcher prüft ob Battle ein "Launcher Battle" ist
# BEIDE Klassen brauchen die Methode: Battle UND Battle::AI
#===============================================================================

# Battle-Klasse: Hauptmethode (falls nicht schon definiert)
class Battle
  def launcherBattle?
    # Prüfe ob Wonder Launcher aktiv ist
    return @launcherBattle if instance_variable_defined?(:@launcherBattle)
    return false
  end unless method_defined?(:launcherBattle?)
end

# Battle::AI Delegation - IMMER definieren (überschreibt falls nötig)
class Battle::AI
  # Diese Methode wird von DBK Wonder Launcher in Zeile 11 aufgerufen
  # BEVOR es in Zeile 27 zu battle.battle konvertiert
  def launcherBattle?
    # @battle ist das eigentliche Battle-Objekt (von attr_reader :battle)
    return false unless @battle
    return @battle.launcherBattle? if @battle.respond_to?(:launcherBattle?)
    return false
  end
end

# Debug: Bestätigen dass Methode definiert wurde
puts "[Advanced AI] Battle::AI.launcherBattle? defined: #{Battle::AI.method_defined?(:launcherBattle?)}"

#===============================================================================
# DBK Improved Item AI Hotfix
#===============================================================================
# Problem: NoMethodError 'battler' for nil:NilClass (AIMove)
# Lösung: Nil-safe battler-Methode
#===============================================================================

if defined?(Battle::AI::AIMove)
  class Battle::AI::AIMove
    alias original_battler battler if method_defined?(:battler)
    
    def battler
      return original_battler if respond_to?(:original_battler)
      return @battler if instance_variable_defined?(:@battler)
      return nil
    end
  end
end

#===============================================================================
# Essentials Core Effectiveness Hotfix
#===============================================================================
# Problem: SystemStackError in Type::calculate (Recursion)
# Lösung: Recursion Guard (max depth 10)
#===============================================================================

module Effectiveness
  @recursion_depth = 0
  MAX_RECURSION_DEPTH = 10
  
  class << self
    alias original_calculate calculate if method_defined?(:calculate)
    
    def calculate(attack_type, *target_types)
      @recursion_depth ||= 0
      @recursion_depth += 1
      
      if @recursion_depth > MAX_RECURSION_DEPTH
        @recursion_depth = 0
        return NORMAL_EFFECTIVE_MULTIPLIER
      end
      
      result = original_calculate(attack_type, *target_types)
      @recursion_depth -= 1
      return result
    rescue
      @recursion_depth = 0
      return NORMAL_EFFECTIVE_MULTIPLIER
    end
  end
end

# GameData::Type Recursion Guard
if defined?(GameData::Type)
  module GameData
    class Type
      @type_recursion_depth = 0
      MAX_TYPE_RECURSION = 10
      
      class << self
        alias original_type_calculate calculate if method_defined?(:calculate)
        
        def calculate(attack_type, *target_types)
          @type_recursion_depth ||= 0
          @type_recursion_depth += 1
          
          if @type_recursion_depth > MAX_TYPE_RECURSION
            @type_recursion_depth = 0
            return Effectiveness::NORMAL_EFFECTIVE_ONE
          end
          
          result = original_type_calculate(attack_type, *target_types)
          @type_recursion_depth -= 1
          return result
        rescue
          @type_recursion_depth = 0
          return Effectiveness::NORMAL_EFFECTIVE_ONE
        end
      end
    end
  end
end

puts "[Advanced AI] Hotfixes loaded: Wonder Launcher, Item AI, Type Effectiveness"

# Test echoln output
echoln "═══════════════════════════════════════════════════"
echoln "[AAI] Advanced AI System v3.0.0 - DEBUG MODE ACTIVE"
echoln "[AAI] Console output is working!"
echoln "[AAI] Switch Intelligence Handler will be registered by [002] Core.rb"
echoln "═══════════════════════════════════════════════════"

