class User < ApplicationRecord

    has_many :items, foreign_key: 'seller_id', class_name: 'Item'
    has_many :bids, foreign_key: 'user_id'
    has_many :bidded_items, through: :bids, source: :item
    has_many :comments
    has_many :comment_items, through: :comments, source: :item

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

    def sorted_bids_asc
        self.bids.sort { |b| b.bid_amount }
    end

    def my_highest_bid
        self.sorted_bids_asc[-1]
    end

    def total_bid
        self.sorted_bids_asc.map do |bid|
            bid.bid_amount
        end.reduce(:+)
    end

    def items_sorted_by_price
        self.items.sort_by { |item| item.asking_price }.reverse
    end

    def most_bids_on_item
        self.items.sort_by do |item| 
            item.bids.count 
        end[-1]
    end

    private
    
    def default_values
        self.balance = 0.00
    end 

    def round_balance 
        self.balance = self.balance.round(2)
    end 

end
