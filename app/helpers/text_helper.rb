module TextHelper
  def s_or_not?(user)
    user.first_name.downcase.ends_with?('s') ? '' : 's'
  end
end
