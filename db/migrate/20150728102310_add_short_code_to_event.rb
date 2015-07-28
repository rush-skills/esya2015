class AddShortCodeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :short_code, :string
    add_index :events, :short_code, :unique => true
  end
end
