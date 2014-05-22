module RunPal
  class CreateChallenge < UseCase

    def run(inputs)

      sender_id = RunPal.db.get_circle(inputs[:sender_id].to_i)
      return failure (:circle_does_not_exist) if sender_id.nil?

      # SHOULD WE TEST SENDER AND RECIPIENT HERE?

      recipient_id = RunPal.db.get_circle(inputs[:recipient_id].to_i)
      return failure (:circle_does_not_exist) if recipient_id.nil?

      inputs[:name] = inputs[:name].to_s
      inputs[:sender_id] = inputs[:sender_id].to_i
      inputs[:recipient_id] = inputs[:recipient_id].to_i
      inputs[:creator_id] = inputs[:creator_id].to_i
      inputs[:pace] = inputs[:pace].to_i
      inputs[:complete]

      challenge = create_new_challenge(inputs)
      return failure(:invalid_inputs) if !challenge.valid?

      success :challenge => challenge

    end

    def create_new_challenge(attrs)
      RunPal.db.create_challenge(attrs)
    end

  end
end
