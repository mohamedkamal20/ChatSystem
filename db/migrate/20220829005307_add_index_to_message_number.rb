class AddIndexToMessageNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, :number
  end
end
