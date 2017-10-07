class ChangeUserDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_index :user_documents, :user_info_id
    remove_column :user_documents, :user_info_id, :bigint
    rename_table :user_documents, :attachments
    add_reference :attachments, :attachable, polymorphic: true, index: true
    rename_column :attachments, :doc_type, :file_type
  end
end
