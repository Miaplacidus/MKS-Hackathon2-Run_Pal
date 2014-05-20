class AddDescAndLevelToCircles < ActiveRecord::Migration
  def change
    add_column("circles", "description", :text)
    add_column("circles", "level", :integer)
  end
end
