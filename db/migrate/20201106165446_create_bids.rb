class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :item_id
      t.float :bid_amount

      t.timestamps
    end
  end
end
