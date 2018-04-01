require 'fantasy_lineup_manager/bot'

module FantasyLineupManager
  class PlayerBot < Bot

    HEADER_ROW_FIRST_COL = 'SLOT'

    LAST_PRE_STATS_COL = 'STATUS ET'
    FIRST_POST_STATS_COL = 'PR15'

    ROW_INDEX_MAPPING = [
        :position,
        :name,
        nil,
        :opponent,
        :game_status,
        nil
    ]

    def initialize(bot)
      super(bot)
      @stats_mapping = {}
    end

    def process_players
      @bot.find(:xpath, "//table[@id='playertable_0']/tbody").all("tr").each do |tr|
        process_header_row(tr.all('td')) if header_row?(tr.all('td'))
        process_player(tr.all("td"))
      end
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

    def process_player(player_row)
    end
  end
end