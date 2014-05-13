require 'spec_helper'

describe RunPal::ShowUserWallet do

    before :each do
        RunPal.db.clear_everything
    end

  it 'shows information about user wallet' do
    user = RunPal.db.create_user({username:"Isaac Asimov", gender: 2, email: "write@smarty.com"})
    wallet = RunPal.db.create_wallet({user_id: user.id, balance: 20.50})

    result = subject.run({user_id: user.id})
    expect(result.success?).to eq(true)
    expect(result.wallet.balance).to eq(20.50)
    expect(RunPal.db.get_user(result.wallet.user_id).username).to eq("Isaac Asimov")
  end

end

