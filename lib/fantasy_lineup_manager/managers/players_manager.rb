module FantasyLineupManager
  module Managers
    module PlayersManager
      def process_team(team_link)
        get_players(team_link)
      end

      def get_team_links
        @team_links = @bot.get_team_links
      end

      def get_players(team_link)
        @players = @bot.go_to_team(team_link).process_players
      end
    end
  end
end