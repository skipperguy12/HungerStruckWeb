MongoidForums::Forum.class_eval do
=begin
  # Redefinition
  # Near total change, adds redis caching
  def unread_topic_count(user)
    count = $redis.get("forum:" + id + ":unread_topic_count:" + user.to_s)

    if count.nil?
      view = MongoidForums::View.where(:viewable_id => id, :user_id => user.id).first
      return topics.count unless view.present?
      count = 0
      topics.each do |topics|
        if topics.created_at > view.current_viewed_at
          count+=1
        end
      end

      $redis.set("forum:" + id + ":unread_topic_count:" + user.to_s, count)
      $redis.expire("forum:" + id + ":unread_topic_count:" + user.to_s,2.minute.to_i)
    end
    return count.to_i
  end
=end
end
