class CountChatMessagesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.debug("Started Chat Messages Job")
    @application = Application.where(:token => args[0]).first
    @chat = @application.chats.where(:number => args[1]).first
    logger.debug("Updating Message counts for application: #{@application.token}, chat number #{@chat.number}")
    messages_count = @chat.messages.count
    @chat.message_count = messages_count
    @chat.save
    logger.debug("Finished Chat Messages Job")
  end
end
