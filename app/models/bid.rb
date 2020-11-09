class Bid < ApplicationRecord

    belongs_to :user 
    belongs_to :item
    validate :valid_bid
    validates :bid_amount, presence: true

    private
    def valid_bid
        if self.bid_amount && self.bid_amount < 0.0
            self.errors.add(:bid_amount, "must be more than zero buddy :(")
        end 
    end 
end
