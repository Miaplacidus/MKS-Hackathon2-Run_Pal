class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
