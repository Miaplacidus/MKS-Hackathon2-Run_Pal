module RunPal
  class DeleteChallenge < UseCase

    def run(inputs)
      challenge = RunPal.db.get_challenge(inputs[:id])
      return failure(:challenge_does_not_exist) if challenge.nil?

      delete_challenge(inputs[:id])
      deleted = RunPal.db.get_challenge(inputs[:id])
      return failure(:failed_to_delete_challenge) if !deleted.nil?

      success :challenge => challenge
    end

    def delete_challenge(attrs)
      RunPal.db.delete_challenge(attrs)
    end

  end
end
