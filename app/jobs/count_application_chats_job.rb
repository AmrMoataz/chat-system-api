class CountApplicationChatsJob < ApplicationJob
  queue_as :default
  def perform(*args)
    logger.debug("Started Application Chat Job")
    @application = Application.where(:token => args[0]).first
    logger.debug("Updating chat counts for application: #{@application.token}")
    chats_count = @application.chats.count
    @application.chat_count = chats_count
    @application.save
    logger.debug("Finished Application Chat Job")
  end
end
