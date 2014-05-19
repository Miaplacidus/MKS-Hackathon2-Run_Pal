class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.belongs_to :user
      t.integer :max_members
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
