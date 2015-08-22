class KeysController < ApplicationController
  def insertkey
    uuid = params[:uuid]
    @message = uuid
    if not uuid == nil
      @message = "not nil"
      if User.where(uuid: uuid).exists?
        @message = "found user"
        newtoken = rand(36**14).to_s(36)
        key = Key.where(user: uuid).first_or_create
        key.token = newtoken
        key.save!
        @message = key.id
      end
    end
  end
end
