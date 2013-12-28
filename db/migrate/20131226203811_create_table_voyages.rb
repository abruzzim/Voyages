class CreateTableVoyages < ActiveRecord::Migration
  def up
    create_table :voyages do |t|
      t.integer :astronaut_id
      t.integer :planet_id
      t.integer :moon_id
    end
  end

  def down
    drop_table :voyages
  end
end
