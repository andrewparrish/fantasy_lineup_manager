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

      def link_for_date(lineup_date)
        @link + "&scoringPeriodId=#{lineup_date.scoring_period}"
      end
    end
  end
end