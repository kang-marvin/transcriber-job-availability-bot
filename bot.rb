require 'dotenv'
require 'selenium-webdriver'
require 'ruby2d'
require 'logger'

require_relative './lib/authenticate_user'
require_relative './lib/is_user_authenticated'
require_relative './lib/check_available_jobs'

Dotenv.load

class TranscriberJobsBot
  TRANSCRIBER_LOGIN_PAGE =
    'https://transcriber.amberscript.com'.freeze

  attr_accessor :driver, :logger

  def initialize
    @logger = Logger.new('./log/cron.log', 'daily')
    @driver = Selenium::WebDriver.for :chrome, options: configure_options
    @driver.get(TRANSCRIBER_LOGIN_PAGE)
  end

  def run
    log_time do
      authenticate_user_and_then do
        if CheckAvailableJobs.call(driver)
          play_music
          logger.info 'Job invites available'
        else
          logger.info 'No job invites right now'
        end
      end
    end
  ensure
    logger.close
    driver.quit
  end

  private

  def authenticate_user_and_then
    if IsUserAuthenticated.call(driver)
      yield
    else
      has_login_errors = AuthenticateUser.call(driver)

      if has_login_errors
        logger.debug 'Login failed. Check login credentials in file `.env`'
      else
        yield
      end
    end
  end

  def log_time
    logger.info Time.now.strftime('%a %d %b - %H:%M')
    yield
    logger.info "\n"
  end

  def play_music
    music = Music.new('./audio/alarm-clock.mp3')
    music.play
    music.fadeout(5000)
  end

  def configure_options
    Selenium::WebDriver::Options.chrome(args: ['--headless'])
  end
end

TranscriberJobsBot.new.run
