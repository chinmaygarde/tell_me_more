require 'application'

# Setup paths
map "/" do
  run HomeController.new
end

map "/users" do
  run UserController.new
end

puts "Server Started in #{Application::ENVIRONMENT}..."