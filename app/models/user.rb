class User
  include DataMapper::Resource
  
  ### TODO: Needs handle and email at least
  property :id, Serial
  property :handle, String
  property :email, String
  # field :handle
  # field :email

  ### TODO: Needs association with authentications
  # references_many :authentications
  has n, :authentications
end