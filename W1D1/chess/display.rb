require 'colorize'
require_relative 'cursor.rb'

class Display

    attr_accessor :cursor
    
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0],board)
    end

    def render
        @board.rows.each_with_index do |row, x_index|
            row.each_with_index do |item,y_index|
                if [x_index,y_index] != @cursor.cursor_pos
                    if (x_index % 2 == 0 && y_index % 2 == 0) || (x_index % 2 == 1 && y_index % 2 == 1)
                        if @board[[x_index,y_index]].symbol == :N
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:light_white).colorize( :background => :light_white)
                        else
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:light_blue).colorize( :background => :light_white)
                        end
                    else
                        if @board[[x_index,y_index]].symbol == :N
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:light_black).colorize( :background => :light_black)
                        else
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:light_blue).colorize( :background => :light_black)
                        end
                    end
                else
                    if @cursor.selected != true
                        if @board[[x_index,y_index]].symbol != :N
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:light_blue).colorize( :background => :red)
                        else
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:red).colorize( :background => :red)
                        end
                    else
                        if @board[[x_index,y_index]].symbol != :N
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:light_blue).colorize( :background => :green)
                        else
                            print @board[[x_index,y_index]].symbol.to_s.colorize(:green).colorize( :background => :green)
                        end
                    end

                end
            end
            puts
        end  
    end

    def test
        while @cursor.selected == false
            @cursor.get_input
            system("clear")
            self.render
        end
        @cursor.cursor_pos
    end


end


#[39] pry(main)> print nb[[1,7]].symbol.to_s.colorize(:light_blue).colorize( :background => :black)  
