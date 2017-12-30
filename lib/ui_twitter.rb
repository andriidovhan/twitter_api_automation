require './lib/helpers/api_client'

class UiTwitter
  include Capybara::DSL

  CONF = ENV['CONF_PATH'] || 'config/conf.yml'

  attr_reader :email, :password

  def read_config
    data = YAML::load_file(CONF)

    @email = data['email']
    @password= data['password']

    Log.error("Some credentials are not defined") if !@email || !@password
  end

  def log_in
    read_config
    visit '/login'
    fill_in 'Phone, email or username', :with => email
    fill_in 'Password', :with => password
    check 'Remember me'
    click_on 'Log in'
  end
end

