require 'spec_helper'

describe RunPal::CreateCircle do

  it 'creates a new circle' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    result = subject.run({name: "MakerSquare", location: [30.25, -97.75], admin_id: user.id, max_members: 45})
    expect(result.success?).to eq(true)
    expect(result.circle.name).to eq("MakerSquare")
  end

end

# :name, :admin_id, :member_ids, :post_ids, :max_members, :location
# attr_accessor :id, :username, :gender, :email, :bday, :history, :password
#     attr_accessor :rating, :wallet_id, :circle_ids, :level
