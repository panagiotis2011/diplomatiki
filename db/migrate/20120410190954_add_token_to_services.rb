class AddTokenToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :token, :string
  end

  def self.down
    remove_column :services, :token
  end
end
