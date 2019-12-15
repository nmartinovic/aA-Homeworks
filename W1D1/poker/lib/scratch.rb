


class Game

    attr_accessor :bet
    def initialize
        @bet = [0]
    end

end


class Player

    attr_accessor :current_bet, :game
    def initialize(game_object)
        @game = game_object
        @current_bet = @game.bet
    end

end


if $PROGRAM_NAME == __FILE__
    game1 = Game.new
    player1 = Player.new(game1)

    puts "game1 bet = #{game1.bet[0]}"
    puts "player1 current bet = #{player1.current_bet[0]}"
    puts "setting game1.bet to 50"
    game1.bet[0] = 50
    puts "game1 bet = #{game1.bet[0]}"
    puts "player1 current bet = #{player1.current_bet[0]}"
end

# #Results
# game1 bet = 0
# player1 current bet = 0
# setting game1.bet to 50
# game1 bet = 50
# player1 current bet = 0