class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.integer :student_id, :null => false        #ξένο κλειδί για τον πίνακα Lesson

      t.string :title, :null => false
      t.string :message
      t.text :body, :null => false
      t.text :freezebody                                        # κατά την αποδοχή ενός άρθου το κύριο μέρος του άρθου body αντιγράφεται σε αυτό το πεδίο
      t.integer :state, :null => false, :default => 0           # 0...draft, 1...submitted, 2...rejected, 3...full article, 4...featured article
      t.string :message                                         # μήνυμα στον φοιτητή για την απόρριψη του άρθρου
      t.date :submitted
      t.date :accepted

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
