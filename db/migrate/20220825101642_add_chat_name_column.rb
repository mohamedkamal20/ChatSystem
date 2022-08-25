class AddChatNameColumn < ActiveRecord::Migration[5.2]
  def up
    add_column("chats", "chat_name", :string, :limit => 100, :null => false)
  end

  def down
    remove_column("chats", "chat_name")
  end
end
