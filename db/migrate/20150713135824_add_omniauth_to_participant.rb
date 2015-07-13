class AddOmniauthToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :uid, :string
    add_column :participants, :provider, :string
  end
end
