require 'fantasy_lineup_manager/bot_config'

module FantasyLineupManager
  MAX_RETRY = 10

  class Bot
    def initialize(bot = nil)
      @bot = bot || Capybara::Session.new(:chrome)
    end

    def login(username, password)
      @bot.visit('http://www.espn.com/login')
      wait_until_loaded("//*[@id='disneyid-iframe']")
      @bot.within_frame @bot.find(:xpath, "//*[@id='disneyid-iframe']") do
        @bot.find(:xpath, "//input[@type='email']").set username
        @bot.find(:xpath, "//input[@type='password']").set password
        @bot.find(:xpath, "//button[@type='submit']").click
      end
      wait_until_loaded("//a[@id='global-user-trigger']")
    end

    def get_team_links
      @bot.visit('http://www.espn.com/fantasy/baseball/')
      team_links = @bot.all(:xpath, "//*[@id='favfeed-items']/div/a").map { |e| e[:href] }
      @links = team_links.select { |l| l.match(/flb\/clubhouse/) }
    end

    def process_teams
      @bot.visit(@links.first + '&pnc=off')
      PlayerBot.new(@bot).process_players
    end

    private

    def wait_until_loaded(xpath)
      count = 0
      until @bot.has_xpath?(xpath) do
        sleep(1)
        count + 1
        break if count > MAX_RETRY
      end
    end
  end
end