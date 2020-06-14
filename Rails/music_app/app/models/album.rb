class Album < ApplicationRecord

    belongs_to :band
    has_many :tracks, dependent: :destroy
    
end
