require 'elasticsearch'
module Api
	module V1
		class MessagesController < Api::V1::BaseController
			def create
				logger.debug([params])
				@application = Application.where(:token => [params[:application_token]]).first
				@chat = @application.chats.where(:number => [params[:chat_number]]).first
				messages_count = @chat.messages.count
				@message = @chat.messages.create(message_params)
				@message.number = messages_count + 1
				if @message.save
					CountChatMessagesJob.set(wait: 1.minute).perform_later(@application.token, @chat.number)
					client = Elasticsearch::Client.new(
						cloud_id: 'chat_system_test:dXMtY2VudHJhbDEuZ2NwLmNsb3VkLmVzLmlvJDE1M2U1NjMzZjdiZDQ1NDdhOWJkNmM2ZjFhMzRjMTVhJDQ1NmQ1ZTA4ZmUzODQyYzVhN2FkZWM0ODM3NDdiYTNm',
						user: 'elastic',
						password: 'zWZjgNSvSksY9O77zHKn4GPa'
					)
					body = {
						body: @message.body,
						number: @message.number,
						chat_number: @chat.number,
						application_token: @application.token
					}
					client.index(index: 'messages', body: body)
					render json: {
						"success": true,
						"data": @message.as_json(:except => [:id, :chat_id])
					}
				else
					render json:{
						"success": false,
						"errors": @message.errors.full_messages
					}
				end
			end

			def search
				logger.debug([params[:query]])
				client = Elasticsearch::Client.new(
					cloud_id: 'chat_system_test:dXMtY2VudHJhbDEuZ2NwLmNsb3VkLmVzLmlvJDE1M2U1NjMzZjdiZDQ1NDdhOWJkNmM2ZjFhMzRjMTVhJDQ1NmQ1ZTA4ZmUzODQyYzVhN2FkZWM0ODM3NDdiYTNm',
					user: 'elastic',
					password: 'zWZjgNSvSksY9O77zHKn4GPa'
				)

				respones = client.search(index: 'messages', body: { query: { match: { body: params[:query] } } })
				hits = respones['hits']
				hits_array = hits['hits'];
				@messages ||= []
				hits_array.each do |h|
					message = h['_source']
					logger.debug(message);
					@messages << message
				end
				render json:{
					"success": true,
					"data": @messages
				}
			end

			private
			def message_params
				params.require(:message).permit(:body)
			end
			
		end
	end
end
