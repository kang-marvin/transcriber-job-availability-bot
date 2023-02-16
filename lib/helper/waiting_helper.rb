class WaitingHelper
  def self.with_default(value, &block)
    wait.until(&block)
  rescue Selenium::WebDriver::Error::TimeoutError
    value
  end

  def self.wait
    Selenium::WebDriver::Wait.new(
      timeout: 5,
      interval: 1,
      message: '',
      ignore: Selenium::WebDriver::Error::NoSuchElementError
    )
  end
end
