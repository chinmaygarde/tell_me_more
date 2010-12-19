module UserHelpers
  def gravatar(email, size=32)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}.jpg?s=#{size}"
  end
end
