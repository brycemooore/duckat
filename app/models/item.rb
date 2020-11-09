class Item < ApplicationRecord

    belongs_to :seller, class_name: 'User', dependent: :destroy
    has_many :bids 
    has_many :bidders, through: :bids, source: :user, foreign_key: 'buyer_id', class_name: 'User'

    has_many :item_tags
    has_many :tags, through: :item_tags
    
    validates :name, :asking_price, :end_date,  presence: true
    validates :image, presence: false
    validate :valid_asking_price
    # validate :valid_date

    before_save :default_desc

    

    def display_asking_price
        if self.asking_price == 0
            return "Free"
        end
    return self.asking_price
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
end 
