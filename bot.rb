require 'dotenv'
require 'selenium-webdriver'

require_relative './lib/authenticate_user'
require_relative './lib/is_user_authenticated'

class TranscriberJobsBot
  TRANSCRIBER_LOGIN_PAGE =
    'https://transcriber.amberscript.com'.freeze

  attr_accessor :driver

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    configure(@driver)
  end

  def start
    if IsUserAuthenticated.call(driver)
      puts 'Already authenticated'
    else
      puts 'Not yet authenticated. Doing it now...'
      has_login_errors = AuthenticateUser.call(driver)
      puts has_login_errors === false ? 'Success login' : 'Failed Login'
    end
  ensure
    driver.quit
  end

  private

  def configure(driver)
    driver.get(TRANSCRIBER_LOGIN_PAGE)
  end
end

Dotenv.load

bot = TranscriberJobsBot.new
bot.start
