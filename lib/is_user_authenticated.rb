require_relative './helper/waiting_helper'

class IsUserAuthenticated
  PAGE_TITLE = 'Transcriber Jobs'.freeze

  attr_accessor :driver

  def initialize(driver)
    @driver = driver
  end

  def call
    check_if_page_is_dashboard
  end

  def self.call(driver)
    new(driver).call
  end

  private

  def check_if_page_is_dashboard
    page_title =
      WaitingHelper.with_default(false) do
        driver.find_element(id: 'tableTitle').text
      end
    PAGE_TITLE.eql? page_title
  rescue StandardError
    false
  end
end
