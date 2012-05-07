class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :student_id 				#ξένο κλειδί για τον πίνακα Student
      t.integer :question_id				#ξένο κλειδί για τον πίνακα question
      t.string :body, :null => false

      t.timestamps
    end

    add_index :comments, [:student_id, :question_id]
  end

  def self.down
    drop_table :comments
  end
end
