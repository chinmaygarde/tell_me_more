class ApplicationController < Sinatra::Base
  configure(:development) do
    register Sinatra::Reloader
    also_reload File.join(Application::ROOT, "app/models/*.rb")
  end
  
  # Add application wide helpers here
  helpers UserHelpers
  helpers Sinatra::ContentFor
  
  set(:environment, Application::ENVIRONMENT.to_sym)
  set(:public, File.join(Application::ROOT, "public"))
  set(:views, File.join(Application::ROOT, "app", "views"))
  use Rack::MethodOverride

  enable :sessions
  
  use OmniAuth::Builder do
    provider :twitter,   Application::AUTH_TOKENS["twitter_#{Application::ENVIRONMENT}"]["consumer_key"], Application::AUTH_TOKENS["twitter_#{Application::ENVIRONMENT}"]["consumer_secret"]
  end
  
  get '/login' do
    haml :login
  end
  
  get '/auth/:name/callback' do
    auth = request.env['omniauth.auth']
    
    auth_record = Authentication.first(:conditions => { :provider => auth['provider'], :uid => auth['uid'] })
    if !auth_record.nil?
      # Existing User
      login_user(auth_record.user)
    else
      # New User
      user = User.new
      user.handle = auth['user_info']['nickname']
      user.email = auth['user_info']['email'] if !auth['user_info']['email'].nil?
      user.image_url = auth['user_info']['image'] if !auth['user_info']['image'].nil?
      user.save

      # TODO: Figure out why validation fails here :(
      Authentication.create!(:provider => auth['provider'], :uid => auth['uid'], :user => user)
      
      login_user(user)
    end
    redirect '/'
  end
  
  get '/logout' do
    logout_user
    redirect '/'
  end
  
  protected
  
  def current_user
    User.get(session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  
  def login_user(user)
    session[:user_id] = user.id.to_s
  end
  
  def logout_user
    session[:user_id] = nil
  end
  
end