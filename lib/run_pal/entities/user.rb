module RunPal
  class User < Entity
    attr_accessor :id, :username, :gender, :email, :bday, :history, :password
    attr_accessor :rating, :wallet_id, :circle_ids, :level
    # Facebook related properties
    attr_accessor :fbid, :oauth_token, :oauth_expires_at

    # REMOVE PASSWORD FROM PROPERTIES AND TESTS
    # REMOVE LEVEL FROM PROPERTIES AND TESTS
    # removed history property. instead, get history by grabbing user's id from post membership table
    # and sorting by date
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
