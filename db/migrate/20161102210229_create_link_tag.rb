class CreateLinkTag < ActiveRecord::Migration[5.0]
  def change
    create_table :link_tags do |t|
      t.references :link, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
