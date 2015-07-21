class CreateCategoriesEvents < ActiveRecord::Migration
  def change
    create_table :categories_events do |t|
      t.references :category, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
    end
  end
end
