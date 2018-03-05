class CreateBookmarkTags < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmark_tags do |t|
      t.integer :bookmark_id
      t.integer :tag_id
    end
  end
end
