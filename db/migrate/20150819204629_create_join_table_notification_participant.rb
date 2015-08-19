class CreateJoinTableNotificationParticipant < ActiveRecord::Migration
  def change
    create_join_table :notifications, :participants do |t|
      # t.index [:notification_id, :participant_id]
      # t.index [:participant_id, :notification_id]
    end
  end
end
