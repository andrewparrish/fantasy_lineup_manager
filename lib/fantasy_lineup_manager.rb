require 'fantasy_lineup_manager/version'
require 'fantasy_lineup_manager/bots'
require 'fantasy_lineup_manager/models'
require 'fantasy_lineup_manager/managers'

module FantasyLineupManager
  def self.manage_lineup
    manager = Managers::Manager.instance
    binding.pry
    manager.swap_positions_example
  end
end
