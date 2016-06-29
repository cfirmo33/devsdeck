ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "devise"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

OmniAuth.config.test_mode = true
omniauth_hash = {
  "provider" => "github",
  "uid" => "12345",
  "info" => {
    "name" => "test",
    "email" => "test@example.com",
    "nickname" => "testytest"
    }
}
OmniAuth.config.add_mock(:github, omniauth_hash)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::TestHelpers, :type => :controller
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
