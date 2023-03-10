require_relative './helper/waiting_helper'

class CheckAvailableJobs
  HEADER = 'Invitations'.freeze
  NO_RESULTS_MESSAGES = ['No open invites.', 'Check back later.'].freeze

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
    # We do this to separate btw Invitations & Active Jobs
    searchable_elements_text =
      elements_text[elements_text.index(HEADER)..].uniq

    (NO_RESULTS_MESSAGES & searchable_elements_text).empty?
  rescue StandardError
    false
  end
end
