module FantasyLineupManager
  module Bots
    module PlayerBot
      PLAYER_TABLE_XPATH = "//table[@id='playertable_0']/tbody"
      HEADER_ROW_FIRST_COL = 'SLOT'
      HEADER_ROW = 1
      PLAYER_START_ROW = 2
      LAST_PRE_STATS_COL = 'STATUS ET'
      FIRST_POST_STATS_COL = 'PR15'
      FINAL_STATS_ROW = 'TOTALS'
      ROW_INDEX_MAPPING = [
          :position,
          :name,
          nil,
          :opponent,
          :game_status,
          nil
      ]

      def process_players
        @stats_mapping = {}
        process_header_row(@session.find(:xpath, PLAYER_TABLE_XPATH).all("tr")[HEADER_ROW].all('td'))
        # TODO - custom each yield method
        index = PLAYER_START_ROW
        @session.find(:xpath, PLAYER_TABLE_XPATH).all("tr")[PLAYER_START_ROW..-1].map do |tr|
          player = process_player(tr.all("td"), index)
          index += 1
          player
        end.reject(&:nil?).reject(&:invalid?)
      end

      private

      def header_row?(row)
        row[0].text == HEADER_ROW_FIRST_COL
      end

      def process_header_row(row)
        row.each_with_index do |col, index|
          @stats_start = (index + 1) if col.text == LAST_PRE_STATS_COL
          @stats_end = (index - 1) if col.text == FIRST_POST_STATS_COL
        end

        (@stats_start..@stats_end).each do |i|
          next if row[i].text == ''
          @stats_mapping[i] = row[i].text
        end
      end

      def process_player(player_row, row_index)
        return nil if player_row[2].text == FINAL_STATS_ROW
        stats = {}
        @stats_mapping.each do |index, v|
          stats[v] = player_row[index].text
        end

        Player.new(player_hash(player_row, stats).merge(index: row_index))
      end

      def player_hash(player_row, stats)
        hash = { batter: true }
        ROW_INDEX_MAPPING.each_with_index do |key, index|
          next if key.nil?
          hash[key] = player_row[index].text
        end

        # TODO: place to use .tap?
        hash[:stats] = stats
        hash
      end
    end
  end
end
