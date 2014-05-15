require_relative 'messages_to_player'

class CodeMaker
	# the codemaker has to make a pattern
	# the codemaker has to check whether the pattern matches or not
	# the codemaker has to give feedback
	attr_reader :unsolved_pattern
	def initialize
		@unsolved_pattern = generate_code_pattern
	end

	def give_feedback(user_guess)
		p user_guess

		# Correct letter and position: 1
		# Correct letter and incorrect position: 2 
	end

	private

	def generate_code_pattern
		array = ('A'..'F').to_a
		box = []

		1.upto(4) { box << array.sample }
		box
	end
end

class Board
	attr_reader :codebreaker_guesses
	def initialize(maker_pattern)
		@maker_pattern = maker_pattern
		@codebreaker_guesses = [] || 'none'
	end

	def save_guess(user_guess)
		@codebreaker_guesses << user_guess
	end

	def print_all_guesses
		@codebreaker_guesses.each do |guess|
			puts "[#{guess}]"
		end
	end
end

class Game
	def initialize
		@message = MessagesToCodeBreaker.new
	end

	def run
		@message.greeting
		player_options(gets.chomp)
	end

	private

	def player_options(input)
		case input
		when '1'
			@message.play_instructions
			player_options(gets.chomp)
		when '2'
			# Maybe I should be creating a round/guess here instead?
			maker = CodeMaker.new
			# Maybe it's easier to keep track of the pattern, the guess, and the number of guesses (counter) in the same spot?
			@message.intro_to_game
			board = Board.new(maker.unsolved_pattern)

			1.upto(12) do |num|
				# board.print_all_guesses
				print "Guess #{num}: "
				user_guess = gets.chomp.upcase
				board.save_guess(user_guess)
				maker.give_feedback(user_guess)
			end

		when '3'
			@message.greeting
			player_options(gets.chomp)
		when '4'
			@message.quit_game
		else
			@message.help
			player_options(gets.chomp)
		end
	end

end

game = Game.new
p game.run

# TODO:
# Guess/Round
# Board
# Feedback
# Computer (CodeMaker)
# Human (CodeBreaker)

