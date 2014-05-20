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

      end


    end
  end
end
