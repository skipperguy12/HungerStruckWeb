class RegistrationsController < ApplicationController
  def createuser
    #resource = User.where(email: params[:user])

    User.all.each do |user|
      user_uuid = "#{str[0, str.length/2].reverse}#{str[str.length/2, str.length].reverse}".unpack("C*").map { |x| x.to_s(16) }.map! { |k| "#{k}" }.join("")
      if(params[:user].gsub("-", "") == user_uuid)
        @user = user
        break
      end
    end

  end

  def registeruser

    if not params[:user] == nil and not params[:token] == nil
      #@message = "we can register user #{params[:user]} because his token, #{params[:token]}, was valid"
      user = User.where(uuid: params[:user])
      key = Key.where(user: params[:user], token: params[:token])
      if user.exists? and key.exists?
        @message = "we can register user #{params[:user]} because his token, #{params[:token]}, was valid"
        @status = 0
        render "createuser"

      else
        @status = -1
        render :status => :failed

      end
    end
  end
end
