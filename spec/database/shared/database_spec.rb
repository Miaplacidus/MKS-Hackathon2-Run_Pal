
shared_examples 'a database' do
  let(:db) { described_class.new}

  before :each do
    db.clear_everything
  end

# USER TESTS
  describe 'Users' do

    before :each do
        users = [
            {username: "Fast Feet", gender: 0, email:"marathons@speed.com", password:"abc123", bday:"2/8/1987"},
            {username: "Runna Lot", gender: 1, email:"jogger@run.com", password:"111222", bday:"6/6/1966"},
            {username: "Jon Jones", gender: 1, email:"runlikemad@sprinter.com", password:"aabbcc", bday:"3/14/1988"},
            {username: "Nee Upp", gender: 0, email:"sofast@runna.com", password: "123abc", bday: "5/15/1994"}
        ]
        @user_objs = []
        users.each do |info|
            @user_objs << db.create_user(info)
        end
    end

    it "creates a user" do
      user = @user_objs[0]
      expect(user.username).to eq("Fast Feet")
      expect(user.gender).to eq(1)
      expect(user.password).to eq("abc123")
      expect(user.email).to eq("marathons@speed.com")
      expect(user.bday).to eq("2/8/1987")
    end

    it "will not create a user without the requisite information" do
      # required: username, bday, email, gender, password
      user = db.create_user(username: "Jo")
      user.should be_nil
    end

    it "gets a user" do
      user = @user_objs[1]
      retrieved_user = db.get_user(user.id)
      expect(retrieved_user.username).to eq('Runna Lot')
      expect(retrieved_user.bday).to eq('6/6/1966')
    end

    it "gets all users" do
      # %w{Alice Bob}.each {|name| db.create_user :username => name }
      expect(db.all_users.count).to eq(4)
      expect(db.all_users.map &:username).to include('Fast Feet', 'Runna Lot', 'Jon Jones', 'Nee Upp')
    end

    it "updates user information" do
      user = @user_objs[2]
      user = db.update_user(user.id, {email:"awesome@running.net"})
      expect(user.email).to eq("awesome@running.net")
    end

  end

# POST TESTS
  describe 'Posts' do
    before :each do
      db.create_post({})
    end

    xit "creates a post" do
      user = db.create_user({username:"Runna Lot"})
      post = db.create_post({creator_id: user.id, time: Time.now, pace: 3, min_amt: 10, complete: false, circle_id: nil})
      expect((db.get_user(post.creator_id)).username).to eq("Runna Lot")
      # expect(post.time).to eq(Time.now)
      expect(post.pace).to eq(3)
      expect(post.min_amt).to eq(10)
      expect(post.complete).to eq(false)
      expect(post.circle_id).to eq(nil)
    end

    xit "will not create a post without requisite information" do

    end

    xit "creates a post associated with a circle" do
      circle = db.create_circle({name: "MakerSquare", max_members: 23})
      post = db.create_post(creator_id: 1, circle_id: circle.id)
      expect((db.get_circle(post.circle_id)).name).to eq("MakerSquare")
      expect((db.get_circle(post.circle_id)).max_members).to eq(23)
    end

    xit "gets a post" do
      user = db.create_user({username: "Usain Bolt"})
      post = db.create_post({creator_id: user.id, notes: "What a sunny day!", gender_pref: 1, age_pref: 4})
      result = db.get_post(post.id)
      expect(result.notes).to eq("What a sunny day!")
      expect(result.gender_pref).to eq(1)
      expect(result.age_pref).to eq(4)
    end

    xit "gets all people committed to a run" do
      committers = [(db.create_user({username:"Joan"})).id, (db.create_user({username:"Jane"})).id, (db.create_user({username:"Janet"})).id]
      post = db.create_post({creator_id: committers[0].id, pace:6, committer_ids: committers})
      result = db.get_committed_users(post.id)
      result.count.should eql(3)
      result[1].username.should eql("Jane")
      result[2].username.should eql("Janet")
    end

    xit "gets all people who have attended a run" do
      attendees = [(db.create_user({username:"Mike"})).id, (db.create_user({username:"Moe"})).id, (db.create_user({username:"Marty"})).id]
      post = db.create_post({creator_id: attendees[0].id, pace:3, attend_ids: attendees})
      result db.get_attendees(post.id)
      result[1].username.should eql("Moe")
      result[2].username.should eql("Marty")
    end

    xit "gets all posts" do
        %w{Chicago Austin NYC}.each {|location| db.create_user :location => location }
        result = db.all_posts
        result.count.should eql(3)
        expect(db.all_users.map &:location).to include('A', 'Bob', "NYC")
    end

    xit "deletes old posts" do
      post = %w{Dallas Springfield Austin}.each do |location|
        db.create_user :location => location
      end.last
      post_id = post.id
      db.delete_post(post.id)
      expect(db.get_post(post.id)).to eq(nil)
    end

    xit "filters posts by age preference" do
      %w{0 3 6 3 4}.each {|age| db.create_post :age_pref => age }
      result = db.posts_filter_age(3)
      result.count.should eql(2)
      result[1].age_pref.should eql(3)
    end

    xit "filters posts by gender preference" do
      %w{0 2 0 1 0}.each {|gender| db.create_post :gender_pref => gender }
      result = db.posts_filter_gender(0)
      result.count.should eql(3)
      result[1].gender_pref.should eql(0)
    end

    xit "filters posts by location" do
      %w{Chicago Austin Austin Dallas}.each {|location| db.create_post :location => location }
      result = db.posts_filter_location("Austin")
      result.count.should eql(2)
      result[1].location.should eql("Austin")
    end

    xit "filters posts by pace" do
      %w{2 6 2 5 2 2}.each {|pace| db.create_post :pace => pace }
      result = db.posts_filter_pace()
      result.count.should eql(2)
      result[1].location.should eql("Austin")
    end

    xit "filters posts by time" do
    end

  end

# COMMITMENT TESTS
  describe 'Commitments' do

    before :each do
      @user1 = db.create_user({})
      @post = db.create_post()
    end

    it "creates a commitment with fulfilled set to false" do
      commit = db.create_commitment({user_id: 1, post_id: @post.id, amount: 5.50})
      expect(commit.user_id).to eq(1)
      expect(commit.post_id).to eq(3)
      expect(commit.amount).to eq(5.50)
      # call .last on the end keyword
    end

    it "will not create a commitment without an amount and existing user and post ids" do
      commit = db.create_commitment({user_id: 1})
      expect(commit).to eq(nil)
      commit2 = db.create_commitment({user_id: 1, post_id: 1, amount: 20})
      expect(commit2).to eq(nil)
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

