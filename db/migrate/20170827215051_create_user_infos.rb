class CreateUserInfos < ActiveRecord::Migration[5.1]

  def change
    create_table :user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :city
      t.text :about
      t.timestamps
    end
  end
end
