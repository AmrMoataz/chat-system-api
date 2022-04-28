class AddNumberToChats < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :number, :integer
  end
end
