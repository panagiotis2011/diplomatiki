class AddHaslocalpwToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :haslocalpw, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :users, :Haslocalw
  end
end
