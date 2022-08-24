class CreateApplications < ActiveRecord::Migration[5.2]
  def up
    create_table :applications do |t|
      t.string "token", :limit => 250, :null => false
      t.string "application_name", :limit => 100, :null => false
      t.integer "chats_count", :null => false, :default => 0
      t.timestamps
    end
  end

  def down
    drop_table :applications
  end
end
