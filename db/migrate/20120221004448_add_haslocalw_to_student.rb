class AddHaslocalwToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :Haslocalw, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :students, :Haslocalw
  end
end
