module Api
	module V1
			class ChatsController < Api::V1::BaseController
				def create
					logger.debug([params])
					@application = Application.where(:token => [params[:application_token]]).first
					logger.debug(@application)
					chats_count = @application.chats.count
					@chat = @application.chats.new
					@chat.number = chats_count + 1;
					if @chat.save
						CountApplicationChatsJob.set(wait: 1.minute).perform_later @application.token
						render json: {
							"success": true,
							"data": @chat.as_json(:except => [:id, :application_id])
						}
					else
						render json: {
							"success": false,
							"errors": @chat.errors.full_messages
						}
					end
				end
			
				def index
					logger.debug([params])
					@application = Application.where(:token => [params[:application_token]]).first
					@chats = @application.chats
					render json: {"sucsess": true, "data": @chats.as_json(:except => [:id, :application_id])}
				end
			
				private
				def chat_params
				end
			end
	end
end