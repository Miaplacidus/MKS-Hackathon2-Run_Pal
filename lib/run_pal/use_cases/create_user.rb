module RunPal
  class CreateUser < UseCase

    def run(inputs)
      # WE NEED TO ADD A METHOD TO CHECK USER BY EMAIL SO ANOTHER USER DOESNT CREATE AN ACCOUNT WITH SAME EMAIL
      email_check = RunPal.db.get_user_by_email(inputs[:email].to_s)
      return failure (:email_already_exists) if !email_check.nil?

      inputs[:username] = inputs[:username].to_s
      inputs[:gender] = inputs[:gender].to_s
      inputs[:email] = inputs[:email].to_s
      inputs[:bday] = inputs[:bday].to_s
      inputs[:password] = inputs[:password].to_s

      user = create_user(inputs)
      return failure(:invalid_inputs) if !user.valid?

      success :user => user
    end

    def create_user(attrs)
      RunPal.db.create_user(attrs)
    end

  end
end
