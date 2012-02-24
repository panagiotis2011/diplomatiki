class DeviseCreateStudents < ActiveRecord::Migration
  def self.up
    create_table(:students) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      ##t.encryptable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string :fullname
      t.text :shortbio
      t.string :weburl
      t.integer :lesson_id, :null => false, :default => 1  #ξένο κλειδί για τον πίνακα Lesson

      t.timestamps
    end

    add_index :students, :fullname
    add_index :students, :lesson_id
    add_index :students, :email,                :unique => true
    add_index :students, :reset_password_token, :unique => true
    add_index :students, :confirmation_token,   :unique => true
    # add_index :students, :unlock_token,         :unique => true
    ## add_index :students, :authentication_token, :unique => true
  end

  def self.down
    drop_table :students
  end
end
