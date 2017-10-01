class CreateUserDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_documents do |t|
      t.string :file
      t.string :md5
      t.string :doc_type
      t.references :user_info
      t.timestamps
    end
  end
end
