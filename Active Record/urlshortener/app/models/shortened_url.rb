require 'securerandom'

class Shortened_Url < ApplicationRecord
    # validates :email, presence: true, uniqueness: true

    validates :long_url, presence:true
    validates :short_url, presence: true, uniqueness: true

    def self.random_code
        surl = SecureRandom.urlsafe_base64(6)
        until Shortened_Url.exists?(short_url: surl) == false
            surl = SecureRandom.urlsafe_base64(6)
        end
        surl
    end

    def self.create!(user, lurl)
        Shortened_Url.new(long_url: lurl, short_url: Shortened_Url.random_code,user_id: user.id).save

    end

    def num_clicks
        clicks.count(:user_id)
    end

    def num_uniques
        visitors.count(:user_id).distinct
    end

    def num_recent_uniques
        visitors.where('updated_at > ?',10.minutes.ago).count(:user_id)
    end

    belongs_to(
        :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visitors,
        Proc.new { distinct },
        class_name: 'Visit',
        foreign_key: :shortened_url,
        primary_key: :short_url
    )

    has_many(
        :clicks,
        class_name: 'Visit',
        foreign_key: :shortened_url,
        primary_key: :short_url
    )

    has_many(
        :tags,
        class_name: 'Tagging',
        foreign_key: :long_url,
        primary_key: :long_url
    )

end