module RunPal
  class FilterPostsByAge < UseCase

    def run(inputs)
      post_arr = filter_posts_by_age(inputs)

      success :post_arr => post_arr
    end

    def filter_posts_by_age(attrs)
      RunPal.db.posts_filter_age(attrs)
    end

  end
end
