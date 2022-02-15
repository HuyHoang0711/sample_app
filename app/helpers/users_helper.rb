module UsersHelper
  def gravatar_for user, size: 80
    gravatar_id  = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = Settings.url.gravatar + gravatar_id + "?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def allow_delete? user
    current_user.admin? && !current_user?(user)
  end
end
