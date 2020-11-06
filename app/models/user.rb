class User < ApplicationRecord

    has_many :items, foreign_key: 'seller_id', class_name: 'Item'
    has_many :bids, foreign_key: 'bidder_id', class_name: 'Bid'
    has_many :bidded_items, through: :bids, source: :item

    def add_item(name, desc, price, date)
        Item.create(seller_id: self.id, name: name, description: desc, asking_price: price, 
        end_date: date)
    end 

    def make_bid(item, amount)
        Bid.create(user_id: self.id, item_id: item.id, bid_amount: amount)
    end 


end
