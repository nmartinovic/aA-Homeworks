#work on overlapping requests

class CatRentalRequest < ApplicationRecord

   STATUS = ['PENDING','APPROVED','DENIED']
    validates :status, inclusion: { in: STATUS}
    validates :cat_id, :start_date, :end_date, :status, presence: true


    belongs_to :cat,
    class_name: :Cat,
    foreign_key: :cat_id,
    primary_key: :id


    def overlapping_requests
        #CatRentalRequest.where("start_date > '2020/04/01'")
        #CatRentalRequest.where("start_date between '2020/04/01' and '2020/04/10' and end_date between ")
        CatRentalRequest.where("start_date between ? and ? or end_date between ? and ?", self.start_date, self.end_date,self.start_date, self.end_date)

    end

end
