class AddToUserInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :user_infos, :phone_number, :string
    add_column :user_infos, :wechat_id, :string
    add_column :user_infos, :need_early_consult, :boolean
    add_column :user_infos, :need_essay_consult, :boolean
    add_column :user_infos, :need_brainstorm_consult, :boolean
    add_column :user_infos, :need_visa_consult, :boolean
  end
end
