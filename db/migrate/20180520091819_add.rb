class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :user_wallet_activities, :amount, :float
  end
end
