class TweetsController < ApplicationController
  before do
    unless signed_in?
      redirect '/login'
    end
  end
  
  get '/gather' do
    haml :gather
  end
  
end