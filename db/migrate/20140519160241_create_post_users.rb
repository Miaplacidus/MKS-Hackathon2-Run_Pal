class CreatePostUsers < ActiveRecord::Migration
  def change
    create_table :post_users do |t|
      t.belongs_to :post
      t.belongs_to :user
    end
    add_index("post_users", "post_id")
    add_index("post_users", "user_id")
  end
end
