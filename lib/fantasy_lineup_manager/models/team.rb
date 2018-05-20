module FantasyLineupManager
  module Models
    class Team
      attr_reader :players

      def initialize(players:)
        @players = players
      end
    end
  end
end
