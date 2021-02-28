class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :image
      t.integer :price
      t.string :place
      t.string :genre
      t.string :detail

      t.timestamps
    end
  end
end
