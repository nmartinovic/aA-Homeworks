require_relative 'display.rb'
require_relative 'board.rb'
require_relative 'humanplayer.rb'


class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = {:W => HumanPlayer.new(:W, @display), :B => HumanPlayer.new(:B,@display)}
        @current_player = :W
    end

    def play

        while @board.checkmate?(:W) != true && @board.checkmate?(:B) != true
            begin
                @display.render
                while @display.cursor.selected == false
                    @display.cursor.get_input
                    system("clear")
                    @display.render
                end
                start_pos = @display.cursor.cursor_pos

                @display.cursor.selected = false

                while @display.cursor.selected == false
                    @display.cursor.get_input
                    system("clear")
                    @display.render
                end
                end_pos = @display.cursor.cursor_pos
                
                @display.cursor.selected = false

                #start_pos, end_pos = @players[@current_player].make_move
                if @board[start_pos].color == @current_player
                    @board.move_piece(start_pos,end_pos)
                else
                    raise "select your position"
                end
            rescue
                system("clear")
                retry
            end
            system("clear")
            swap_turn!
        end
    end

    def swap_turn!
        if @current_player == :W
            @current_player = :B
        else
            @current_player = :W
        end
        @current_player
    end
end

if $PROGRAM_NAME == __FILE__
    game = Game.new
    game.play
end