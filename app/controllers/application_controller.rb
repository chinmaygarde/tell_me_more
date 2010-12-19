class ApplicationController < Sinatra::Base
  configure(:development) do
    register Sinatra::Reloader
    also_reload File.join(Application::ROOT, "app/models/*.rb")
  end
  
  # TODO: Add application wide helpers here
  helpers UserHelpers
  helpers Sinatra::ContentFor
  
  set(:environment, Application::ENVIRONMENT.to_sym)
  set(:public, File.join(Application::ROOT, "public"))
  set(:views, File.join(Application::ROOT, "app", "views"))
  use Rack::MethodOverride

  enable :sessions
  
  use OmniAuth::Builder do
    provider :github,   Application::AUTH_TOKENS["github"]["client_id"], Application::AUTH_TOKENS["github"]["secret"]
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
      auth_record = Authentication.create!(:provider => auth['provider'], :uid => auth['uid'])

      user = User.new
      user.authentications << auth_record
      user.handle = auth['user_info']['nickname'] if !auth['user_info']['nickname'].nil?
      user.email = auth['user_info']['email'] if !auth['user_info']['email'].nil?
      user.save!
      
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