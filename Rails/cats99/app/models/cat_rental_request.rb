
class CatRentalRequest < ApplicationRecord

   STATUS = ['PENDING','APPROVED','DENIED']
    validates :status, inclusion: { in: STATUS}
    validates :cat_id, :start_date, :end_date, :status, presence: true
    validate :does_not_overlap_approved_request


    belongs_to :cat,
    class_name: :Cat,
    foreign_key: :cat_id,
    primary_key: :id


    def overlapping_requests
        #CatRentalRequest.where("start_date between ? and ? or end_date between ? and ?", self.start_date, self.end_date,self.start_date, self.end_date)
        CatRentalRequest.where("((start_date between ? and ?) or (end_date between ? and ?)
        or (start_date < ? and end_date > ?)) and cat_id = ?", self.start_date, self.end_date,self.start_date, self.end_date,self.start_date, self.end_date, self.cat_id)

    end

    def overlapping_approved_requests
        overlapping_requests.where("status = ? and id != ?",'APPROVED',self.id)
    end

    def does_not_overlap_approved_request
        if overlapping_approved_requests.exists?
            errors.add(:start_date, "There is an overlapping request")
        end
    end

    def overlapping_pending_requests
        overlapping_requests.where("status = ?",'PENDING')
    end

    def approve!

        ActiveRecord::Base.transaction do 
            self.status = 'APPROVED'
            to_deny = overlapping_pending_requests.where("id != ?", self.id)
            to_deny.each do |deny|
                deny.status = 'DENIED'
                deny.save!
            end
            self.save!
        end
    end

    def deny!
        self.status = 'DENIED'
        self.save
    end


end
