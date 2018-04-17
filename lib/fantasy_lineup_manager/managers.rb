require 'fantasy_lineup_manager/managers/players_manager'
require 'fantasy_lineup_manager/managers/account_manager'

module FantasyLineupManager
  module Managers
    class Manager
      include Singleton
      include AccountManager
      include PlayersManager

      attr_reader :dates, :team_links, :leagues

      def initialize
        @bot = FantasyLineupManager::Bots::Bot.instance
        setup_data
      end

      private

      def setup_data
        login
        @team_links = get_team_links
        @leagues = @team_links.map { |link| Models::League.new(league_data(link)) }
      end

      def league_data(link)
        players = process_team(link)
        {
            players: players,
            slots: slots,
            link: link
        }
      end
    end
  end
end