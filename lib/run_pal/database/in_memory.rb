module RunPal
  module Database

    class InMemory
      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @challenge_id_counter = 0
        @circle_id_counter = 0
        @commit_id_counter = 0
        @post_id_counter = 0
        @user_id_counter = 0
        @wallet_id_counter = 0
        @challenges = {} #Key: challenge_id, Value: challenge_obj
        @circles = {} # Key: circle_id, Value: circle_obj
        @commits = {} # Key: user_id, Value: commitment_obj
        @posts = {} # Key: post_id, Value: post_obj
        @users = {} # Key: user_id, Value: user_obj
        @wallets = {} # Key: user_id, Value: wallet_obj
      end

      def create_challenge(attrs)
        cid = @challenge_id_counter+=1
        pid = @post_id_counter+=1
        attrs[:id] = pid
        RunPal::Post.new(attrs).tap{|post| @posts[pid] = post}
        attrs[:id] = cid
        attrs[:post_id] = pid
        RunPal::Challenge.new(attrs).tap{|challenge| @challenges[cid] = challenge}
      end

      def get_challenge(id)
        @challenges[id]
      end

      def get_circle_challenges(id)
      end

      def update_challenge(id, attrs)
         if @challenges[id]
          attrs.each do |key, value|
            setter = "#{key}="
            @challenges[id].send(setter, value) if @challenges[id].class.method_defined?(setter)
            @posts[@challenges[id].post_id].send(setter, value) if @posts[@challenges[id].post_id].class.method_defined?(setter)
          end
        end
        @challenges[id]
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
        circle_arr = []
        @circles.each do |cid, circle|
          if circle.member_ids.length < circle.max_members
            circle_arr << circle
          end
        end
        circle_arr
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
        id = @commit_id_counter+=1
        attrs[:id] = id
        RunPal::Commitment.new(attrs).tap{|commit| @commits[id] = commit}
      end

      def get_commit(user_id)

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

      def create_circle_post(circle_id, attrs)
      end

      def get_post(id)
        @posts[id]
      end

      def all_posts
        @posts.values
      end

      def get_committed_users(post_id)
        post = @posts[post_id]
        post.committer_ids
      end

      def get_attendees(post_id)
        post = @posts[post_id]
        post.attend_ids
      end

      def update_post(id, attrs)
        if @posts[id]
          attrs.each do |key, value|
            setter = "#{key}="
            @posts[id].send(setter, value) if @posts[id].class.method_defined?(setter)
          end
        end
        @posts[id]
      end

      def delete_post(id)
        @posts.delete(id)
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
        RunPal::Wallet.new(attrs).tap{|wallet| @wallets[wallet.user_id] = wallet}
      end

      def get_wallet(user_id)
        @wallets[user_id]
      end

      def update_wallet(user_id, attrs)
         if @wallets[user_id]
          attrs.each do |key, value|
            setter = "#{key}="
            @wallets[user_id].send(setter, value) if @wallets[user_id].class.method_defined?(setter)
          end
        end
        @wallets[user_id]
      end

      def delete_wallet(user_id)
        @wallets.delete(user_id)
      end

    end

  end
end
