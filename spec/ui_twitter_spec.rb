require 'spec_helper'


describe 'UI Twitter' do
  before :all do
    Capybara.configure do |c|
      c.app_host = 'http://twitter.com'
      c.run_server = false
      c.default_driver = :selenium_chrome
      c.match = :first
    end

    @fake_status=Faker::Twitter.status[:text]
    UiTwitter.new.log_in
  end

  let(:fake_status) { @fake_status }


  it '#home_timeline, #update' do
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
