class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages:#{current_user.id}"
    puts "Subscribed to the channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message_notification
    puts "******* send_message_notification ********"
    TutorMailer.send_message_notification(current_user).deliver
    return
    # transmit type: 'success', comm_data: {content: 'Email Sent'}
  end

end
