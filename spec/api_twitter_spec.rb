require 'spec_helper'


describe "API_twitter" do
  before :all do
    @ac=ApiTwitter.new
    @fake_status=Faker::Twitter.status[:text]
  end

  let(:client) { @ac.conn }
  let(:fake_status) { @fake_status }

  it '#home_timeline' do
    @ac.attrs_update(client.home_timeline.first.id)
    expect(@ac.created_at.class).to eql String
    expect(@ac.retweet_count.nil?).not_to be true
    expect(@ac.text).not_to be_empty
  end

  it '#update' do
    @ac.update(fake_status)
    expect(@ac.text).to eql fake_status
  end

  it '#not_update(due to duplicate)' do
    expect { client.update!(fake_status) }.to raise_error(Twitter::Error::DuplicateStatus)
  end

  it '#destroy' do
    client.destroy_status(@ac.id)
    expect { client.status(@ac.id) }.to raise_error(Twitter::Error::NotFound)
  end
end
