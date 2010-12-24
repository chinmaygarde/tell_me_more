class Tweet
  include DataMapper::Resource
  include IndexTankDocument
  
  property :id, Serial
  property :tweet_id, String
  property :text, Text
  property :lat, String
  property :lon, String
  property :created_at, DateTime
  
  belongs_to :user
  
  validates_presence_of :tweet_id
  validates_presence_of :text
  validates_presence_of :created_at
  
  indexes :id, :tweet_id, :text, :lat, :lon
  
  after :create do
    add_to_index
  end
end