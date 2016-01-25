MongoidForums::PostsController.class_eval do
  # Temporary patch: Validations caused a 422. Moving the @post.user inside of a valid check seems to resolve the issue
  def create
    authorize! :reply, @topic
    @post = @topic.posts.new(post_params)
    if @post.valid?
      @post.user = mongoid_forums_user
      @post.save
      @topic.alert_subscribers(mongoid_forums_user.id)
      @topic.forum.increment_posts_count
      flash[:notice] = t("mongoid_forums.post.created")
      redirect_to @topic
    else
      flash.now.alert = t("mongoid_forums.post.not_created")
      render :action => "new"
    end
  end
end
