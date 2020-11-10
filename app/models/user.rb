class User < ApplicationRecord

    has_many :items, foreign_key: 'seller_id', class_name: 'Item'
    has_many :bids, foreign_key: 'bidder_id', class_name: 'Bid'
    has_many :bidded_items, through: :bids, source: :item

    # before_create :default_values
    before_save :round_balance

    validates :username, uniqueness: true, presence: true

    has_secure_password

    def add_item(name, desc, price, date, image)
        Item.create(seller_id: self.id, name: name, description: desc, asking_price: price, 
        end_date: date, image: image)
    end 

    def make_bid(item, amount)
        Bid.create(user_id: self.id, item_id: item.id, bid_amount: amount)
    end 

    private
    def default_values
        self.balance = 0.00
    end 

    def round_balance 
        self.balance = self.balance.round(2)
    end 

end
