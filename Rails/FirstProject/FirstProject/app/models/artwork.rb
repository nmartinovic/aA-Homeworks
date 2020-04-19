# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    #validates :username, presence: true, uniqueness: true
    validates :title, uniqueness: {scope: :artist_id}

    belongs_to :artist,
    class_name: :User,
    foreign_key: :artist_id,
    primary_key: :id

    has_many :shares,
    class_name: :ArtworkShare,
    foreign_key: :artwork_id,
    primary_key: :id

    has_many :viewers,
    through: :shares,
    source: :viewer
end
