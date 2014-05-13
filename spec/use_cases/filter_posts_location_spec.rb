require 'spec_helper'

describe RunPal::FilterPostsByLocation do

  it 'filters posts by location' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    post1 = RunPal.db.create_post({location: [30.25, -97.75], creator_id: user.id, max_runners: 10, time: Time.now, pace: 3, notes: "Fun!", min_amt: 12.50, age_pref: 3, gender_pref: 0, committer_ids: [user.id]})
    post2 = RunPal.db.create_post({creator_id: user.id, time: Time.now, location:[30.251, -97.751], pace: 1, notes:"Let's go.", complete:false, min_amt:5.50, age_pref: 3, gender_pref: 1, committer_ids: [user.id]})
    post3 = RunPal.db.create_post({creator_id: user.id, time: Time.now, location:[66, 77], pace: 7, notes:"Will be a fairly relaxed jog.", complete:true, min_amt:12.00, age_pref: 3, gender_pref: 1, committer_ids: [user.id]})
    result = subject.run({location: [30.25, -97.75], radius: 30})

    expect(result.success?).to eq(true)
    expect(result.post_arr.length).to eq(2)
    expect(RunPal.db.get_user(result.post_arr[0].creator_id).username).to eq("Isaac Asimov")
  end

end
