require 'spec_helper'

describe RunPal::CreateWallet do

  before :each do
    RunPal.db.clear_everything
  end

  it 'creates a new wallet' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    result = subject.run({user_id: user.id, balance: 20.00})
    expect(result.success?).to eq(true)
    expect(RunPal.db.get_user(result.wallet.user_id).username).to eq("Isaac Asimov")
  end

end
