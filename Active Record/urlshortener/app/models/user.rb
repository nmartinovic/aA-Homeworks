class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true

   has_many(
       :submitted_urls,
       class_name: 'Shortened_Url',
       foreign_key: :user_id,
       primary_key: :id
   ) 

   has_many(
       :visited_urls,
       class_name: 'Visit',
       foreign_key: :user_id,
       primary_key: :id
   )
end