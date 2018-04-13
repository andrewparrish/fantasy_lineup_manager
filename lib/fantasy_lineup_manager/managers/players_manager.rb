module FantasyLineupManager
  module Managers
    module PlayersManager
      def process_teams
        get_team_links
        @team_links.each do |link|
          process_team(link)
        end
      end

      private

      def process_team(team_link)
        get_players
      end

      def get_team_links
        @team_links = @bot.get_team_links
      end

      def get_players
        @players = @bot.go_to_team(@team_links.first).process_players
      end
    end
  end
end