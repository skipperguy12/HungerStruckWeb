class UsersController < ApplicationController
  def show
    @user = User.where(username: params[:id]).first
    @posts_count = MongoidForums::Post.where(:user_id => @user.id).count
    @topics_count = MongoidForums::Topic.where(:user_id => @user.id, :hidden => false).count
  end
end
