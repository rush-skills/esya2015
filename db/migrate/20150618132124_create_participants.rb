class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :college

      t.timestamps
    end
  end
end
