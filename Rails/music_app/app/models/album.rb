class Album < ApplicationRecord

    belongs_to :band
    has_many :tracks
    
end
