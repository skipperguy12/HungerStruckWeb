MongoidForums::ForumsController.class_eval do

    # Redefinition
    def index

      # start changes
      @recent = MongoidForums::Topic.by_most_recent_post.page(params[:page]).per(MongoidForums.per_page)
      # end
    end
end
