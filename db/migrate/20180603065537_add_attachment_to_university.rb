class AddAttachmentToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_attachment :universities, :logo
  end
end
