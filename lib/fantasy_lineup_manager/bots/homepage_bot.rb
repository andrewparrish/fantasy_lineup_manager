module FantasyLineupManager
  module Bots
    module HomepageBot
      def team_data
        @team_data ||= get_team_data
      end

      def logged_in?
        wait_until_loaded("//*[@id='global-header']/div[2]/ul/li[2]/div/div/ul[2]/li/div/ul[3]", 5)
      end


      def get_team_links
        team_data.map { |data| data[:link] }
      end

      private

      def get_team_data
        @session.visit('http://www.espn.com/fantasy/baseball/')
        team_links = @session.all(:xpath, "//*[@id='favfeed-items']/div/a").map { |e| e[:href] }.select do |link|
          link.include?('clubhouse')
        end
        team_names = @session.all(:xpath, "//*[@id='favfeed-items']/div/a/div/div/h2").map { |e| e.text }.reject do |name|
          name.downcase.include?('streak')
        end
        team_data = team_links.zip(team_names)
        team_data.select { |data| data[0].match(/flb\/clubhouse/) }.map do |data|
          {
            name: data[1],
            link: data[0]
          }
        end
      end
    end
  end
end