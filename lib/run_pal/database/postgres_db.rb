module RunPal
  module Database
    class PostgresDB

       def initialize
        ActiveRecord::Base.establish_connection(
          YAML.load_file("db/config.yml")["test"]
        )
      end

      def clear_everything
        Circle.destroy_all
        Challenge.destroy_all
        Commitment.destroy_all
        Post.destroy_all
        User.destroy_all
        Wallet.destroy_all
      end

      class Circle < ActiveRecord::Base
        # Differentiate between reg users and administrator
        belongs_to :admin, class_name:"User", foreign_key:"admin_id"

        has_many :circle_users
        has_many :users, :through => :circle_users

        has_many :posts

        has_many :sent_challenges, class_name: "Challenge", foreign_key:"sender_id"
        has_many :received_challenges, class_name: "Challenge", foreign_key:"recipient_id"
      end

      class Challenge < ActiveRecord::Base
        has_one :post

        # Differentiate between sender and recipient
        belongs_to :sender, class_name: "Circle", foreign_key: "sender_id"
        belongs_to :recipient, class_name: "Circle", foreign_key: "recipient_id"
      end

      class Commitment < ActiveRecord::Base
        belongs_to :post
        belongs_to :user
      end

      class User < ActiveRecord::Base
        has_many :adm_circles, class_name:"Circle"

        has_many :circle_users
        has_many :circles, :through => :circle_users

        has_many :commitments

        has_many :created_posts, class_name:"Posts", foreign_key:"creator_id"

        has_many :post_users
        has_many :posts, :through => :post_users

        has_one :wallet
      end

      class Wallet < ActiveRecord::Base
        belongs_to :user
      end

      class CircleUsers < ActiveRecord::Base
        belongs_to :circle
        belongs_to :user
      end

      class Post < ActiveRecord::Base
        has_many :commitments

        belongs_to :challenge
        # differentiate between creator and committers
        belongs_to :creator, class_name:"User", foreign_key:"creator_id"

        has_many :post_users
        has_many :users, :through => :post_users

        belongs_to :circle
      end

      class PostUsers < ActiveRecord::Base
        belongs_to :post
        belongs_to :user
      end

      def create_challenge(attrs)
        post_attrs = attrs.clone

        post_attrs.delete_if do |name, value|
          setter = "#{name}"
          !RunPal::Post.method_defined?(setter)
        end

        ar_post = Post.create(post_attrs)

        attrs.delete_if do |name, value|
          setter = "#{name}"
          !RunPal::Challenge.method_defined?(setter)
        end

        attrs.merge!({post_id: ar_post.id})
        ar_challenge = Challenge.create(attrs)
        RunPal::Challenge.new(ar_challenge.attributes)
      end

      def get_challenge(id)
        ar_challenge = Challenge.where(id: id).first
        return nil if ar_challenge == nil
        RunPal::Challenge.new(ar_challenge.attributes)
      end

      def get_circle_sent_challenges(circle_id)
        ar_circle = Circle.where(id: circle_id).first
        sent_chal = ar_circle.sent_challenges.order(:created_at)
      end

      def get_circle_rec_challenges(circle_id)
        ar_circle = Circle.where(id: circle_id).first
        received_chal = ar_circle.received_challenges.order(:created_at)
      end

      def delete_challenge(id)
        Challenge.where(id: id).first.delete
      end

      def create_circle(attrs)
        members = attrs[:member_ids]
        attrs.delete(:member_ids)
        ar_circle = Circle.create(attrs)

        members.each do |uid|
          CircleUsers.create(circle_id: ar_circle.id, user_id: uid )
        end

        ar_members = CircleUsers.where(circle_id: ar_circle.id)

        attrs_w_members = ar_circle.attributes
        attrs_w_members[:member_ids] = ar_members

        RunPal::Circle.new(attrs_w_members)
      end

      def get_circle(id)
        ar_circle = Circle.where(id: id).first
        return nil if ar_circle == nil
        RunPal::Circle.new(ar_circle.attributes)
      end

      def get_circle_names

      end

      def all_circles
        ar_circles = Circle.all

        ar_circles.map do |ar_circle|
          RunPal::Circle.new(ar_circle.attributes)
        end
      end

      def create_commit(attrs)
        ar_commit = Commitment.create(attrs)
        RunPal::Commitment.new(ar_commit.attributes)
      end

      def get_commit(id)
        ar_commit = Commitment.where(id: id).first
        return nil if ar_commit == nil
        RunPal::Commitment.new(ar_commit.attributes)
      end

      def get_commits_by_user(user_id)
        ar_commits = Commitment.where(user_id: user_id)
      end

      def create_post(attrs)
        ar_post = Post.create(attrs)
        RunPal::Post.new(ar_post.attributes)
      end

      def get_post(id)
        ar_post = Post.where(id: id).first
        return nil if ar_post == nil
        RunPal::Post.new(ar_post.attributes)
      end

      def get_circle_posts(circle_id)
        ar_circle = Circle.where(id: circle_id).first
        ar_circle.posts
      end

      def all_posts
        ar_posts = Post.all

        ar_posts.map do |ar_post|
          RunPal::Post.new(ar_post.attributes)
        end
      end

      def get_committed_users(post_id)
        ar_post = Post.where(id: post_id).first
        ar_commits = ar_post.commitments

        commit_arr = ar_commits.map do |ar_commit|
          RunPal::Commitment.new(ar_commit.attributes)
        end

        commit_arr.map &:user_id
      end

      def get_attendees(post_id)
        ar_post = Post.where(id: post_id).first
        ar_commits = ar_post.commitments.where(fulfilled: true)

        commit_arr = ar_commits.map do |ar_commit|
          RunPal::Commitment.new(ar_commit.attributes)
        end

        commit_arr.map &:user_id
      end

      def create_user(attrs)
        ar_user = User.create(attrs)
        RunPal::User.new(ar_user.attributes)
      end

      def get_user(id)
        ar_user = User.where(id: id).first
        return nil if ar_user == nil
        RunPal::User.new(ar_user.attributes)
      end

      def delete_user(id)
        User.where(id: id).first.delete
      end

      def create_wallet(attrs)
        ar_wallet = Wallet.create(attrs)
        RunPal::Wallet.new(ar_wallet.attributes)
      end

      def get_wallet_by_userid(user_id)
        ar_wallet = Wallet.where(user_id: user_id).first
        return nil if ar_wallet == nil
        RunPal::Wallet.new(ar_wallet.attributes)
      end

      def delete_wallet(user_id)
        ar_wallet = Wallet.where(user_id: user_id).first.delete
      end


    end
  end
end
