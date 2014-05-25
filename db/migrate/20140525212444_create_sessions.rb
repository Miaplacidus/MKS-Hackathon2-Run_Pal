class CreateSessions < ActiveRecord::Migration
  def change
     create_table :sessions do |t|
      t.string :session_key
      t.integer :user_id

      t.timestamps
    end
  end
end
