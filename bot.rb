require 'dotenv'
require 'selenium-webdriver'
require 'ruby2d'

require_relative './lib/authenticate_user'
require_relative './lib/is_user_authenticated'
require_relative './lib/check_available_jobs'

Dotenv.load

class TranscriberJobsBot
  TRANSCRIBER_LOGIN_PAGE =
    'https://transcriber.amberscript.com'.freeze

  attr_accessor :driver

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    configure(@driver)
  end

  def run
    authenticate_user_and_then do
      if CheckAvailableJobs.call(driver)
        play_music
        puts '-> Jobs available. Run the bell.'
      else
        puts '-> No job invites yet, will try again in a few minutes.'
      end
    end
  ensure
    driver.quit
  end

  private

  def authenticate_user_and_then
    if IsUserAuthenticated.call(driver)
      puts '-> Already authenticated.'
      yield
    else
      puts '-> Authenticating user...'
      has_login_errors = AuthenticateUser.call(driver)

      if has_login_errors
        puts '-> Login failed. Check login credentials in file `.env`'
      else
        puts '-> Login successful.'
        yield
      end
    end
  end

  def play_music
    music = Music.new('./audio/alarm-clock.mp3')
    music.play
    music.fadeout(5000)
  end

  def configure(driver)
    driver.get(TRANSCRIBER_LOGIN_PAGE)
  end
end

bot = TranscriberJobsBot.new
bot.run
