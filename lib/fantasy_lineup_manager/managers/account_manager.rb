module FantasyLineupManager
  module Managers
    module AccountManager
      def logged_in?
        @bot.logged_in?
      end

      def login
        @bot.login(ENV['espn_username'], ENV['espn_password'])
      end
    end
  end
end