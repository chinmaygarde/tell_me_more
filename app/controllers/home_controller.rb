class HomeController < ApplicationController
  get '/?' do
    # TODO: Do something
    haml :hello
  end
end
