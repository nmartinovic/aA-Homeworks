# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord

    has_many :answer_choices,
        class_name: :AnswerChoice,
        primary_key: :id,
        foreign_key: :question_id

    belongs_to :poll,
        class_name: :Poll,
        primary_key: :id,
        foreign_key: :poll_id

    has_many :responses,
    through: :answer_choices,
    source: :responses

    def results_n_plus_one
        answers = self.answer_choices
        results = {}
        answers.each do |answer_option|
            results[answer_option.text] = answer_option.responses.length
        end

        results
    end

    def results_not_plus_1
        answers = self.answer_choices.includes(:responses)
        results = {}
        answers.each do |answer_option|
            results[answer_option.text] = answer_option.responses.length
        end

        results
    end

    def results
        a = Question.left_outer_joins(:responses).where(id:self.id).select("answer_choices.text, COUNT(*)").group("answer_choices.text")
        results = {}
        a.each do |ele|
            results[ele.text] = ele.count
        end
        results
    end
end
