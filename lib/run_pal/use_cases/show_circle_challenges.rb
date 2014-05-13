module RunPal
  class ShowCircleChallenges < UseCase

    def run(inputs)
      challenges = RunPal.db.get_circle_challenges(inputs[:circle_id])
      return failure(:challenges_do_not_exist) if challenges.nil?

      challenges = show_circle_challenges(inputs)
      success :challenges => challenges
    end

    def show_circle_challenges(attrs)
      RunPal.db.get_circle_challenges(attrs[:circle_id])
    end

  end
end
