require "fantasy_lineup_manager/version"
require 'fantasy_lineup_manager/bots/bots'
require 'fantasy_lineup_manager/player'

module FantasyLineupManager

  class PlayersManager
    include Singleton

    attr_reader :players, :dates, :team_links

    def initialize
      @session = Capybara::Session.new(:chrome)
    end

    def login
      Bots::LoginBot.new(@session).login(ENV['espn_username'], ENV['espn_password'])
    end

    def get_team_links
      @team_links = Bots::HomepageBot.new(@session).get_team_links
    end

    def get_players
      @players = Bots::TeamPageBot.new(@session).go_to_team(@team_links.first).process_players
    end
  end

  def self.manage_lineup
    manager = PlayersManager.instance
    manager.login
    # TODO: thread each of these actions - turn this into an instance method
    # This likely won't work in ruby, but elixer option?
    manager.get_team_links
    manager.get_players
  end
end
