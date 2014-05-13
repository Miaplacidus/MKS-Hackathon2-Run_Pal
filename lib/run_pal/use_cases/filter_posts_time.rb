module RunPal
  class FilterPostsByTime < UseCase

    def run(inputs)
      post_arr = filter_posts_by_time(inputs)

      success :post_arr => post_arr
    end

    def filter_posts_by_time(attrs)
      RunPal.db.posts_filter_time(attrs)
    end

  end
end
