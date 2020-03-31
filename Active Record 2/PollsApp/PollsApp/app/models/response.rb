# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  answer_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Response < ApplicationRecord

    belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_id


    belongs_to :respondent,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

    has_one :question,
    through: :answer_choice,
    source: :question

    def sibling_responses
        self.question.responses.where.not("responses.id = ?", self.id)
    end

    def respondent_already_answered?

    end
end
