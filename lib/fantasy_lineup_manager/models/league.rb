module FantasyLineupManager
  module Models
    class League
      attr_reader :players, :slots

      def initialize(link:, players:, slots:)
        @link = link
        @players = players
        @slots = slots
      end
    end
  end
end