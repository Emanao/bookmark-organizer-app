class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :url
      t.integer :user_id
    end
  end
end
