class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :seller_id
      t.float :asking_price
      t.date :end_date

      t.timestamps
    end
  end
end
