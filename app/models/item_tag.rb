class ItemTag < ApplicationRecord

    belongs_to :item
    belongs_to :tag, dependent: :destroy
    
end
