# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
  SELECT
    DISTINCT a.yr
  FROM (
    SELECT 
      *
    FROM
      nobels
    WHERE subject = 'Physics'
  ) a
  LEFT JOIN (
    SELECT
      *
    FROM
      nobels
    WHERE subject = 'Chemistry'
  ) b
  ON a.yr = b.yr
  WHERE b.subject is null
  SQL
end
