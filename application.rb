require 'yaml'

module Application
  ROOT = File.dirname(__FILE__)
  ENVIRONMENT = ENV['environment'] || 'development'
  AUTH_TOKENS = YAML.load_file("config/authentications.yml")
end

# Requires
require 'rubygems'
require 'fileutils'
require 'bundler'

Bundler.setup
Bundler.require
Bundler.require(:development) if Application::ENVIRONMENT == "development"

# Load lib directory
Dir[File.join(File.dirname(__FILE__), "lib", "**/*.rb")].each do |file|
  require File.expand_path(file)
end

# Database
db = YAML.load_file("db/database.yml")[Application::ENVIRONMENT]
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{File.expand_path(File.join(Application::ROOT, 'db', db['database']))}.db")


# Load Paths under app directory
%w[helpers controllers jobs models].each do |dir|
  Dir[File.join(File.dirname(__FILE__), "app", dir, "**/*.rb")].each do |file|
    require File.expand_path(file)
  end
end

DataMapper.auto_migrate!
