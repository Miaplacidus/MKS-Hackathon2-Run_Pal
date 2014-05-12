module RunPal
  class CreateWallet < UseCase

    def run(inputs)

      user = RunPal.db.get_user(inputs[:user_id])
      return failure (:user_does_not_exist) if user.nil?

      wallet = create_new_wallet(inputs)
      return failure(:invalid_input) if !wallet.valid?

      success :wallet => wallet
    end

    def create_new_wallet(attrs)
      RunPal.db.create_wallet(attrs)
    end

  end
end
