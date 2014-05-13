module RunPal
  class ShowPost < UseCase

    def run(inputs)
      post = RunPal.db.get_post(inputs[:post_id])
      return failure(:post_does_not_exist) if post.nil?

      post = get_post_data(inputs)
      success :post => post
    end

    def get_post_data(attrs)
      RunPal.db.get_post(attrs[:post_id])
    end

  end
end
