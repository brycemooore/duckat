class Item < ApplicationRecord

    belongs_to :seller, class_name: 'User', dependent: :destroy
    has_many :bids 
    has_many :bidders, through: :bids, source: :user, foreign_key: 'buyer_id', class_name: 'User'

    has_many :item_tags
    has_many :tags, through: :item_tags

    has_many :comments
    has_many :users, through: :comments 
    
    validates :name, :asking_price, :end_date,  presence: true
    validates :image, presence: false
    validate :valid_asking_price
    validate :valid_date

    before_save :default_desc

    accepts_nested_attributes_for :tags 

    attr_accessor :bid_accepted

    def initialize(*args)
      super(*args)
      @bid_accepted = false
    end 


    def display_asking_price
        if self.asking_price == 0
            return "Free"
        end
    return self.asking_price
    end 

    def current_highest_bid
      return nil unless self.bids.any?
      return self.bids.order("bid_amount DESC").first
    end 

    def sorted_bids
      self.bids.sort { |a| a.bid_amount }
    end

    def auction_ended?
      self.end_date < Time.now
    end 

    def auction_winner
      if self.auction_ended?
        return User.find(self.current_highest_bid.user_id)
      end
    end 

    def transaction(accepted = true)
      if accepted == false
        winner = self.auction_winner
        self.seller.balance += self.current_highest_bid.bid_amount
        winner.balance -= self.current_highest_bid.bid_amount
        self.seller.save 
        winner.save 
      end 
    end 
 
    private

    def valid_asking_price
        if self.asking_price && asking_price < 0.0
            self.errors.add(:asking_price, 'must be at least free')
        end 
    end

    def default_desc
        if self.description == ''
            self.description = "Non Descript Duck"
        end
    end 

    def valid_date
        if end_date && end_date <= Date.today
          errors.add(:end_date, "must at least be tomorrow")
        end
      end    

    def self.default_pic
      return "https://media.istockphoto.com/photos/rubber-duck-picture-id476147637?k=6&m=476147637&s=612x612&w=0&h=AkhVVp-iQHgQmC9ullv78kYYRDHvPi6QOv8jZFwCRKo="
    end

    def self.no_longer_for_sale
      "https://1.bp.blogspot.com/_9g2caaQ2kgA/TGRjL0ND6sI/AAAAAAAACis/W1K8eilisIo/s320/duck.jpg"
    end
  end 
