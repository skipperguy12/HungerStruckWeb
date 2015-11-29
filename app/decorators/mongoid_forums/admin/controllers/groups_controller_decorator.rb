MongoidForums::Admin::GroupsController.class_eval do
    # Redefinition
    def add_member
      group = MongoidForums::Group.find(params.require(:group_id))
      # start change
      user = User.find_by(email: params[:user][:email])
      # end

      group.members << user.id unless group.members.include?(user.id)
      group.save

      redirect_to admin_group_path(group)
    end

    # Redefinition
    def remove_member
      group = MongoidForums::Group.find(params.require(:group_id))
      # start change
      user = User.find(params[:user][:id])
      # end change

      group.members.delete(user.id)
      group.save

      redirect_to admin_group_path(group)
    end
end
