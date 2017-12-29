require 'spec_helper'
require 'capybara'
require 'capybara/dsl'


describe 'UI Twitter' do
  include Capybara::DSL

  before :all do
    Capybara.app_host = 'http://twitter.com'
    Capybara.run_server = false
    Capybara.default_driver = :selenium_chrome
  end

  it 'opens #home_timeline' do
    CONF = ENV['CONF_PATH'] || 'config/conf.yml'

    visit '/login'
    fill_in 'Phone, email or username', :with => YAML::load_file(CONF)['email']
    fill_in 'Password', :with => YAML::load_file(CONF)['password']
    find(:css, ".t1-label.remember>input").set(true)
    click_on 'Log in'

    binding.pry
    #update
    find('#tweet-box-home-timeline').set('11111test capybara')
    click_on 'Tweet'

    # expect(page).to have_content '....'

    #duplicate
    # expect(page).to have_content '....'

    #destroy
    # expect(page).to_not have_content "..."
  end

  # it 'update' do
  #
  # end
  #
  # it '#not_update(due to dublicate)' do
  #
  # end
  #
  # it '#delete' do
  #
  # end
end
