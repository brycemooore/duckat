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
    # validate :valid_date

    before_save :default_desc

    accepts_nested_attributes_for :tags 

    
    def display_asking_price
        if self.asking_price == 0
            return "Free"
        end
    return self.asking_price
    end 

    def current_highest_bid
      return 0 unless self.bids.any?
      return self.bids.maximum(:bid_amount)
    end 

    def sorted_bids
      self.bids.sort { |a| a.bid_amount }
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
