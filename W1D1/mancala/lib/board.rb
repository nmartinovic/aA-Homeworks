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

    stones.times do |stone|
      start_pos += 1
      if start_pos > 13
        start_pos = 0
      end
      if current_player_name == @name1 && start_pos == 13
        start_pos = 0
      elsif current_player_name == @name2 && start_pos == 6
        start_pos = 7
      else
        start_pos = start_pos
      end
      @cups[start_pos] << :stone
    end
    self.render
    self.next_turn(start_pos)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].length == 1
      return :switch
    else
      return ending_cup_idx
    end

  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    if @cups[0..5].all? { |cup| cup.empty? } || cups[7..12].all? { |cup| cup.empty? }
      return true
    end
    false
  end

  def winner
    if @cups[6].length == @cups[13].length
      return :draw
    elsif @cups[6].length > cups[13].length
      return @name1
    else
      return @name2
    end
  end
end
