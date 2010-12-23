module UserHelpers
  def gravatar(user, size=32)
    if user.image_url.nil?
      email = user.email unless user.email.nil?
      email ||= "nothing@buzzyand.me"
      return "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}.jpg?s=#{size}"
    else
      return user.image_url
    end
  end
end
