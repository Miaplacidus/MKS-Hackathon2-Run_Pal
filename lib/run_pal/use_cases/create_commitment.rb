module RunPal
  class CreateCommitment < UseCase

    def run(inputs)
      user = RunPal.db.get_user(inputs[:user_id].to_i)
      return failure (:user_does_not_exist) if user.nil?

      post = RunPal.db.get_post(inputs[:post_id].to_i)
      return failure (:post_does_not_exist) if post.nil?

      inputs[:user_id] = inputs[:user_id].to_i
      inputs[:post_id] = inputs[:post_id].to_i
      inputs[:amount] = inputs[:amount].to_i

      commit = create_commit(inputs)
      return failure(:invalid_input) if !commit.valid?

      success :commit => commit
    end

    def create_commit(attrs)
      RunPal.db.create_commit(attrs)
    end

  end
end
