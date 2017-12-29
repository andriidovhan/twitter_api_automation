require 'twitter'

module ApiClient

  CONF = ENV['CONF_PATH'] || 'config/conf.yml'

  attr_reader :conn

  def conn
    unless @conn
      read_config
      setup_connection
    end
    @conn
  end

  def read_config
    data = YAML::load_file(CONF)

    @consumer_key = data['consumer_key']
    @consumer_secret = data['consumer_secret']
    @access_token = data['access_token']
    @access_token_secret = data['access_token_secret']

    Log.error("Some credentials are not defined") if !@consumer_key || !@consumer_secret || !@access_token || !@access_token_secret

    @config = {
                 consumer_key:        @consumer_key,
                 consumer_secret:     @consumer_secret,
                 access_token:        @access_token,
                 access_token_secret: @access_token_secret
              }
  end

  def setup_connection
    @conn = Twitter::REST::Client.new(@config)
  end
end


