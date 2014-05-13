module RunPal
  class FilterPostsByPace < UseCase

    def run(inputs)
      post_arr = filter_posts_by_pace(inputs)

      success :post_arr => post_arr
    end

    def filter_posts_by_pace(attrs)
      RunPal.db.posts_filter_pace(attrs[:pace])
    end

  end
end
