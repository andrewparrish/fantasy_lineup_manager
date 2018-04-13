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
      end
    end
  end
end