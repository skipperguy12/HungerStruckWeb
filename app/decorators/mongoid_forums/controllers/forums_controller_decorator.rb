MongoidForums::ForumsController.class_eval do
    # Redefinition
    def index
      # start changes
      @recent = MongoidForums::Topic.by_most_recent_post.page(params[:page]).per(MongoidForums.per_page)
      # end
    end

    #Redefinition
    def create

      @forum = MongoidForums::Forum.find(params[:forum_id])
      authorize! :create_topic, @forum
      #puts DateTime.parse((Time.now - Time.demongoize(mongoid_forums_user.mongoid_forums_posts.last.created_at)))
      puts 3.minutes
      puts "ALDKSAJ"
      if (Time.now - Time.demongoize(mongoid_forums_user.mongoid_forums_posts.last.created_at))/60 < 3
        flash[:notice] = t("mongoid_forums.topic.not_created_time")
        redirect_to @topic
      end

      @topic = MongoidForums::Topic.new
      @topic.name = topic_params[:name]
      @topic.user = mongoid_forums_user.id
      @topic.forum = @forum.id
      @post = MongoidForums::Post.new
      @post.user = mongoid_forums_user.id
      @post.text = topic_params[:posts][:text]
      @topic.posts << @post

      if @topic.save && @topic.posts.first.save
        flash[:notice] = t("mongoid_forums.topic.created")
        redirect_to @topic
      else
        flash.now.alert = t("mongoid_forums.topic.not_created")
        render :action => "new"
      end
    end
end
