module RunPal
  class UpdateWalletBalance < UseCase

    def run(inputs)
      user = RunPal.db.get_user(inputs[:user_id])
      return failure (:user_does_not_exist) if user.nil?

      wallet = RunPal.db.get_wallet_by_userid(inputs[:user_id])
      return failure (:wallet_does_not_exist) if wallet.nil?

      updated_wallet = wallet_transaction(inputs)
      success :wallet => updated_wallet
    end

    def wallet_transaction(attrs)
      RunPal.db.update_wallet_balance(attrs[:user_id], attrs[:transaction])
    end

  end
end
