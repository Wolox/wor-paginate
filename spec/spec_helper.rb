require 'simplecov'
SimpleCov.start

require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../spec/dummy/db/migrate", __FILE__)]

require 'rspec/rails'
require 'timecop'
require 'byebug'
