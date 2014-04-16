class CreateExercises < ActiveRecord::Migration
  def self.up
    create_table :exercises do |t|
      t.string :etitle
      t.text :ebody
      t.decimal :average, :precision => 3, :scale =>1

      t.timestamps
    end
  end

  def self.down
    drop_table :exercises
  end
end
