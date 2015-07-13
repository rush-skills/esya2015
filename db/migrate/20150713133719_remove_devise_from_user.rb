class RemoveDeviseFromUser < ActiveRecord::Migration
  def change
    devise_columns = [:encrypted_password,:reset_password_token,:reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip]

    devise_columns.each do |column|
      remove_column :users, column
    end

    remove_index :users, :name => 'index_users_on_email'
  end
end
