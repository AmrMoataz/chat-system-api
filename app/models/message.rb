class Message < ApplicationRecord
  belongs_to :chat, class_name: "Chat", foreign_key: "chat_id"
  validates :body, presence: true
end
