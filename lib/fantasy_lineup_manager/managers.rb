require 'fantasy_lineup_manager/managers/players_manager'
require 'fantasy_lineup_manager/managers/account_manager'

module FantasyLineupManager
  module Managers
    class Manager
      include Singleton
      include AccountManager
      include PlayersManager

      attr_reader :leagues

      def initialize
        @bot = FantasyLineupManager::Bots::Bot.instance
        get_leagues_data
        get_teams_data
      end

      def swap_positions(league, date, players)
        
      end

      private

      def get_leagues_data
        return @leagues if @leagues
        login unless logged_in?
        @leagues = @bot.team_data.map { |data| Models::League.new(data) }
      end

      def get_teams_data
        get_leagues_data.each do |league|
          team = Models::Team.new(process_team(league.link))
          process_dates(league.link)
          league.current_team = team
          league.teams << team
          league.slots = slots
        end
      end

      def setup_data
        login
        @team_links = get_team_links
        @leagues = @team_links.map { |link| Models::League.new(league_data(link)) }
      end
    end
  end
end