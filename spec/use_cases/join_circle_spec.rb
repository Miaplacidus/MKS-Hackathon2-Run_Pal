require 'spec_helper'

describe RunPal::JoinCircle do

  before :all do
    RunPal.db.clear_everything
    @user1 = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com", bday:"4/2/1922"})
    @circle = RunPal.db.create_circle({name: "MakerSquare", admin_id: @user1.id, max_members: 2, latitude: 33, longitude: 44, description:"Hell yeah!", level: 2})
  end

  it 'allows users to join circles' do
    user2 = RunPal.db.create_user({username: "Runna Lot", gender: 1, email:"jogger@run.com", bday:"6/6/1966"})
    result = subject.run({circle_id: @circle.id, user_id: user2.id})

    expect(result.success?).to eq(true)
    expect(result.user.username).to eq("Runna Lot")
  end

  it "disallows joining if maximum membership reached" do
    user3 = RunPal.db.create_user({username: "Jon Jones", gender: 2, email:"runlikemad@sprinter.com", password:"aabbcc", bday:"3/14/1988"})
    subject.run({circle_id: @circle.id, user_id: @user1.id })
    result = subject.run({circle_id: @circle.id, user_id: user3.id})

    expect(result.success?).to eq(false)
  end

end
