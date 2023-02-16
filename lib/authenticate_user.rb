require_relative './helper/waiting_helper'

class AuthenticateUser
  attr_accessor :driver

  def initialize(driver)
    @driver = driver
  end

  def call
    set_email_field
    set_password_field
    click_login_button
    check_if_login_error_appears
  end

  def self.call(driver)
    new(driver).call
  end

  private

  def set_email_field
    email_field = driver.find_element(name: 'email')
    email_field.send_keys(ENV.fetch('EMAIL_ADDRESS'))
  end

  def set_password_field
    password_field = driver.find_element(name: 'password')
    password_field.send_keys(ENV.fetch('PASSWORD'))
  end

  def click_login_button
    login_button = driver.find_element(css: '[type="submit"]')
    login_button.click
  end

  def check_if_login_error_appears
    WaitingHelper.with_default(false) do
      driver.find_element(id: 'client-snackbar').displayed?
    end
  end
end
