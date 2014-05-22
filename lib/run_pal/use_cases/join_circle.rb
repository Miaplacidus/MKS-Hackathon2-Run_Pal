module RunPal
  class JoinCircle < UseCase

    def run(inputs)
      user = RunPal.db.get_user(inputs[:user_id])
      return failure (:user_does_not_exist) if user.nil?

      circle = RunPal.db.get_circle(inputs[:circle_id])
      max_members = circle.max_members
      number_of_members = circle.member_ids.length
      return failure (:circle_does_not_exist) if circle.nil?
      return failure (:max_num_members_reached) if max_members == number_of_members

      updated_circle = join_circle(inputs)
      success :circle => updated_circle, :user => user
    end

    def join_circle(attrs)
      RunPal.db.add_user_to_circle(attrs[:circle_id], attrs[:user_id])
    end

  end
end
