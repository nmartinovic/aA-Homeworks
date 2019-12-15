require_relative 'deck'
#TODO: Calculate the value of a hand

class Hand

    HAND_RANKING = ['High Card','Pair','Two Pair','Three of a kind','Straight', 'Flush','Full House','Four of a kind','Straight Flush']

    attr_reader :hand
    def initialize
        @hand = []
    end

    def add_card_to_hand(card)
        @hand << card
    end

    def hand_sort
        @hand.sort! { |a,b| b.value <=> a.value }
    end


    def [](value)
        @hand[value]
    end

    def hand_value
        straight? && flush? ? hand_value = 8000 : hand_value = 0
        flush? && hand_value < 5000 ? hand_value = 5000 : hand_value
        straight? && hand_value < 4000 ? hand_value = 4000 : hand_value
        pairs_value > hand_value ? hand_value = pairs_value : hand_value
        @hand[0].value  > hand_value ? hand_value = @hand[0].value : hand_value
    end

    def flush?
        @hand.all? { |card| card.suit == @hand[0].suit }
    end

    def straight?
        high_to_low
        if hand[0].value - hand[1].value == 1 &&
            hand[1].value - hand[2].value == 1 &&
            hand[2].value - hand[3].value == 1 &&
            hand[3].value - hand[4].value == 1
                return true
        elsif hand[0].value == 14 && hand[1].value == 5 &&
            hand[1].value - hand[2].value == 1 &&
            hand[2].value - hand[3].value == 1 &&
            hand[3].value - hand[4].value == 1
                return true
        else
            false
        end
            

    end

    def hand_winner?(hand_object)
        if self.hand_value != hand_object.hand_value
            return self.hand_value > hand_object.hand_value
        end
        @hand.each_with_index do |card,card_index|
            if @hand[card_index].value > hand_object.hand[card_index].value
                return true
            elsif @hand[card_index].value < hand_object.hand[card_index].value
                return false
            end
        end
        return 'Draw'
    end

    def high_to_low
        @hand.sort! { |a,b | b.value <=> a.value }
    end
    private

    def hand_value_to_hash
        card_values = Hash.new(0)
        @hand.each do |card|
            card_values[card.value] += 1
        end
        card_values     
    end    

    def pairs_counter
        pair_values = Hash.new(0)
        hand_value_to_hash.each do |key,value|
            pair_values[value] += 1
        end
        pair_values
    end

    def pairs_value
        pairs = pairs_counter
        if pairs.has_key?(4)
            return 7000
        elsif pairs.has_key?(3) && pairs.has_key?(2)
            return 6000
        elsif pairs.has_key?(3)
            return 3000
        elsif pairs.has_key?(2) && pairs[2] == 2
            return 2000
        elsif pairs.has_key?(2)
            return 1000
        else
            return 0
        end
    end


end