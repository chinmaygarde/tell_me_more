require 'application'

# Setup paths
map "/" do
  run HomeController.new
end

map "/users" do
  run UserController.new
end

map "/tweets" do
  run TweetsController.new
end

puts "Server Started in #{Application::ENVIRONMENT}..."