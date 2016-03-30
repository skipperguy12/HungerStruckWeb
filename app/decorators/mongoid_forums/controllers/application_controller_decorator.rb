MongoidForums::ApplicationController.class_eval do
  include MongoidForums::CategoriesHelper

  def update_current_user_time
    if user_signed_in?
      current_user.last_response = Time.now
      current_user.save!
    end
  end


  after_action :update_current_user_time
  #handle_asynchronously :update_current_user_time

  private
    def set_categories
      fetch_categories
    end


end
