require_relative 'hand'
require_relative 'game'

class Player


    attr_reader :name, :pot, :hand, :in_hand, :game, :bet
    attr_writer :hand, :game, :bet, :pot

    def initialize(name, pot,game_object)
        @name = name
        @pot = pot
        @hand = Hand.new
        @in_hand = true
        @game = game_object
        @bet = []
    end

    def render
        s = ""
        @hand.hand.each do |card|
             s += "#{card.display}#{card.suit} "
        end
        s.strip
    end

    def discard_cards
        cards_to_discard = discard_input.sort! { |a,b| b <=> a}
        
        cards_to_discard.each do |card_index|
            @hand.hand.delete_at(card_index)
        end

        @hand
    end


    def discard_input
        begin
            puts render
            puts "#{@name}, please enter the cards that you would like to discard based on position.  (ex: 0,1,2,3)"
            input = gets.chomp
            input = input.split(",").map {|x| Integer(x)}

            if input.length > 3
                puts "You can only discard a maximum of three cards"
                raise "too many cards error"
            elsif input.empty? || input.all? { |x| x.is_a? Integer }
                return input
            else
                puts "You need to enter it in the correct format"
                raise "format error"
            end
        rescue
            retry
        end

    end

    def player_action
        action, bet_amount = input_action
        if action == 'fold'
            @in_hand = false
            @bet = @game.current_bet
        elsif action == 'call'
            @pot -= bet_amount
            @game.current_pot += bet_amount
            @bet[0] = game.current_bet[0]
        elsif action == 'raise'
            @pot -= bet_amount
            @game.current_pot += bet_amount
            @game.current_bet[0] = bet_amount
            @bet = [bet_amount]
        else 
            puts "you need"
        end

    end

    def input_action
        begin
            puts "Would you like to fold, raise, or call the current bet?  Please enter 'f', 'r', or 'c'"
            input = gets.chomp
            if input == 'f'
                return ['fold',0]
            elsif input == 'r'
                begin
                    puts "How much would you like to raise?"
                    bet_amount = gets.chomp.to_i
                    if bet_amount <= @game.current_bet[0]
                        puts "You must bet more than #{game.current_bet[0]}"
                        raise "Bet amount must be greater than current bet"
                    end
                    if bet_amount > @pot
                        puts "You cannot bet more than what you have.  Please try again"
                        raise "Attempted bet bigger than bank"
                    end
                rescue
                    retry
                end
                return ['raise',bet_amount]
            elsif input == 'c'
                return ['call',@game.current_bet[0]]
            else
                puts "You must enter r, c, or f"
                raise "Wrong input"
            end
        rescue
            retry
        end
    end
end