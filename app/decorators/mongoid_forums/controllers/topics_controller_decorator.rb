MongoidForums::TopicsController.class_eval do
    def my_topics
        @topics = Kaminari.paginate_array(MongoidForums::Topic.where(:user_id => mongoid_forums_user.id).by_most_recent_post.select {|t| can? :read, t}).page(params[:page]).per(MongoidForums.per_page)
    end
end
