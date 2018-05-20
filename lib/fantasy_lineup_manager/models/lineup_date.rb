module FantasyLineupManager
  module Models
    class LineupDate
      attr_reader :scoring_period, :date, :title

      def initialize(date_title, scoring_period)
        @title = date_title
        @date = Date.parse(date_title)
        @scoring_period = scoring_period
      end
    end
  end
end
