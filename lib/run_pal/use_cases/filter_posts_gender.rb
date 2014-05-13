module RunPal
  class FilterPostsByGender < UseCase

    def run(inputs)
      post_arr = filter_posts_by_gender(inputs)

      success :post_arr => post_arr
    end

    def filter_posts_by_gender(attrs)
      RunPal.db.posts_filter_gender(attrs)
    end

  end
end
