class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.string :photo
      t.integer :posts_counter
      t.timestamps
    end

    change_column_default :users, :posts_counter, 0
  end
end
