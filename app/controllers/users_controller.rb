class UsersController < ApplicationController
  def show
    @user = User.where(uuid: params[:id]).first
    @user = User.where(username: params[:id]).first   if @user.nil?
    not_found if @user.nil?
    
    @posts_count = MongoidForums::Post.where(:user_id => @user.id).count
    @topics_count = MongoidForums::Topic.where(:user_id => @user.id, :hidden => false).count
  end
end
