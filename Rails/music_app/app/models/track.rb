class Track < ApplicationRecord

    belongs_to :album
    has_one :band, through: :album
    has_many :notes
end


# - Taylor Swift (Band)
# ---- Red (Album)
# -------- 22 (Song)
# -------- Begin Again (Song)
# ---- 1989 (Album)
# -------- Shake it off (Song)
# -------- Bad Blood (Song)
# - Tim McGraw (Band)