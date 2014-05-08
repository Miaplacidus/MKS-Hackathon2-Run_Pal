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
        @commits = {} # Key: commit_id, Value: commitment_obj
        @posts = {} # Key: post_id, Value: post_obj
        @users = {} # Key: user_id, Value: user_obj
        @wallets = {} # Key: user_id, Value: wallet_obj
      end

      def create_challenge(attrs)
        cid = @challenge_id_counter+=1
        pid = @post_id_counter+=1
        post_attrs = attrs.clone
        post_attrs[:id] = pid
        RunPal::Post.new(attrs)
        @posts[pid] = attrs

        attrs[:id] = cid
        attrs[:post_id] = pid
        challenge = RunPal::Challenge.new(attrs).tap{|challenge| @challenges[cid] = challenge}
        challenge
      end

      def get_challenge(id)
        @challenges[id]
      end

      def get_circle_challenges(circle_id)
        challenge_arr = []
        @challenges.each do |challenge|
          if challenge.sender_id == circle_id || challenge.recipient_id == circle_id
            challenge_arr << challenge
          end
        end
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

      def delete_challenge(id)
        @challenges.delete(id)
      end

      def create_circle(attrs)
        id = @circle_id_counter+=1
        attrs[:id] = id
        circle = RunPal::Circle.new(attrs)
        @circles[id] = attrs
        circle
      end

      def get_circle(id)
        attrs = @circles[id]
        RunPal::Circle.new(attrs)
      end

# #######################################################
      # c = db.get_circle(5)
      # c.size = 9

      # c2 = db.get_circle(5)
      # c2.size == 5

      # db.update_circle_a(89, :size => 9, :radius => 3)
      def update_circle_a(circle_id, attrs)
        # Grab the circle data hash by the circle_id
        # Merge in the changes (attrs)
        circle_attrs = @circle[circle_id]
        # circle_attrs[:size] = attrs[:size] if attrs[:size]
        # circle_attrs[:radius] = attrs[:radius] if attrs[:radius]
        circle_attrs.merge!(attrs)
      end


      # db.update_circle_b(circle)
      def update_circle_b(circle)
        # Grab the circle data hash by the circle.id
        # Merge in the changes (circle attributes)
        circle_attrs = @circle[circle.id]
        circle_attrs[:size] = circle.size
        circle_attrs[:radius] = circle.radius
      end

##########################################################
      def all_circles
        @circles.values
      end

      def circles_filter_location(user_loc, radius)
         mi_to_km = 1.60934
        earth_radius = 6371
        post_arr = []
        radius = radius * mi_to_km
        @circles.each do |cid, circle|
          loc_arr = post.location
          distance = Math.acos(Math.sin(user_loc[0]) * Math.sin(loc_arr[0]) + Math.cos(user_loc[0]) * Math.cos(loc_arr[0]) * Math.cos(loc_arr[1] - user_loc[1])) * earth_radius
          if distance <= radius
            circle_arr << circle
          end
        end
        circle
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

      def get_commit(id)
        @commits[id]
      end

      def get_user_commit(user_id)
        commit_arr = []
        @commits.each do |cid, commit|
          if commit.user_id == user_id
            commit_arr << commit
          end
        end
        commit_arr
      end

      def update_commit(id, attrs)
         if @commits[id]
          attrs.each do |key, value|
            setter = "#{key}="
            @commits[id].send(setter, value) if @commits[id].class.method_defined?(setter)
          end
        end
        @commits[id]
      end


      # ^^^IFU^^^

      # TEMPLATE
      # def create_circle(attrs)
      #   id = @circle_id_counter+=1
      #   attrs[:id] = id
      #   circle = RunPal::Circle.new(attrs)
      #   @circles[id] = attrs
      #   circle
      # end
      # binding.pry
      # def create_post(attrs)
      #   id = @post_id_counter+=1
      #   attrs[:id] = id
      #   RunPal::Post.new(attrs).tap{|post| @posts[id] = post}
      # end

      # @posts = {
      #   1 => post_obj1,
      #   2 => post_obj2
      # }

      # post = create_post(attrs) # id is 1, pace is 2
      # retrieved_post = get_post(1)
      # retrieved_post.pace # 2

      # post.pace = 3 # same as doing post_obj1.pace = 3
      # retrieved_post_2 = get_post(1)
      # post.pace # 3
      # # never had to run the update method to change the post attributes

      def create_post(attrs)
        id = @post_id_counter+=1
        attrs[:id] = id
        @posts[id] = attrs
        post = RunPal::Post.new(attrs)
        post
      end

      # @posts = {
      #   1 => post_obj1_attrs_hash,
      #   2 => post_obj2_attrs_hash
      # }

      # post = create_post(attrs) # id is 1, pace is 2
      # retrieved_post = get_post(1)
      # retrieved_post.pace # 2

      # post.pace = 3
      # retrieved_post_2 = get_post(1)
      # post.pace # 2

      def get_post(id)
        post_attrs = @posts[id]
        Post.new(post_attrs)
      end

      def get_circle_posts(circle_id)
        post_arr = []
        @posts.each do |pid, post|
          if post.circle_id == circle_id
            post_arr << post
          end
        end
        post_arr
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
        post_attrs = @posts[id]
        post_attrs.merge!(attrs)
      end

      def delete_post(id)
        @posts.delete(id)
      end

      def posts_filter_age(age)
        post_objects = @posts.values
        posts_with_correct_age = post_objects.select do |post|
          post.age_pref == age
        end
        posts_with_correct_age
      end

      def posts_filter_gender(gender)
        post_objects = @posts.values
        posts_with_correct_gender = post_objects.select do |post|
          post.gender_pref == gender
        end
        posts_with_correct_gender
      end

      def posts_filter_location(user_loc, radius)
        mi_to_km = 1.60934
        earth_radius = 6371
        post_arr = []
        radius = radius * mi_to_km
        @posts.each do |pid, post|
          loc_arr = post.location
          distance = Math.acos(Math.sin(user_loc[0]) * Math.sin(loc_arr[0]) + Math.cos(user_loc[0]) * Math.cos(loc_arr[0]) * Math.cos(loc_arr[1] - user_loc[1])) * earth_radius
        # acos(sin(1.3963) * sin(Lat) + cos(1.3963) * cos(Lat) * cos(Lon - (-0.6981))) * 6371 <= 1000
          if distance <= radius
            post_arr << post
          end
        end
        post_arr
      end

      def posts_filter_pace(pace)
        post_objects = @posts.values
        post_objects.select do |post|
          post.pace == pace
        end
      end

      def posts_filter_time(start_time, end_time)
        post_objects = @posts.values
        post_objects.select do |post|
          start_time < post.time && post.time < end_time
        end
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
