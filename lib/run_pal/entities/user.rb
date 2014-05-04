module RunPal
  class User < Entity
    attr_accessor :id, :username, :gender, :email, :age, :history, :password
    attr_accessor :rating, :wallet_id, :circle_ids, :level
    # circle_ids: array
  end
end
