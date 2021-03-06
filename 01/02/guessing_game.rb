require 'pry'
require 'minitest/autorun'

class Game
  attr_reader :max, :guesses_left

  def initialize
    @max = 10 # <- one source of truth for the max
    @answer = rand(1 .. @max)
    @guesses_left = 5
  end

  def won?
    @guessed_correct_answer
  end

  def lost?
    @guesses_left <= 0
  end

  def over?
    # && ~ and ... || ~ or
    won? || lost?
  end

  def check_guess guessed_number
    if guessed_number == @answer
      puts "Guessed correctly!"
      @guessed_correct_answer = true
    elsif guessed_number > @answer
      puts "Your guess was high"
      @guesses_left = @guesses_left - 1
    else
      puts "Your guess was low"
      @guesses_left = @guesses_left - 1
    end
  end
end

class GameTest < Minitest::Test
  def test_starts_right
    g = Game.new
    assert_equal 10, g.max
    assert_equal 5, g.guesses_left
  end
end



g = Game.new
puts "Guess a random number between 1 and #{g.max}"

until g.over?
  puts "You have #{g.guesses_left} guesses left"
  puts "What is your guess?"
  guess = gets.chomp.to_i
  g.check_guess guess
end

if g.won?
  puts "You won"
else
  puts "You lost"
end
