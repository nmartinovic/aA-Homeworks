class Visit < ApplicationRecord


    def self.record_visit!(user, surl)
        Visit.new(user_id:user.id, shortened_url:surl).save
    end



end