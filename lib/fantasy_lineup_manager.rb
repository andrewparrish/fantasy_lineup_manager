require 'fantasy_lineup_manager/version'
require 'fantasy_lineup_manager/bots'
require 'fantasy_lineup_manager/models'
require 'fantasy_lineup_manager/managers'

module FantasyLineupManager
  def self.manage_lineup
    manager = Managers::Manager.instance
    manager.login
    # TODO: thread each of these actions - turn this into an instance method
    # This likely won't work in ruby, but elixer option?
    manager.get_team_links
    manager.get_players
  end
end
