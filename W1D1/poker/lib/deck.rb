require_relative 'card'


class Deck
    attr_reader :deck

    def initialize
        @deck = []
        values = { 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6=> 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, :J => 11, :Q => 12, :K => 13, :A => 14}
        suits = [:H,:S,:C,:D]
        values.each do |key,value|
            suits.each do |suit|
                @deck << Card.new(value,suit,key)
            end
        end
        @deck.shuffle!
    end

    def [](value)
        @deck[value]
    end

    def deal_one
        @deck.shift
    end
end