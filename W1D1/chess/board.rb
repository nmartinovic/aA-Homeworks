require_relative "piece"

# render the board better and check that my in_check functions work)
# [6,5],[5,5]
# [1,4],[3,4]
# [6,6],[4,6]
# [0,3],[4,7]

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
                    @rows[x_index][y_index] = Queen.new(:W,self,[x_index,y_index])
                elsif x_index == 7 && y_index == 4 
                    @rows[x_index][y_index] = King.new(:W,self,[x_index,y_index])
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
        begin
            if self[start_pos] == [] || self[end_pos] == []
                raise StandardError "Enter a valid position"
            end
            if self[start_pos].valid_moves_piece.include?(end_pos) == false
                raise StandardError "Move is invalid"
            end
        rescue
            retry
        end
        self[end_pos] = self[start_pos].dup
        self[end_pos].pos = end_pos
        self[start_pos] = NullPiece.instance
        @rows
    end

    def move_piece!(start_pos, end_pos)
        begin
            if self[start_pos] == [] || self[end_pos] == []
                raise StandardError "Enter a valid position"
            end
            if self[start_pos].moves.include?(end_pos) == false
                raise "Please enter a valid position"
            end
        rescue
            retry
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
        @rows.each do |row|
            row.each do |column|
                if column.symbol == :E && column.color == color
                    return column.pos
                end
            end
        end
        return "cannot find king"
    end

    def in_check?(color)
        king_pos = find_king(color)
        rows.each do |row|
            row.each do |column|
                if column.color != color&& !column.instance_of?(NullPiece) && column.moves.include?(king_pos) 
                    return true
                end
            end
        end
        false
    end

    def checkmate?(color)
        if in_check?(color) == false
            return false
        end

        @rows.each do |row|
            row.each do |piece|
                if piece.color == color && piece.valid_moves_piece != []
                    puts piece.pos
                    return false
                end
            end
        end

        true
    end

    def board_dup
        duped_board = Board.new

        duped_board.rows.each_with_index do |row, r_i|
            row.each_with_index do |column, c_i|
                if !self[[r_i,c_i]].instance_of?(NullPiece)
                    duped_board[[r_i,c_i]] = self[[r_i,c_i]].dup
                else
                    duped_board[[r_i,c_i]] = NullPiece.instance
                end
            end
        end

        duped_board.rows.each do |row|
            row.each do |piece|
                piece.board = duped_board if piece != NullPiece.instance
            end
        end

        duped_board
    end

end