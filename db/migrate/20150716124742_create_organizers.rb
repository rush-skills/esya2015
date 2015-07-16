class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.string :photo

      t.timestamps null: false
    end
  end
end
