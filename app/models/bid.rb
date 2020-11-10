class Bid < ApplicationRecord

    belongs_to :user 
    belongs_to :item
    validate :valid_bid, :validate_bid
    validates :bid_amount, presence: true

    private
    def valid_bid
        if self.bid_amount && self.bid_amount < 0.0
            self.errors.add(:bid_amount, "must be more than zero buddy :(")
        end 
    end 

    def validate_bid
        @item = Item.find(self.item_id)
        if self.bid_amount.to_f <= @item.asking_price
            self.errors.add(:bid_amount, ' must be above highest bid.')
            return false
        elsif User.find(@item.seller_id).balance < self.bid_amount
            self.errors.add(:bid_amount, ' is greater than available balance.')
            return false
        else
            return true
        end
    end
end
