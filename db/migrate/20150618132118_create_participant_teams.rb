class CreateParticipantTeams < ActiveRecord::Migration
  def change
    create_table :participant_teams do |t|
      t.references :team, index: true
      t.references :participant, index: true

      t.timestamps
    end
  end
end
