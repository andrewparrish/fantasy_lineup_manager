module FantasyLineupManager
  module Bots
    module PlayerBot
      BATTER_TABLE_XPATH = "//table[@id='playertable_0']/tbody"
      PITCHER_TABLE_XPATH = BATTER_TABLE_XPATH.gsub('0', '1')
      DATES_XPATH = "//*[@id='content']/div/div[4]/div/div/div[3]/div[1]/div[5]/ul/li/a"
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
      SCORING_PERIOD = /scoringPeriodId=(\d+)/
      SUBMIT_BUTTON_XPATH = "//*[@id='playerTableFramedForm']/div[1]/input"

      def process_players
        process_player_table(BATTER_TABLE_XPATH, true) + process_player_table(PITCHER_TABLE_XPATH)
      end

      def process_dates
        @session.all(:xpath, DATES_XPATH).map do |a|
          Models::LineupDate.new(a.text, a[:href].match(SCORING_PERIOD)[1])
        end
      end

      def swap_players(players)
        players.each do |player_index, position|
          begin
            # TODO: NEED TO SUPPORT PITCHERS AS WELL
            player_rows(BATTER_TABLE_XPATH)[player_index].find("select").select position
          rescue => e
           binding.pry
          end
        end

        @session.find(:xpath, SUBMIT_BUTTON_XPATH).click
      end

      private

      def player_rows(table_xpath)
        @session.find(:xpath, table_xpath).all("tr")[PLAYER_START_ROW..-1].reject do |tre|
          tre[:class].include?('playerTableBgRowTotals')
        end
      end

      def process_player_table(table_xpath, batter=false)
        @stats_mapping = {}
        process_header_row(@session.find(:xpath, table_xpath).all("tr")[HEADER_ROW].all('td'))
        index = 0
        # TODO - custom each yield method
        player_rows(table_xpath).map do |tr|
          player = process_player(tr.all("td"), index, batter)
          index += 1
          player
        end.reject(&:nil?).reject(&:invalid?)
      end

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

      def process_player(player_row, row_index, batter=false)
        return nil if player_row[2].text == FINAL_STATS_ROW
        stats = {}
        @stats_mapping.each do |index, v|
          stats[v] = player_row[index].text
        end

        Player.new(player_hash(player_row, stats, batter).merge(index: row_index))
      end

      def player_hash(player_row, stats, batter)
        hash = { batter: batter }
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
