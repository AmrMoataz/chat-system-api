class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @application = Application.where(:token => args[0]).first
    logger.debug(@application)
    chats_count = @application.chats.count
    @chat = @application.chats.new
    @chat.number = chats_count + 1;
    if @chat.save
      CountApplicationChatsJob.set(wait: 1.minute).perform_later @application.token
    end
end
