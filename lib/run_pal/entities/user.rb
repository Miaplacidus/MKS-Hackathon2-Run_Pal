module RunPal
  class User < Entity
    attr_accessor :id, :username, :gender, :email, :bday, :history, :password
    attr_accessor :rating, :wallet_id, :circle_ids, :level
    # circle_ids: array
  end
end

=begin
GENDER
0 - Female
1 - Male
=end
