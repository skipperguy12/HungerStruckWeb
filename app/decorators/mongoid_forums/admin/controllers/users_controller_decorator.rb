MongoidForums::Admin::UsersController.class_eval do
    # Redefinition (prevent this method from being called)
    before_action :set_user, only: []

    # Redefinition
    def add_admin
      # start change
      @user = User.find_by(email: params[:user][:email])
      # end
      @user.mongoid_admin = true
      @user.save
      redirect_to admin_users_path
    end

    # Redefinition
    def remove_admin
      # start change
      @user = User.find(params[:user][:id])
      # end
      @user.mongoid_admin = false
      @user.save
      redirect_to admin_users_path
    end
end
