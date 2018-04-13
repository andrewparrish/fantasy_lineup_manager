module FantasyLineupManager
  module Bots
    module HomepageBot
      def get_team_links
        @session.visit('http://www.espn.com/fantasy/baseball/')
        team_links = @session.all(:xpath, "//*[@id='favfeed-items']/div/a").map { |e| e[:href] }
        team_links.select { |l| l.match(/flb\/clubhouse/) }
      end
    end
  end
end