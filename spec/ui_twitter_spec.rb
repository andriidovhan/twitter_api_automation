require 'spec_helper'
require 'capybara'
require 'capybara/dsl'


describe 'UI Twitter' do
  CONF = ENV['CONF_PATH'] || 'config/conf.yml'

  def log_in
    credentials=YAML::load_file(CONF)
    Log.error("Some credentials are not defined") if !credentials['email'] || !credentials['password']

    visit '/login'
    fill_in 'Phone, email or username', :with => credentials['email']
    fill_in 'Password', :with => credentials['password']
    check 'Remember me'
    click_on 'Log in'
  end

  before :all do
    Capybara.configure do |c|
      c.app_host = 'http://twitter.com'
      c.run_server = false
      c.default_driver = :selenium_chrome
      c.match = :first
    end

    @fake_status=Faker::Twitter.status[:text]
    log_in
  end

  let(:fake_status) { @fake_status }


  it '#home_timeline' do
    visit '/'
    find('#tweet-box-home-timeline').set(fake_status)
    within('#timeline') do
      find('.tweet-action.EdgeButton.EdgeButton--primary.js-tweet-btn').click
    end

    expect(page).to have_text fake_status
    expect(page).to have_selector '#timeline'
  end

  it '#non_update(due to duplicate)' do
    visit '/'
    find('#tweet-box-home-timeline').set(fake_status)
    within('#timeline') do
      find('.tweet-action.EdgeButton.EdgeButton--primary.js-tweet-btn').click
    end

    sleep 1
    expect(page).to have_text 'You have already sent this Tweet.'
    find('#tweet-box-home-timeline').set(' ')
  end

  it '#destroy' do
    visit '/'
    find('.ProfileTweet-actionButton.u-textUserColorHover.dropdown-toggle.js-dropdown-toggle').click
    click_on 'Delete Tweet'
    click_on 'Delete'

    sleep 1
    expect(page).to have_text 'Your Tweet has been deleted.'
    expect(page).to have_no_text fake_status
  end
end
