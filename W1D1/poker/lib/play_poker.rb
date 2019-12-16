require_relative 'game'


if $PROGRAM_NAME == __FILE__
  game1 = Game.new(["Nick","Erin","Rob"])
  until game1.players.any? { |player| player.pot == 0}
    game1.leaderboard
    game1.round_of_betting
    game1.round_of_discard
    game1.round_of_betting
    puts "#{game1.determine_winner[0]} wins #{game1.current_pot} with #{game1.determine_winner[1]}"  
    game1.players[game1.determine_winner[2]].pot += game1.current_pot
    game1.new_round
  end

end