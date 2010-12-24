class Authentication
  include DataMapper::Resource
  
  property :id, Serial
  property :provider, String, :length => 255
  property :uid, String, :length => 255
  
  belongs_to :user
  
  validates_presence_of :id
  validates_presence_of :provider
end