class CreateTableAstronauts < ActiveRecord::Migration
  def up
    create_table :astronauts do |t|
      t.string :fname
      t.string :lname
      t.string :imgsrc
      t.timestamps
    end
  end

  def down
    drop_table :astronauts
  end
end
