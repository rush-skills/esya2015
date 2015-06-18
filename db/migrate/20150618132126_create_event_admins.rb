class CreateEventAdmins < ActiveRecord::Migration
  def change
    create_table :event_admins do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
