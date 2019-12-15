require_relative 'game'


if $PROGRAM_NAME == __FILE__
  game1 = Game.new(["Nick","Erin","Rob"])

  game1.round_of_betting

  game1.round_of_discard

  game1.current_bet = [0]
  game1.current_turn = 0
  game1.round_of_betting
  puts game1.determine_winner

end