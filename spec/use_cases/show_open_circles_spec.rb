require 'spec_helper'

describe RunPal::ShowOpenCircles do

    before :each do
        RunPal.db.clear_everything
    end

  it 'shows open circles' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    circle1 = RunPal.db.create_circle({name: "Silvercar", admin_id: user.id, max_members: 1, location:[32, 44], member_ids:[user.id]})
    circle2 = RunPal.db.create_circle({name: "Crazy Apps", admin_id: user.id, max_members: 19, location: [22, 67], member_ids:[]})

    result = subject.run({})
    expect(result.success?).to eq(true)
    expect(result.circle_arr.length).to eq(1)
    expect(result.circle_arr[0].name).to eq("Crazy Apps")
  end

end

