class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :student_id, :null => false      # ξένο κλειδί για τον πίνακα Student
      t.integer :question_id, :null => false      # ξένο κλειδί για τον πίνακα Question
      t.integer :stars

      t.timestamps
    end

    add_index :ratings, :question_id
  end

  def self.down
    drop_table :ratings
  end
end
