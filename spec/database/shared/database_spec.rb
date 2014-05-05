
shared_examples 'a database' do
  let(:db) { described_class.new}

  before :each do
    db.clear_everything
  end

# USER TESTS
  describe 'Users' do
    it "creates a user" do
      user = RunPal::User.new({username: "Fast Feet", gender: 1, email:"marathons@speed.com", password:"abc123", age:"25"})
      expect(user.username).to eq("Fast Feet")
      expect(user.gender).to eq(1)
      expect(user.password).to eq("abc123")
    end

    it "gets a user" do
      user = db.create_user :username => 'Jon Jones'  gender: 0, age: 26
      retrieved_user = db.get_user(user.id)
      expect(retrieved_user.username).to eq('Jon Jones')
      expect(retrieved_user.gender).to eq(0)
      expect(retrieved_user.age).to eq(26)
    end

    it "gets all users" do
      %w{Alice Bob}.each {|name| db.create_user :name => name }
      expect(db.all_users.count).to eq 2
      expect(db.all_users.map &:name).to include('Alice', 'Bob')
    end

    it "updates user information" do
      user = db.create_user({username:"Isaac Newton", email: "apple@ouch.com", age:21})
      user.update_user({email:"genius@physics.com"})
      expect(db.all_users.count).to eq 2
    end

  end

# POST TESTS
  describe 'Posts' do
    it "creates a post" do
      user = db.create_user({username:"Runna Lot"})
      post = RunPal::Post.new(creator_id: user.id, time: Time.now, pace: 3, min_amt: 10)
      expect((db.get_user(post.creator_id)).username).to eq("Runna Lot")
      expect(post.time).to eq(Time.now)
      expect(post.pace).to eq(3)
      expect(post.min_amt).to eq(10)
    end

    it "creates a post associated with a circle" do
      circle = RunPal::Circle.new(name:"MakerSquare", max_members: 23)
      post = RunPal::Post.new(:creator_id: 1, circle_id: circle.id)
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

