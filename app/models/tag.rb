class Tag < ApplicationRecord

    has_many :item_tags
    has_many :items, through: :item_tags
    

    before_save :downcase_name

    private 
    def downcase_name
        self.name.downcase!
    end 
end
