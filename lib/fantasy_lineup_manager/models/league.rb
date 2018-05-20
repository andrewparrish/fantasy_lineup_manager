module FantasyLineupManager
  module Models
    class League
      attr_reader :players, :link, :name
      attr_accessor :slots, :current_team, :teams

      def initialize(link:, slots: [], name:)
        @name = name
        @link = link + '&pnc=off'
        @slots = slots
        @teams = []
      end
    end
  end
end