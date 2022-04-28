class Chat < ApplicationRecord
	belongs_to :application, class_name: "Application", foreign_key: "application_id"
	has_many :messages
end
