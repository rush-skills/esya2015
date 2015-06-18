class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :tid
      t.string :team_name
      t.references :event, index: true

      t.timestamps
    end
  end
end
