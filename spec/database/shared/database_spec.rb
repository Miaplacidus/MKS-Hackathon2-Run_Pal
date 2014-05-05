
shared_examples 'a database' do
  let(:db) { described_class.new}

  before {db.clear_everything}

# USER TESTS
  describe 'Users' do
    it "creates a user" do

    end

    it "gets a user" do
    end

    it "gets all users" do
    end

  end

# POST TESTS
  describe 'Posts' do
    it "creates a post" do
    end

    it "creates a post associated with a circle" do
    end

    it "gets a post" do
    end

    it "gets all posts" do
    end

    it "deletes old posts" do
    end

    it "filters posts by age" do
    end

    it "filters posts by age preference" do
    end

    it "filters posts by gender preference" do
    end

    it "filters posts by location" do
    end

    it "filters posts by pace" do
    end

    it "filters posts by time" do
    end

  end

# COMMITMENT TESTS
  describe 'Commitments' do
    it "creates a commitment" do
    end

    it "gets a commitment" do
    end

    it "gets commitments by user_id" do

    end
  end

# CIRCLE TESTS
  describe 'Circles' do
    it "creates a circle" do
    end

    it "gets a circle" do
    end

    it "gets all circles" do
    end

    it "filters circles by location" do
    end

    it "filters out full circles" do
    end
  end

# WALLET TESTS
  describe 'Wallets' do
    it "creates a wallet" do
    end

    it "gets a wallet" do
    end

  end

end

