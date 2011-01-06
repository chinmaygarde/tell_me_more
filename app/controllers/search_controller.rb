class SearchController < ApplicationController
  get "/" do
    haml :search, :layout => false
  end
  
  get "/:q" do |q|
    @results = Tweet.search("#{q} author:#{current_user.handle}")["results"]
    haml :search_result, :layout => false
  end
end