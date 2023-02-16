require 'dotenv'
require 'selenium-webdriver'

require_relative './lib/login'

class TranscriberJobsBot
  TRANSCRIBER_LOGIN_PAGE =
    'https://transcriber.amberscript.com'.freeze

  attr_accessor :driver

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    configure(@driver)
  end

  def login
    failed_login = Login.call(driver)
    puts failed_login ? 'Failed Login' : 'Success login'
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
bot.login
