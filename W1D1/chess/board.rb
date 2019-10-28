require_relative "piece"

# write a find kind and in_check? method

class Board

    attr_accessor :rows
    def initialize
        @rows = Array.new(8) { Array.new(8) }
        set_board
    end

    def set_board
        @rows.each_with_index do |ele_x,x_index|
            ele_x.each_with_index do |ele_y,y_index|
                if x_index == 0 && (y_index == 0 || y_index == 7)
                    @rows[x_index][y_index] = Rook.new(:B,self,[x_index,y_index])
                elsif x_index == 0 && (y_index == 1 || y_index == 6)
                    @rows[x_index][y_index] = Knight.new(:B,self,[x_index,y_index])
                elsif x_index == 0 && (y_index == 2 || y_index == 5)
                    @rows[x_index][y_index] = Bishop.new(:B,self,[x_index,y_index])
                elsif x_index == 0 && y_index == 3 
                    @rows[x_index][y_index] = Queen.new(:B,self,[x_index,y_index])
                elsif x_index == 0 && y_index == 4 
                    @rows[x_index][y_index] = King.new(:B,self,[x_index,y_index])
                elsif x_index == 7 && (y_index == 0 || y_index == 7)
                    @rows[x_index][y_index] = Rook.new(:W,self,[x_index,y_index])
                elsif x_index == 7 && (y_index == 1 || y_index == 6)
                    @rows[x_index][y_index] = Knight.new(:W,self,[x_index,y_index])
                elsif x_index == 7 && (y_index == 2 || y_index == 5)
                    @rows[x_index][y_index] = Bishop.new(:W,self,[x_index,y_index])
                elsif x_index == 7 && y_index == 3 
                    @rows[x_index][y_index] = King.new(:W,self,[x_index,y_index])
                elsif x_index == 7 && y_index == 4 
                    @rows[x_index][y_index] = Queen.new(:W,self,[x_index,y_index])
                elsif x_index == 1
                    @rows[x_index][y_index] = Pawn.new(:B,self,[x_index,y_index])
                elsif x_index == 6
                    @rows[x_index][y_index] = Pawn.new(:W,self,[x_index,y_index])
                else
                    @rows[x_index][y_index] = NullPiece.instance
                end
            end
        end
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos,value)
        row,col = pos
        @rows[row][col] = value
    end


    def move_piece(start_pos, end_pos)

        if self[start_pos] == [] || self[end_pos] == []
            raise StandardError "Enter a valid position"
        end
        if self[start_pos].moves.include?(end_pos) == false
            raise StandardError "Move is invalid"
        end
        self[end_pos] = self[start_pos].dup
        self[end_pos].pos = end_pos
        self[start_pos] = NullPiece.instance
        @rows
    end

    def valid_pos?(pos)
        x,y = pos
        if x <0  || x >7 || y < 0 || y > 7
            return false
        end
        return true
    end

    def find_king(color)

    end

    def in_check?(color)

    end

end