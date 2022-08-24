class CreateChats < ActiveRecord::Migration[5.2]
  def up
    create_table :chats do |t|
      t.integer "number", :null => false
      t.integer "application_id"
      t.integer "messages_count", :null => false, :default => 0
      t.timestamps
    end
    add_index :chats, "application_id"
  end

  def down
    drop_table :chats
  end
end
