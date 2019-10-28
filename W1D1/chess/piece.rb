require 'singleton'

class Piece

    attr_accessor :pos, :color, :board, :symbol

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def inspect
        { 'color' => @color, 'pos' => @pos, 'symbol' => @symbol}
    end


end

module Slideable
    
    @@HORIZONTAL_DIRS = [[-1,0],[1,0],[0,-1],[0,1]]
    @@DIAGONAL_DIRS = [[-1,-1],[-1,1],[1,-1],[1,1]]

    def move_dirs
        #left to be implemented by subclasses
    end

    public
    def grow_unblocked_moves_in_dir(dx,dy)
        grow = true
        unblocked_moves = []
        x,y = self.pos
        check_x, check_y = x+ dx, y + dy

        while grow == true

            if check_x > 7 || check_x < 0 || check_y > 7 || check_y < 0
                return unblocked_moves
            elsif
                @board[[check_x,check_y]].instance_of?(NullPiece)  == false
                if @board[[check_x,check_y]].color == self.color
                    return unblocked_moves
                else  @board[[check_x,check_y]].color != self.color
                    unblocked_moves << [check_x,check_y]
                    return unblocked_moves
                end
            else
                unblocked_moves << [check_x,check_y]
                check_x += dx
                check_y += dy
            end
        end
                
    end

    public
    def horizontal_dirs
        @@HORIZONTAL_DIRS
    end

    def diagonal_dirs
        @@DIAGONAL_DIRS
    end

    def moves
        moves_a = []
        self.move_dirs.each do |ele|
            x,y = ele
            moves_a += self.grow_unblocked_moves_in_dir(x,y)
        end
        moves_a
    end


end

module Stepable


    def moves
        valid_moves = []
        self.move_diffs.each do |ele|
            x,y = self.pos
            check_x, check_y = x + ele[0], y + ele[1]
            if check_x > 7 || check_x < 0 || check_y > 7 || check_y < 0 
                next
            elsif @board[[check_x,check_y]].instance_of?(NullPiece) == false
                if @board[[check_x,check_y]].color == self.color
                    next
                else @board[[check_x,check_y]].color != self.color
                    valid_moves << [check_x,check_y]
                end
            else
                valid_moves << [check_x,check_y]
            end

        end
        valid_moves
    end

    def move_diffs

    end
end

class Bishop < Piece
    include Slideable

    def initialize(color, board, pos)
        super(color, board, pos)
        @symbol = :B
    end

    def move_dirs
        self.diagonal_dirs
    end

end

class Queen < Piece
    include Slideable
    def initialize(color, board, pos)
        super(color, board, pos)
        @symbol = :Q
    end

    def move_dirs
        new_arr = []
        new_arr += self.horizontal_dirs
        new_arr += self.diagonal_dirs
        new_arr
    end
end

class Rook < Piece
    include Slideable
    def initialize(color, board, pos)
        super(color, board, pos)
        @symbol = :R
    end

    def move_dirs
        self.horizontal_dirs
    end
end


class King < Piece
    include Stepable
    
    def initialize(color, board, pos)
        super(color, board, pos)
        @symbol = :K
    end

    def move_diffs
        [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
    end

end

class Knight < Piece
    include Stepable

    def initialize(color,board, pos)
        super(color,board,pos)
        @symbol = :Kn
    end

    def move_diffs
        [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
    end
end


class NullPiece < Piece
    include Singleton

    def initialize
        @color = 'green'
        @symbol = :N
    end

    def color
        @color
    end

    def symbol
        @symbol
    end
end

class Pawn < Piece

    def initialize(color,board,pos)
        super(color,board,pos)
        @symbol = :P
    end

    def symbol
        :P
    end

    def move_dirs
        if self.at_start_row?
            [[1,0],[1,-1],[1,1],[2,0]]
        else
            [[1,0],[1,-1],[1,1]]
        end
    end

    #private
    def at_start_row?
        if self.color == :W && self.pos[0] == 6
            return true
        elsif self.color == :B && self.pos[0] == 1
            return true
        else
            return false
        end
    end

    def forward_dir
        #returns 1 or negative 1
        if self.color == :W
            return -1
        else
            return 1
        end
    end

    def forward_steps
        piece_moves = self.move_dirs
        piece_moves = piece_moves.map { |x| [x[0] * self.forward_dir,x[1]]}

        piece_x, piece_y = self.pos

        
        piece_moves.select { |x| piece_x + x[0] > 0 && piece_x + x[0] < 8 && x[1] == 0}
    end

    
    def side_attacks
        piece_moves = self.move_dirs
        piece_moves = piece_moves.map { |x| [x[0] * self.forward_dir,x[1]]}  
        
        piece_x, piece_y = self.pos
        piece_moves = piece_moves.select { |x| piece_x + x[0] > 0 && piece_x + x[0] < 8 && piece_y + x[1] > 0 && piece_y + x[1] < 8 && x[1] != 0}

        moves = []
        piece_moves.each do |position|
            if self.board[[piece_x + position[0],piece_y + position[1]]].color != self.color && self.board[[piece_x + position[0],piece_y + position[1]]].instance_of?(NullPiece) != true
                moves << position
            end
        end
        moves
    end

    def moves
        valid_moves = []
        valid_moves += self.forward_steps
        valid_moves += self.side_attacks
        valid_moves.map { |x| [self.pos[0] + x[0],self.pos[1] + x[1]] }
    end

end






