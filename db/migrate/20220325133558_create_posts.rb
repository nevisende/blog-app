class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :comments_counter
      t.integer :likes_counter
      t.text :text
      t.string :title
      t.timestamps
    end

    change_column_default :posts, :posts_counter, 0
    change_column_default :posts, :likes_counter, 0
  end
end
