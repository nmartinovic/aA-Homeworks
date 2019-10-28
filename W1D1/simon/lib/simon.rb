class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over == true
      take_turn
    end
    if @game_over == true
      game_over_message
      reset_game
    end
  end

  def take_turn
    show_sequence
    require_sequence
    unless game_over
      round_success_message
    end
    @sequence_length += 1
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color
      sleep(1)
      system("clear")
    end
  end

  def require_sequence
    puts "enter sequence one at a time"
    @seq.each do |n|
      user_seq = gets.chomp
      if user_seq != n
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Good Job!!!"
    sleep(1)
    system("clear")
  end

  def game_over_message
    puts "You lose!!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

simon = Simon.new
simon.play

