class Authentication
  include DataMapper::Resource
  
  ### TODO: Needs provider and uid at least
  property :id, Serial
  property :provider, String
  property :uid, String
  # field :provider
  # field :uid 
  
  ### TODO: Needs association with user
  belongs_to :user
  # referenced_in :user
  
  # validates_presence_of :provider, :uid
  # validates_uniqueness_of :uid, :scope => :provider
end