class AddUrlToSponsor < ActiveRecord::Migration
  def change
    add_column :sponsors, :url, :string
  end
end
