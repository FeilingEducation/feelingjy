class MessageJob < ApplicationJob
  queue_as :default

  def perform(message)
     html = ApplicationController.render partial: "messages/message", locals: {message: message}, formats: [:html]
     ActionCable.server.broadcast "messages:#{message.receiver_id}", html: html
   end
end
