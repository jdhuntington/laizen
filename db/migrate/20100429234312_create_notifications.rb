class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :target_type
      t.boolean :seen, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
