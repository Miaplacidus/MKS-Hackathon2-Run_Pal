module RunPal
  class Post < Entity
    attr_accessor :id, :creator_id, :time, :location, :pace, :complete, :min_amt
    attr_accessor :age_pref, :gender_pref, :committer_ids, :attend_ids, :circle_id
    # committer_ids: array
    # attend_ids: array
  end
end
