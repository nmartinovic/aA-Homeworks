class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    setup = Array.new(14)
    setup.each_with_index do |arr, i|
      if i == 6 || i == 13
        setup[i] = []
      else
        setup[i] = [:stone,:stone,:stone,:stone]
      end
    end
    @cups = setup

  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    if (0..12).include?(start_pos) == false
      raise "Invalid starting cup"
    end
    if @cups[start_pos].empty?
      raise "Starting cup is empty"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].length
    @cups[start_pos] = []

    start_pos += 1
    stones.times do |stone|
      #NEED TO FIGURE OUT HOW TO NOT DROP IN OPPONENTS STUFF
      # if start_pos > 13
      #   start_pos -= 13
      # end
      # if current_player_name == @name1 && start_pos != 13
      #   @cups[start_pos] << :stone
      #   start_pos +=1
      # else
      #   @cups[start_pos] << :stone
      #   start_pos += 1
      end
    end
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
