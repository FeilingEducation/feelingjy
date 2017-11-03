class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages:#{current_user.id}"
    puts "Subscribed to the channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
