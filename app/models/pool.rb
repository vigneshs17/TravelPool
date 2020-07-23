class Pool < ApplicationRecord
    belongs_to :user
    validates :contact, :numericality => {:only_integer => true}, length: { minimum: 10, maximum: 10 }
    scope :filter_by_dest, -> (where) {where where: where}

    def self.search(search)
        if(search)
            where('name LIKE ? OR destination LIKE ?', "%#{search}%", "%#{search}%")
        else
            all
        end
    end
end
