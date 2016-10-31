class AddTitleToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :title, :text
  end
end
