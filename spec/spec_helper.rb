require 'simplecov'
SimpleCov.start

require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../spec/dummy/db/migrate", __FILE__)]
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

require 'rspec/rails'
require 'byebug'
