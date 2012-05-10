class AddUserKindToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_kind, :integer, :default => 0
  end

  def self.down
    remove_column :users, :user_kind
  end
end
