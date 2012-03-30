class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :student_id, :null => false      # ξένο κλειδί
      t.integer :article_id, :null => false      # ξένο κλειδί
      t.integer :stars

      t.timestamps
    end

    add_index :ratings, :article_id
  end

  def self.down
    drop_table :ratings
  end
end
