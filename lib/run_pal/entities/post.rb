module RunPal
  class Post < Entity
    attr_accessor :id, :creator_id, :time, :pace, :notes, :complete, :min_amt, :min_distance
    attr_accessor :age_pref, :gender_pref, :committer_ids, :attend_ids, :circle_id, :max_runners
    attr_accessor :latitude, :longitude
    # committer_ids: array
    # when created, committer ids will first include the creator's id
    # attend_ids: array
    #location: [lat: number, long: number]
    # NOTE IN DB TABLES: location, committer ids, attend ids
    validates_presence_of :creator_id, :time, :pace, :min_amt, :latitude, :longitude
    validates_presence_of :age_pref, :gender_pref, :committer_ids, :max_runners

    def initialize(attrs={})
      @notes = ""
      @circle_id = nil
      @complete = false
      @attend_ids = []
      super
    end
  end
end


=begin
PACE LEVELS
0 - Military: 6 min and under/mile
1 - Advanced: 6-7 min/mi
2 - High Intermediate: 7-8 min/mi
3 - Intermediate: 8-9 min/mi
4 - High Beginner: 9-10 min/mi
5 - Beginner: 10-11 min/mi
6 - [Something]: 11-12 min/mi
7 - [Something]: 12+ min/mi

GENDER PREFERENCES
0 - BOTH
1 - FEMALE
2 - MALE

AGE PREFERENCES
0 - No preference
1 - 16-17
2 - 18-22
3 - 23-29
4 - 30-39
5 - 40-49
6 - 50-59
7 - 60-69
8 - 70+
=end

