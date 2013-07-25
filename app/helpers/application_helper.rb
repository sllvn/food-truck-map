module ApplicationHelper
  def nilsafe_time_ago_in_words(datetime)
    if datetime.nil?
      'Never'
    else
      "#{time_ago_in_words(datetime).capitalize} ago"
    end
  end
end
