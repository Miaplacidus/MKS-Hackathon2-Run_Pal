require 'spec_helper'

describe RunPal::DeletePost do

  before :each do
    RunPal.db.clear_everything
  end

  it 'deletes a post' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    post = RunPal.db.create_post({location: [30.25, -97.75], creator_id: user.id, max_runners: 10, time: Time.now, pace: 3, notes: "Fun!", min_amt: 12.50, age_pref: 3, gender_pref: 0})
    result = subject.run(id: post.id)
    expect(result.success?).to eq(true)
    expect(RunPal.db.get_post(post.id)).to eq(nil)
  end

end
