require 'spec_helper'

describe RunPal::FilterPostsByPace do

  before :each do
    RunPal.db.clear_everything
  end

  it 'filters posts by pace' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    post1 = RunPal.db.create_post({latitude: 30.25, longitude: -97.75, creator_id: user.id, max_runners: 10, time: Time.now, pace: 3, notes: "Fun!", min_amt: 12.50, age_pref: 3, gender_pref: 0})
    post2 = RunPal.db.create_post({creator_id: user.id, time: Time.now, latitude: 30.251, longitude:-97.751, pace: 1, notes:"Let's go.", complete:false, min_amt:5.50, age_pref: 3, gender_pref: 1})
    post3 = RunPal.db.create_post({creator_id: user.id, time: Time.now, latitude: 66, longitude: 77, pace: 3, notes:"Will be a fairly relaxed jog.", complete:true, min_amt:12.00, age_pref: 3, gender_pref: 1})
    result = subject.run({pace: 4})
    expect(result.success?).to eq(true)
    expect(result.post_arr.length).to eq(0)

    result = subject.run({pace: 3})
    expect(result.post_arr.length).to eq(2)
    expect(RunPal.db.get_user(result.post_arr[0].creator_id).username).to eq("Isaac Asimov")
  end

end
