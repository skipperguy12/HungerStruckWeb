module UsersHelper
  def get_image(user, size, style)
    return image_tag("https://crafatar.com/avatars/" + user.to_s + "?size=#{size}&overlay", style: style)
  end
end
