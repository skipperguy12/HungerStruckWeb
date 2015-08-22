module ApplicationHelper
  def resource_class
    User
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def button_tag(text, options = {})
    options[:type] ||= :submit
    options[:class] ||= "btn btn-primary"
    content_tag :button, :type => options[:type], :class => options[:class] do
      text.to_s
    end
  end

  def bootstrap_class_for flash_type
      { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def labels_for user
    unless user
      return
    end
    ret = ""
    if user.mongoid_admin?
      ret = ret + "<span class=\"label label-warning\">
        Admin
      </span>
      &nbsp;"
    end

    user.get_mod_groups.each do |mod_group|
      ret = ret + "<span class=\"label #{mod_group.moderator ? "label-success" : "label-info"}\">
        #{mod_group.name}
      </span>
      &nbsp;"
    end
    return ret.html_safe
  end

  def color_for user
    unless user
      return ""
    end
    if user.mongoid_admin?
      return "#f89406"
    elsif user.get_mod_groups.select{|group| group.moderator}.size > 0
      return "#12bd00"
    end
    ""
  end

end
