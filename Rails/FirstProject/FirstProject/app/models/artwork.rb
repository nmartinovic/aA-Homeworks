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

    has_many :comments,
    class_name: :Comment,
    foreign_key: :artwork_id,
    primary_key: :id,
    dependent: :destroy

    def self.artworks_for_user_id(user_id)
        Artwork
      .left_outer_joins(:shares)
      .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
      .distinct
  end
end
