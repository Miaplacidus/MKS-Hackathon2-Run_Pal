module RunPal
  class ShowUserWallet < UseCase

    def run(inputs)

      user = RunPal.db.get_user(inputs[:user_id])
      return failure(:user_does_not_exist) if user.nil?

      wallet = RunPal.db.get_wallet_by_userid(inputs[:user_id])
      return failure(:wallet_does_not_exist) if wallet.nil?

      wallet = get_wallet_data(inputs)
      success :wallet => wallet
    end

    def get_wallet_data(attrs)
      RunPal.db.get_wallet_by_userid(attrs[:user_id])
    end

  end
end
