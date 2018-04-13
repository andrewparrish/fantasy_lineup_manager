require 'fantasy_lineup_manager/managers/players_manager'
require 'fantasy_lineup_manager/managers/account_manager'

module FantasyLineupManager
  module Managers
    class Manager
      include Singleton
      include AccountManager
      include PlayersManager

      attr_reader :players, :dates, :team_links

      def initialize
        @bot = FantasyLineupManager::Bots::Bot.instance
        setup_data
      end

      private

      def setup_data
        login
        @team_links = get_team_links
        @players = @team_links.flat_map  { |link| process_team(link) }
      end
    end
  end
end