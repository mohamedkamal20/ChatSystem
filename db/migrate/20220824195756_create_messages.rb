class CreateMessages < ActiveRecord::Migration[5.2]
  def up
    create_table :messages do |t|
      t.integer "number", :null => false
      t.integer "chat_id"
      t.string "message", :null => false, :limit => 500
      t.timestamps
    end
    add_index :messages, "chat_id"
  end

  def down
    drop_table :messages
  end
end
