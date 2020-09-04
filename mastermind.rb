# frozen_string_literal: true

# generates new code
class NewCode
  @peg_colors = { 1 => 'blue',
                  2 => 'yellow',
                  3 => 'orange',
                  4 => 'purple',
                  5 => 'green',
                  6 => 'pink' }

  def initialize
    @new_code = NewCode.generate_code
  end

  def self.generate_code
    [NewCode.generate_color, NewCode.generate_color, NewCode.generate_color, NewCode.generate_color]
  end

  def self.generate_color
    @peg_colors.fetch(rand(1..6))
  end
end

# plays the game
class PlayGame < NewCode
  @@guess_counter = 0
  def initialize
    puts 'Solve the code with the colors: blue, yellow, orange, purple, green and pink!'
    puts "\n"
    puts 'Red means you got a correct color in the correct position, white means correct color wrong position'
      super
      @@new_code = @new_code
      while @@guess_counter < 13
        puts "\n"
        puts 'Enter 4 colors to decipher the code:'
        @@player_colors = gets.chomp.downcase.split(' ')
        @@guess_counter += 1
        PlayGame.check_code
      end
      if @@guess_counter == 13
        puts 'You lost, the code was:'
        @@new_code.each do |x|
          print x + ' '
        end
      end
  end

  def self.check_code
    @i = 0
    marker_string = ""
    @check_arr = @@player_colors.dup
    for i in 0..@@new_code.length-1
      if @@new_code[i] == @check_arr[i]
        marker_string += 'red '
        @check_arr[i] = ' '
        i += 1
      end
    end
    @check_arr.each do |x|
      marker_string += 'white ' if @@new_code.include?(x)
    end
    if marker_string == 'red red red red '
      puts 'You win! You guessed the code!'
      @@guess_counter = 15
      return true
    end
    puts marker_string
  end
end

PlayGame.new
