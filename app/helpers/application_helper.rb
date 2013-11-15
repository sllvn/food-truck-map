module ApplicationHelper
  def nilsafe_time_ago_in_words(datetime)
    if datetime.nil?
      'Never'
    else
      "#{time_ago_in_words(datetime).capitalize} ago"
    end
  end

  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
