require_relative './helper/waiting_helper'

class CheckAvailableJobs
  TITLE = 'No open invites.'.freeze

  attr_accessor :driver

  def initialize(driver)
    @driver = driver
  end

  def call
    check_if_page_has_any_open_invites
  end

  def self.call(driver)
    new(driver).call
  end

  private

  def check_if_page_has_any_open_invites
    elements =
      WaitingHelper.with_default(false) do
        driver.find_elements(class: 'MuiBox-root')
      end

    elements_text = elements.map(&:text)
    !elements_text.uniq.include? TITLE
  rescue StandardError
    false
  end
end
