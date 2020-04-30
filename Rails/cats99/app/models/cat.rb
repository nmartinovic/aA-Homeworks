class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    COLORS = ['black','brown','white','red']
    validates :birth_date, presence: true
    validates :color, inclusion: { in: COLORS}


    has_many :reservations,
    class_name: :CatRentalRequest,
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy


    def age
        age = distance_of_time_in_words_to_now(self.birth_date)
    end

end