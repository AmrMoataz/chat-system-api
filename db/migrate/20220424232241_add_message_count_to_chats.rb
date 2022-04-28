class AddMessageCountToChats < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :message_count, :integer
  end
end
