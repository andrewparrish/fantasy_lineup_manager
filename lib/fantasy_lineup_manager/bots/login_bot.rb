module FantasyLineupManager
  module Bots
    module LoginBot
      def login(username, password)
        @session.visit('http://www.espn.com/login')
        wait_until_loaded("//*[@id='disneyid-iframe']")
        @session.within_frame @session.find(:xpath, "//*[@id='disneyid-iframe']") do
          @session.find(:xpath, "//input[@type='email']").set username
          @session.find(:xpath, "//input[@type='password']").set password
          @session.find(:xpath, "//button[@type='submit']").click
        end
        wait_until_loaded("//a[@id='global-user-trigger']")
      end
    end
  end
end