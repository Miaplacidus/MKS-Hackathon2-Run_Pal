module RunPal
  class FilterPostsByLocation < UseCase

    def run(inputs)
      post_arr = filter_posts_by_location(inputs)

      success :post_arr => post_arr
    end

    def filter_posts_by_location(attrs)
      RunPal.db.posts_filter_location(attrs[:location], attrs[:radius])
    end

  end
end
