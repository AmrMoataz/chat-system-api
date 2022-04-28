class AddChatCountToApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :chat_count, :integer
  end
end
