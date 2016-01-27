MongoidForums::Topic.class_eval do
    field :spam, type: Boolean, default: false

    # Redefinition
    # Near total change, adds redis caching
    def unread_post_count(user)
      count = $redis.get("topic:" + id + ":unread_post_count:" + user.to_s)

      if count.nil?
        view = MongoidForums::View.where(:viewable_id => id, :user_id => user.id).first
        return posts.count unless view.present?
        count = 0
        posts.each do |post|
          if post.created_at > view.current_viewed_at
            count+=1
          end
        end


        $redis.set("topic:" + id + ":unread_post_count:" + user.to_s, count)
        $redis.expire("topic:" + id + ":unread_post_count:" + user.to_s,5.minute.to_i)
      end

      return count.to_i
    end

    # Added method
    def last_post
      last_post = $redis.get("topic:" + id + ":last_post")

      if last_post.nil?
        last_post = posts.order_by([:created_at, :desc]).first
        $redis.set("topic:" + id + ":last_post" , last_post.to_json)
        $redis.expire("topic:" + id + ":last_post" ,10.minute.to_i)
        return last_post
      end

      last_post_json = JSON.parse(last_post)
      last_post_json['user_id'] = last_post_json['user_id']['$oid']
      last_post_json['_id'] = last_post_json['_id']['$oid']
      last_post =  MongoidForums::Post.new(last_post_json)

      return last_post
    end

end
