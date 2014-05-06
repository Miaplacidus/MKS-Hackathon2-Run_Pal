module RunPal
  module Database

    class InMemory
      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @challenge_id_counter = 0
        @circle_id_counter = 0
        @commitment_id_counter = 0
        @post_id_counter = 0
        @user_id_counter = 0
        @wallet_id_counter = 0
        @challenges = {} #Key: challenge_id, Value: challenge_obj
        @circles = {} # Key: circle_id, Value: circle_obj
        @commitments = {} # Key: user_id, Value: commitment_obj
        @posts = {} # Key: user_id, Value: post_obj
        @users = {} # Key: user_id, Value: user_obj
        @wallets = {} # Key: user_id, Value: wallet_obj
      end

      def create_challenge(attrs)
        # post = RunPal::Post.new({creator_id: attrs[:creator_id], time: attrs[:time], location: attrs[:location], pace: attrs[:pace], notes: attrs[:notes], age_pref: 0, gender_pref: 0, circle_id: attrs[:circle_id], min_amt: 0, committer_ids: []})
        # challenge = RunPal::Challenge.new(name: attrs[:name], sender_id:attrs[], recipient_id: attrs[:recipient_id], post_id: attrs[:post_id])
      end

      def get_challenge(id)
      end

      def update_challenge(attrs)
      end

      def create_circle(attrs)
        id = @circle_id_counter+=1
        attrs[:id] = id
        RunPal::Circle.new(attrs).tap{|circle| @circles[id] = circle}
      end

      def get_circle(id)
        @circles[id]
      end

      def all_circles
        @circles.values
      end

      def circles_filter_location(location)
      end

      def circles_filter_full
      end

      def update_circle(id, attrs)
        if @circles[id]
          attrs.each do |key, value|
            setter = "#{key}="
            @circles[id].send(setter, value) if @circles[id].class.method_defined?(setter)
          end
        end
        @circles[id]
      end

      def create_commit(attrs)

      end

      def get_commit(id)
      end

      def get_user_commit(user_id)
      end

      def update_commit(id, updates)
      end

      def create_post(attrs)
        id = @post_id_counter+=1
        attrs[:id] = id
        RunPal::Post.new(attrs).tap{|post| @posts[id] = post}
      end

      def create_circle_post(circle_id)
      end

      def get_post(attrs)
      end

      def all_posts(attrs)
      end

      def get_committed_users(post_id)
      end

      def get_attendees(post_id)
      end

      def update_post(id, updates)
      end

      def delete_old_posts
        # delete posts older than 1 year
      end
      def posts_filter_age(age)
      end

      def posts_filter_gender(gender)
      end

      def posts_filter_location(location)
      end

      def posts_filter_pace(pace)
      end

      def posts_filter_time(start_time, end_time)
      end

      def create_user(attrs)
        id = @user_id_counter+=1
        attrs[:id] = id
        RunPal::User.new(attrs).tap{|user| @users[id] = user}
      end

      def get_user(id)
        @users[id]
      end

      def all_users
        @users.values
      end

      def update_user(id, attrs)
        if @users[id]
          attrs.each do |key, value|
            setter = "#{key}="
            @users[id].send(setter, value) if @users[id].class.method_defined?(setter)
          end
        end
        @users[id]
      end

      def delete_user(id)
        @users.delete(id)
      end

      def create_wallet(attrs)
        id = @wallet_id_counter+=1
        attrs[:id] = id
        RunPal::Wallet.new(attrs).tap{|wallet| @wallets[id] = wallet}
      end

      def get_wallet(id)
      end

      def get_user_wallet(user_id)
      end

      def update_wallet(user_id, attrs)
         if @wallets[id]
          attrs.each do |key, value|
            setter = "#{key}="
            @wallets[id].send(setter, value) if @wallets[id].class.method_defined?(setter)
          end
        end
        @wallets[id]
      end

      def delete_wallet(id)
      end

    end

  end
end
