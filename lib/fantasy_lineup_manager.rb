require "fantasy_lineup_manager/version"
require 'fantasy_lineup_manager/bot'
require 'fantasy_lineup_manager/player_bot'
require 'fantasy_lineup_manager/player'

module FantasyLineupManager
  def self.manage_lineup
    bot = Bot.new
    bot.login(ENV['espn_username'], ENV['espn_password'])
    bot.get_team_links
    bot.process_teams
  end
end
