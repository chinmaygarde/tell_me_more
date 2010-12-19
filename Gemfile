source :gemcutter

gem "sinatra"

### Database
gem "datamapper"
gem "dm-sqlite-adapter"
# Heroku needs it
gem "dm-postgres-adapter"
gem "activesupport"
gem "i18n"

### Views
gem "haml"
gem "sinatra-content-for", :require => "sinatra/content_for"

### Authorization
gem "omniauth", "0.1.6"

### Test Group
group :test do
	### RSpec
	gem "rspec"
	
	### Factory Replacement
	gem "factory_girl"
	
	### Continuous Testing
	gem "ZenTest"
end

### Development Group
group :development do
  ### No more restarting the server every 10 seconds
  gem "sinatra-reloader", :require => "sinatra/reloader"
end