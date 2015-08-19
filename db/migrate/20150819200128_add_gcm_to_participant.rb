class AddGcmToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :gcm_token, :string
  end
end
