
def my_uniq(array)
    new_array = []
    array.each do |ele|
        if !new_array.include?(ele)
            new_array << ele
        end
    end
    new_array

end

class Array

    def two_sum
        returned_array = []
        self.each_with_index do |ele1, i1|
            self.each_with_index do |ele2,i2|
                if i2 > i1
                    if (ele1 + ele2) == 0
                        returned_array << [i1,i2]
                    end
                end
            end
        end
        returned_array 

    end
end

def my_tranpose(array)
    new_arr = []
    array.each_with_index do |subarray, si|
        arr = []
        subarray.each_with_index do |ele, ei|
            arr << array[ei][si]
        end
        new_arr << arr
    end      
    new_arr
end

def stock_picker(prices)
    profit = 0
    buy_day = nil
    sell_day = nil

    prices.each_with_index do |buyday, buyindex|
        prices.each_with_index do |sellday, sellindex|
            if sellindex > buyindex
                if (prices[sellindex] - prices[buyindex]) > profit
                    buy_day = buyindex
                    sell_day = sellindex
                    profit = prices[sellindex] - prices[buyindex]
                end
            end
        end
    end
    if buy_day == nil
        return nil
    end
    [buy_day,sell_day]
end


class Board
    attr_accessor :r0, :r1, :r2


    def initialize
        @r0 = [3,2,1]
        @r1 = []
        @r2 = []
    end

    def move_piece(start,finish)
        rods = { 0=> @r0, 1 => @r1, 2 => @r2}
        valid_move?(rods[start],rods[finish])
        rods[finish] << rods[start].pop
    end


    private
    def valid_move?(start,finish)
        if finish != []
            if start[-1] > finish[-1]
                raise "You cannot move a bigger disk on top of a smaller disk"
            end
        end
        true
    end
    
end

class Game
    attr_reader :game

    def initialize
        @game = Board.new
    end

    def render
        puts "0: #{@game.r0}, 1: #{@game.r1}, 2: #{@game.r2}"
    end

    def won?
        if @game.r0 == [3,2,1] || (@game.r1 != [3,2,1] && @game.r2 != [3,2,1] )
            return false
        end
        true
    end

    def move(start,finish)
        @game.move_piece(start,finish)
    end

    def get_moves
        puts "Enter the starting disc"
        x = gets.chomp.to_i
        puts "Enter the ending disc"
        y = gets.chomp.to_i
        [x,y]
    end

    def play
        while won? == false
            self.render
            start_pos, end_pos = get_moves
            move(start_pos, end_pos)
        end
        self.render
        puts "You won!"

    end

end

if $PROGRAM_NAME == __FILE__
    Game.new.play
end

