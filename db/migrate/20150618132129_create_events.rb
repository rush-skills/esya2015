class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :category
      t.text :rules
      t.text :judging
      t.datetime :event_date_time
      t.integer :team_size
      t.string :venue
      t.string :eligibilty
      t.datetime :registration_deadline
      t.text :prizes
      t.text :contact
      t.string :photo

      t.timestamps
    end
  end
end
