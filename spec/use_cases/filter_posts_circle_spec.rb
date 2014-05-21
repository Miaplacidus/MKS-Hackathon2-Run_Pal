require 'spec_helper'

describe RunPal::FilterPostsByCircle do

  before :each do
    RunPal.db.clear_everything
  end

  it 'filters posts by circle' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    circle = RunPal.db.create_circle({name: "MakerSquare", admin_id: user.id, max_members: 30, member_ids: []})
    post = RunPal.db.create_post({location: [30.25, -97.75], creator_id: user.id, max_runners: 10, time: Time.now, pace: 3, notes: "Fun!", min_amt: 12.50, age_pref: 3, gender_pref: 0, circle_id: circle.id})
    result = subject.run({circle_id: circle.id})
    expect(result.success?).to eq(true)
    expect(result.post_arr.length).to eq(1)
    expect(RunPal.db.get_user(result.post_arr[0].creator_id).username).to eq("Isaac Asimov")
  end

end
