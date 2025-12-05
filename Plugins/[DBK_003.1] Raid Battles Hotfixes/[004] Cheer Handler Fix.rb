#===============================================================================
# Cheer Handler Null Reference Fix
# Fixes nil comparison errors in cheer handlers when timer is set to nil
#===============================================================================

#-------------------------------------------------------------------------------
# Fix for "Keep it going!" cheer - NoMethodError when turn_count/ko_count is nil
#-------------------------------------------------------------------------------
Battle::Cheer::CheerEffects.add(:BasicRaid,
  proc { |cheer, side, owner, battler, battle|
    next false if !battle.raidBattle?
    next false if battle.cheerLevel[side][owner] < 2
    foe = battler.pbDirectOpposing
    count = 5 - battle.pbSideSize(battler.index)
    case battle.cheerLevel[side][owner]
    when 2
      turn_count = battle.raidRules[:turn_count]
      next false if turn_count && turn_count < 0
      battle.pbDisplay(_INTL("The energy surrounding {1} seems to have weakened...", foe.pbThis(true)))
      battle.pbRaidChangeTurnCount(foe, count)
      battle.pbDisplay(_INTL("The cheer increased the number of remaining turns!"))
      next true
    when 3
      turn_count = battle.raidRules[:turn_count]
      ko_count = battle.raidRules[:ko_count]
      next false if (turn_count && turn_count < 0) && (ko_count && ko_count < 0)
      battle.pbDisplay(_INTL("The energy surrounding {1} seems to have weakened...", foe.pbThis(true)))
      battle.pbRaidChangeTurnCount(foe, count)
      battle.pbRaidChangeKOCount(foe, 2, false)
      battle.pbDisplay(_INTL("The cheer increased the number of remaining turns!"))
      battle.pbDisplay(_INTL("The cheer increased the number of remaining knock outs!"))
      next true
    end
    next false
  }
)