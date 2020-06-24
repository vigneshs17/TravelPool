class Pool < ApplicationRecord
    belongs_to :user
    validates :contact, :numericality => {:only_integer => true}, length: { minimum: 10, maximum: 10 }
end
