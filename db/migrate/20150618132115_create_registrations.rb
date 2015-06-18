class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references :participant, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
