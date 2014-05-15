require 'spec_helper'

describe RunPal::CreateUser do

  before :each do
    RunPal.db.clear_everything
  end

  it 'creates a new user' do

    result = subject.run({username:"FastRunner", gender: 1, email: "fast@runner.com", bday: "01-01-1980", password: "runReallyFast"})
    expect(result.success?).to eq(true)
    expect(result.user.username).to eq("FastRunner")

  end

end
