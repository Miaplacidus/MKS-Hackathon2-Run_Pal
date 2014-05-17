module RunPal
  class User < Entity
    attr_accessor :id, :username, :gender, :email, :bday, :history, :password
    attr_accessor :rating, :wallet_id, :circle_ids, :level

    # consider image
    # circle_ids: array

    validates_presence_of :username, :gender, :email, :bday, :password
  end
end

=begin
GENDER
1 - Female
2 - Male
=end
