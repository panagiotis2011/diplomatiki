class RemoveFbStudentUidFromStudent < ActiveRecord::Migration
  def self.up
    remove_column :students, :fb_student_uid
  end

  def self.down
    add_column :students, :fb_student_uid, :integer
  end
end
