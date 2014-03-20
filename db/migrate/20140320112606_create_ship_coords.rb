class CreateShipCoords < ActiveRecord::Migration
  def change
    create_table :ship_coords do |t|
      t.integer :coord
      t.integer :player_id
    end
  end
end
