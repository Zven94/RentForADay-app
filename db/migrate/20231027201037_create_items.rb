class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, limit: 50
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string :city, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
