class AddImageToStaticPage < ActiveRecord::Migration
  def change
    add_column :static_pages, :image, :string
  end
end
