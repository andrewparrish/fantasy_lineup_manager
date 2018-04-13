require 'fantasy_lineup_manager/bot_config'
require 'fantasy_lineup_manager/bots/login_bot'
require 'fantasy_lineup_manager/bots/homepage_bot'
require 'fantasy_lineup_manager/bots/team_page_bot'
require 'fantasy_lineup_manager/bots/player_bot'

module FantasyLineupManager
  module Bots
    class Bot
      include Singleton
      include LoginBot
      include PlayerBot
      include TeamPageBot
      include HomepageBot

      MAX_RETRY = 10

      def initialize
        @session = Capybara::Session.new(:chrome)
        @stats_mapping = {}
      end

      protected

      def wait_until_loaded(xpath)
        count = 0
        until @session.has_xpath?(xpath) do
          sleep(1)
          count + 1
          break if count > MAX_RETRY
        end
      end
    end
  end
end
