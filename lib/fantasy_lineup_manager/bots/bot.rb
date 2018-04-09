require 'fantasy_lineup_manager/bot_config'

module FantasyLineupManager
  module Bots
    class Bot
      MAX_RETRY = 10

      def initialize(session = nil)
        @session = session || Capybara::Session.new(:chrome)
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
