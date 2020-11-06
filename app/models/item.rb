class Item < ApplicationRecord

    belongs_to :seller, class_name: 'User', dependent: :destroy
    has_many :bids 
    has_many :bidders, through: :bids, source: :user, foreign_key: 'buyer_id', class_name: 'User'
end
