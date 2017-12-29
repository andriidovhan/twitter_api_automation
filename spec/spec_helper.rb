require 'rubygems'
require 'capybara/dsl'
Bundler.require(:default)

Dir["lib/*.rb", "lib/helpers/*.rb"].each {|file| require Dir.pwd + '/' + file }


RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.before :each do |x|
    test_name = "#{x.metadata[:example_group][:full_description]} #{x.description}"
    puts "\n" + '=' * test_name.size
    puts test_name
    puts '=' * test_name.size
  end

  # c.include Capybara::DSL
  # c.before(:suite) do
  #   SmppTest.servers_proxy.start_servers
  #   Capybara.app_host = SmppTest.servers_proxy.a2p_admin.url
  # end
  c.include Capybara::DSL

  if ENV['DEBUG']
    c.after :each do |x|
      binding.pry if x.exception
    end
  end
end