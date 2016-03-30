MongoidForums::Admin::TopicsController.class_eval do
  def change_forum
    @topic.forum = MongoidForums::Forum.find(params[:new_forum])

    if @topic.valid?
      @topic.save
      flash[:notice] = t("mongoid_forums.topic.updated")
      redirect_to @topic
    else
      @topic.save
      flash[:notice] = t("mongoid_forums.topic.not_updated")
      redirect_to @topic
    end
  end
end
