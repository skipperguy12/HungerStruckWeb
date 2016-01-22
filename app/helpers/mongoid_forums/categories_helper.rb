module MongoidForums
  module CategoriesHelper

    def fetch_categories
      @categories =  $redis.get("categories")
      if @categories.nil?
        @categories = Category.asc(:position)

        $redis.set("categories", @categories.to_json)

        # Expire the cache, every 3 hours
        $redis.expire("categories",1.hour.to_i)
        return @categories
      end


      @ret_val = Array.new
      JSON.load(@categories).each do |cat|
        next if cat.nil?
        #cat['category_id'] = cat['category_id']['$oid']
        cat['_id'] = cat['_id']['$oid']
        @ret_val << Category.new(cat)
      end

      @categories = @ret_val
      return @ret_val
    end

  end
end
