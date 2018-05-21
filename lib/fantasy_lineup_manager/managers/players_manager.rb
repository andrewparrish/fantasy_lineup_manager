module FantasyLineupManager
  module Managers
    module PlayersManager
      def process_team(team_link)
        {
            players: get_players(team_link),
        }
      end


      def process_dates(team_link)
        @dates ||= @bot.go_to_team(team_link).process_dates
      end

      def get_team_links
        @team_links = @bot.get_team_links
      end

      def get_players(team_link)
        @players = @bot.go_to_team(team_link).process_players
      end

      def slots
        @players.reject(&:inactive?).map(&:current_position)
      end

      def swap_player_positions(link, players)
        @bot.go_to_team(link).swap_players(players)
      end
    end
  end
end