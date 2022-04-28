class Application < ApplicationRecord
	has_many :chats
	validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50, minimum: 3}
end
