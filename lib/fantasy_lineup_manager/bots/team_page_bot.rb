module FantasyLineupManager
  module Bots
    module TeamPageBot
      def go_to_team(team_link)
        @session.visit(team_link) unless @session.current_url.include?(team_link)
        self
      end
    end
  end
end