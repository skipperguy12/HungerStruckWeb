if ENV["REDISCLOUD_URL"]
  $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  $redis = Redis::Namespace.new("mongoid_forums", :redis => Redis.new)
end
