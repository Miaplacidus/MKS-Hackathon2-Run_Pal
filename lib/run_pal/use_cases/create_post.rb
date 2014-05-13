module RunPal
  class CreatePost < UseCase

    def run(inputs)
      user = RunPal.db.get_user(inputs[:creator_id].to_i)
      return failure (:user_does_not_exist) if user.nil?

      # inputs[:creator_id] = inputs[:creator_id].to_i
      # inputs[:pace] = inputs[:pace].to_i
      # inputs[:min_amt] = inputs[:min_amt].to_f
      # inputs[:age_pref] = inputs[:age_pref].to_i
      # inputs[:gender_pref] = inputs[:gender_pref].to_i
      # inputs[:circle_id] = inputs[:circle_id].to_i if inputs[:circle_id]
      # inputs[:max_runners] = inputs[:max_runners].to_i

      post = create_new_post(inputs)
      return failure(:invalid_input) if !post.valid?

      success :post => post
    end

    def create_new_post(attrs)
      RunPal.db.create_post(attrs)
    end

  end
end
