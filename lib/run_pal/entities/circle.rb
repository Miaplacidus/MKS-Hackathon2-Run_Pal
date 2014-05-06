module RunPal
  class Circle < Entity
    attr_accessor :id, :name, :admin_id, :member_ids, :post_ids, :max_members, :location
    # post_ids: array
    # member_ids: array
    validates_presence_of :name, :admin_id, :max_members, :location

    def initialize(attrs={})
      @member_ids = []
      super
    end
  end
end
