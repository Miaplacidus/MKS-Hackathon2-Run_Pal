module RunPal
  module Database

    class InMemory
      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @circle_id_counter = 0
        @commitment_id_counter = 0
        @post_id_counter = 0
        @user_id_counter = 0
        @wallet_id_counter = 0
        @circles = {} # Key: circle_id, Value: circle_obj
        @commitments = {} # Key: user_id, Value: commitment_obj
        @posts = {} # Key: user_id, Value: post_obj
        @users = {} # Key: user_id, Value: user_obj
        @wallets = {} # Key: user_id, Value: wallet_obj
      end

      def create_circle(attrs)
      end

      def get_circle(id)
      end

      def all_circles
      end

      def circles_filter_location(location)
      end

      def update_circle(id, updates)
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
      end

      def get_user(id)
      end

      def all_users
      end

      def update_user(id, attrs)
      end

      def create_wallet(attrs)
      end

      def get_wallet(id)
      end

      def get_user_wallet(user_id)
      end

      def update_wallet(user_id)
      end

      def delete_wallet(id)
      end

    end

  end
end
