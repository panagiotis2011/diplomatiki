class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      #t.encryptable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :time
      # t.token_authenticatable

      t.string :fullname
      t.text :shortbio
      t.string :weburl, :default => 'www.facebook.com/eap.edu'
      t.integer :lesson_id, :null => false, :default => 1  #ξένο κλειδί για τον πίνακα Lesson

      t.timestamps
    end

    add_index :users, :fullname
    add_index :users, :lesson_id
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    ## add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
