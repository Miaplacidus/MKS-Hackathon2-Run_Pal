class RemoveChallengeIdFromPosts < ActiveRecord::Migration
  def change
    remove_column("posts", "challenge_id")
  end
end
