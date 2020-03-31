# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{username: 'nmartinovic'}, {username: 'eodwyer'}])
polls = Poll.create([{title:'nmartinovic poll 1',user_id: User.first.id},{title:'eodwyer poll 1',user_id: User.last.id}])
questions = Question.create([{text: "What is 2+2?",poll_id: Poll.first.id},{text: "What color is red + yellow?",poll_id: Poll.last.id}])

answerchoices = AnswerChoice.create([{question_id:Question.first.id,text:'4'},{question_id:Question.first.id,text:'2'},{question_id:Question.first.id,text:'0'},
{question_id:Question.last.id,text:'blue'},{question_id:Question.last.id,text:'black'},{question_id:Question.last.id,text:'orange'}])


responses = Response.create([{answer_id:AnswerChoice.first.id, user_id: User.first.id},{answer_id:AnswerChoice.last.id, user_id: User.first.id}])