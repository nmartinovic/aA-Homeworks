class Track < ApplicationRecord

    belongs_to :album
    has_one :band, through: :album
end
