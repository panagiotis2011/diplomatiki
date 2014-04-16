class CreateWritings < ActiveRecord::Migration
  def self.up
    create_table :writings do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.date :writing_date

      t.timestamps
    end
   #scope :exercised, lambda { |exercise_id| where("exercise_id = ?", exercise_id)}
  end

  def self.down
    drop_table :writings
  end
end
