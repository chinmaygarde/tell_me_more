class User
  include DataMapper::Resource
  
  property :id, Serial
  property :handle, String
  property :email, String
  property :image_url, String
  has n, :authentications
end