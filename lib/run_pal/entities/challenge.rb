module RunPal
  class Challenge < Entity
    attr_accessor :id, :name, :sender_id, :recipient_id, :post_id, :accepted
    # post_ids: array
    # member_ids: array
    # default value for associated post min_amount is $0
    validates_presence_of :name, :sender_id, :recipient_id, :post_id

    def initialize(attrs)
      @accepted = false
      super
    end
  end
end
