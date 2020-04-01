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
    validate :not_duplicate_response, :respondent_cant_answer_own_poll

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
        self.question.responses.where.not(id:self.id)
    end

    def respondent_already_answered?
        sibling_responses.where(user_id:self.user_id).exists?
    end

    def not_duplicate_response
        errors[:duplicate] << "User cannot answer the same question" if self.respondent_already_answered?
    end

    def respondent_is_poll_creator?
        self.question.poll.user_id == self.user_id
    end

    def respondent_cant_answer_own_poll
        errors[:invalid_user] << "User cannot answer their own poll" if self.respondent_is_poll_creator?
    end
end
