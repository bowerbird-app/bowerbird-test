RSpec.configure do |config|
  config.include Warden::Test::Helpers

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.after :each do
    Warden.test_reset!
  end
end