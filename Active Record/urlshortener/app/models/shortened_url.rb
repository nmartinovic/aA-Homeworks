require 'securerandom'

class Shortened_Url < ApplicationRecord
    # validates :email, presence: true, uniqueness: true

    validates :long_url, presence:true
    validates :short_url, presence: true, uniqueness: true
    validate :no_spamming, :nonpremium_max

    def self.prune(min)
        # deletes shortened_urls that have not been visited in n minutes
        # delete shortened_urls that are older than n minutes but have never been visited
        Shortened_Url.all.joins("FULL JOIN visits on shortened_urls.short_url = visits.shortened_url").where('visits.updated_at < ? or visits.id is ?', 1.minutes.ago, nil).destroy_all
    end

    def self.random_code
        surl = SecureRandom.urlsafe_base64(6)
        until Shortened_Url.exists?(short_url: surl) == false
            surl = SecureRandom.urlsafe_base64(6)
        end
        surl
    end

    def no_spamming
        if self.submitter.submitted_urls.where('created_at > ?',1.minutes.ago).count(:long_url) >=1
            errors[:short_url] << "User has submitted too many URLs in 1 minute"
        end
    end

    def nonpremium_max
        if self.submitter.submitted_urls.count(:long_url) >= 5 and self.submitter.premium == false
            errors.add(:user_id, "can't have more than 5 urls")
        end

    end

    def self.create!(user, lurl)
        Shortened_Url.new(long_url: lurl, short_url: Shortened_Url.random_code,user_id: user.id).save!

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
        dependent: :destroy,
        #Proc.new { distinct },
        class_name: 'Visit',
        foreign_key: :shortened_url,
        primary_key: :short_url
    )

    has_many(
        :clicks,
        dependent: :destroy,
        class_name: 'Visit',
        foreign_key: :shortened_url,
        primary_key: :short_url
    )

    has_many(
        :tags,
        dependent: :destroy,
        class_name: 'Tagging',
        foreign_key: :long_url,
        primary_key: :long_url
    )

end