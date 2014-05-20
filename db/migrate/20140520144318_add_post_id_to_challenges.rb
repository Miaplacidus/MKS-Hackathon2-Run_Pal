class AddPostIdToChallenges < ActiveRecord::Migration
  def change
    add_column("challenges", "post_id", :integer)
    add_index("challenges", "post_id")
  end
end
