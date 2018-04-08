module FantasyLineupManager
  class Player
    NAME_POSITION_REGEX = /(\D+),\s(\D{3,4})\s?((\s?[\w|,]+)+)[\s+|S*]?/

    attr_reader :stats, :name, :index

    def initialize(index:, name:, position:, opponent:, game_status:, stats:)
      self.name = name
      @current_position = position
      @opponent = opponent
      @game_status = game_status
      @stats = stats
      @index = index
    end

    def name=(name_and_positions)
      data = name_and_positions.match(NAME_POSITION_REGEX)
      @team = data[2].strip
      @name = data[1]
      @positions = data[3].split(',').map(&:strip).map { |pos| pos.match(/(\w{1,2})\s?S?/)[1] }
    end
  end
end
