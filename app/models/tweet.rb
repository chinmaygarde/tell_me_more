class Tweet
  include DataMapper::Resource
  include IndexTankDocument
  
  property :id, Serial
  property :tweet_id, String
  property :text, Text
  property :lat, String
  property :lon, String
  
  belongs_to :user
  
  indexes :id, :tweet_id, :text, :lat, :lon
  
  after :save do
    add_to_index
  end
end