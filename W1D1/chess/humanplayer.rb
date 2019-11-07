

class HumanPlayer


    attr_accessor :symbol, :display
    def initialize(symbol,display)
        @symbol = symbol
        @display = display

    end

    def make_move
        puts "Select start position (like '1,2'): "
        a = gets.chomp.split(",")
        a.map! { |e| e.to_i }

        puts "Select end position (like '3,4'): "
        b = gets.chomp.split(",")
        b.map! { |e| e.to_i }

        [a,b]
    end
end