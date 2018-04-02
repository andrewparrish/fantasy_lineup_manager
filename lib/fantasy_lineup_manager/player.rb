module FantasyLineupManager
  class Player
    attr_reader :stats

    def initialize(name:, position:, opponent:, game_status:, stats:)
      @name = name
      @position = position
      @opponent = opponent
      @game_status = game_status
      @stats = stats
    end
  end
end