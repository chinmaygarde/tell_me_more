class Authentication
  include DataMapper::Resource
  
  property :id, Serial
  property :provider, String
  property :uid, String
  
  belongs_to :user
  
  validates_presence_of :id
  validates_presence_of :provider
end