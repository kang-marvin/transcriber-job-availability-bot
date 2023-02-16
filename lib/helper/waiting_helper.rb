class WaitingHelper
  def self.with_default(value)
    wait.until do
      yield
    end
  rescue Selenium::WebDriver::Error::TimeoutError
    value
  end

  private

  def self.wait
    Selenium::WebDriver::Wait.new(
      timeout: 10,
      interval: 1,
      message: '',
      ignore: Selenium::WebDriver::Error::NoSuchElementError
    )
  end
end