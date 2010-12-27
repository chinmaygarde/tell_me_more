class TweetsController < ApplicationController
  before do
    unless signed_in?
      redirect '/login'
    end
  end
  
  get '/wizard' do
    haml :wizard
  end
  
  get '/step1' do
    haml :step1, :layout => false
  end
  
  get '/step2' do
    haml :step2, :layout => false
  end
  
  get '/step3' do
    haml :step3, :layout => false
  end
  
  # Called by step 1
  get '/latest/:user' do |user|
    raw_tweets = Twitter.user_timeline(user, :count => 200)
    @tweets = []
    raw_tweets.each do |raw_tweet|
      tweet = Tweet.first_or_new(:tweet_id => raw_tweet.id.to_s)
      tweet.text = raw_tweet.text
      tweet.user = current_user
      tweet.created_at = Time.now
      tweet.save
      @tweets << tweet
    end
    @tweet_count = current_user.tweets.count
    haml :tweets, :layout => false
  end
  
  # Called by step 2
  get '/process/:user_id' do |user_id|
    processor = TweetProcessor.new
    processor.raw_text = ""
    User.get(user_id).tweets.each do |tweet|
      processor.raw_text = processor.raw_text + " " + tweet.text
    end
    @result = processor.gather_result
    haml :processed, :layout => false
  end
end