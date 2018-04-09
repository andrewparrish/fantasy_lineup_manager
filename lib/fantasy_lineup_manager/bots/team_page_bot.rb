module FantasyLineupManager
  module Bots
    class TeamPageBot < Bot
      def go_to_team(team_link)
        @session.visit(team_link)
        self
      end

      def process_players
        Bots::PlayerBot.new(@session).process_players
      end
    end
  end
end