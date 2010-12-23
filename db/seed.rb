user = User.create(:handle => "chinmaygarde", :email => "chinmaygarde@gmail.com")

Tweet.create(:tweet_id => 17887113865334784, :text => "First Tweet", :lat => 12.0, :lon => 20.0, :user => user)
Tweet.create(:tweet_id => 17887113865334785, :text => "Second Tweet", :lat => 1.0, :lon => 11.0, :user => user)
Tweet.create(:tweet_id => 17887113865334786, :text => "Third Tweet", :lat => 16.0, :lon => 18.0, :user => user)
Tweet.create(:tweet_id => 17887113865334787, :text => "Fourth Tweet", :lat => 28.0, :lon => 30.0, :user => user)
Tweet.create(:tweet_id => 17887113865334788, :text => "Fifth Tweet", :lat => 12.0, :lon => 16.0, :user => user)
Tweet.create(:tweet_id => 17887113865334789, :text => "Sixth Tweet", :lat => 18.0, :lon => 13.0, :user => user)
Tweet.create(:tweet_id => 17887113865334710, :text => "Seventh Tweet", :lat => 13.0, :lon => 20.0, :user => user)
puts "Added Seed Tweet Values"