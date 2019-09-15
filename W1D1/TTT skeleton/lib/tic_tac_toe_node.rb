require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def children
    children = []
    (0..2).each do |row|
      (0..2).each do |column|
        if @board.empty?([row,column])
          new_board = @board.dup
          new_board[[row,column]] = @next_mover_mark
          if @next_mover_mark == :x
            updater = :o
          else
            updater = :x
          end
          children << TicTacToeNode.new(new_board, updater, [row,column])
        end
      end
    end
    children
  end

  def losing_node?(evaluator)
    if @board.over? == true && !(@board.winner == evaluator || @board.winner == nil)
      return true
    end

    if @board.over? && (@board.winner == evaluator || @board.winner == nil)
      return false
    end

    if evaluator == @next_mover_mark
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end


  def winning_node?(evaluator)
    if @board.over? && @board.winner == evaluator
      return true
    end

    if @board.over? && @board.winner != evaluator
      return false
    end

    if evaluator == @next_mover_mark
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

end
