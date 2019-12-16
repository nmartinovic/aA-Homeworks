require_relative 'deck'
require_relative 'player'


class Game

    attr_reader :deck, :players, :current_pot, :current_turn, :current_bet
    attr_writer :current_pot, :current_bet, :current_turn

    def initialize(players)
        @deck = Deck.new
        @players = []
        players.each do |player|
            @players << Player.new(player,100,self)
        end

        @current_pot = 0
        @current_bet = [0]
        @current_turn = 0
        create_hands

    end

    def next_turn
        @current_turn += 1
        if @current_turn >= @players.length
            @current_turn = @current_turn % @players.length
        end
        until @players[@current_turn].in_hand == true
            @current_turn += 1
            if @current_turn >= @players.length
                @current_turn = @current_turn % @players.length
            end
        end
        @current_turn
    end

    def turn
        @players[@current_turn].hand.hand_sort
        puts "#{@players[current_turn].name}, it is your turn.  Bet, call or fold?  The pot is #{@current_pot} and the current_bet is #{@current_bet[0]}.  Your bank is #{@players[@current_turn].pot}"
        puts @players[@current_turn].render
        @players[@current_turn].player_action
        system("clear")
        next_turn
    end

    def create_hands
        while @players[-1].hand.hand.length < 5
            @players[@current_turn].hand.add_card_to_hand(@deck.deal_one)
            next_turn
        end
    end

    def display_current_hand
        @players[@current_turn].render
    end


    def determine_winner
        best_hand = 0
        winner = nil
        hand = nil
        player_i_winner = nil
        @players.each_with_index do |player, index|
            if player.in_hand == true && player.hand.hand_value > best_hand
                best_hand = player.hand.hand_value
                winner = player.name
                hand = player.render
                player_i_winner = index
            end
        end
        [winner, hand, player_i_winner]

    end

    def round_of_betting
        @current_bet[0] = 0
        @current_turn = 0
        @players.each do |player|
            if player.in_hand == true
                turn
            end
        end

        until @players.all? { |player| player.bet == @current_bet }
            turn
            
        end

    end

    def round_of_discard
        @players.each do |player|
            if player.in_hand == true
                player.discard_cards
            end
        end

        @players.each do |player|
            if player.in_hand == true
                while player.hand.hand.length < 5
                    player.hand.add_card_to_hand(@deck.deal_one)
                end
            end
        end

    end

    def leaderboard
        puts "Current Bank"

        @players.each do |player|
            puts "#{player.name}: #{player.pot}"    
        end

    end

    def new_round
        @Deck = Deck.new
        @players.each do |player|
            player.bet = []
        end
        @current_pot = 0
        @current_bet = [0]

    end
end