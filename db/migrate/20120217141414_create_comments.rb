class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :student_id
      t.integer :article_id
      t.string :body, :null => false

      t.timestamps
    end

    add_index :comments, [:student_id, :article_id]
  end

  def self.down
    drop_table :comments
  end
end
