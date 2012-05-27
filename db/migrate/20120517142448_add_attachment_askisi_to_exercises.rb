class AddAttachmentAskisiToExercises < ActiveRecord::Migration
  def self.up
    add_column :exercises, :askisi_file_name, :string
    add_column :exercises, :askisi_content_type, :string
    add_column :exercises, :askisi_file_size, :integer
    add_column :exercises, :askisi_updated_at, :datetime
  end

  def self.down
    remove_column :exercises, :askisi_file_name
    remove_column :exercises, :askisi_content_type
    remove_column :exercises, :askisi_file_size
    remove_column :exercises, :askisi_updated_at
  end
end
